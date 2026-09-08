unit FrameToast;

interface

uses
  Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uniGUIFrame, uniGUIBaseClasses,
  uniGUIClasses, UniDSABase, UniDSAToast, uniButton, uniEdit, uniLabel, uniPanel,
  UniDSAExecuteFunction, DemoUI, UniDSAFlexPanel;

type
  TFrToast = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;
    lblSectionugbMensagem: TUniLabel;
    Toast: TUniDSAToast;
    usbPrincipal: TUniDSAFlexPanel;
    ugbMensagem: TUniDSAFlexPanel;
    UniContainerPanel20: TUniDSAFlexPanel;
    UniContainerPanel23: TUniDSAFlexPanel;
    UniLabel16: TUniLabel;
    edtTitulo: TUniEdit;
    UniContainerPanel21: TUniDSAFlexPanel;
    UniLabel15: TUniLabel;
    edtMensagem: TUniEdit;
    UniContainerPanel22: TUniDSAFlexPanel;
    btnMostrar: TUniButton;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    procedure btnMostrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrToast: TFrToast;

implementation

{$R *.dfm}

procedure TFrToast.btnMostrarClick(Sender: TObject);
begin
  inherited;
  Toast.Heading := edtTitulo.Text;
  Toast.Text := edtMensagem.Text;
  Toast.Show;
end;

end.
