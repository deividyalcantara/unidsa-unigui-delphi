unit FrameLeitorQRCode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrameBase, UniDSAJQuery, uniGUIBaseClasses, uniGUIClasses, UniDSABase, UniDSAToast, uniButton, uniEdit, uniLabel, uniPanel,
  uniGroupBox, uniScrollBox, UniDSABaseControl, UniDSAQrCodeReader, FormLeitorQrCode;

type
  TFrLeitorQrCode = class(TFrBase)
    usbPrincipal: TUniScrollBox;
    ugbMensagem: TUniGroupBox;
    UniContainerPanel20: TUniContainerPanel;
    UniContainerPanel23: TUniContainerPanel;
    UniLabel16: TUniLabel;
    edtResultado: TUniEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    Toast: TUniDSAToast;
    qrcLeitor: TUniDSAQrCodeReader;
    UniContainerPanel22: TUniContainerPanel;
    btnLeitura: TUniButton;
    procedure qrcLeitorAfterReading(Sender: TObject);
    procedure btnLeituraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrLeitorQrCode: TFrLeitorQrCode;

implementation

{$R *.dfm}

procedure TFrLeitorQrCode.btnLeituraClick(Sender: TObject);
begin
  inherited;
  qrcLeitor.Stop;
  edtResultado.Text := FormLeitorQrCode.Ler;
end;

procedure TFrLeitorQrCode.qrcLeitorAfterReading(Sender: TObject);
begin
  inherited;
  edtResultado.Text := TUniDSAQrCodeReader(Sender).Result;
end;

end.
