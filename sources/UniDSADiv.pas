unit UniDSADiv;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSABaseControl, UniDSAExecuteFunction, uniGUITypes,
 System.TypInfo, UniDSALibrary, System.Variants, Vcl.Graphics, UniDSASource, Vcl.Controls,
 System.Types, uniPanel, uniGUIInterfaces;

type
  // Div em desenvolvimento ....

  TUniDSADiv = class(TUniControl)
  protected
    procedure WebCreate; override;
  public
    constructor Create(AOwner:TComponent); override;
  published
    property Align;
    property Height;
    property Width;
    property Visible;
  end;

implementation

{ TUniDSADiv }

constructor TUniDSADiv.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TUniDSADiv.WebCreate;
begin
  inherited;
  JSCls := 'x-uni-dsa-div-' + JSName;
end;

end.
