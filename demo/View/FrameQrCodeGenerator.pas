unit FrameQrCodeGenerator;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, uniGUIFrame, uniGUIBaseClasses, uniGUIClasses,
  uniLabel, uniEdit, uniButton, UniDSAFlexPanel, UniDSAQrCodeGenerator;

type
  TFrQrCodeGenerator = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;
    flexPrincipal: TUniDSAFlexPanel;
    lblTitle: TUniLabel;
    lblSubtitle: TUniLabel;
    flexCard: TUniDSAFlexPanel;
    lblSection: TUniLabel;
    flexInput: TUniDSAFlexPanel;
    edtContent: TUniEdit;
    btnGenerate: TUniButton;
    btnRequestData: TUniButton;
    lblStatus: TUniLabel;
    QrGenerator: TUniDSAQrCodeGenerator;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnRequestDataClick(Sender: TObject);
    procedure QrGeneratorData(Sender: TObject);
    procedure QrGeneratorGenerated(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TFrQrCodeGenerator.btnGenerateClick(Sender: TObject);
begin
  QrGenerator.Text := edtContent.Text;
  QrGenerator.Generate;
end;

procedure TFrQrCodeGenerator.btnRequestDataClick(Sender: TObject);
begin
  QrGenerator.RequestData;
end;

procedure TFrQrCodeGenerator.QrGeneratorData(Sender: TObject);
begin
  lblStatus.Caption := 'PNG Base64: ' + IntToStr(Length(QrGenerator.DataURL)) +
    ' caracteres | SVG: ' + IntToStr(Length(QrGenerator.SVG)) + ' caracteres';
end;

procedure TFrQrCodeGenerator.QrGeneratorGenerated(Sender: TObject);
begin
  lblStatus.Caption := 'QR Code atualizado com sucesso.';
end;

end.
