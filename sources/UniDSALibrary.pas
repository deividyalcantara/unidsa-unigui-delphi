unit UniDSALibrary;

interface

uses
  System.UITypes, System.SysUtils, Vcl.Graphics, Winapi.Windows;

type
  TArrayOfString = Array of string;

function ColorToHex(cor: TColor): string;
function IIfStr(condicao: Boolean; verdadeiro: string; falso: string): string;
function SortName: string;

implementation

function SortName: string;
var
  i: Integer;
  values: TArrayOfString;
begin
  values := ['D','E','I','V','I','D','Y', '_', 'A','L','C','A','N','T','A','R','A'];

  for i := 1 to 10 do
    Result := Result + values[random(16)];
end;

function ColorToHex(cor: TColor): string;
var
  color: LongInt;
  red: Integer;
  green: Integer;
  blue: Integer;
begin
  color := ColorToRGB(cor);

  red := ($000000FF and Color);
  green := ($0000FF00 and Color) Shr 8;
  blue := ($00FF0000 and Color) Shr 16;

  Result := 'rgb(' + IntToStr(red) + ',' + IntToStr(green) + ',' + IntToStr(blue) + ')'
end;

function IIfStr(condicao: Boolean; verdadeiro: string; falso: string): string;
begin
  if condicao then
    Result := verdadeiro
  else
    Result := falso;
end;

end.
