[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Load only function definitions: never build or install into a real BDS profile.
$InstallerPath = Join-Path $PSScriptRoot 'Install-UniDSA.ps1'
$Tokens = $null
$ParseErrors = $null
$InstallerAst = [Management.Automation.Language.Parser]::ParseFile(
  $InstallerPath, [ref]$Tokens, [ref]$ParseErrors)
if ($ParseErrors.Count -gt 0) {
  throw ($ParseErrors | Out-String)
}
foreach ($FunctionName in @('Initialize-KnownPackagesKey', 'Restore-Installation')) {
  $Definition = $InstallerAst.Find({
    param($Node)
    $Node -is [Management.Automation.Language.FunctionDefinitionAst] -and
      $Node.Name -eq $FunctionName
  }, $true)
  if ($null -eq $Definition) { throw "Missing function: $FunctionName" }
  . ([scriptblock]::Create($Definition.Extent.Text))
}

function Assert-RegistryValues {
  param([string]$Path, [hashtable]$Expected)

  $Key = Get-Item -LiteralPath $Path
  if ($Key.GetValueNames().Count -ne $Expected.Count) {
    throw "Unexpected number of package registrations in $Path"
  }
  foreach ($Name in $Expected.Keys) {
    if ($Key.GetValue($Name) -cne $Expected[$Name]) {
      throw "Package registration changed or missing: $Name"
    }
  }
}

$TestRoot = 'HKCU:\Software\UniDSAInstallerTests-' + [guid]::NewGuid().ToString('N')
try {
  New-Item -Path $TestRoot | Out-Null
  $KnownPackagesKey = Join-Path $TestRoot 'Known Packages'
  Initialize-KnownPackagesKey -KnownPackagesKey $KnownPackagesKey
  Assert-RegistryValues -Path $KnownPackagesKey -Expected @{}
  Write-Output 'PASS: missing key is created.'

  $OriginalPackages = @{
    'C:\Other\dclThirdParty.bpl' = 'Third-party components'
    'C:\Other\dclStandard.bpl' = 'Standard components'
    'C:\Old\UniDSA.bpl' = 'Previous UniDSA runtime'
    'C:\Old\UniDSADesign.bpl' = 'Previous UniDSA designers'
  }
  foreach ($Name in $OriginalPackages.Keys) {
    New-ItemProperty -LiteralPath $KnownPackagesKey -Name $Name `
      -Value $OriginalPackages[$Name] -PropertyType String | Out-Null
  }
  Initialize-KnownPackagesKey -KnownPackagesKey $KnownPackagesKey
  Initialize-KnownPackagesKey -KnownPackagesKey $KnownPackagesKey
  Assert-RegistryValues -Path $KnownPackagesKey -Expected $OriginalPackages
  Write-Output 'PASS: repeated initialization preserves every existing package.'

  $PreviousPackages = @{}
  foreach ($Name in $OriginalPackages.Keys) {
    if ([IO.Path]::GetFileName($Name) -match '^UniDSA(?:Design)?\.bpl$') {
      $PreviousPackages[$Name] = $OriginalPackages[$Name]
      Remove-ItemProperty -LiteralPath $KnownPackagesKey -Name $Name
    }
  }
  New-ItemProperty -LiteralPath $KnownPackagesKey -Name 'C:\New\UniDSADesign.bpl' `
    -Value 'Incomplete installation' -PropertyType String | Out-Null
  $InstallationStarted = $true
  $InstallationCompleted = $false
  $InstalledFiles = @()
  Restore-Installation -KnownPackagesKey $KnownPackagesKey -BackupDirectory $PSScriptRoot
  Assert-RegistryValues -Path $KnownPackagesKey -Expected $OriginalPackages
  Write-Output 'PASS: rollback restores UniDSA and preserves third-party packages.'
}
finally {
  # Delete only values in the unique test key, then remove empty keys (no recursion).
  $TestPackagesKey = Join-Path $TestRoot 'Known Packages'
  if (Test-Path -LiteralPath $TestPackagesKey) {
    foreach ($Name in (Get-Item -LiteralPath $TestPackagesKey).GetValueNames()) {
      Remove-ItemProperty -LiteralPath $TestPackagesKey -Name $Name
    }
    Remove-Item -LiteralPath $TestPackagesKey
  }
  if (Test-Path -LiteralPath $TestRoot) {
    Remove-Item -LiteralPath $TestRoot
  }
}
