param(
  [ValidateSet('Win32', 'Win64')]
  [string]$Platform = 'Win32',
  [ValidateSet('Debug', 'Release')]
  [string]$Config = 'Debug'
)

# Executado também pelo pós-build do RAD Studio. Recria os arquivos web para
# impedir que uma compilação use JavaScript ou CSS de uma versão anterior.
$ErrorActionPreference = 'Stop'
$raizSaida = [IO.Path]::GetFullPath(
  (Join-Path $PSScriptRoot "bin\$Platform\$Config"))
$arquivosSaida = [IO.Path]::GetFullPath((Join-Path $raizSaida 'files'))

if (-not $arquivosSaida.StartsWith(
    $raizSaida + [IO.Path]::DirectorySeparatorChar,
    [StringComparison]::OrdinalIgnoreCase)) {
  throw "Destino de assets inválido: $arquivosSaida"
}

if (Test-Path -LiteralPath $arquivosSaida) {
  Remove-Item -LiteralPath $arquivosSaida -Recurse -Force
}
New-Item -ItemType Directory -Path $arquivosSaida -Force | Out-Null

$arquivosAplicacao = Join-Path $PSScriptRoot 'Files'
if (Test-Path -LiteralPath $arquivosAplicacao) {
  Get-ChildItem -LiteralPath $arquivosAplicacao -Force |
    Copy-Item -Destination $arquivosSaida -Recurse -Force
}

$origemFlex = [IO.Path]::GetFullPath(
  (Join-Path $PSScriptRoot '..\..\dsa\flex'))
$destinoFlex = Join-Path $arquivosSaida 'dsa\flex'
New-Item -ItemType Directory -Path $destinoFlex -Force | Out-Null
Get-ChildItem -LiteralPath $origemFlex -Force |
  Copy-Item -Destination $destinoFlex -Recurse -Force

Write-Host "Assets atualizados: $arquivosSaida"