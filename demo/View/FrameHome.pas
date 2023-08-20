unit FrameHome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrameBase, UniDSAJQuery, uniGUIBaseClasses, uniGUIClasses, UniDSABase, UniDSAToast, uniButton, uniEdit, uniLabel, uniPanel,
  uniGroupBox, uniScrollBox;

type
  TFrHome = class(TFrBase)
    UniLabel2: TUniLabel;
    UniLabel1: TUniLabel;
  end;

implementation

{$R *.dfm}

end.
