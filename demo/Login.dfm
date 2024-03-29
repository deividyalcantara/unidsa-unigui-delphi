object FormLogin: TFormLogin
  Left = 0
  Top = 0
  ClientHeight = 677
  ClientWidth = 904
  Caption = 'FormLogin'
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.onresize = function(){'
    '  if (typeof FormLogin !== '#39'undefined'#39') {  '
    '    var getSize = Ext.getBody().getViewSize(),'
    '        winWidth = getSize.width,'
    '        winHeight = getSize.height,'
    '        left = (winWidth - FormLogin.window.width) / 2,'
    '        top = (winHeight - FormLogin.window.height) / 2;'
    ''
    '    FormLogin.window.setPosition(left, top);'
    '  }'
    '}')
  Visible = True
  OnCreate = UniLoginFormCreate
  TextHeight = 15
  object dsaLogin: TUniDSALogin
    Left = 0
    Top = 0
    Width = 904
    Height = 677
    Hint = ''
    Align = alClient
    LoginNow.Visible = True
    LoginNow.Caption = 'Entrar'
    LoginNow.Width = 90
    CreateAccount.Visible = True
    CreateAccount.Caption = 'Nova conta'
    CreateAccount.Width = 90
    RememberMe.Visible = True
    RememberMe.Caption = 'Lembrar da senha'
    RememberMe.Checked = False
    ForgetPassword.Visible = True
    ForgetPassword.Caption = 'Esqueceu a senha?'
    Login.Caption = 'Email:'
    Login.Enabled = False
    Slide.Image = 'https://i.ibb.co/QpmYjyw/working.png'
    Slide.MarginTop = 100
    Slide.MarginLeft = 40
    Password.Caption = 'Senha:'
    Password.Enabled = False
    Title = 'Bem-vindo de volta :)'
    Description = 
      'Para permanecer conectado conosco, por favor fa'#231'a login com suas' +
      ' informa'#231#245'es pessoais usando seu endere'#231'o de e-mail e senha '#55357#56596
    Logo.Image = 'https://i.ibb.co/4TTX0b6/logo-login-2.png'
    Logo.MarginTop = 0
    Logo.MarginLeft = 0
    TrimSpacesOnRememberMeForgetPassword = False
    OnLoginNow = dsaLoginLoginNow
    OnCreateAccount = dsaLoginCreateAccount
    OnRememberMe = dsaLoginRememberMe
    OnLoginEnter = dsaLoginLoginEnter
    OnPasswordEnter = dsaLoginPasswordEnter
    OnForgetPassword = dsaLoginForgetPassword
  end
  object saAlerta: TUniSweetAlert
    Title = 'Title'
    ConfirmButtonText = 'OK'
    CancelButtonText = 'Cancel'
    Padding = 20
    Left = 584
    Top = 416
  end
end
