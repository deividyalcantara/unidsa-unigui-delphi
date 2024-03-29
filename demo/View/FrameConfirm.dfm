inherited FrConfirm: TFrConfirm
  object UniLabel2: TUniLabel
    AlignWithMargins = True
    Left = 20
    Top = 50
    Width = 352
    Height = 20
    Hint = ''
    Margins.Left = 20
    Margins.Top = 0
    Margins.Right = 20
    Margins.Bottom = 0
    Caption = 'Componente para exibi'#231#227'o de mensagem e dialogos'
    Align = alTop
    ParentFont = False
    Font.Color = clGray
    Font.Height = -15
    ParentColor = False
    Color = clBtnFace
    TabOrder = 0
  end
  object UniLabel1: TUniLabel
    AlignWithMargins = True
    Left = 20
    Top = 20
    Width = 80
    Height = 30
    Hint = ''
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Margins.Bottom = 0
    Caption = 'Confirm'
    Align = alTop
    ParentFont = False
    Font.Height = 30
    Font.Style = [fsBold]
    ParentColor = False
    Color = clBtnFace
    TabOrder = 1
  end
  object ugbMensagem: TUniGroupBox
    AlignWithMargins = True
    Left = 20
    Top = 80
    Width = 584
    Height = 70
    Hint = ''
    Margins.Left = 20
    Margins.Top = 10
    Margins.Right = 20
    Margins.Bottom = 0
    Caption = 'Mensagem'
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 601
    object UniContainerPanel20: TUniContainerPanel
      AlignWithMargins = True
      Left = 2
      Top = 20
      Width = 596
      Height = 42
      Hint = ''
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 0
      ParentColor = False
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 597
      object UniContainerPanel23: TUniContainerPanel
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 163
        Height = 39
        Hint = ''
        Margins.Top = 0
        ParentColor = False
        Align = alLeft
        TabOrder = 1
        object UniLabel16: TUniLabel
          Left = 0
          Top = 0
          Width = 30
          Height = 13
          Hint = ''
          Caption = 'T'#237'tulo'
          Align = alTop
          ParentColor = False
          Color = clBtnFace
          TabOrder = 1
        end
        object edtTitulo: TUniEdit
          Left = 0
          Top = 17
          Width = 163
          Hint = ''
          Text = 'T'#237'tulo Confirm'
          Align = alBottom
          TabOrder = 2
        end
      end
      object UniContainerPanel21: TUniContainerPanel
        AlignWithMargins = True
        Left = 172
        Top = 0
        Width = 157
        Height = 39
        Hint = ''
        Margins.Top = 0
        ParentColor = False
        Align = alLeft
        TabOrder = 2
        object UniLabel15: TUniLabel
          Left = 0
          Top = 0
          Width = 56
          Height = 13
          Hint = ''
          Caption = 'Mensagem'
          Align = alTop
          TabOrder = 1
        end
        object edtMensagem: TUniEdit
          Left = 0
          Top = 17
          Width = 157
          Hint = ''
          Text = 'Mensagem Confirm'
          Align = alBottom
          TabOrder = 2
        end
      end
      object UniContainerPanel22: TUniContainerPanel
        AlignWithMargins = True
        Left = 335
        Top = 0
        Width = 61
        Height = 39
        Hint = ''
        Margins.Top = 0
        ParentColor = False
        Align = alLeft
        TabOrder = 3
        object btnMostrar: TUniButton
          Left = 0
          Top = 17
          Width = 61
          Height = 22
          Hint = ''
          Caption = 'Mostrar'
          Align = alBottom
          TabOrder = 1
          OnClick = btnMostrarClick
        end
      end
    end
  end
  object UniLabel3: TUniLabel
    AlignWithMargins = True
    Left = 20
    Top = 155
    Width = 251
    Height = 13
    Hint = ''
    Margins.Left = 20
    Margins.Top = 5
    Margins.Right = 20
    Margins.Bottom = 0
    Caption = 'Demais recursos ser'#227'o exemplificados em breve...'
    Align = alTop
    ParentFont = False
    Font.Color = clGray
    Font.Height = -12
    ParentColor = False
    Color = clBtnFace
    TabOrder = 3
  end
  object Confirm: TUniDSAConfirm
    Version = '1.1.0'
    Draggable = True
    DrawWindowsBorder = True
    DrawWindowsGap = 15
    Buttons = <>
    Theme = Light
    Types.Enabled = True
    Types.Color = clBlue
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
    Type = Blue
    Left = 160
    Top = 232
  end
end
