unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, UniDSABaseControl, UniDSALogin, UniDSAExecuteFunction, UniDSABase, UniDSAConfirm, uniSweetAlert;

type
  TFormLogin = class(TUniLoginForm)
    dsaLogin: TUniDSALogin;
    saAlerta: TUniSweetAlert;
    function IfThenStr(ACondicao: Boolean; AVerdadeiro: string; AFalso: string): string;
    procedure dsaLoginLoginNow(Sender: TObject);
    procedure dsaLoginRememberMe(Sender: TObject);
    procedure dsaLoginForgetPassword(Sender: TObject);
    procedure dsaLoginPasswordEnter(Sender: TObject);
    procedure dsaLoginLoginEnter(Sender: TObject);
    procedure ProcedimentoFocusEmail(Sender: TObject);
    procedure ProcedimentoFocusSenha(Sender: TObject);
    procedure ProcedimentoAposEsquecerSenha(Sender: TObject);
    procedure UniLoginFormCreate(Sender: TObject);
    procedure dsaLoginCreateAccount(Sender: TObject);
  private
    FTentativaLogin: Integer;
    FAdminHabilitado: Boolean;
  end;

function FormLogin: TFormLogin;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function FormLogin: TFormLogin;
begin
  Result := TFormLogin(UniMainModule.GetFormInstance(TFormLogin));
end;

procedure TFormLogin.dsaLoginCreateAccount(Sender: TObject);
begin
  saAlerta.OnConfirm := nil;
  saAlerta.Title := 'Criação de conta!';
  saAlerta.AlertType := TAlertType.atSuccess;
  saAlerta.Show('Conta criada! E-mail: admin, senha: admin');
  FAdminHabilitado := True;
end;

procedure TFormLogin.dsaLoginForgetPassword(Sender: TObject);
begin
  saAlerta.OnConfirm := ProcedimentoAposEsquecerSenha;
  saAlerta.Title := 'Esqueceu a senha';
  saAlerta.AlertType := TAlertType.atSuccess;
  saAlerta.Show('Utilize o acesso de convidado, e-mail: convidado, senha: convidado');
end;

procedure TFormLogin.dsaLoginLoginEnter(Sender: TObject);
begin
  dsaLogin.Password.SetFocus;
end;

procedure TFormLogin.dsaLoginLoginNow(Sender: TObject);
begin
  saAlerta.OnConfirm := nil;

  if Trim(dsaLogin.Login.Value).IsEmpty then begin
    saAlerta.OnConfirm := ProcedimentoFocusEmail;
    saAlerta.Title := 'Login';
    saAlerta.AlertType := TAlertType.atWarning;
    saAlerta.Show('Preencha o campo e-mail e tente novamente!');
    Exit;
  end;

  if Trim(dsaLogin.Password.Value).IsEmpty then begin
    saAlerta.OnConfirm := ProcedimentoFocusSenha;
    saAlerta.Title := 'Login';
    saAlerta.AlertType := TAlertType.atWarning;
    saAlerta.Show('Preencha o campo senha e tente novamente!');
    Exit;
  end;

  if
    (
      (dsaLogin.Login.Value = 'convidado') and
      (dsaLogin.Password.Value = 'convidado')
    ) or
    (
      FAdminHabilitado and
      (dsaLogin.Login.Value = 'admin') and
      (dsaLogin.Password.Value = 'admin')
    )
  then begin
    ModalResult := mrOk;
  end
  else begin
    if FTentativaLogin = 3 then begin
      saAlerta.Title := 'Login';
      saAlerta.AlertType := TAlertType.atError;
      saAlerta.Show('Desculpe, parece que houve mais de três tentativas incorretas de login. Utilize o "Esqueceu a senha?".');

      dsaLogin.Login.Enabled := False;
      dsaLogin.Password.Enabled := False;

      dsaLogin.Login.Clear;
      dsaLogin.Password.Clear;

      Exit;
    end;

    saAlerta.Title := 'Login';
    saAlerta.AlertType := TAlertType.atInfo;
    saAlerta.Show('E-mail ou senha inválidos. Por favor, tente novamente.');
    Inc(FTentativaLogin);
  end;
end;

procedure TFormLogin.dsaLoginPasswordEnter(Sender: TObject);
begin
  dsaLoginLoginNow(nil);
end;

procedure TFormLogin.dsaLoginRememberMe(Sender: TObject);
begin
  saAlerta.Title := 'Lembrar da senha';
  saAlerta.AlertType := TAlertType.atInfo;
  saAlerta.Show(
    'Opção marcada: ' + IfThenStr(dsaLogin.RememberMe.Checked, '"Sim"', '"Não"') + ' || ' +
    'Título: ' + dsaLogin.RememberMe.Caption +  ' || ' +
    'Visível: ' + IfThenStr(dsaLogin.RememberMe.Visible, '"Sim"', '"Não"')
  );
end;

procedure TFormLogin.ProcedimentoAposEsquecerSenha(Sender: TObject);
begin
  FTentativaLogin := 1;
  dsaLogin.Login.Enabled := True;
  dsaLogin.Password.Enabled := True;
  dsaLogin.Login.SetFocus;
end;

procedure TFormLogin.ProcedimentoFocusEmail(Sender: TObject);
begin
  dsaLogin.Login.SetFocus;
end;

procedure TFormLogin.ProcedimentoFocusSenha(Sender: TObject);
begin
  dsaLogin.Password.SetFocus;
end;

function TFormLogin.IfThenStr(ACondicao: Boolean; AVerdadeiro, AFalso: string): string;
begin
  if ACondicao then
    Result := AVerdadeiro
  else
    Result := AFalso;
end;

procedure TFormLogin.UniLoginFormCreate(Sender: TObject);
begin
  FTentativaLogin := 1;
  FAdminHabilitado := False;
end;

initialization
  RegisterAppFormClass(TFormLogin);

end.
