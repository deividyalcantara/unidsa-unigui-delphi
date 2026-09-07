unit UniDSAWebUtils;

interface

uses
  System.SysUtils, Vcl.Graphics;

function UniDSAHtmlEncode(const AValue: string): string;
function UniDSAJSString(const AValue: string): string;
function UniDSABoolJS(const AValue: Boolean): string;
function UniDSAColorToCSS(const AColor: TColor): string;
function UniDSAClamp(const AValue, AMin, AMax: Integer): Integer;

implementation

function UniDSAHtmlEncode(const AValue: string): string;
begin
  Result := AValue;
  Result := StringReplace(Result, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]);
  Result := StringReplace(Result, '''', '&#39;', [rfReplaceAll]);
end;

function UniDSAJSString(const AValue: string): string;
var
  I: Integer;
  C: Char;
begin
  Result := '"';
  for I := 1 to Length(AValue) do
  begin
    C := AValue[I];
    case C of
      '"': Result := Result + '\"';
      '\': Result := Result + '\\';
      #8: Result := Result + '\b';
      #9: Result := Result + '\t';
      #10: Result := Result + '\n';
      #12: Result := Result + '\f';
      #13: Result := Result + '\r';
    else
      if (Ord(C) < 32) or (Ord(C) = $2028) or (Ord(C) = $2029) then
        Result := Result + '\u' + IntToHex(Ord(C), 4)
      else
        Result := Result + C;
    end;
  end;
  Result := Result + '"';
end;

function UniDSABoolJS(const AValue: Boolean): string;
begin
  if AValue then
    Result := 'true'
  else
    Result := 'false';
end;

function UniDSAColorToCSS(const AColor: TColor): string;
var
  LColor: LongInt;
  R, G, B: Integer;
begin
  LColor := ColorToRGB(AColor);
  R := ($000000FF and LColor);
  G := ($0000FF00 and LColor) Shr 8;
  B := ($00FF0000 and LColor) Shr 16;
  Result := 'rgb(' + IntToStr(R) + ',' + IntToStr(G) + ',' + IntToStr(B) + ')';
end;

function UniDSAClamp(const AValue, AMin, AMax: Integer): Integer;
begin
  if AValue < AMin then
    Result := AMin
  else if AValue > AMax then
    Result := AMax
  else
    Result := AValue;
end;

end.
