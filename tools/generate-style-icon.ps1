# Reproducible 24x24 palette icon for TUniDSAStyle.
Add-Type -AssemblyName System.Drawing
$bitmap = [Drawing.Bitmap]::new(24,24)
$graphics = [Drawing.Graphics]::FromImage($bitmap)
$green = [Drawing.SolidBrush]::new([Drawing.Color]::FromArgb(8,127,105))
$light = [Drawing.SolidBrush]::new([Drawing.Color]::FromArgb(219,244,232))
$white = [Drawing.SolidBrush]::new([Drawing.Color]::White)
try {
  $graphics.Clear([Drawing.Color]::Fuchsia)
  $graphics.FillRectangle($green,1,1,22,22)
  $graphics.FillRectangle($light,4,6,16,2)
  $graphics.FillRectangle($light,4,11,16,2)
  $graphics.FillRectangle($light,4,16,16,2)
  $graphics.FillRectangle($white,8,4,4,6)
  $graphics.FillRectangle($white,14,9,4,6)
  $graphics.FillRectangle($white,6,14,4,6)
  $bitmap.Save((Join-Path $PSScriptRoot '..\images\TUniDSAStyle.bmp'),[Drawing.Imaging.ImageFormat]::Bmp)
} finally {
  $graphics.Dispose(); $bitmap.Dispose(); $green.Dispose(); $light.Dispose(); $white.Dispose()
}
