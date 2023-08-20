unit FormLeitorQrCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, UniDSABaseControl, UniDSAQrCodeReader;

type
  TFrmLeitorQrCode = class(TUniForm)
    qrcLeitor: TUniDSAQrCodeReader;
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrcLeitorAfterReading(Sender: TObject);
  end;

function Ler: string;

implementation

uses
  uniGUIApplication;

{$R *.dfm}

function Ler: string;
var
  LForm: TFrmLeitorQrCode;
begin
  Result := '';
  LForm := TFrmLeitorQrCode.Create(UniApplication);
  if LForm.ShowModal() = mrOk then begin
    Result := LForm.qrcLeitor.Result;
    LForm.qrcLeitor.Stop;
  end;
  LForm.Free;
end;


procedure TFrmLeitorQrCode.qrcLeitorAfterReading(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmLeitorQrCode.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

end.
