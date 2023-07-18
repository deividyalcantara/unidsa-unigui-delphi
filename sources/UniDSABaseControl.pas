unit UniDSABaseControl;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSAJQuery, UniDSABrowser, UniDSALibrary, uniGUITypes;

type
  TUniDSABaseControl = class(TUniControl)
  private
    FAbout: string;
    FVersion: string;
  public
    constructor Create(AOwner: TComponent); override;
    function IIfVar(condicao: Boolean; verdadeiro: Variant; falso: Variant): Variant;
  published
    property About: string read FAbout;
    property Version: string read FVersion write FVersion;
  end;

implementation

{ TUniDSABaseControl }

constructor TUniDSABaseControl.Create(AOwner: TComponent);
begin
  inherited;
  FAbout := 'https://github.com/deividyalcantara?tab=repositories';
  FVersion := '1.1.0';
end;

function TUniDSABaseControl.IIfVar(condicao: Boolean; verdadeiro, falso: Variant): Variant;
begin
  if condicao then
    Result := verdadeiro
  else
    Result := falso;
end;

end.
