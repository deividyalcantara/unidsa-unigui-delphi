unit UniDSABase;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSAJQuery, UniDSABrowser, UniDSALibrary, uniGUITypes;

type
  TUniDSABaseComponent = class(TUniComponent)
  private
    FAbout: string;
    FVersion: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AjaxRequest(EventName: string; Parametros: TArrayOfString = nil): string;
    function IIfStr(condicao: Boolean; verdadeiro: string; falso: string): string;
    function IIfVar(condicao: Boolean; verdadeiro: Variant; falso: Variant): Variant;
  protected
    procedure DOHandleEvent(EventName: string; Params: TUniStrings); override;
    procedure AJAXEvent(var EventName: string; var Params: TUniStrings); virtual;
    procedure WebCreate; override;
    procedure ExecuteJQuery(jquery: string);
  published
    property About: string read FAbout;
    property Version: string read FVersion write FVersion;
  end;

implementation

{ TUniDSABaseComponent }

procedure TUniDSABaseComponent.AJAXEvent(var EventName: string; var Params: TUniStrings);
begin
end;

function TUniDSABaseComponent.AjaxRequest(EventName: string; Parametros: TArrayOfString = nil): string;
  function GetParametros: string;
  var
    k: Integer;
  begin
    Result := '[';

    for k := Low(Parametros) to High(Parametros) do
      Result := Result +  IIfStr(k <> Low(Parametros), ',', '') + QuotedStr(Parametros[k] + '=p' + IntToStr(k));

    Result := Result + ']'
  end;
begin
  Result :=
    ' ' +
    'function (p0) { ' +
    '  alert(p0); ' +
    '  ajaxRequest(' + IIfStr(Self.JSName = '', 'body', Self.JSName) + ', "' + EventName + '", ' + GetParametros +'); ' +
    '  $(".qrr-overlay").remove(); ' +
    '} ';
end;

constructor TUniDSABaseComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAbout := 'https://github.com/deividyalcantara?tab=repositories';
  FVersion := '1.1.0';
end;

destructor TUniDSABaseComponent.Destroy;
begin
  inherited Destroy;
end;

procedure TUniDSABaseComponent.DOHandleEvent(EventName: string; Params: TUniStrings);
var
  i: Integer;
begin
  inherited;
  for i := 0 to Params.Count - 1 do begin
    if Params.Objects[i] = nil then
      Continue;

    Params.ValueFromIndex[i] := IIfStr(Params.ValueFromIndex[i] = 'undefined', '', Params.ValueFromIndex[i]);
  end;

  AJAXEvent(EventName, Params);
end;

procedure TUniDSABaseComponent.ExecuteJQuery(jquery: string);
begin
  UniSession.AddJS(JQuery);
end;

function TUniDSABaseComponent.IIfStr(condicao: Boolean; verdadeiro, falso: string): string;
begin
  if condicao then
    Result := verdadeiro
  else
    Result := falso;
end;

function TUniDSABaseComponent.IIfVar(condicao: Boolean; verdadeiro, falso: Variant): Variant;
begin
  if condicao then
    Result := verdadeiro
  else
    Result := falso;
end;

procedure TUniDSABaseComponent.WebCreate;
begin
  inherited;
  JSComponent := TJSObject.JSCreate('Object');
end;

end.
