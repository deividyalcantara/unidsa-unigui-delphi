object FrHome: TFrHome
  Left = 0
  Top = 0
  Width = 946
  Height = 680
  TabOrder = 0
  object flexDemoPage: TUniDSAFlexPanel
    Tag = 120
    Width = 900
    Height = 680
    Align = alClient
    Flex.Direction = fdColumn
    Flex.Wrap = fwNoWrap
    Flex.Gap = 20
    Flex.Padding = 24
    Flex.Overflow = foAuto
    object UniLabel1: TUniLabel
      AlignWithMargins = True
      Left = 20
      Top = 20
      Width = 59
      Height = 30
      Hint = ''
      Margins.Left = 20
      Margins.Top = 20
      Margins.Right = 20
      Margins.Bottom = 0
      Caption = 'Home'
      ParentFont = False
      Font.Height = 30
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 1
      Align = alNone
    end
    object UniLabel2: TUniLabel
      AlignWithMargins = True
      Left = 20
      Top = 50
      Width = 429
      Height = 20
      Hint = ''
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Caption = 'Bem-vindo a paleta de componente UniDSA para UniGUI/Delphi'
      ParentFont = False
      Font.Color = clGray
      Font.Height = -15
      ParentColor = False
      Color = clBtnFace
      TabOrder = 0
      Align = alNone
    end
  end
end
