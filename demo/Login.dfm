object FormLogin: TFormLogin
  Left = 0
  Top = 0
  ClientHeight = 677
  ClientWidth = 904
  Caption = 'FormLogin'
  OnShow = UniLoginFormShow
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Visible = True
  OnCreate = UniLoginFormCreate
  TextHeight = 15
  object flexLogin: TUniDSAFlexPanel
    Align = alClient
    Flex.Direction = fdColumn
    Flex.Wrap = fwNoWrap
    Flex.Overflow = foAuto
    FlexItems = <
      item
        Control = dsaLogin
        Grow = 1
        Basis = '0px'
      end>
    object dsaLogin: TUniDSALogin
      Left = 0
      Top = 0
      Width = 904
      Height = 677
      Hint = ''
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
      Align = alNone
    end
  end
  object saAlerta: TUniSweetAlert
    Title = 'Title'
    ConfirmButtonText = 'OK'
    CancelButtonText = 'Cancel'
    Padding = 20
    Left = 584
    Top = 416
  end
  object UniDSATour1: TUniDSATour
    Version = '1.1.0'
    Steps = <
      item
        ID = 'tour_step_1'
        Caption = 'Login'
        Content = 'Informe seu e-mail para acessar o sistema'
        Target = dsaLogin
        TargetSelector = '.un-lg-gp-login'
      end
      item
        ID = 'tour_step_2'
        Caption = 'Senha'
        Content = 'Informe sua senha de acesso que enviamos no seu e-mail'
        Target = dsaLogin
        TargetSelector = '.un-lg-gp-password'
      end
      item
        ID = 'tour_step_3'
        Caption = 'Entrar'
        Content = 'Clique no bot'#227'o entrar para acessar o sistema demo'
        TargetSelector = '#un-lg-login-now'
      end>
    AutoStart = True
    OverlayOpacity = 0.620000000000000000
    BackCaption = 'Voltar'
    NextCaption = 'Pr'#243'ximo'
    FinishCaption = 'Concluir'
    SkipCaption = 'Pular'
    Left = 344
    Top = 264
  end
end
