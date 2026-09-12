param([string]$BdsVersion = '37.0')
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$bdsRoot = [string](Get-ItemProperty "HKCU:\Software\Embarcadero\BDS\$BdsVersion").RootDir
$originalPath = $env:Path
foreach ($line in Get-Content (Join-Path $bdsRoot 'bin\rsvars.bat')) {
  if ($line -match '^@?SET\s+([^=]+)=(.*)$' -and $Matches[1] -ne 'PATH') {
    [Environment]::SetEnvironmentVariable($Matches[1], $Matches[2], 'Process')
  }
}
$environmentKey = "HKCU:\Software\Embarcadero\BDS\$BdsVersion\Environment Variables"
if (Test-Path $environmentKey) {
  (Get-ItemProperty $environmentKey).PSObject.Properties | Where-Object Name -NotLike 'PS*' | ForEach-Object {
    [Environment]::SetEnvironmentVariable($_.Name, [string]$_.Value, 'Process')
  }
}
$env:BDS = $bdsRoot.TrimEnd('\')
$env:Path = "$bdsRoot\bin;$originalPath"
$stage = Join-Path $repoRoot 'tmp\style-validation'
New-Item -ItemType Directory -Force $stage | Out-Null
$msbuild = Join-Path $env:FrameworkDir 'MSBuild.exe'
$common = @('/t:Build','/p:Config=Release','/p:Platform=Win32','/v:minimal','/nologo')
& $msbuild (Join-Path $repoRoot 'UniDSA.dproj') @common "/p:DCC_BplOutput=$stage\bpl" "/p:DCC_DcpOutput=$stage\dcp" "/p:DCC_DcuOutput=$stage\runtime"
if ($LASTEXITCODE -ne 0) { throw 'Runtime package failed.' }
$search = "$stage\dcp;$stage\runtime;$repoRoot\sources".Replace(';','%3B')
& $msbuild (Join-Path $repoRoot 'UniDSADesign.dproj') @common "/p:DCC_BplOutput=$stage\bpl" "/p:DCC_DcpOutput=$stage\dcp" "/p:DCC_DcuOutput=$stage\design" "/p:DCC_UnitSearchPath=$search"
if ($LASTEXITCODE -ne 0) { throw 'Design package failed.' }
$testProject = '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003"><PropertyGroup><MainSource>../../tools/test-style-model.dpr</MainSource><AppType>Console</AppType><FrameworkType>VCL</FrameworkType><DCC_Namespace>Winapi;System;System.Win;Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;Data;Data.Win;Datasnap;Xml;Xml.Win;Web;Web.Win;Soap;Soap.Win</DCC_Namespace><DCC_UnitSearchPath>../../sources;$(DCC_UnitSearchPath)</DCC_UnitSearchPath><DCC_ExeOutput>.</DCC_ExeOutput><DCC_DcuOutput>test-dcu</DCC_DcuOutput></PropertyGroup><ItemGroup><DelphiCompile Include="$(MainSource)"><MainSource>MainSource</MainSource></DelphiCompile></ItemGroup><Import Project="$(BDS)\Bin\CodeGear.Delphi.Targets"/></Project>'
[IO.File]::WriteAllText((Join-Path $stage 'test-style-model.dproj'), $testProject)
& $msbuild (Join-Path $stage 'test-style-model.dproj') @common
if ($LASTEXITCODE -ne 0) { throw 'Model test build failed.' }
& (Join-Path $stage 'test-style-model.exe')
if ($LASTEXITCODE -ne 0) { throw 'Model test failed.' }
