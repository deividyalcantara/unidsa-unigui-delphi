unit FrameSignature;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, uniGUIFrame, uniGUIBaseClasses, uniGUIClasses,
  uniLabel, uniButton, UniDSAFlexPanel, UniDSASignature;

type
  TFrSignature = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;
    flexPrincipal: TUniDSAFlexPanel;
    lblTitle: TUniLabel;
    lblSubtitle: TUniLabel;
    flexCard: TUniDSAFlexPanel;
    lblSection: TUniLabel;
    Signature: TUniDSASignature;
    flexActions: TUniDSAFlexPanel;
    btnValidate: TUniButton;
    btnRequestValue: TUniButton;
    lblStatus: TUniLabel;
    procedure btnRequestValueClick(Sender: TObject);
    procedure btnValidateClick(Sender: TObject);
    procedure SignatureChange(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TFrSignature.btnRequestValueClick(Sender: TObject);
begin
  Signature.RequestValue;
end;

procedure TFrSignature.btnValidateClick(Sender: TObject);
begin
  if Signature.IsValid then
    lblStatus.Caption := 'Assinatura valida e pronta para salvar.'
  else
    lblStatus.Caption := 'A assinatura e obrigatoria.';
end;

procedure TFrSignature.SignatureChange(Sender: TObject);
begin
  if Signature.Empty then
    lblStatus.Caption := 'A area de assinatura esta vazia.'
  else
    lblStatus.Caption := 'Assinatura capturada: ' +
      IntToStr(Length(Signature.Value)) + ' caracteres em Base64.';
end;

end.
