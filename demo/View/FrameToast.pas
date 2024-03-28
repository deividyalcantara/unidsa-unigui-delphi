unit FrameToast;

interface

uses
  Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrameBase, UniDSAJQuery, uniGUIBaseClasses,
  uniGUIClasses, UniDSABase, UniDSAToast, uniButton, uniEdit, uniLabel, uniPanel,
  uniGroupBox, uniScrollBox;

type
  TFrToast = class(TFrBase)
    Toast: TUniDSAToast;
    usbPrincipal: TUniScrollBox;
    ugbMensagem: TUniGroupBox;
    UniContainerPanel20: TUniContainerPanel;
    UniContainerPanel23: TUniContainerPanel;
    UniLabel16: TUniLabel;
    edtTitulo: TUniEdit;
    UniContainerPanel21: TUniContainerPanel;
    UniLabel15: TUniLabel;
    edtMensagem: TUniEdit;
    UniContainerPanel22: TUniContainerPanel;
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
  Toast.Text := edtTitulo.Text;
  Toast.Show;
end;

end.
