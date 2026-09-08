unit FrameLeitorQRCode;

interface

uses
  Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uniGUIFrame, uniGUIBaseClasses,
  uniGUIClasses, UniDSABase, UniDSAToast, uniButton, uniEdit, uniLabel, uniPanel,
  UniDSABaseControl, UniDSAQrCodeReader, FormLeitorQrCode, UniDSAExecuteFunction, DemoUI, UniDSAFlexPanel;

type
  TFrLeitorQrCode = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;
    lblSectionugbMensagem: TUniLabel;
    usbPrincipal: TUniDSAFlexPanel;
    ugbMensagem: TUniDSAFlexPanel;
    UniContainerPanel20: TUniDSAFlexPanel;
    UniContainerPanel23: TUniDSAFlexPanel;
    UniLabel16: TUniLabel;
    edtResultado: TUniEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    Toast: TUniDSAToast;
    qrcLeitor: TUniDSAQrCodeReader;
    UniContainerPanel22: TUniDSAFlexPanel;
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
  edtResultado.Text := FormLeitorQrCode.Ler(qrcLeitor.FPS, qrcLeitor.QrBox);
end;

procedure TFrLeitorQrCode.qrcLeitorAfterReading(Sender: TObject);
begin
  inherited;
  edtResultado.Text := TUniDSAQrCodeReader(Sender).Result;
end;

end.
