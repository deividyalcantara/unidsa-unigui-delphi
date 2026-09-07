# Reproducible palette bitmap; no external artwork or dependencies.
Add-Type -AssemblyName System.Drawing
$iconPath = Join-Path $PSScriptRoot '..\images\TUniDSAFormStyle.bmp'
$bitmap = New-Object Drawing.Bitmap 24,24
$graphics = [Drawing.Graphics]::FromImage($bitmap)
$blue = New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(37,99,235))
$white = New-Object Drawing.SolidBrush ([Drawing.Color]::White)
$gray = New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(226,232,240))
$pen = New-Object Drawing.Pen ([Drawing.Color]::White),1
try {
  $graphics.Clear([Drawing.Color]::Fuchsia)
  $graphics.FillRectangle($gray,3,5,20,18)
  $graphics.FillRectangle($blue,1,2,20,18)
  $graphics.FillRectangle($white,3,9,16,9)
  $graphics.DrawLine($pen,15,4,18,7)
  $graphics.DrawLine($pen,18,4,15,7)
  $graphics.FillRectangle($gray,5,11,12,2)
  $graphics.FillRectangle($blue,5,15,6,2)
  $bitmap.Save($iconPath,[Drawing.Imaging.ImageFormat]::Bmp)
} finally {
  $pen.Dispose(); $blue.Dispose(); $white.Dispose(); $gray.Dispose()
  $graphics.Dispose(); $bitmap.Dispose()
}
