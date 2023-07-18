unit LeitorQrCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, UniDSABaseControl,
  UniDSAQrCodeReader;

type
  TFormLeitorQrCode = class(TUniForm)
    UniDSAQrCodeReader1: TUniDSAQrCodeReader;
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniDSAQrCodeReader1AfterReading(Sender: TObject);
  end;

function RealizarLeituraQrCode: string;

implementation

uses
  uniGUIApplication;

function RealizarLeituraQrCode: string;
var
  form: TFormLeitorQrCode;
begin
  form := TFormLeitorQrCode.Create(UniApplication);
  with form do begin
    ShowModal();
    Result := UniDSAQrCodeReader1.Result;
  end;
  //form.Free;
end;

{$R *.dfm}

procedure TFormLeitorQrCode.UniDSAQrCodeReader1AfterReading(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormLeitorQrCode.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

end.
