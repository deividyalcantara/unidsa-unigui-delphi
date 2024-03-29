unit UniDSABaseControl;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSAExecuteFunction, UniDSALibrary, uniGUITypes;

type
  TUniDSABaseControl = class(TUniControl)
  private
    FAbout: string;
    FVersion: string;
    FFontAwesome: string;
  public
    constructor Create(AOwner: TComponent); override;
    function IIfVar(ACondicao: Boolean; AVerdadeiro: Variant; AFalso: Variant): Variant;
    procedure JS(AScript: string);
  published
    property About: string read FAbout;
    property Version: string read FVersion;
    property FontAwesome: string read FFontAwesome;
  end;

implementation

{ TUniDSABaseControl }

constructor TUniDSABaseControl.Create(AOwner: TComponent);
begin
  inherited;
  FAbout := 'https://github.com/deividyalcantara?tab=repositories';
  FVersion := '1.1.0';
  FFontAwesome := '5.14.0';
end;

function TUniDSABaseControl.IIfVar(ACondicao: Boolean; AVerdadeiro, AFalso: Variant): Variant;
begin
  if ACondicao then
    Result := AVerdadeiro
  else
    Result := AFalso;
end;

procedure TUniDSABaseControl.JS(AScript: string);
begin
  if WebMode then
    JSCode(AScript);
end;

end.
