unit UniDSALogin;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSABaseControl, UniDSAExecuteFunction, uniGUITypes,
 System.TypInfo, UniDSALibrary, System.Variants, Vcl.Graphics, UniDSASource, Vcl.Controls,
 System.Types, UniDSAControl;

type
  TUniDSALogin = class(TUniDSABaseControl)
  private
    FOnLoginNow: TNotifyEvent;
    FOnCreateAccount: TNotifyEvent;
    FOnForgetPassword: TNotifyEvent;
    FLoginNow: TUniDSAButton;
    FCreateAccount: TUniDSAButton;
    FRememberMe: TUniDSACheckBox;
    FForgetPassword: TUniDSAButtonText;
    FSlide: TUniDSALoginImage;
    FLogin: TUniDSAInput;
    FPassword: TUniDSAInput;
    FLogo: TUniDSALoginImage;    
    FTitle: string;
    FDescription: string;
    FTrimSpacesOnRememberMeForgetPassword: Boolean;
    FOnRememberMe: TNotifyEvent;
    FOnLoginEnter: TNotifyEvent;
    FOnPasswordEnter: TNotifyEvent;

    procedure PrepareHtml;
    procedure PrepareJS;
    procedure PrepareDefault;
    
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    function GetDescription: string;
    procedure SetDescription(const Value: string);
    function GetTrimSpacesOnRememberMeForgetPassword: Boolean;
    procedure SetTrimSpacesOnRememberMeForgetPassword(const Value: Boolean);
  protected
    procedure JSEventHandler(AEventName: string; AParams: TUniStrings); override;
    procedure LoadCompleted; override;
    procedure WebCreate; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    
    property LoginNow: TUniDSAButton read FLoginNow write FLoginNow;
    property CreateAccount: TUniDSAButton read FCreateAccount write FCreateAccount;
    property RememberMe: TUniDSACheckBox read FRememberMe write FRememberMe;
    property ForgetPassword: TUniDSAButtonText read FForgetPassword write FForgetPassword;
    property Login: TUniDSAInput read FLogin write FLogin;
    property Slide: TUniDSALoginImage read FSlide write FSlide;
    property Password: TUniDSAInput read FPassword write FPassword;
    property Title: string read GetTitle write SetTitle;
    property Description: string read GetDescription write SetDescription;
    property Logo: TUniDSALoginImage read FLogo write FLogo;
    property TrimSpacesOnRememberMeForgetPassword: Boolean read GetTrimSpacesOnRememberMeForgetPassword write SetTrimSpacesOnRememberMeForgetPassword;
   
    property OnLoginNow: TNotifyEvent  read FonLoginNow write FonLoginNow;
    property OnCreateAccount: TNotifyEvent read FOnCreateAccount write FOnCreateAccount;
    property OnRememberMe: TNotifyEvent read FOnRememberMe write FOnRememberMe;
    property OnLoginEnter: TNotifyEvent read FOnLoginEnter write FOnLoginEnter;
    property OnPasswordEnter: TNotifyEvent read FOnPasswordEnter write FOnPasswordEnter;
    property OnForgetPassword: TNotifyEvent read FOnForgetPassword write FOnForgetPassword;
  end;

procedure Register;

implementation

{ TUniDSALogin }

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSALogin]);
end;


constructor TUniDSALogin.Create(AOwner: TComponent);
begin
  inherited;

  Align := TAlign.alClient;
  
  FLoginNow := TUniDSAButton.Create(
    Self,
    '#un-lg-login-now',
    'Entrar',
    True,
    90
  );
  
  FCreateAccount := TUniDSAButton.Create(
    Self,
    '#un-lg-create-account',
    'Nova conta',
    True,
    90   
  );
  
  FRememberMe := TUniDSACheckBox.Create(
    Self,
    '#un-lg-login-remember-me',
    '#un-lg-rm-ck',
    'Lembrar da senha',
    True    
  );
  
  ForgetPassword := TUniDSAButtonText.Create(
    Self,
    '#un-lg-forget-password',
    '',
    'Esqueceu a senha?',
    True
  );
  
  FLogin := TUniDSAInput.Create(Self, '#un-lg-lg-login', 'un-lg-gp-lg-r-title-caption', 'Email:', '');
  
  FPassword := TUniDSAInput.Create(Self, '#un-lg-lg-password', '#un-lg-gp-lg-r-title-password', 'Senha:', '');
  
  FSlide := TUniDSALoginImage.Create(
    Self,
    '#un-lg-img-demo-img',
    'https://i.ibb.co/QpmYjyw/working.png',
    100,
    40
  );
  
  FLogo := TUniDSALoginImage.Create(
    Self,
    'un-lg-logo-left-img',
    'https://i.ibb.co/4TTX0b6/logo-login-2.png',
    0,
    0
  );
  
  Description := 'Para permanecer conectado conosco, por favor faça login com suas informações pessoais usando seu endereço de e-mail e senha 🔔';
  Title := 'Bem-vindo de volta :)';
  TrimSpacesOnRememberMeForgetPassword := False;
end;

destructor TUniDSALogin.Destroy;
begin
  inherited;
  FreeAndNil(FLoginNow);
  FreeAndNil(FCreateAccount);
  FreeAndNil(FRememberMe);
  FreeAndNil(FForgetPassword);
  FreeAndNil(FLogin);
  FreeAndNil(FPassword);
  FreeAndNil(FSlide);
  FreeAndNil(FLogo);
end;

function TUniDSALogin.GetDescription: string;
begin
  Result := FDescription;
end;

function TUniDSALogin.GetTitle: string;
begin
  Result := FTitle;
end;

function TUniDSALogin.GetTrimSpacesOnRememberMeForgetPassword: Boolean;
begin
  Result := FTrimSpacesOnRememberMeForgetPassword;
end;

procedure TUniDSALogin.JSEventHandler(AEventName: string; AParams: TUniStrings);
begin
  inherited;
  if AEventName = 'UniDSALoginLoginOnInput' then begin
    if Assigned(FLogin) then
      FLogin.Value := AParams.Values['texto']
  end
  else if AEventName = 'UniDSALoginPasswordOnInput' then begin
    if Assigned(FPassword) then
      FPassword.Value := AParams.Values['texto']
  end
  else if AEventName = 'UniDSALoginLoginNowOnClick' then begin
    if Assigned(FOnLoginNow) then
      FOnLoginNow(nil);
  end
  else if AEventName = 'UniDSALoginCreateAccountOnClick' then begin
    if Assigned(FOnCreateAccount) then
      FOnCreateAccount(nil);
  end
  else if AEventName = 'UniDSALoginRememberMeOnClick' then begin
    FRememberMe.SetVarChecked(IIf(AParams.Values['checked'] = 'S', True, False));

    if Assigned(FOnRememberMe) then
      FOnRememberMe(nil);
  end
  else if AEventName = 'UniDSALoginForgetPasswordOnClick' then begin
    if Assigned(FOnForgetPassword) then
      FOnForgetPassword(nil);
  end
  else if AEventName = 'UniDSALoginLoginOnEnter' then begin
    if Assigned(FOnLoginEnter) then
      FOnLoginEnter(nil);
  end
  else if AEventName = 'UniDSALoginPasswordOnEnter' then begin
    if Assigned(FOnPasswordEnter) then
      FOnPasswordEnter(nil);
  end;
end;

procedure TUniDSALogin.LoadCompleted;
begin
  inherited;
  PrepareJS;
  PrepareDefault;
  PrepareHTML;
end;

procedure TUniDSALogin.PrepareDefault;
begin
  TrimSpacesOnRememberMeForgetPassword := TrimSpacesOnRememberMeForgetPassword;

  CreateAccount.Refresh;
  LoginNow.Refresh;
  Login.Refresh;
  Password.Refresh;
  RememberMe.Refresh;
  ForgetPassword.Refresh;
  Slide.Refresh;
end;

procedure TUniDSALogin.PrepareHtml;
var
  LHTML: TStringBuilder;
begin
  if WebMode then begin
    LHTML := TStringBuilder.Create;

    try
      with LHTML do begin
        Append('<!DOCTYPE html>');
        Append('<html>');
        Append('  <head>');
        Append('    <meta charset="UTF-8">');
        Append('    <meta name="viewport" content="width=device-width, initial-scale=1.0">');
        Append('    <title>fdsfsd</title>');
        Append('    <meta name="description" content="">');
        Append('    <meta name="viewport" content="width=device-width, initial-scale=1">');
        Append('    <link rel="stylesheet" href="estilo.css">');
        Append('    <link rel="preconnect" href="https://fonts.googleapis.com"> ');
        Append('    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>');
        Append('    <link rel="preconnect" href="https://fonts.googleapis.com">');
        Append('    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>');
        Append('    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">');
        Append('  </head>');
        Append('  <body>  ');
        Append('    <div class="un-lg-bg">');
        Append('      <div class="un-lg-shape">');
        Append('        <svg id="sw-js-blob-svg" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" version="1.1">');
        Append('        <defs> ');
        Append('        <linearGradient id="sw-gradient" x1="0" x2="1" y1="1" y2="0">');
        Append('        <stop id="stop1" stop-color="rgba(145, 235, 228, 1)" offset="0%"></stop>');
        Append('        <stop id="stop2" stop-color="rgba(145, 235, 228, 1)" offset="100%"></stop>');
        Append('        </linearGradient>');
        Append('        </defs>');
        Append('        <path fill="url(#sw-gradient)" d="M25.7,-34.6C32.4,-30.6,36.1,-21.8,39.1,-12.6C42.2,-3.5,44.6,5.9,41.2,12.5C37.8,19.1,28.6,22.9,20.8,27.9C12.9,33,6.5,39.3,-0.2,39.6C-6.8,39.8,-13.7,34,-19.4,28.3C-25.2,22.6,-29.9,16.9,-33.7,9.8C-37.5,2.8,-40.4,-5.6,-38.1,-12.3C-35.8,-18.9,-28.3,-23.8,-21.1,-27.5C-13.9,-31.3,-6.9,-33.9,1.3,-35.7C9.6,-37.6,19.1,-38.5,25.7,-34.6Z" width="100%" height="100%" transform="translate(50 50)" stroke-width="0" style="transition: all 0.3s ease 0s;" stroke="url(#sw-gradient)"></path>');
        Append('        </svg>');
        Append('      </div>');
        Append('      <div class="un-lg-login">');
        Append('        <div class="un-lg-logo">');
        Append('          <div class="un-lg-logo-left">');
        Append('            <img id="un-lg-logo-left-img" src="' + FLogo.Image + '" alt="Logo">');
        Append('          </div>');
        Append('        </div>');
        Append('        <div class="un-lg-img-submit">');
        Append('          <div class="un-lg-img-demo">');
        Append('            <img id="un-lg-img-demo-img" src="' + FSlide.Image + '"/>');
        Append('          </div>');
        Append('          <div class="un-lg-submit">');
        Append('            <span class="un-lg-welcome-back" id="un-lg-id-welcome-back">' + FTitle + '</span>');
        Append('            <span class="un-lg-msg-extra" id="un-lg-id-msg-extra">' + FDescription + '</span>');
        Append('            <div class="un-lg-gp-login">');
        Append('              <div class="un-lg-gp-login-left">');
        Append('                <svg height="14" width="14px" version="1.1" id="_x32_" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" ');
        Append('                viewBox="0 0 512 512"  xml:space="preserve">');
        Append('                <style type="text/css">');
        Append('                .st0{fill:#a4afc9;}');
        Append('                </style>');
        Append('                <g>');
        Append('                <path class="st0" d="M510.678,112.275c-2.308-11.626-7.463-22.265-14.662-31.054c-1.518-1.915-3.104-3.63-4.823-5.345');
        Append('                c-12.755-12.818-30.657-20.814-50.214-20.814H71.021c-19.557,0-37.395,7.996-50.21,20.814c-1.715,1.715-3.301,3.43-4.823,5.345');
        Append('                C8.785,90.009,3.63,100.649,1.386,112.275C0.464,116.762,0,121.399,0,126.087V385.92c0,9.968,2.114,19.55,5.884,28.203');
        Append('                c3.497,8.26,8.653,15.734,14.926,22.001c1.59,1.586,3.169,3.044,4.892,4.494c12.286,10.175,28.145,16.32,45.319,16.32h369.958');
        Append('                c17.18,0,33.108-6.145,45.323-16.384c1.718-1.386,3.305-2.844,4.891-4.43c6.27-6.267,11.425-13.741,14.994-22.001v-0.064');
        Append('                c3.769-8.653,5.812-18.171,5.812-28.138V126.087C512,121.399,511.543,116.762,510.678,112.275z M46.509,101.571');
        Append('                c6.345-6.338,14.866-10.175,24.512-10.175h369.958c9.646,0,18.242,3.837,24.512,10.175c1.122,1.129,2.179,2.387,3.112,3.637');
        Append('                L274.696,274.203c-5.348,4.687-11.954,7.002-18.696,7.002c-6.674,0-13.276-2.315-18.695-7.002L43.472,105.136');
        Append('                C44.33,103.886,45.387,102.7,46.509,101.571z M36.334,385.92V142.735L176.658,265.15L36.405,387.435');
        Append('                C36.334,386.971,36.334,386.449,36.334,385.92z M440.979,420.597H71.021c-6.281,0-12.158-1.651-17.174-4.552l147.978-128.959');
        Append('                l13.815,12.018c11.561,10.046,26.028,15.134,40.36,15.134c14.406,0,28.872-5.088,40.432-15.134l13.808-12.018l147.92,128.959');
        Append('                C453.137,418.946,447.26,420.597,440.979,420.597z M475.666,385.92c0,0.529,0,1.051-0.068,1.515L335.346,265.221L475.666,142.8');
        Append('                V385.92z"/>');
        Append('                </g>');
        Append('                </svg>');
        Append('              </div>');
        Append('              <div class="un-lg-gp-login-right">');
        Append('                <span class="un-lg-gp-lg-r-title" id="un-lg-gp-lg-r-title-caption">' + FLogin.Caption + '</span>');
        Append('                <input id="un-lg-lg-login" onkeydown="UniDSALoginLoginOnKeyDown(' + JSName + ', event)" onInput="UniDSALoginLoginOnInput(' + JSName + ', event)" type="text">');
        Append('              </div>');
        Append('            </div>');

        Append('            <div class="un-lg-gp-password">');
        Append('              <div class="un-lg-gp-password-left">');
        Append('                <svg height="16" width="16px"  viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#a4afc9"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M12 14.5V16.5M7 10.0288C7.47142 10 8.05259 10 8.8 10H15.2C15.9474 10 16.5286 10 17 10.0288M7 10.0288C6.41168 10.0647 5.99429 10.1455 5.63803 10.327C5.07354 10.6146 4.6146 11.0735 4.32698 11.638C4 12.2798 4 13.1198 4 14.8V16.2C4 17.8802 4 18.7202 4.32698 19.362C4.6146 19.9265 5.07354 20.3854 5.63803 20.673C6.27976 21 7.11984 21 8.8 21H15.2C16.8802 21 17.7202 21 18.362 20.673C18.9265 20.3854 19.3854 19.9265 19.673 19.362C20 18.7202 20 17.8802 20 16.2V14.8C20 13.1198 20 12.2798 19.673 11.638C19.3854 11.0735 18.9265 10.6146 18.362 10.327C18.0057 10.1455 17.5883 10.0647 17 10.0288M7 10.0288V8C7 5.23858 9.23858 3 12 3C14.7614 3 ');
        Append(' 17 5.23858 17 8V10.0288" stroke="#a4afc9" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>');
        Append('              </div>');
        Append('              <div class="un-lg-gp-password-right">');
        Append('                <span class="un-lg-gp-lg-r-title" id="un-lg-gp-lg-r-title-password">' + FPassword.Caption + '</span>');
        Append('                <input id="un-lg-lg-password" onkeydown="UniDSALoginPasswordOnKeyDown(' + JSName + ', event)" onInput="UniDSALoginPasswordOnInput(' + JSName + ', event)" type="password">');
        Append('              </div>');
        Append('            </div>  ');

        Append('            <div class="un-lg-rm-fp">');
        Append('              <div class="un-lg-remember-me">');
        Append('                <input type="checkbox" id="un-lg-rm-ck" onClick="UniDSALoginRememberMeOnClick(' + JSName + ', event)">');
        Append('                <label id="un-lg-login-remember-me" for="un-lg-rm-ck">' + FRememberMe.Caption + '</label>');
        Append('              </div>');
        Append('              <div class="un-lg-forget-password">');
        Append('                <span class="un-lg-action-forget-password" id="un-lg-forget-password" onClick="UniDSALoginForgetPasswordOnClick(' + JSName + ')">' + FForgetPassword.Caption + '</span>');
        Append('              </div>');
        Append('            </div> ');

        Append('            <div class="un-lg-login-now-create-account">');
        Append('              <div id="un-lg-login-now" onClick="UniDSALoginLoginNowOnClick(' + JSName + ')">' + FLoginNow.Caption + '</div>');
        Append('              <div id="un-lg-create-account" onClick="UniDSALoginCreateAccountOnClick(' + JSName + ')">' + FCreateAccount.Caption + '</div>');
        Append('            </div>');

        Append('          </div>');
        Append('        </div>');
        Append('      </div>');
        Append('    </div>   ');
        Append('  </body>');
        Append('</html>');

        Caption := LHTML.ToString;
      end;
    finally
      FreeAndNil(LHTML);
    end;
  end;
end;

procedure TUniDSALogin.PrepareJS;
begin
end;

procedure TUniDSALogin.SetDescription(const Value: string);
begin
  JQueryText('#un-lg-id-msg-extra', Value);

  FDescription := Value;
end;

procedure TUniDSALogin.SetTitle(const Value: string);
begin
  JQueryText('#un-lg-id-welcome-back', Value);

  FTitle := Value;
end;

procedure TUniDSALogin.SetTrimSpacesOnRememberMeForgetPassword(const Value: Boolean);
begin
  if Value then
    JQueryHide('.un-lg-rm-fp')
  else
    JQueryShow('.un-lg-rm-fp');

  FTrimSpacesOnRememberMeForgetPassword := Value;
end;

procedure TUniDSALogin.WebCreate;
begin
  inherited;
  JSCls := 'x-uni-dsa-login';
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.Login);

end.
