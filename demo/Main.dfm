object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 686
  ClientWidth = 867
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Font.Height = -12
  Font.Name = 'Segoe UI'
  TextHeight = 15
  object UniButton1: TUniButton
    Left = 0
    Top = 0
    Width = 867
    Height = 33
    Hint = ''
    Caption = 'Exemplo 1'
    Align = alTop
    TabOrder = 0
    OnClick = UniButton1Click
  end
  object UniButton2: TUniButton
    Left = 0
    Top = 33
    Width = 867
    Height = 33
    Hint = ''
    Caption = 'Novos bot'#245'es'
    Align = alTop
    TabOrder = 1
    OnClick = UniButton2Click
    ExplicitTop = 39
  end
  object UniButton3: TUniButton
    Left = 0
    Top = 66
    Width = 867
    Height = 33
    Hint = ''
    Caption = 'Dialogo'
    Align = alTop
    TabOrder = 2
    OnClick = UniButton2Click
    ExplicitLeft = -8
    ExplicitTop = 72
  end
  object UniButton4: TUniButton
    Left = 0
    Top = 99
    Width = 867
    Height = 33
    Hint = ''
    Caption = 'Toast'
    Align = alTop
    TabOrder = 3
    OnClick = UniButton2Click
    ExplicitTop = 74
  end
  object UniDSAConfirm1: TUniDSAConfirm
    Version = '1.0.0'
    Title = 'Cliente'
    Content = 'Deseja excluir o cliente?'
    Draggable = True
    DrawWindowsBorder = True
    DrawWindowsGap = 15
    Buttons = <
      item
        Text = 'Sim'
        BtnClass = 'btn-green'
        IsHidden = False
        isDisabled = False
        AutoClose = 0
        ScapeKey = False
      end
      item
        Text = 'N'#227'o'
        IsHidden = False
        isDisabled = False
        AutoClose = 0
        ScapeKey = False
        OnClick = UniDSAConfirm1Buttons1Click
      end>
    Theme = Supervan
    Types.Enabled = True
    Types.Color = clBlue
    TypeAnimated = False
    ContainerFluid = False
    ColumnClass = 
      'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-' +
      'xs-offset-1'
    BoxWidth = '80%'
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
    PromptCustom.PlaceHolder = 'Digite o ID do cliente...'
    PromptCustom.InputType = Text
    EscapeKey = False
    Close.CloseIcon = True
    TypeConfirm = Alert
    Type = Blue
    OnButtonClick = UniDSAConfirm1ButtonClick
    Left = 456
    Top = 128
  end
  object UniDSAToast1: TUniDSAToast
    Version = '1.0.0'
    Icon = Success
    ShowHideTransition = Fade
    HideAfter = 3000
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
    Left = 312
    Top = 304
  end
end
