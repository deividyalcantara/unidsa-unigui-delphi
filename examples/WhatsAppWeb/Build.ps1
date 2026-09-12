param(
  [string]$BdsVersion = '37.0',
  [ValidateSet('Debug', 'Release')]
  [string]$Config = 'Debug'
)

# Compila o projeto com o ambiente registrado pelo RAD Studio. O pós-build do
# DPROJ chama CopiarAssets.ps1 e recria os arquivos web da configuração usada.
$ErrorActionPreference = 'Stop'
$caminhoOriginal = $env:Path
$configuracoes = Get-ItemProperty "HKCU:\Software\Embarcadero\BDS\$BdsVersion"
$raizBds = [string]$configuracoes.RootDir

# Importa as variáveis do rsvars.bat, exceto PATH, montado logo abaixo.
foreach ($linha in Get-Content (Join-Path $raizBds 'bin\rsvars.bat')) {
  if ($linha -match '^@?SET\s+([^=]+)=(.*)$' -and $Matches[1] -ne 'PATH') {
    [Environment]::SetEnvironmentVariable($Matches[1], $Matches[2], 'Process')
  }
}

# Inclui os caminhos personalizados de Tools > Options do Delphi.
$chaveAmbiente = "HKCU:\Software\Embarcadero\BDS\$BdsVersion\Environment Variables"
if (Test-Path $chaveAmbiente) {
  (Get-ItemProperty $chaveAmbiente).PSObject.Properties |
    Where-Object Name -NotLike 'PS*' |
    ForEach-Object {
      [Environment]::SetEnvironmentVariable($_.Name, [string]$_.Value, 'Process')
    }
}

$env:BDS = $raizBds.TrimEnd('\')
$env:Path = "$raizBds\bin;$caminhoOriginal"
$msbuild = Join-Path $env:FrameworkDir 'MSBuild.exe'
$projeto = Join-Path $PSScriptRoot 'WhatsAppWeb.dproj'
$raizSaida = [IO.Path]::GetFullPath(
  (Join-Path $PSScriptRoot "bin\Win32\$Config"))

& $msbuild $projeto /t:Build /p:Platform=Win32 "/p:Config=$Config" /v:minimal /nologo
if ($LASTEXITCODE -ne 0) {
  throw 'Falha na compilação do UniChat.'
}

$javascriptFlex = Join-Path $raizSaida 'files\dsa\flex\js\unidsa-flex.js'
if (-not (Test-Path -LiteralPath $javascriptFlex)) {
  throw "O pós-build não gerou o JavaScript do FlexPanel: $javascriptFlex"
}

Write-Host "Executável: $raizSaida\WhatsAppWeb.exe"
Write-Host 'Depois de executar, abra http://localhost:8078'