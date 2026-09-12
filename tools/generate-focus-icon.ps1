# Reproducible 24x24 palette icon: a focus rectangle crossed out.
Add-Type -AssemblyName System.Drawing
$bitmap = [Drawing.Bitmap]::new(24,24)
$graphics = [Drawing.Graphics]::FromImage($bitmap)
$green = [Drawing.SolidBrush]::new([Drawing.Color]::FromArgb(8,127,105))
$white = [Drawing.SolidBrush]::new([Drawing.Color]::White)
$cut = [Drawing.Pen]::new([Drawing.Color]::FromArgb(8,127,105),5)
$slash = [Drawing.Pen]::new([Drawing.Color]::FromArgb(219,244,232),2)
try {
  $graphics.Clear([Drawing.Color]::Fuchsia)
  $graphics.FillRectangle($green,1,1,22,22)
  foreach ($x in @(5,9,13,17)) {
    $graphics.FillRectangle($white,$x,5,2,2)
    $graphics.FillRectangle($white,$x,17,2,2)
  }
  foreach ($y in @(9,13)) {
    $graphics.FillRectangle($white,5,$y,2,2)
    $graphics.FillRectangle($white,17,$y,2,2)
  }
  $graphics.DrawLine($cut,4,20,20,4)
  $graphics.DrawLine($slash,4,20,20,4)
  $bitmap.Save((Join-Path $PSScriptRoot '..\images\TUniDSAFocusControl.bmp'),[Drawing.Imaging.ImageFormat]::Bmp)
} finally {
  $graphics.Dispose(); $bitmap.Dispose(); $green.Dispose(); $white.Dispose(); $cut.Dispose(); $slash.Dispose()
}
