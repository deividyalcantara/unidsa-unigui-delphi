unit FrameHome;

interface

uses
  Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uniGUIFrame, uniGUIBaseClasses,
  uniGUIClasses, UniDSABase, UniDSAToast, uniButton, uniEdit, uniLabel, uniPanel,
  uniGroupBox, uniScrollBox;

type
  TFrHome = class(TUniFrame)
    UniLabel2: TUniLabel;
    UniLabel1: TUniLabel;
  end;

implementation

{$R *.dfm}

end.
