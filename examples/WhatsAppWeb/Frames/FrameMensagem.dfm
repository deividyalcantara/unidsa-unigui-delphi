object FrMensagem: TFrMensagem
  Left = 0
  Top = 0
  Width = 700
  Height = 90
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  TabOrder = 0
  object flexLinha: TUniDSAFlexPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 82
    Hint = ''
    Flex.Wrap = fwNoWrap
    Flex.AlignItems = faStart
    Flex.AutoHeight = True
    FlexItem.Shrink = 0
    FlexItem.Basis = 'auto'
    Responsive.XS.Span = 12
    FlexItems = <>
    Align = alClient
    ParentColor = False
    Color = clBtnFace
    TabOrder = 0
    ExplicitHeight = 90
    object flexBalao: TUniDSAFlexPanel
      Left = 0
      Top = 0
      Width = 384
      Height = 82
      Hint = ''
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 4
      Flex.Padding = 12
      Flex.AutoHeight = True
      Flex.AutoWidth = True
      FlexItem.Shrink = 0
      FlexItem.Basis = 'auto'
      Responsive.XS.Span = 12
      FlexItems = <>
      ParentColor = False
      Color = clWhite
      TabOrder = 1
      object lblMensagem: TUniLabel
        Left = 12
        Top = 12
        Width = 360
        Height = 42
        Hint = ''
        AutoSize = False
        Caption =
          'Pr'#233'via na IDE: esta mensagem ser'#225' substitu'#237'da pelo hist'#243'rico da ' +
          'conversa.'
        ParentFont = False
        Font.Color = 3484949
        Font.Height = -14
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 1
      end
      object lblHorario: TUniLabel
        Left = 12
        Top = 58
        Width = 22
        Height = 12
        Hint = ''
        Alignment = taRightJustify
        Caption = '10:20'
        ParentFont = False
        Font.Color = 8753531
        Font.Height = -10
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 2
      end
    end
  end
  object EstiloMensagem: TUniDSAStyle
    Version = '1.1.0'
    Styles = <
      item
        Name = 'mensagem-recebida'
        Appearance.Background.Color = clWhite
        Appearance.Border.Radius = 10
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Sizing.MaxWidth.Value = 620.000000000000000000
        Appearance.Sizing.MaxWidth.Units = suPx
        Appearance.Sizing.MaxWidthPercent = 82
        Appearance.Shadow.Enabled = ssYes
        Appearance.Shadow.Color = 2766369
        Appearance.Shadow.Opacity = 10
        Appearance.Shadow.OffsetX = 0
        Appearance.Shadow.OffsetY = 1
        Appearance.Shadow.Blur = 1
        Appearance.Shadow.Spread = 0
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
            Appearance.Sizing.MaxWidthPercent = 92
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
        Name = 'texto-mensagem'
        Appearance.Typography.LineHeight = 1.550000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Typography.WhiteSpace = wsPreWrap
        Appearance.Typography.WrapAnywhere = ssYes
        Appearance.Sizing.Width.Units = suAuto
        Appearance.Sizing.Height.Units = suAuto
        Appearance.Sizing.MinHeight.Value = 20.000000000000000000
        Appearance.Sizing.MinHeight.Units = suPx
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
        Name = 'MensagemEnviada'
        Appearance.Background.Color = 14285017
        Appearance.Border.Radius = 10
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Sizing.MaxWidth.Value = 620.000000000000000000
        Appearance.Sizing.MaxWidth.Units = suPx
        Appearance.Sizing.MaxWidthPercent = 82
        Appearance.Shadow.Enabled = ssYes
        Appearance.Shadow.Color = 2766369
        Appearance.Shadow.Opacity = 10
        Appearance.Shadow.OffsetX = 0
        Appearance.Shadow.OffsetY = 1
        Appearance.Shadow.Blur = 1
        Appearance.Shadow.Spread = 0
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
            Appearance.Sizing.MaxWidthPercent = 92
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
      end>
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
        Control = flexBalao
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
        Control = lblMensagem
        StyleName = 'texto-mensagem'
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
