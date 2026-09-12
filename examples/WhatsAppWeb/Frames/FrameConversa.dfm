object FrConversa: TFrConversa
  Left = 0
  Top = 0
  Width = 850
  Height = 760
  OnCreate = CriarFrame
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  TabOrder = 0
  object flexRaiz: TUniDSAFlexPanel
    Left = 0
    Top = 0
    Width = 850
    Height = 760
    Hint = ''
    Flex.Direction = fdColumn
    Flex.Wrap = fwNoWrap
    Flex.Gap = 0
    Flex.Overflow = foHidden
    FlexItem.Basis = 'auto'
    Responsive.XS.Span = 12
    FlexItems = <>
    Align = alClient
    ParentColor = False
    Color = clBtnFace
    TabOrder = 0
    object flexCabecalho: TUniDSAFlexPanel
      Left = 0
      Top = 0
      Width = 850
      Height = 78
      Hint = ''
      Flex.Wrap = fwNoWrap
      Flex.AlignItems = faCenter
      Flex.Padding = 16
      Flex.AutoHeight = True
      FlexItem.Shrink = 0
      FlexItem.Basis = 'auto'
      Responsive.XS.Span = 12
      FlexItems = <
        item
          Control = btnVoltar
          Shrink = 0
          Basis = 'auto'
        end
        item
          Control = lblAvatar
          Shrink = 0
          Basis = 'auto'
        end>
      ParentColor = False
      Color = clBtnFace
      TabOrder = 1
      object btnVoltar: TUniButton
        Left = 16
        Top = 21
        Width = 36
        Height = 36
        Hint = 'Voltar '#224's conversas'
        ShowHint = True
        ParentShowHint = False
        Caption = #8249
        ParentFont = False
        Font.Color = 6779473
        Font.Height = -26
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 1
        OnClick = ClicarVoltar
      end
      object lblAvatar: TUniLabel
        Left = 64
        Top = 17
        Width = 44
        Height = 44
        Hint = ''
        Alignment = taCenter
        AutoSize = False
        Caption = 'MC'
        ParentFont = False
        Font.Color = 5465650
        Font.Height = -15
        Font.Style = [fsBold]
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 2
      end
      object flexIdentidade: TUniDSAFlexPanel
        Left = 120
        Top = 16
        Width = 818
        Height = 46
        Hint = ''
        Flex.Direction = fdColumn
        Flex.Wrap = fwNoWrap
        Flex.Gap = 2
        Flex.AutoHeight = True
        FlexItem.Grow = 1
        FlexItem.Basis = '0px'
        Responsive.XS.Span = 12
        FlexItems = <>
        ParentColor = False
        Color = clBtnFace
        TabOrder = 3
        object lblNome: TUniLabel
          Left = 0
          Top = 0
          Width = 818
          Height = 22
          Hint = ''
          AutoSize = False
          Caption = 'Mariana Costa'
          ParentFont = False
          Font.Color = 3484949
          Font.Height = -15
          Font.Style = [fsBold]
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
        end
        object lblStatus: TUniLabel
          Left = 0
          Top = 24
          Width = 818
          Height = 22
          Hint = ''
          AutoSize = False
          Caption = 'conversa de demonstra'#231#227'o'
          ParentFont = False
          Font.Color = 9077874
          Font.Height = -12
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 2
        end
      end
    end
    object flexHistorico: TUniDSAFlexPanel
      Left = 0
      Top = 78
      Width = 850
      Height = 80
      Hint = ''
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Padding = 28
      Flex.Overflow = foAuto
      FlexItem.Grow = 1
      FlexItem.Basis = '0px'
      Responsive.XS.Span = 12
      FlexItems = <>
      ParentColor = False
      Color = clBtnFace
      TabOrder = 4
      object flexAviso: TUniDSAFlexPanel
        Left = 28
        Top = 28
        Width = 794
        Height = 44
        Hint = ''
        Flex.Direction = fdColumn
        Flex.Wrap = fwNoWrap
        Flex.Padding = 12
        Flex.AutoHeight = True
        FlexItem.Shrink = 0
        FlexItem.Basis = 'auto'
        Responsive.XS.Span = 12
        FlexItems = <>
        ParentColor = False
        Color = 14087679
        TabOrder = 3
        object lblAviso: TUniLabel
          Left = 12
          Top = 12
          Width = 770
          Height = 20
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = 'Conversa de demonstra'#231#227'o. Mensagens ficam nesta sess'#227'o.'
          ParentFont = False
          Font.Color = 5667720
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
        end
      end
      inline PreviaRecebida: TFrMensagem
        Left = 28
        Top = 84
        Width = 794
        Height = 90
        Layout = 'fit'
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        TabOrder = 0
        Background.Picture.Data = {00}
        ExplicitLeft = 28
        ExplicitTop = 84
        ExplicitWidth = 794
        inherited flexLinha: TUniDSAFlexPanel
          Width = 794
          ExplicitWidth = 794
        end
        inherited EstiloMensagem: TUniDSAStyle
          StyleItems = <
            item
              Appearance.Background.Color = clWhite
              Appearance.Background.Opacity = 0
              Appearance.Border.Width = 0
              Appearance.Typography.LineHeight = -1.000000000000000000
              Appearance.Typography.LetterSpacing = -1000.000000000000000000
              Appearance.Sizing.Width.Value = 100.000000000000000000
              Appearance.Sizing.Width.Units = suPercent
              Appearance.Sizing.Height.Units = suAuto
              States.Hover.Typography.LineHeight = -1.000000000000000000
              States.Hover.Typography.LetterSpacing = -1000.000000000000000000
              States.Focus.Typography.LineHeight = -1.000000000000000000
              States.Focus.Typography.LetterSpacing = -1000.000000000000000000
              States.Pressed.Typography.LineHeight = -1.000000000000000000
              States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
              States.Disabled.Typography.LineHeight = -1.000000000000000000
              States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
              States.Selected.Typography.LineHeight = -1.000000000000000000
              States.Selected.Typography.LetterSpacing = -1000.000000000000000000
              Responsive = <>
            end
            item
              Appearance.Typography.LineHeight = -1.000000000000000000
              Appearance.Typography.LetterSpacing = -1000.000000000000000000
              States.Hover.Typography.LineHeight = -1.000000000000000000
              States.Hover.Typography.LetterSpacing = -1000.000000000000000000
              States.Focus.Typography.LineHeight = -1.000000000000000000
              States.Focus.Typography.LetterSpacing = -1000.000000000000000000
              States.Pressed.Typography.LineHeight = -1.000000000000000000
              States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
              States.Disabled.Typography.LineHeight = -1.000000000000000000
              States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
              States.Selected.Typography.LineHeight = -1.000000000000000000
              States.Selected.Typography.LetterSpacing = -1000.000000000000000000
              Responsive = <>
              Control = PreviaRecebida.flexBalao
              StyleName = 'mensagem-recebida'
            end
            item
              Appearance.Typography.LineHeight = -1.000000000000000000
              Appearance.Typography.LetterSpacing = -1000.000000000000000000
              States.Hover.Typography.LineHeight = -1.000000000000000000
              States.Hover.Typography.LetterSpacing = -1000.000000000000000000
              States.Focus.Typography.LineHeight = -1.000000000000000000
              States.Focus.Typography.LetterSpacing = -1000.000000000000000000
              States.Pressed.Typography.LineHeight = -1.000000000000000000
              States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
              States.Disabled.Typography.LineHeight = -1.000000000000000000
              States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
              States.Selected.Typography.LineHeight = -1.000000000000000000
              States.Selected.Typography.LetterSpacing = -1000.000000000000000000
              Responsive = <>
              Control = PreviaRecebida.lblMensagem
              StyleName = 'texto-mensagem'
            end>
        end
      end
      inline PreviaEnviada: TFrMensagem
        Left = 28
        Top = 186
        Width = 794
        Height = 90
        Layout = 'fit'
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        TabOrder = 1
        Background.Picture.Data = {00}
        ExplicitLeft = 28
        ExplicitTop = 186
        ExplicitWidth = 794
        inherited flexLinha: TUniDSAFlexPanel
          Width = 794
          Flex.JustifyContent = fjEnd
          ExplicitWidth = 794
          inherited flexBalao: TUniDSAFlexPanel
            Color = 14286809
            inherited lblMensagem: TUniLabel
              Caption = 'Pr'#233'via na IDE: resposta enviada por voc'#234'.'
            end
          end
        end
        inherited EstiloMensagem: TUniDSAStyle
          StyleItems = <
            item
              Appearance.Background.Color = clWhite
              Appearance.Background.Opacity = 0
              Appearance.Border.Width = 0
              Appearance.Typography.LineHeight = -1.000000000000000000
              Appearance.Typography.LetterSpacing = -1000.000000000000000000
              Appearance.Sizing.Width.Value = 100.000000000000000000
              Appearance.Sizing.Width.Units = suPercent
              Appearance.Sizing.Height.Units = suAuto
              States.Hover.Typography.LineHeight = -1.000000000000000000
              States.Hover.Typography.LetterSpacing = -1000.000000000000000000
              States.Focus.Typography.LineHeight = -1.000000000000000000
              States.Focus.Typography.LetterSpacing = -1000.000000000000000000
              States.Pressed.Typography.LineHeight = -1.000000000000000000
              States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
              States.Disabled.Typography.LineHeight = -1.000000000000000000
              States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
              States.Selected.Typography.LineHeight = -1.000000000000000000
              States.Selected.Typography.LetterSpacing = -1000.000000000000000000
              Responsive = <>
            end
            item
              Appearance.Typography.LineHeight = -1.000000000000000000
              Appearance.Typography.LetterSpacing = -1000.000000000000000000
              States.Hover.Typography.LineHeight = -1.000000000000000000
              States.Hover.Typography.LetterSpacing = -1000.000000000000000000
              States.Focus.Typography.LineHeight = -1.000000000000000000
              States.Focus.Typography.LetterSpacing = -1000.000000000000000000
              States.Pressed.Typography.LineHeight = -1.000000000000000000
              States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
              States.Disabled.Typography.LineHeight = -1.000000000000000000
              States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
              States.Selected.Typography.LineHeight = -1.000000000000000000
              States.Selected.Typography.LetterSpacing = -1000.000000000000000000
              Responsive = <>
              Control = PreviaEnviada.flexBalao
              StyleName = 'mensagem-recebida'
            end
            item
              Appearance.Typography.LineHeight = -1.000000000000000000
              Appearance.Typography.LetterSpacing = -1000.000000000000000000
              States.Hover.Typography.LineHeight = -1.000000000000000000
              States.Hover.Typography.LetterSpacing = -1000.000000000000000000
              States.Focus.Typography.LineHeight = -1.000000000000000000
              States.Focus.Typography.LetterSpacing = -1000.000000000000000000
              States.Pressed.Typography.LineHeight = -1.000000000000000000
              States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
              States.Disabled.Typography.LineHeight = -1.000000000000000000
              States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
              States.Selected.Typography.LineHeight = -1.000000000000000000
              States.Selected.Typography.LetterSpacing = -1000.000000000000000000
              Responsive = <>
              Control = PreviaEnviada.lblMensagem
              StyleName = 'texto-mensagem'
            end>
        end
      end
    end
    inline PreviaRecebidaLonga: TFrMensagem
      Left = 0
      Top = 158
      Width = 850
      Height = 110
      Layout = 'fit'
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      TabOrder = 2
      Background.Picture.Data = {00}
      ExplicitTop = 158
      ExplicitWidth = 850
      ExplicitHeight = 110
      inherited flexLinha: TUniDSAFlexPanel
        Width = 850
        ExplicitWidth = 850
        inherited flexBalao: TUniDSAFlexPanel
          inherited lblMensagem: TUniLabel
            Caption =
              'Esta mensagem recebida possui mais texto para mostrar como o bal' +
              #227'o aumenta automaticamente dentro do hist'#243'rico.'
          end
          inherited lblHorario: TUniLabel
            Caption = '10:22'
          end
        end
      end
      inherited EstiloMensagem: TUniDSAStyle
        StyleItems = <
          item
            Appearance.Background.Color = clWhite
            Appearance.Background.Opacity = 0
            Appearance.Border.Width = 0
            Appearance.Typography.LineHeight = -1.000000000000000000
            Appearance.Typography.LetterSpacing = -1000.000000000000000000
            Appearance.Sizing.Width.Value = 100.000000000000000000
            Appearance.Sizing.Width.Units = suPercent
            Appearance.Sizing.Height.Units = suAuto
            States.Hover.Typography.LineHeight = -1.000000000000000000
            States.Hover.Typography.LetterSpacing = -1000.000000000000000000
            States.Focus.Typography.LineHeight = -1.000000000000000000
            States.Focus.Typography.LetterSpacing = -1000.000000000000000000
            States.Pressed.Typography.LineHeight = -1.000000000000000000
            States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
            States.Disabled.Typography.LineHeight = -1.000000000000000000
            States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
            States.Selected.Typography.LineHeight = -1.000000000000000000
            States.Selected.Typography.LetterSpacing = -1000.000000000000000000
            Responsive = <>
          end
          item
            Appearance.Typography.LineHeight = -1.000000000000000000
            Appearance.Typography.LetterSpacing = -1000.000000000000000000
            States.Hover.Typography.LineHeight = -1.000000000000000000
            States.Hover.Typography.LetterSpacing = -1000.000000000000000000
            States.Focus.Typography.LineHeight = -1.000000000000000000
            States.Focus.Typography.LetterSpacing = -1000.000000000000000000
            States.Pressed.Typography.LineHeight = -1.000000000000000000
            States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
            States.Disabled.Typography.LineHeight = -1.000000000000000000
            States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
            States.Selected.Typography.LineHeight = -1.000000000000000000
            States.Selected.Typography.LetterSpacing = -1000.000000000000000000
            Responsive = <>
            Control = PreviaRecebidaLonga.flexBalao
            StyleName = 'mensagem-recebida'
          end
          item
            Appearance.Typography.LineHeight = -1.000000000000000000
            Appearance.Typography.LetterSpacing = -1000.000000000000000000
            States.Hover.Typography.LineHeight = -1.000000000000000000
            States.Hover.Typography.LetterSpacing = -1000.000000000000000000
            States.Focus.Typography.LineHeight = -1.000000000000000000
            States.Focus.Typography.LetterSpacing = -1000.000000000000000000
            States.Pressed.Typography.LineHeight = -1.000000000000000000
            States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
            States.Disabled.Typography.LineHeight = -1.000000000000000000
            States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
            States.Selected.Typography.LineHeight = -1.000000000000000000
            States.Selected.Typography.LetterSpacing = -1000.000000000000000000
            Responsive = <>
            Control = PreviaRecebidaLonga.lblMensagem
            StyleName = 'texto-mensagem'
          end>
        Left = 680
        Top = 0
      end
    end
    inline PreviaEnviadaCurta: TFrMensagem
      Left = 0
      Top = 268
      Width = 850
      Height = 90
      Layout = 'fit'
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      TabOrder = 3
      Background.Picture.Data = {00}
      ExplicitTop = 268
      ExplicitWidth = 850
      inherited flexLinha: TUniDSAFlexPanel
        Width = 850
        Flex.JustifyContent = fjEnd
        ExplicitWidth = 850
        inherited flexBalao: TUniDSAFlexPanel
          Color = 14286809
          inherited lblMensagem: TUniLabel
            Caption = 'Perfeito, combinado!'
          end
          inherited lblHorario: TUniLabel
            Width = 51
            Caption = '10:23 '#183' voc'#234
            ExplicitWidth = 51
          end
        end
      end
      inherited EstiloMensagem: TUniDSAStyle
        StyleItems = <
          item
            Appearance.Background.Color = clWhite
            Appearance.Background.Opacity = 0
            Appearance.Border.Width = 0
            Appearance.Typography.LineHeight = -1.000000000000000000
            Appearance.Typography.LetterSpacing = -1000.000000000000000000
            Appearance.Sizing.Width.Value = 100.000000000000000000
            Appearance.Sizing.Width.Units = suPercent
            Appearance.Sizing.Height.Units = suAuto
            States.Hover.Typography.LineHeight = -1.000000000000000000
            States.Hover.Typography.LetterSpacing = -1000.000000000000000000
            States.Focus.Typography.LineHeight = -1.000000000000000000
            States.Focus.Typography.LetterSpacing = -1000.000000000000000000
            States.Pressed.Typography.LineHeight = -1.000000000000000000
            States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
            States.Disabled.Typography.LineHeight = -1.000000000000000000
            States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
            States.Selected.Typography.LineHeight = -1.000000000000000000
            States.Selected.Typography.LetterSpacing = -1000.000000000000000000
            Responsive = <>
          end
          item
            Appearance.Typography.LineHeight = -1.000000000000000000
            Appearance.Typography.LetterSpacing = -1000.000000000000000000
            States.Hover.Typography.LineHeight = -1.000000000000000000
            States.Hover.Typography.LetterSpacing = -1000.000000000000000000
            States.Focus.Typography.LineHeight = -1.000000000000000000
            States.Focus.Typography.LetterSpacing = -1000.000000000000000000
            States.Pressed.Typography.LineHeight = -1.000000000000000000
            States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
            States.Disabled.Typography.LineHeight = -1.000000000000000000
            States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
            States.Selected.Typography.LineHeight = -1.000000000000000000
            States.Selected.Typography.LetterSpacing = -1000.000000000000000000
            Responsive = <>
            Control = PreviaEnviadaCurta.flexBalao
            StyleName = 'mensagem-recebida'
          end
          item
            Appearance.Typography.LineHeight = -1.000000000000000000
            Appearance.Typography.LetterSpacing = -1000.000000000000000000
            States.Hover.Typography.LineHeight = -1.000000000000000000
            States.Hover.Typography.LetterSpacing = -1000.000000000000000000
            States.Focus.Typography.LineHeight = -1.000000000000000000
            States.Focus.Typography.LetterSpacing = -1000.000000000000000000
            States.Pressed.Typography.LineHeight = -1.000000000000000000
            States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
            States.Disabled.Typography.LineHeight = -1.000000000000000000
            States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
            States.Selected.Typography.LineHeight = -1.000000000000000000
            States.Selected.Typography.LetterSpacing = -1000.000000000000000000
            Responsive = <>
            Control = PreviaEnviadaCurta.lblMensagem
            StyleName = 'texto-mensagem'
          end>
        Left = 680
      end
    end
    object flexCompositor: TUniDSAFlexPanel
      Left = 0
      Top = 358
      Width = 850
      Height = 133
      Hint = ''
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 8
      Flex.Padding = 16
      Flex.AutoHeight = True
      FlexItem.Shrink = 0
      FlexItem.Basis = 'auto'
      Responsive.XS.Span = 12
      FlexItems = <>
      ParentColor = False
      Color = clBtnFace
      TabOrder = 5
      object flexEntrada: TUniDSAFlexPanel
        Left = 16
        Top = 16
        Width = 818
        Height = 42
        Hint = ''
        Flex.Wrap = fwNoWrap
        Flex.AlignItems = faCenter
        Flex.AutoHeight = True
        FlexItem.Basis = 'auto'
        Responsive.XS.Span = 12
        FlexItems = <
          item
            Control = edtMensagem
            Grow = 1
            Basis = '0px'
          end
          item
            Control = btnEnviar
            Shrink = 0
            Basis = 'auto'
          end>
        ParentColor = False
        Color = clBtnFace
        TabOrder = 1
        object edtMensagem: TUniEdit
          Left = 0
          Top = 0
          Width = 719
          Height = 42
          Hint = ''
          MaxLength = 2000
          Text = ''
          ParentFont = False
          Font.Color = 3484949
          Font.Height = -14
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
          EmptyText = 'Digite uma mensagem'
          CheckChangeDelay = 0
          OnChange = AlterarMensagem
          OnKeyDown = PressionarTeclaMensagem
        end
        object btnEnviar: TUniButton
          Left = 731
          Top = 0
          Width = 90
          Height = 42
          Hint = ''
          Caption = 'Enviar  '#8250
          ParentFont = False
          Font.Color = clWhite
          Font.Height = -13
          Font.Style = [fsBold]
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 2
          OnClick = ClicarEnviar
        end
      end
      object lblDicaCompositor: TUniLabel
        Left = 16
        Top = 66
        Width = 818
        Height = 18
        Hint = ''
        AutoSize = False
        Caption = 'Enter para enviar'
        ParentFont = False
        Font.Color = 9147266
        Font.Height = -10
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 2
      end
      object UniButton1: TUniButton
        Left = 16
        Top = 92
        Width = 818
        Height = 25
        Cursor = crHandPoint
        Hint = ''
        Caption = 'UniButton1'
        ParentFont = False
        Font.Color = clWhite
        TabOrder = 3
      end
    end
  end
  object EstiloControles: TUniDSAStyle
    Version = '1.1.0'
    Styles = <
      item
        Name = 'raiz-conversa'
        Appearance.Background.Color = 15922672
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'cabecalho'
        Appearance.Background.Color = clWhite
        Appearance.Border.Bottom.Width = 1
        Appearance.Border.Bottom.Color = 14804445
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'voltar'
        Appearance.Background.Color = clWhite
        Appearance.Border.Width = 0
        Appearance.Border.Radius = 999
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Background.Color = 15396838
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Effects.OutlineWidth = 2
        States.Focus.Effects.OutlineColor = 8431397
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'avatar'
        Appearance.Background.Color = 15002330
        Appearance.Border.Radius = 999
        Appearance.Typography.LineHeight = 3.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'nome-contato'
        Appearance.Typography.LineHeight = 1.470000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Typography.WhiteSpace = wsNoWrap
        Appearance.Typography.TextOverflow = toEllipsis
        Appearance.Sizing.OverflowX = soHidden
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'historico'
        Appearance.Background.Color = 15463150
        Appearance.Background.Pattern = spDots
        Appearance.Background.PatternColor = 14345692
        Appearance.Background.PatternSize = 18
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Scrollbar.Visible = ssYes
        Appearance.Scrollbar.Size = 8
        Appearance.Scrollbar.ThumbColor = 14345692
        Appearance.Scrollbar.ThumbHoverColor = 6913800
        Appearance.Scrollbar.Radius = 999
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <
          item
            MaxWidth = 700
            Appearance.Typography.LineHeight = -1.000000000000000000
            Appearance.Typography.LetterSpacing = -1000.000000000000000000
            Appearance.Spacing.Padding.All = 14
            States.Hover.Typography.LineHeight = -1.000000000000000000
            States.Hover.Typography.LetterSpacing = -1000.000000000000000000
            States.Focus.Typography.LineHeight = -1.000000000000000000
            States.Focus.Typography.LetterSpacing = -1000.000000000000000000
            States.Pressed.Typography.LineHeight = -1.000000000000000000
            States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
            States.Disabled.Typography.LineHeight = -1.000000000000000000
            States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
            States.Selected.Typography.LineHeight = -1.000000000000000000
            States.Selected.Typography.LetterSpacing = -1000.000000000000000000
          end>
      end
      item
        Name = 'compositor'
        Appearance.Background.Color = 16317175
        Appearance.Border.Top.Width = 1
        Appearance.Border.Top.Color = 14936545
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'entrada-mensagem'
        Appearance.Background.Color = clWhite
        Appearance.Border.Width = 0
        Appearance.Border.Radius = 9
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Spacing.Padding.Left = 14
        Appearance.Spacing.Padding.Top = 10
        Appearance.Spacing.Padding.Right = 14
        Appearance.Spacing.Padding.Bottom = 10
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'enviar'
        Appearance.Background.Color = 6913800
        Appearance.Border.Width = 0
        Appearance.Border.Radius = 9
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Effects.TransitionMs = 150
        States.Hover.Background.Color = 5860101
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Effects.OutlineWidth = 2
        States.Focus.Effects.OutlineColor = 8431397
        States.Focus.Effects.OutlineOffset = 2
        States.Pressed.Background.Color = 4345347
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Effects.Opacity = 50
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'dica-compositor'
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Spacing.Padding.Left = 3
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'caixa-aviso'
        Appearance.Background.Color = 14087679
        Appearance.Border.Radius = 7
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'texto-aviso'
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Typography.WhiteSpace = wsNormal
        Appearance.Typography.WrapAnywhere = ssYes
        Appearance.Sizing.Height.Units = suAuto
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'btnUniverse'
        Appearance.Background.Color = clWhite
        Appearance.Border.Line = blNone
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Typography.Transform = ttUppercase
        Appearance.Spacing.Padding.Left = 20
        Appearance.Spacing.Padding.Top = 10
        Appearance.Spacing.Padding.Right = 20
        Appearance.Spacing.Padding.Bottom = 10
        States.Hover.Background.Color = -1
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end>
    StyleItems = <
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = flexRaiz
        StyleName = 'raiz-conversa'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = flexCabecalho
        StyleName = 'cabecalho'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = btnVoltar
        StyleName = 'voltar'
      end
      item
        Appearance.Background.Color = 15002330
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = lblAvatar
        StyleName = 'avatar'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = lblNome
        StyleName = 'nome-contato'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = flexHistorico
        StyleName = 'historico'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = lblAviso
        StyleName = 'texto-aviso'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = flexCompositor
        StyleName = 'compositor'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = edtMensagem
        StyleName = 'entrada-mensagem'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = btnEnviar
        StyleName = 'enviar'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = lblDicaCompositor
        StyleName = 'dica-compositor'
      end
      item
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = flexAviso
        StyleName = 'caixa-aviso'
      end
      item
        Name = 'name1'
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
        Control = UniButton1
        StyleName = 'btnUniverse'
      end>
    Defaults.Appearance.Typography.LineHeight = -1.000000000000000000
    Defaults.Appearance.Typography.LetterSpacing = -1000.000000000000000000
    Defaults.States.Hover.Typography.LineHeight = -1.000000000000000000
    Defaults.States.Hover.Typography.LetterSpacing = -1000.000000000000000000
    Defaults.States.Focus.Typography.LineHeight = -1.000000000000000000
    Defaults.States.Focus.Typography.LetterSpacing = -1000.000000000000000000
    Defaults.States.Pressed.Typography.LineHeight = -1.000000000000000000
    Defaults.States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
    Defaults.States.Disabled.Typography.LineHeight = -1.000000000000000000
    Defaults.States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
    Defaults.States.Selected.Typography.LineHeight = -1.000000000000000000
    Defaults.States.Selected.Typography.LetterSpacing = -1000.000000000000000000
    Defaults.Responsive = <>
    Left = 24
    Top = 24
  end
end
