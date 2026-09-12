[CmdletBinding()]
param(
  [string]$BdsVersion,
  [switch]$NoPause
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$LogDirectory = Join-Path $env:LOCALAPPDATA 'UniDSA\Installer'
$LogFile = Join-Path $LogDirectory 'install.log'
$StageRoot = Join-Path (Join-Path $env:TEMP 'UniDSA-Installer') ([guid]::NewGuid().ToString('N'))
$TranscriptStarted = $false
$InstallationStarted = $false
$InstallationCompleted = $false
$PreviousPackages = @{}
$InstalledFiles = @()

function Write-Step {
  param([string]$Message)

  Write-Host "`n>> $Message" -ForegroundColor Cyan
}

function Expand-BdsValue {
  param(
    [string]$Value,
    [hashtable]$Variables
  )

  $Result = $Value
  foreach ($Name in $Variables.Keys) {
    $Result = $Result.Replace('$(' + $Name + ')', [string]$Variables[$Name])
  }

  return [Environment]::ExpandEnvironmentVariables($Result)
}

function Invoke-DelphiBuild {
  param(
    [string]$MsBuild,
    [string]$Project,
    [string]$BplOutput,
    [string]$DcpOutput,
    [string]$DcuOutput,
    [string]$AdditionalSearchPath
  )

  $Arguments = @(
    $Project,
    '/t:Build',
    '/p:Config=Release',
    '/p:Platform=Win32',
    "/p:DCC_BplOutput=$BplOutput",
    "/p:DCC_DcpOutput=$DcpOutput",
    "/p:DCC_DcuOutput=$DcuOutput",
    '/verbosity:minimal',
    '/nologo'
  )

  if ($AdditionalSearchPath) {
    $EscapedSearchPath = $AdditionalSearchPath.Replace(';', '%3B')
    $Arguments += "/p:DCC_UnitSearchPath=$EscapedSearchPath"
  }

  & $MsBuild @Arguments
  if ($LASTEXITCODE -ne 0) {
    throw "Falha ao compilar $Project (código $LASTEXITCODE)."
  }
}

function Initialize-KnownPackagesKey {
  param([string]$KnownPackagesKey)

  # New-Item -Force replaces an existing registry key and removes its values.
  # Only create the key when missing so other installed packages are preserved.
  if (-not (Test-Path -LiteralPath $KnownPackagesKey)) {
    New-Item -Path $KnownPackagesKey | Out-Null
  }
}

function Restore-Installation {
  param(
    [string]$KnownPackagesKey,
    [string]$BackupDirectory
  )

  if (-not $InstallationStarted -or $InstallationCompleted) {
    return
  }

  Write-Warning 'A instalação não foi concluída. Restaurando a versão anterior.'

  if (Test-Path -LiteralPath $KnownPackagesKey) {
    $CurrentPackages = Get-Item -LiteralPath $KnownPackagesKey
    foreach ($PackageName in $CurrentPackages.GetValueNames()) {
      if ([IO.Path]::GetFileName($PackageName) -match '^UniDSA(?:Design)?\.bpl$') {
        Remove-ItemProperty -LiteralPath $KnownPackagesKey -Name $PackageName
      }
    }
  }

  foreach ($File in $InstalledFiles) {
    $BackupFile = Join-Path $BackupDirectory ([IO.Path]::GetFileName($File))
    if (Test-Path -LiteralPath $BackupFile) {
      Copy-Item -LiteralPath $BackupFile -Destination $File -Force
    }
    elseif (Test-Path -LiteralPath $File) {
      Remove-Item -LiteralPath $File -Force
    }
  }

  foreach ($PackageName in $PreviousPackages.Keys) {
    New-ItemProperty -LiteralPath $KnownPackagesKey -Name $PackageName `
      -Value $PreviousPackages[$PackageName] -PropertyType String -Force | Out-Null
  }
}

try {
  New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null
  Start-Transcript -LiteralPath $LogFile -Force | Out-Null
  $TranscriptStarted = $true

  Write-Host 'UniDSA - Compilador e instalador de pacotes' -ForegroundColor White
  Write-Host "Projeto: $ProjectRoot" -ForegroundColor DarkGray

  $RunningIde = @(Get-Process -Name bds -ErrorAction SilentlyContinue)
  if ($RunningIde.Count -gt 0) {
    throw 'Feche o Delphi/RAD Studio antes de reinstalar os pacotes.'
  }

  $BdsRegistryRoot = 'HKCU:\Software\Embarcadero\BDS'
  if (-not (Test-Path -LiteralPath $BdsRegistryRoot)) {
    throw 'Nenhuma instalação do Delphi foi encontrada no perfil atual.'
  }

  $Installations = @(Get-ChildItem -LiteralPath $BdsRegistryRoot | ForEach-Object {
    $Settings = Get-ItemProperty -LiteralPath $_.PSPath
    $Compiler = Join-Path ([string]$Settings.RootDir) 'bin\dcc32.exe'
    if ($Settings.RootDir -and (Test-Path -LiteralPath $Compiler)) {
      [PSCustomObject]@{
        Version = $_.PSChildName
        SortVersion = [version]$_.PSChildName
        RootDir = ([string]$Settings.RootDir).TrimEnd('\')
      }
    }
  })

  if ($BdsVersion) {
    $Installation = $Installations | Where-Object Version -eq $BdsVersion | Select-Object -First 1
    if (-not $Installation) {
      throw "Delphi $BdsVersion não foi encontrado."
    }
  }
  else {
    $Installation = $Installations | Sort-Object SortVersion -Descending | Select-Object -First 1
    if (-not $Installation) {
      throw 'Nenhum compilador Delphi Win32 foi encontrado.'
    }
  }

  $Version = $Installation.Version
  $BdsRoot = $Installation.RootDir
  $RsVarsFile = Join-Path $BdsRoot 'bin\rsvars.bat'
  if (-not (Test-Path -LiteralPath $RsVarsFile)) {
    throw "Arquivo de ambiente não encontrado: $RsVarsFile"
  }

  $RsVars = @{}
  foreach ($Line in Get-Content -LiteralPath $RsVarsFile) {
    if ($Line -match '^@?SET\s+([^=]+)=(.*)$') {
      $RsVars[$Matches[1].Trim()] = $Matches[2].Trim()
    }
  }

  $BdsCommonDir = Expand-BdsValue -Value ([string]$RsVars.BDSCOMMONDIR) -Variables $RsVars
  $FrameworkDir = Expand-BdsValue -Value ([string]$RsVars.FrameworkDir) -Variables $RsVars
  $MsBuild = Join-Path $FrameworkDir 'MSBuild.exe'
  if (-not (Test-Path -LiteralPath $MsBuild)) {
    throw "MSBuild não encontrado: $MsBuild"
  }

  $EnvironmentKey = Join-Path $BdsRegistryRoot "$Version\Environment Variables"
  if (Test-Path -LiteralPath $EnvironmentKey) {
    $EnvironmentSettings = Get-ItemProperty -LiteralPath $EnvironmentKey
    foreach ($Property in $EnvironmentSettings.PSObject.Properties) {
      if ($Property.Name -notlike 'PS*') {
        [Environment]::SetEnvironmentVariable($Property.Name, [string]$Property.Value, 'Process')
      }
    }
  }

  $env:BDS = $BdsRoot
  $env:BDSCOMMONDIR = $BdsCommonDir
  $env:BDSINCLUDE = Join-Path $BdsRoot 'include'
  $env:FrameworkDir = $FrameworkDir
  $env:FrameworkVersion = [string]$RsVars.FrameworkVersion
  $env:LANGDIR = [string]$RsVars.LANGDIR
  $env:Path = "$FrameworkDir;$BdsRoot\bin;$BdsRoot\bin64;$env:Path"

  $BplStage = Join-Path $StageRoot 'Bpl'
  $DcpStage = Join-Path $StageRoot 'Dcp'
  $DcuStage = Join-Path $StageRoot 'Dcu'
  $BackupDirectory = Join-Path $StageRoot 'Backup'
  New-Item -ItemType Directory -Path $BplStage, $DcpStage, $DcuStage, $BackupDirectory -Force | Out-Null

  Write-Step "Compilando os pacotes com Delphi $Version"
  Invoke-DelphiBuild -MsBuild $MsBuild -Project (Join-Path $ProjectRoot 'UniDSA.dproj') `
    -BplOutput $BplStage -DcpOutput $DcpStage -DcuOutput $DcuStage -AdditionalSearchPath ''
  Invoke-DelphiBuild -MsBuild $MsBuild -Project (Join-Path $ProjectRoot 'UniDSADesign.dproj') `
    -BplOutput $BplStage -DcpOutput $DcpStage -DcuOutput $DcuStage `
    -AdditionalSearchPath "$DcpStage;$DcuStage"

  $RequiredBuildFiles = @(
    (Join-Path $BplStage 'UniDSA.bpl'),
    (Join-Path $BplStage 'UniDSADesign.bpl'),
    (Join-Path $DcpStage 'UniDSA.dcp'),
    (Join-Path $DcpStage 'UniDSADesign.dcp')
  )
  foreach ($BuildFile in $RequiredBuildFiles) {
    if (-not (Test-Path -LiteralPath $BuildFile)) {
      throw "A compilação não gerou o arquivo esperado: $BuildFile"
    }
  }

  $BplDirectory = Join-Path $BdsCommonDir 'Bpl'
  $DcpDirectory = Join-Path $BdsCommonDir 'Dcp'
  New-Item -ItemType Directory -Path $BplDirectory, $DcpDirectory -Force | Out-Null

  $KnownPackagesKey = Join-Path $BdsRegistryRoot "$Version\Known Packages"
  Initialize-KnownPackagesKey -KnownPackagesKey $KnownPackagesKey

  $KnownPackages = Get-Item -LiteralPath $KnownPackagesKey
  foreach ($PackageName in $KnownPackages.GetValueNames()) {
    if ([IO.Path]::GetFileName($PackageName) -match '^UniDSA(?:Design)?\.bpl$') {
      $PreviousPackages[$PackageName] = [string]$KnownPackages.GetValue($PackageName)
    }
  }

  $FilesToInstall = @(
    @{ Source = Join-Path $BplStage 'UniDSA.bpl'; Destination = Join-Path $BplDirectory 'UniDSA.bpl' },
    @{ Source = Join-Path $BplStage 'UniDSADesign.bpl'; Destination = Join-Path $BplDirectory 'UniDSADesign.bpl' },
    @{ Source = Join-Path $DcpStage 'UniDSA.dcp'; Destination = Join-Path $DcpDirectory 'UniDSA.dcp' },
    @{ Source = Join-Path $DcpStage 'UniDSADesign.dcp'; Destination = Join-Path $DcpDirectory 'UniDSADesign.dcp' },
    @{ Source = Join-Path $DcpStage 'UniDSA.bpi'; Destination = Join-Path $DcpDirectory 'UniDSA.bpi' },
    @{ Source = Join-Path $DcpStage 'UniDSADesign.bpi'; Destination = Join-Path $DcpDirectory 'UniDSADesign.bpi' },
    @{ Source = Join-Path $DcpStage 'UniDSA.lib'; Destination = Join-Path $DcpDirectory 'UniDSA.lib' },
    @{ Source = Join-Path $DcpStage 'UniDSADesign.lib'; Destination = Join-Path $DcpDirectory 'UniDSADesign.lib' }
  )

  $InstallationStarted = $true

  Write-Step 'Atualizando somente o registro dos pacotes UniDSA'
  foreach ($PackageName in $PreviousPackages.Keys) {
    Remove-ItemProperty -LiteralPath $KnownPackagesKey -Name $PackageName
  }

  foreach ($FileInfo in $FilesToInstall) {
    $Destination = [string]$FileInfo.Destination
    $InstalledFiles += $Destination
    if (Test-Path -LiteralPath $Destination) {
      Copy-Item -LiteralPath $Destination `
        -Destination (Join-Path $BackupDirectory ([IO.Path]::GetFileName($Destination))) -Force
    }
  }

  Write-Step 'Instalando os novos arquivos'
  foreach ($FileInfo in $FilesToInstall) {
    if (Test-Path -LiteralPath ([string]$FileInfo.Source)) {
      Copy-Item -LiteralPath ([string]$FileInfo.Source) -Destination ([string]$FileInfo.Destination) -Force
    }
  }

  $RuntimeBpl = Join-Path $BplDirectory 'UniDSA.bpl'
  $DesignBpl = Join-Path $BplDirectory 'UniDSADesign.bpl'
  New-ItemProperty -LiteralPath $KnownPackagesKey -Name $RuntimeBpl `
    -Value 'Componente UniDSA para UniGUI' -PropertyType String -Force | Out-Null
  New-ItemProperty -LiteralPath $KnownPackagesKey -Name $DesignBpl `
    -Value 'UniDSA - Editores e recursos de design' -PropertyType String -Force | Out-Null

  $LibraryKey = Join-Path $BdsRegistryRoot "$Version\Library\Win32"
  $LibrarySettings = Get-ItemProperty -LiteralPath $LibraryKey
  $SourceDirectory = Join-Path $ProjectRoot 'sources'
  $SearchPath = [string]$LibrarySettings.'Search Path'
  $SourceExists = @($SearchPath.Split(';') | Where-Object {
    $_.Trim().TrimEnd('\') -ieq $SourceDirectory.TrimEnd('\')
  }).Count -gt 0
  if (-not $SourceExists) {
    $NewSearchPath = $SearchPath.TrimEnd(';') + ';' + $SourceDirectory
    Set-ItemProperty -LiteralPath $LibraryKey -Name 'Search Path' -Value $NewSearchPath
  }

  $InstallationCompleted = $true

  Write-Step 'Instalação concluída'
  Write-Host "Delphi: $Version" -ForegroundColor Green
  Write-Host "Runtime: $RuntimeBpl" -ForegroundColor Green
  Write-Host "Design-time: $DesignBpl" -ForegroundColor Green
  Write-Host 'Abra o Delphi e confira a paleta UniDSA.' -ForegroundColor White
}
catch {
  Write-Host "`nERRO: $($_.Exception.Message)" -ForegroundColor Red
  if ($InstallationStarted -and -not $InstallationCompleted) {
    Restore-Installation -KnownPackagesKey $KnownPackagesKey -BackupDirectory $BackupDirectory
  }
}
finally {
  if (Test-Path -LiteralPath $StageRoot) {
    $ExpectedStageParent = [IO.Path]::GetFullPath((Join-Path $env:TEMP 'UniDSA-Installer')).TrimEnd('\') + '\'
    $ResolvedStageRoot = [IO.Path]::GetFullPath($StageRoot)
    if ($ResolvedStageRoot.StartsWith($ExpectedStageParent, [StringComparison]::OrdinalIgnoreCase)) {
      Remove-Item -LiteralPath $ResolvedStageRoot -Recurse -Force
    }
  }

  if ($TranscriptStarted) {
    Stop-Transcript | Out-Null
  }

  Write-Host "`nLog: $LogFile" -ForegroundColor DarkGray
  if (-not $NoPause) {
    Read-Host 'Pressione ENTER para fechar'
  }
}

if (-not $InstallationCompleted) {
  exit 1
}
