unit FrameBarcodeGenerator;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, uniGUIFrame, uniGUIBaseClasses,
  uniGUIClasses, uniLabel, uniEdit, uniButton, UniDSAFlexPanel,
  UniDSABarcodeGenerator;

type
  TFrBarcodeGenerator = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;
    flexPrincipal: TUniDSAFlexPanel;
    lblTitle: TUniLabel;
    lblSubtitle: TUniLabel;
    flexCard: TUniDSAFlexPanel;
    lblSection: TUniLabel;
    flexInput: TUniDSAFlexPanel;
    edtValue: TUniEdit;
    btnGenerate: TUniButton;
    btnRequestData: TUniButton;
    BarcodeGenerator: TUniDSABarcodeGenerator;
    lblStatus: TUniLabel;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnRequestDataClick(Sender: TObject);
    procedure BarcodeGeneratorData(Sender: TObject);
    procedure BarcodeGeneratorError(Sender: TObject);
    procedure BarcodeGeneratorGenerated(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TFrBarcodeGenerator.btnGenerateClick(Sender: TObject);
begin
  BarcodeGenerator.Value := edtValue.Text;
  BarcodeGenerator.Generate;
end;

procedure TFrBarcodeGenerator.btnRequestDataClick(Sender: TObject);
begin
  BarcodeGenerator.RequestData;
end;

procedure TFrBarcodeGenerator.BarcodeGeneratorData(Sender: TObject);
begin
  if BarcodeGenerator.Valid then
    lblStatus.Caption := 'PNG Base64: ' + IntToStr(Length(BarcodeGenerator.DataURL)) +
      ' caracteres | SVG: ' + IntToStr(Length(BarcodeGenerator.SVG)) + ' caracteres'
  else
    lblStatus.Caption := 'O valor atual nao e valido para o formato selecionado.';
end;

procedure TFrBarcodeGenerator.BarcodeGeneratorError(Sender: TObject);
begin
  lblStatus.Caption := BarcodeGenerator.LastError;
end;

procedure TFrBarcodeGenerator.BarcodeGeneratorGenerated(Sender: TObject);
begin
  lblStatus.Caption := 'Codigo de barras atualizado com sucesso.';
end;

end.
