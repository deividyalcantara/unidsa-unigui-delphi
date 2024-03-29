object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 692
  ClientWidth = 966
  Caption = 'UniDSA Demo'
  Color = 16579066
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Font.Height = -12
  OnAfterShow = UniFormAfterShow
  OnCreate = UniFormCreate
  TextHeight = 15
  object mlMenu: TUniDSAMenuLateral
    Left = 0
    Top = 0
    Width = 300
    Height = 692
    Hint = ''
    Logo.UrlImage = 'https://i.ibb.co/yhLx7mc/Logo.jpg'
    Logo.CompanyName = 'UniDSA - Unigui'
    Logo.Visible = True
    Search.Icon = 'fas fa-search'
    Search.TextPrompt = 'Pesquisa...'
    Search.AutoComplete = True
    Search.Visible = True
    Theme.StyleLeft = mltUniGray
    Theme.StyleRight = mltEscuro
    Theme.TitleLeft = 'Claro'
    Theme.TitleRight = 'Escuro'
    Theme.Visible = True
    Profile.Name = 'Nome Sobrenome'
    Profile.Email = 'nome@dominio.com'
    Profile.ImageURL = 'https://s11.gifyu.com/images/SchAL.png'
    Profile.Visible = True
    Menu.IMenuParent = mlMenu
    Menu = <
      item
        Icon = 'fas fa-home'
        Caption = 'Home'
        NotificationCount = 0
        Visible = True
        Enabled = True
        Hidden = False
        Separator = False
        OnClick = mlMenuMenu0Click
      end
      item
        Icon = 'fas fa-bars'
        Caption = 'Menu Lateral'
        NotificationCount = 0
        Visible = True
        Enabled = True
        Hidden = False
        Separator = False
        OnClick = mlMenuMenu1Click
        OnClickNotification = mlMenuMenu1ClickNotification
      end
      item
        Icon = 'fas fa-bell'
        Caption = 'Toast'
        NotificationCount = 0
        Visible = True
        Enabled = True
        Hidden = False
        Separator = False
        OnClick = mlMenuMenu2Click
      end
      item
        Icon = 'fas fa-check-square'
        Caption = 'Confirm'
        NotificationCount = 0
        Visible = True
        Enabled = True
        Hidden = False
        Separator = False
        OnClick = mlMenuMenu3Click
      end
      item
        Icon = 'fas fa-qrcode'
        Caption = 'QrCode Reader'
        NotificationCount = 0
        Visible = True
        Enabled = True
        Hidden = False
        Separator = False
        OnClick = mlMenuMenu4Click
      end
      item
        Icon = 'fas fa-bars'
        Caption = 'Menu 5'
        NotificationCount = 0
        Visible = True
        Enabled = True
        Hidden = False
        Separator = True
      end
      item
        Icon = 'fas fa-hands-helping'
        Caption = 'Apoie o projeto'
        NotificationCount = 0
        Visible = True
        Enabled = True
        Hidden = False
        Separator = False
        OnClick = mlMenuMenu6Click
      end>
    MenuState = mlmMaximize
    Style.PaddingTop = 20
    Style.PaddingLeft = 20
    Style.PaddingRight = 20
    Style.PaddingBottom = 20
    Style.BorderTop = 0
    Style.BorderLeft = 0
    Style.BorderRight = 2
    Style.BorderBottom = 0
    Style.BorderRadiusTopLeft = 0
    Style.BorderRadiusTopRight = 15
    Style.BorderRadiusBottomLeft = 0
    Style.BorderRadiusBottomRight = 15
    SelectedDiretionTheme = mltThemeLeft
    SelectedTheme = mltUniCrisp
    OnClickLogo = mlMenuClickLogo
    OnClickLogoff = mlMenuClickLogoff
    OnSearchEnter = mlMenuSearchEnter
    AjaxSecurity = True
  end
  object Toast: TUniDSAToast
    Version = '1.1.0'
    Icon = Success
    ShowHideTransition = Fade
    HideAfter = 0
    AllowToastClose = True
    Stack.Enabled = True
    Stack.Value = 5
    BgColor.Enabled = False
    BgColor.Color = clAqua
    TextColor.Enabled = False
    TextColor.Color = clAqua
    TextAlign = Left
    Position.Position = BottomLeft
    Position.Custom.Left = 0
    Position.Custom.Top = 0
    Position.Custom.Right = 0
    Position.Custom.Bottom = 0
    Loader.Enabled = True
    Loader.Background = clAqua
    OnAfterHidden = ToastAfterHidden
    Left = 488
    Top = 296
  end
  object Confirm: TUniDSAConfirm
    Version = '1.1.0'
    Title = 'Teste'
    Draggable = True
    DrawWindowsBorder = True
    DrawWindowsGap = 15
    Buttons = <
      item
        IsHidden = False
        isDisabled = False
        AutoClose = 0
        ScapeKey = False
      end
      item
        IsHidden = False
        isDisabled = False
        AutoClose = 0
        ScapeKey = False
      end>
    Theme = Supervan
    Types.Enabled = True
    Types.Color = clLime
    TypeAnimated = False
    ContainerFluid = False
    ColumnClass = 
      'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-' +
      'xs-offset-1'
    BoxWidth = '30%'
    UseBootstrap = False
    Dismiss.BackgroundDismiss = False
    Dismiss.BackgroundDismissAnimation = Shake
    AnimateFromElement = True
    SmoothContent = True
    LazyOpen = False
    BgOpacity = '1'
    Animation.Enabled = True
    Animation.Animation = 'scale'
    Animation.CloseAnimation = 'scale'
    Animation.AnimationSpeed = 400
    Animation.AnimationBounce = 1
    RTL = False
    Container = 'body'
    WatchInterval = 100
    ScrollToPreviousElement = True
    ScrollToPreviousElementAnimate = True
    OffsetTop = 40
    OffsetBottom = 40
    PromptCustom.ClassForm = 'formName'
    PromptCustom.ClassGroup = 'form-group'
    PromptCustom.ClassInput = 'name form-control'
    PromptCustom.PlaceHolder = 'Digite...'
    PromptCustom.InputType = Text
    EscapeKey = False
    Close.CloseIcon = False
    TypeConfirm = Alert
    Type = Green
    Left = 488
    Top = 224
  end
end
