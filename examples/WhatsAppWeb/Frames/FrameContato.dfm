object FrContato: TFrContato
  Left = 0
  Top = 0
  Width = 350
  Height = 78
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  TabOrder = 0
  object flexContato: TUniDSAFlexPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 80
    Hint = ''
    Flex.Wrap = fwNoWrap
    Flex.AlignItems = faCenter
    Flex.Padding = 16
    Flex.AutoHeight = True
    FlexItem.Basis = 'auto'
    FlexItems = <
      item
        Control = lblAvatar
        Shrink = 0
        Basis = 'auto'
      end
      item
        Control = lblNaoLidas
        Shrink = 0
        Basis = 'auto'
      end>
    Align = alClient
    ParentColor = False
    Color = clWhite
    TabOrder = 0
    object lblAvatar: TUniLabel
      Left = 22
      Top = 18
      Width = 46
      Height = 46
      Hint = ''
      Alignment = taCenter
      AutoSize = False
      Caption = 'MC'
      ParentFont = False
      Font.Color = 5465650
      Font.Height = -15
      Font.Style = [fsBold]
      Font.Name = 'Segoe UI'
      Font.OverrideDefaults = [ovFontName, ovFontHeight]
      ParentColor = False
      Color = 15002330
      TabOrder = 1
    end
    object flexDetalhes: TUniDSAFlexPanel
      Left = 74
      Top = 16
      Width = 240
      Height = 48
      Hint = ''
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 4
      Flex.AutoHeight = True
      FlexItem.Grow = 1
      FlexItem.Basis = '0px'
      FlexItems = <>
      ParentColor = False
      Color = clBtnFace
      TabOrder = 2
      object lblNome: TUniLabel
        Left = 0
        Top = 0
        Width = 240
        Height = 22
        Hint = ''
        AutoSize = False
        Caption = 'Mariana Costa'
        ParentFont = False
        Font.Color = 3484949
        Font.Height = -15
        Font.Style = [fsBold]
        Font.Name = 'Segoe UI'
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 1
      end
      object lblPrevia: TUniLabel
        Left = 0
        Top = 26
        Width = 240
        Height = 22
        Hint = ''
        AutoSize = False
        Caption = 'Combinado! At'#233' daqui a pouco.'
        ParentFont = False
        Font.Color = 8422772
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 2
      end
    end
    object lblNaoLidas: TUniLabel
      Left = 326
      Top = 29
      Width = 22
      Height = 22
      Hint = ''
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
      ParentFont = False
      Font.Color = clWhite
      Font.Name = 'Segoe UI'
      Font.OverrideDefaults = [ovFontName, ovFontHeight]
      TabOrder = 3
    end
  end
  object EstiloContato: TUniDSAStyle
    Version = '1.1.0'
    Styles = <
      item
        Name = 'contato'
        Appearance.Background.Color = clWhite
        Appearance.Border.Bottom.Width = 1
        Appearance.Border.Bottom.Color = 15856624
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Effects.Cursor = scPointer
        States.Hover.Background.Color = 16119795
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
        Name = 'avatar'
        Appearance.Background.Color = 15002330
        Appearance.Border.Radius = 999
        Appearance.Typography.Alignment = saCenter
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
        Name = 'texto'
        Appearance.Typography.LineHeight = -1.000000000000000000
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
        Name = 'nao-lidas'
        Appearance.Background.Color = 8169247
        Appearance.Border.Radius = 999
        Appearance.Typography.Alignment = saCenter
        Appearance.Typography.LineHeight = 2.000000000000000000
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
        Control = flexContato
        StyleName = 'contato'
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
        StyleName = 'texto'
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
        Control = lblPrevia
        StyleName = 'texto'
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
        Control = lblNaoLidas
        StyleName = 'nao-lidas'
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
    Left = 200
  end
end
