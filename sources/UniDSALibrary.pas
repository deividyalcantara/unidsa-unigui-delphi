unit UniDSALibrary;

interface

uses
  System.UITypes, System.SysUtils, Vcl.Graphics, Winapi.Windows;

type
  TArrayOfString = Array of string;

function ColorToHex(ACor: TColor): string;
function IIfStr(ACondicao: Boolean; AVerdadeiro: string; AFalso: string): string;
function IIfDbl(ACondicao: Boolean; AVerdadeiro: Double; AFalso: Double): Double;
function IIf(ACondicao: Boolean; AVerdadeiro: Variant; AFalso: Variant): Variant;
function SortName: string;
function RemoverTagFontAwesome(AStr: string): string;
function px(AValor: Integer): string;

implementation

function px(AValor: Integer): string;
begin
  try
    Result := IntToStr(AValor) + 'px';
  except
    Result := '0px';
  end;
end;

function IIf(ACondicao: Boolean; AVerdadeiro: Variant; AFalso: Variant): Variant;
begin
  if ACondicao then
    Result := AVerdadeiro
  else
    Result := AFalso;
end;

function IIfDbl(ACondicao: Boolean; AVerdadeiro: Double; AFalso: Double): Double;
begin
  if ACondicao then
    Result := AVerdadeiro
  else
    Result := AFalso;
end;

function RemoverTagFontAwesome(AStr: string): string;
begin
  Result := StringReplace(AStr, '  <i class="', '', [rfReplaceAll]);
  Result := StringReplace(Result, ' <i class="', '', [rfReplaceAll]);
  Result := StringReplace(Result, '<i class="', '', [rfReplaceAll]);
  Result := StringReplace(Result, '"></i>', '', [rfReplaceAll]);
end;

function SortName: string;
var
  i: Integer;
  AValues: TArrayOfString;
begin
  AValues := ['D','E','I','V','I','D','Y', '_', 'A','L','C','A','N','T','A','R','A'];

  for i := 1 to 10 do
    Result := Result + AValues[random(16)];
end;

function ColorToHex(ACor: TColor): string;
var
  LColor: LongInt;
  LRed: Integer;
  LGreen: Integer;
  LBlue: Integer;
begin
  LColor := ColorToRGB(ACor);

  LRed := ($000000FF and LColor);
  LGreen := ($0000FF00 and LColor) Shr 8;
  LBlue := ($00FF0000 and LColor) Shr 16;

  Result := 'rgb(' + IntToStr(LRed) + ',' + IntToStr(LGreen) + ',' + IntToStr(LBlue) + ')';
end;

function IIfStr(ACondicao: Boolean; AVerdadeiro: string; AFalso: string): string;
begin
  if ACondicao then
    Result := AVerdadeiro
  else
    Result := AFalso;
end;

end.
