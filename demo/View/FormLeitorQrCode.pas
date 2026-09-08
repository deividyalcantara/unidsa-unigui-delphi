unit FormLeitorQrCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, UniDSABaseControl, UniDSAQrCodeReader,
  UniDSAFlexPanel, UniDSAFormStyle, DemoUI, System.Math;

type
  TFrmLeitorQrCode = class(TUniForm)
    qrcLeitor: TUniDSAQrCodeReader;
    flexDemoPage: TUniDSAFlexPanel;
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrcLeitorAfterReading(Sender: TObject);
  end;

function Ler(AFPS: Integer = 10; AQrBox: Integer = 180): string;

implementation

uses
  uniGUIApplication;

{$R *.dfm}

function Ler(AFPS, AQrBox: Integer): string;
var
  LForm: TFrmLeitorQrCode;
  LStyle: TUniDSAFormStyle;
begin
  Result := '';
  LForm := TFrmLeitorQrCode.Create(UniApplication);
  try
    LForm.AlignmentControl := uniAlignmentClient;
    LForm.Layout := 'fit';
    DemoClass(LForm.flexDemoPage, 'demo-page demo-modal');
    LStyle := TUniDSAFormStyle.Create(LForm);
    LStyle.Sizing.AutoHeight := False;
    LStyle.Sizing.MaxWidth := 560;
    LStyle.Sizing.MaxHeight := 650;
    LStyle.Sizing.ViewportMargin := 16;
    LForm.qrcLeitor := TUniDSAQrCodeReader.Create(LForm);
    LForm.qrcLeitor.FPS := EnsureRange(AFPS, 1, 30);
    LForm.qrcLeitor.QrBox := EnsureRange(AQrBox, 80, 220);
    LForm.qrcLeitor.SingleRead := True;
    LForm.qrcLeitor.Height := 420;
    LForm.qrcLeitor.OnAfterReading := LForm.qrcLeitorAfterReading;
    LForm.qrcLeitor.Parent := LForm.flexDemoPage;
    if LForm.ShowModal() = mrOk then
      Result := LForm.qrcLeitor.Result;
  finally
    if Assigned(LForm.qrcLeitor) then LForm.qrcLeitor.Stop;
    LForm.Free;
  end;
end;


procedure TFrmLeitorQrCode.qrcLeitorAfterReading(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmLeitorQrCode.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caHide;
end;

end.
