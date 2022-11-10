unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  uniStatusBar, uniPanel, uniHTMLFrame, UniDSAJQuery, UniDSABase, UniDSAConfirm,
  UniDSAToast;

type
  TMainForm = class(TUniForm)
    UniDSAConfirm1: TUniDSAConfirm;
    UniDSAToast1: TUniDSAToast;
    UniButton1: TUniButton;
    UniButton2: TUniButton;
    UniButton3: TUniButton;
    UniButton4: TUniButton;
    procedure UniDSAConfirm1Buttons0Click(Sender: TObject);
    procedure UniDSAConfirm1Buttons1Click(Sender: TObject);
    procedure UniDSAConfirm1Buttons2Click(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniDSAConfirm1ButtonClick(ButtonText, Result: string);
    procedure UniButton2Click(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.ButtonClick(Sender: TObject);
begin
  ShowMessage('Agendando o cliente ID ' + UniDSAConfirm1.Response);
end;

procedure TMainForm.UniButton1Click(Sender: TObject);
begin
  UniDSAConfirm1.Show;
end;

procedure TMainForm.UniButton2Click(Sender: TObject);
begin
  UniDSAToast1.Heading := 'Produto';
  UniDSAToast1.Text := 'Novo produto cadastrado!';
  UniDSAToast1.Show;
end;

procedure TMainForm.UniDSAConfirm1ButtonClick(ButtonText, Result: string);
begin
  if ButtonText = 'Cancelar' then
    ShowMessage('Cancelado...')
  else if AnsiUpperCase(ButtonText) = 'AGENDAR' then
    ShowMessage('Cliente ID: ' + Result);
  //else if ButtonText = 'Agendar' then begin
  //  ShowMessage('Cliente agendado para exclusão!');
  //end;
end;

procedure TMainForm.UniDSAConfirm1Buttons0Click(Sender: TObject);
begin
  ShowMessage('Sim');
end;

procedure TMainForm.UniDSAConfirm1Buttons1Click(Sender: TObject);
begin
  ShowMessage('Não');
end;

procedure TMainForm.UniDSAConfirm1Buttons2Click(Sender: TObject);
begin
  ShowMessage('Cancelar');
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
