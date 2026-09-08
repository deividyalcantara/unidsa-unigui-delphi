unit FrameBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Vcl.Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, DemoUI, UniDSAFlexPanel;

type
  TFrBase = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;

  end;

implementation

{$R *.dfm}

{ TFrBase }

end.
