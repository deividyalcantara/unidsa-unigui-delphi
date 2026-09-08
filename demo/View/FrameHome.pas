unit FrameHome;

interface

uses
  Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uniGUIFrame, uniGUIBaseClasses,
  uniGUIClasses, UniDSABase, UniDSAToast, uniButton, uniEdit, uniLabel, uniPanel,
  UniDSABaseControl, UniDSAKanban, UniDSAFlexPanel, UniDSAExecuteFunction, DemoUI;

type
  TFrHome = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;

    UniLabel2: TUniLabel;
    UniLabel1: TUniLabel;
  end;

implementation

{$R *.dfm}

end.
