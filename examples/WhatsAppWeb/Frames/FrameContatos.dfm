object FrContatos: TFrContatos
  Left = 0
  Top = 0
  Width = 350
  Height = 760
  OnCreate = CriarFrame
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  TabOrder = 0
  object flexRaiz: TUniDSAFlexPanel
    Left = 0
    Top = 0
    Width = 350
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
      Width = 350
      Height = 106
      Hint = ''
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 4
      Flex.Padding = 22
      Flex.AutoHeight = True
      FlexItem.Shrink = 0
      FlexItem.Basis = 'auto'
      Responsive.XS.Span = 12
      FlexItems = <>
      ParentColor = False
      Color = clBtnFace
      TabOrder = 1
      object lblMarca: TUniLabel
        Left = 22
        Top = 22
        Width = 306
        Height = 36
        Hint = ''
        AutoSize = False
        Caption = 'UniChat'
        ParentFont = False
        Font.Color = 7045130
        Font.Height = -27
        Font.Style = [fsBold]
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 1
      end
      object lblSubtitulo: TUniLabel
        Left = 22
        Top = 62
        Width = 306
        Height = 22
        Hint = ''
        AutoSize = False
        Caption = 'Suas conversas, mais perto.'
        ParentFont = False
        Font.Color = 9077874
        Font.Height = -12
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 2
      end
    end
    object flexPesquisa: TUniDSAFlexPanel
      Left = 0
      Top = 106
      Width = 350
      Height = 122
      Hint = ''
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Padding = 16
      Flex.AutoHeight = True
      FlexItem.Shrink = 0
      FlexItem.Basis = 'auto'
      Responsive.XS.Span = 12
      FlexItems = <>
      ParentColor = False
      Color = clBtnFace
      TabOrder = 2
      object edtPesquisa: TUniEdit
        Left = 16
        Top = 16
        Width = 318
        Height = 42
        Hint = ''
        Text = ''
        ParentFont = False
        Font.Color = 3484949
        Font.Height = -14
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 1
        EmptyText = 'Pesquisar uma conversa'
        OnChange = AlterarPesquisa
      end
      object flexFiltros: TUniDSAFlexPanel
        Left = 16
        Top = 70
        Width = 318
        Height = 36
        Hint = ''
        Flex.Wrap = fwNoWrap
        Flex.Gap = 8
        Flex.AutoHeight = True
        FlexItem.Shrink = 0
        FlexItem.Basis = 'auto'
        Responsive.XS.Span = 12
        FlexItems = <>
        ParentColor = False
        Color = clBtnFace
        TabOrder = 2
        object btnTodas: TUniButton
          Left = 0
          Top = 0
          Width = 90
          Height = 36
          Hint = ''
          Caption = 'Todas'
          ParentFont = False
          Font.Color = 5989448
          Font.Height = -12
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
          OnClick = ClicarFiltro
        end
        object btnNaoLidas: TUniButton
          Tag = 1
          Left = 98
          Top = 0
          Width = 100
          Height = 36
          Hint = ''
          Caption = 'N'#227'o lidas'
          ParentFont = False
          Font.Color = 5989448
          Font.Height = -12
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 2
          OnClick = ClicarFiltro
        end
      end
    end
    object flexContatos: TUniDSAFlexPanel
      Left = 0
      Top = 228
      Width = 350
      Height = 478
      Hint = ''
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 0
      Flex.Overflow = foAuto
      FlexItem.Grow = 1
      FlexItem.Basis = '0px'
      Responsive.XS.Span = 12
      FlexItems = <>
      ParentColor = False
      Color = clBtnFace
      TabOrder = 3
      inline PreviaContatoMariana: TFrContato
        Left = 0
        Top = 0
        Width = 350
        Height = 78
        Layout = 'fit'
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        TabOrder = 0
        Background.Picture.Data = {00}
        inherited flexContato: TUniDSAFlexPanel
          FlexItems = <
            item
              Control = PreviaContatoMariana.lblAvatar
              Shrink = 0
              Basis = 'auto'
            end
            item
              Control = PreviaContatoMariana.lblNaoLidas
              Shrink = 0
              Basis = 'auto'
            end>
        end
        inherited EstiloContato: TUniDSAStyle
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
              Control = PreviaContatoMariana.flexContato
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
              Control = PreviaContatoMariana.lblAvatar
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
              Control = PreviaContatoMariana.lblNome
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
              Control = PreviaContatoMariana.lblPrevia
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
              Control = PreviaContatoMariana.lblNaoLidas
              StyleName = 'nao-lidas'
            end>
        end
      end
      inline PreviaContatoEquipe: TFrContato
        Left = 0
        Top = 78
        Width = 350
        Height = 78
        Layout = 'fit'
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        TabOrder = 1
        Background.Picture.Data = {00}
        ExplicitTop = 78
        inherited flexContato: TUniDSAFlexPanel
          FlexItems = <
            item
              Control = PreviaContatoEquipe.lblAvatar
              Shrink = 0
              Basis = 'auto'
            end
            item
              Control = PreviaContatoEquipe.lblNaoLidas
              Shrink = 0
              Basis = 'auto'
            end>
          inherited lblAvatar: TUniLabel
            Caption = 'EP'
            Font.Color = 9329763
          end
          inherited flexDetalhes: TUniDSAFlexPanel
            inherited lblNome: TUniLabel
              Caption = 'Equipe de produto'
            end
            inherited lblPrevia: TUniLabel
              Caption = 'O prot'#243'tipo ficou muito bom!'
            end
          end
        end
        inherited EstiloContato: TUniDSAStyle
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
              Control = PreviaContatoEquipe.flexContato
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
              Control = PreviaContatoEquipe.lblAvatar
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
              Control = PreviaContatoEquipe.lblNome
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
              Control = PreviaContatoEquipe.lblPrevia
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
              Control = PreviaContatoEquipe.lblNaoLidas
              StyleName = 'nao-lidas'
            end>
        end
      end
      inline PreviaContatoRafael: TFrContato
        Left = 0
        Top = 156
        Width = 350
        Height = 78
        Layout = 'fit'
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        TabOrder = 2
        Background.Picture.Data = {00}
        ExplicitTop = 156
        inherited flexContato: TUniDSAFlexPanel
          FlexItems = <
            item
              Control = PreviaContatoRafael.lblAvatar
              Shrink = 0
              Basis = 'auto'
            end
            item
              Control = PreviaContatoRafael.lblNaoLidas
              Shrink = 0
              Basis = 'auto'
            end>
          inherited lblAvatar: TUniLabel
            Caption = 'RA'
            Font.Color = 4088977
          end
          inherited flexDetalhes: TUniDSAFlexPanel
            inherited lblNome: TUniLabel
              Caption = 'Rafael Almeida'
            end
            inherited lblPrevia: TUniLabel
              Caption = 'Vamos tomar um caf'#233' amanh'#227'?'
            end
          end
          inherited lblNaoLidas: TUniLabel
            Caption = '1'
          end
        end
        inherited EstiloContato: TUniDSAStyle
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
              Control = PreviaContatoRafael.flexContato
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
              Control = PreviaContatoRafael.lblAvatar
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
              Control = PreviaContatoRafael.lblNome
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
              Control = PreviaContatoRafael.lblPrevia
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
              Control = PreviaContatoRafael.lblNaoLidas
              StyleName = 'nao-lidas'
            end>
        end
      end
      object flexContato0: TUniDSAFlexPanel
        Left = 0
        Top = 234
        Width = 350
        Height = 80
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
            Control = lblAvatar0
            Shrink = 0
            Basis = 'auto'
          end
          item
            Control = lblNaoLidas0
            Shrink = 0
            Basis = 'auto'
          end>
        ParentColor = False
        Color = clBtnFace
        TabOrder = 4
        OnClick = ClicarContato
        object lblAvatar0: TUniLabel
          Left = 16
          Top = 17
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
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
          OnClick = ClicarContato
        end
        object flexDetalhes0: TUniDSAFlexPanel
          Left = 74
          Top = 16
          Width = 318
          Height = 48
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 4
          Flex.AutoHeight = True
          FlexItem.Grow = 1
          FlexItem.Basis = '0px'
          Responsive.XS.Span = 12
          FlexItems = <>
          ParentColor = False
          Color = clBtnFace
          TabOrder = 2
          OnClick = ClicarContato
          object lblNome0: TUniLabel
            Left = 0
            Top = 0
            Width = 318
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
            OnClick = ClicarContato
          end
          object lblPrevia0: TUniLabel
            Left = 0
            Top = 26
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'Combinado! At'#233' daqui a pouco.'
            ParentFont = False
            Font.Color = 8422772
            Font.Height = -12
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 2
            OnClick = ClicarContato
          end
        end
        object lblNaoLidas0: TUniLabel
          Left = 404
          Top = 29
          Width = 22
          Height = 22
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = ''
          ParentFont = False
          Font.Color = clWhite
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 3
          OnClick = ClicarContato
        end
      end
      object flexContato1: TUniDSAFlexPanel
        Tag = 1
        Left = 0
        Top = 314
        Width = 350
        Height = 80
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
            Control = lblAvatar1
            Shrink = 0
            Basis = 'auto'
          end
          item
            Control = lblNaoLidas1
            Shrink = 0
            Basis = 'auto'
          end>
        ParentColor = False
        Color = clBtnFace
        TabOrder = 5
        OnClick = ClicarContato
        object lblAvatar1: TUniLabel
          Tag = 1
          Left = 16
          Top = 17
          Width = 46
          Height = 46
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = 'EP'
          ParentFont = False
          Font.Color = 9329763
          Font.Height = -15
          Font.Style = [fsBold]
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
          OnClick = ClicarContato
        end
        object flexDetalhes1: TUniDSAFlexPanel
          Tag = 1
          Left = 74
          Top = 16
          Width = 318
          Height = 48
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 4
          Flex.AutoHeight = True
          FlexItem.Grow = 1
          FlexItem.Basis = '0px'
          Responsive.XS.Span = 12
          FlexItems = <>
          ParentColor = False
          Color = clBtnFace
          TabOrder = 2
          OnClick = ClicarContato
          object lblNome1: TUniLabel
            Tag = 1
            Left = 0
            Top = 0
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'Equipe de produto'
            ParentFont = False
            Font.Color = 3484949
            Font.Height = -15
            Font.Style = [fsBold]
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 1
            OnClick = ClicarContato
          end
          object lblPrevia1: TUniLabel
            Tag = 1
            Left = 0
            Top = 26
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'O prot'#243'tipo ficou muito bom!'
            ParentFont = False
            Font.Color = 8422772
            Font.Height = -12
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 2
            OnClick = ClicarContato
          end
        end
        object lblNaoLidas1: TUniLabel
          Tag = 1
          Left = 404
          Top = 29
          Width = 22
          Height = 22
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = '2'
          ParentFont = False
          Font.Color = clWhite
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 3
          OnClick = ClicarContato
        end
      end
      object flexContato2: TUniDSAFlexPanel
        Tag = 2
        Left = 0
        Top = 394
        Width = 350
        Height = 80
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
            Control = lblAvatar2
            Shrink = 0
            Basis = 'auto'
          end
          item
            Control = lblNaoLidas2
            Shrink = 0
            Basis = 'auto'
          end>
        ParentColor = False
        Color = clBtnFace
        TabOrder = 6
        OnClick = ClicarContato
        object lblAvatar2: TUniLabel
          Tag = 2
          Left = 16
          Top = 17
          Width = 46
          Height = 46
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = 'RA'
          ParentFont = False
          Font.Color = 4088977
          Font.Height = -15
          Font.Style = [fsBold]
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
          OnClick = ClicarContato
        end
        object flexDetalhes2: TUniDSAFlexPanel
          Tag = 2
          Left = 74
          Top = 16
          Width = 318
          Height = 48
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 4
          Flex.AutoHeight = True
          FlexItem.Grow = 1
          FlexItem.Basis = '0px'
          Responsive.XS.Span = 12
          FlexItems = <>
          ParentColor = False
          Color = clBtnFace
          TabOrder = 2
          OnClick = ClicarContato
          object lblNome2: TUniLabel
            Tag = 2
            Left = 0
            Top = 0
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'Rafael Almeida'
            ParentFont = False
            Font.Color = 3484949
            Font.Height = -15
            Font.Style = [fsBold]
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 1
            OnClick = ClicarContato
          end
          object lblPrevia2: TUniLabel
            Tag = 2
            Left = 0
            Top = 26
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'Vamos tomar um caf'#233' amanh'#227'?'
            ParentFont = False
            Font.Color = 8422772
            Font.Height = -12
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 2
            OnClick = ClicarContato
          end
        end
        object lblNaoLidas2: TUniLabel
          Tag = 2
          Left = 404
          Top = 29
          Width = 22
          Height = 22
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = '1'
          ParentFont = False
          Font.Color = clWhite
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 3
          OnClick = ClicarContato
        end
      end
      object flexContato3: TUniDSAFlexPanel
        Tag = 3
        Left = 0
        Top = 474
        Width = 350
        Height = 80
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
            Control = lblAvatar3
            Shrink = 0
            Basis = 'auto'
          end
          item
            Control = lblNaoLidas3
            Shrink = 0
            Basis = 'auto'
          end>
        ParentColor = False
        Color = clBtnFace
        TabOrder = 7
        OnClick = ClicarContato
        object lblAvatar3: TUniLabel
          Tag = 3
          Left = 16
          Top = 17
          Width = 46
          Height = 46
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = 'SM'
          ParentFont = False
          Font.Color = 8412563
          Font.Height = -15
          Font.Style = [fsBold]
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
          OnClick = ClicarContato
        end
        object flexDetalhes3: TUniDSAFlexPanel
          Tag = 3
          Left = 74
          Top = 16
          Width = 318
          Height = 48
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 4
          Flex.AutoHeight = True
          FlexItem.Grow = 1
          FlexItem.Basis = '0px'
          Responsive.XS.Span = 12
          FlexItems = <>
          ParentColor = False
          Color = clBtnFace
          TabOrder = 2
          OnClick = ClicarContato
          object lblNome3: TUniLabel
            Tag = 3
            Left = 0
            Top = 0
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'Sofia Martins'
            ParentFont = False
            Font.Color = 3484949
            Font.Height = -15
            Font.Style = [fsBold]
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 1
            OnClick = ClicarContato
          end
          object lblPrevia3: TUniLabel
            Tag = 3
            Left = 0
            Top = 26
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'Obrigada pelo retorno!'
            ParentFont = False
            Font.Color = 8422772
            Font.Height = -12
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 2
            OnClick = ClicarContato
          end
        end
        object lblNaoLidas3: TUniLabel
          Tag = 3
          Left = 404
          Top = 29
          Width = 22
          Height = 22
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = ''
          ParentFont = False
          Font.Color = clWhite
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 3
          OnClick = ClicarContato
        end
      end
      object flexContato4: TUniDSAFlexPanel
        Tag = 4
        Left = 0
        Top = 554
        Width = 350
        Height = 80
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
            Control = lblAvatar4
            Shrink = 0
            Basis = 'auto'
          end
          item
            Control = lblNaoLidas4
            Shrink = 0
            Basis = 'auto'
          end>
        ParentColor = False
        Color = clBtnFace
        TabOrder = 8
        OnClick = ClicarContato
        object lblAvatar4: TUniLabel
          Tag = 4
          Left = 16
          Top = 17
          Width = 46
          Height = 46
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = 'FA'
          ParentFont = False
          Font.Color = 9598026
          Font.Height = -15
          Font.Style = [fsBold]
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 1
          OnClick = ClicarContato
        end
        object flexDetalhes4: TUniDSAFlexPanel
          Tag = 4
          Left = 74
          Top = 16
          Width = 318
          Height = 48
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 4
          Flex.AutoHeight = True
          FlexItem.Grow = 1
          FlexItem.Basis = '0px'
          Responsive.XS.Span = 12
          FlexItems = <>
          ParentColor = False
          Color = clBtnFace
          TabOrder = 2
          OnClick = ClicarContato
          object lblNome4: TUniLabel
            Tag = 4
            Left = 0
            Top = 0
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'Fam'#237'lia'
            ParentFont = False
            Font.Color = 3484949
            Font.Height = -15
            Font.Style = [fsBold]
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 1
            OnClick = ClicarContato
          end
          object lblPrevia4: TUniLabel
            Tag = 4
            Left = 0
            Top = 26
            Width = 318
            Height = 22
            Hint = ''
            AutoSize = False
            Caption = 'Encontro no domingo confirmado.'
            ParentFont = False
            Font.Color = 8422772
            Font.Height = -12
            Font.OverrideDefaults = [ovFontName, ovFontHeight]
            TabOrder = 2
            OnClick = ClicarContato
          end
        end
        object lblNaoLidas4: TUniLabel
          Tag = 4
          Left = 404
          Top = 29
          Width = 22
          Height = 22
          Hint = ''
          Alignment = taCenter
          AutoSize = False
          Caption = ''
          ParentFont = False
          Font.Color = clWhite
          Font.OverrideDefaults = [ovFontName, ovFontHeight]
          TabOrder = 3
          OnClick = ClicarContato
        end
      end
      object lblVazio: TUniLabel
        Left = 0
        Top = 0
        Width = 240
        Height = 50
        Hint = ''
        Visible = False
        AutoSize = False
        Caption = 'Nenhuma conversa encontrada.'
        ParentFont = False
        Font.Color = 8422772
        Font.Height = -13
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 9
      end
    end
    object flexRodape: TUniDSAFlexPanel
      Left = 0
      Top = 706
      Width = 350
      Height = 54
      Hint = ''
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 0
      Flex.Padding = 16
      Flex.AutoHeight = True
      FlexItem.Shrink = 0
      FlexItem.Basis = 'auto'
      Responsive.XS.Span = 12
      FlexItems = <>
      ParentColor = False
      Color = clBtnFace
      TabOrder = 4
      object lblDemonstracao: TUniLabel
        Left = 16
        Top = 16
        Width = 318
        Height = 22
        Hint = ''
        Alignment = taCenter
        AutoSize = False
        Caption = 'Demonstra'#231#227'o local '#8226' uniGUI + UniDSA'
        ParentFont = False
        Font.Color = 9146753
        Font.OverrideDefaults = [ovFontName, ovFontHeight]
        TabOrder = 1
      end
    end
  end
  object EstiloControles: TUniDSAStyle
    Version = '1.1.0'
    Styles = <
      item
        Name = 'raiz-lateral'
        Appearance.Background.Color = clWhite
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
        Name = 'area-rolagem'
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
        Responsive = <>
      end
      item
        Name = 'pesquisa'
        Appearance.Background.Color = 15988210
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
        Name = 'filtro'
        Appearance.Background.Color = 15922416
        Appearance.Border.Width = 0
        Appearance.Border.Radius = 18
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Shadow.Enabled = ssNo
        Appearance.Effects.TransitionMs = 140
        States.Hover.Background.Color = 15396580
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Effects.OutlineWidth = 2
        States.Focus.Effects.OutlineColor = 8431397
        States.Focus.Effects.OutlineOffset = 2
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Background.Color = 15135964
        States.Selected.Typography.Color = 6913800
        States.Selected.Typography.LineHeight = -1.000000000000000000
        States.Selected.Typography.LetterSpacing = -1000.000000000000000000
        Responsive = <>
      end
      item
        Name = 'contato'
        Appearance.Background.Color = clWhite
        Appearance.Border.Bottom.Width = 1
        Appearance.Border.Bottom.Color = 15856624
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Effects.Cursor = scPointer
        Appearance.Effects.TransitionMs = 120
        States.Hover.Background.Color = 16119795
        States.Hover.Typography.LineHeight = -1.000000000000000000
        States.Hover.Typography.LetterSpacing = -1000.000000000000000000
        States.Focus.Typography.LineHeight = -1.000000000000000000
        States.Focus.Typography.LetterSpacing = -1000.000000000000000000
        States.Pressed.Typography.LineHeight = -1.000000000000000000
        States.Pressed.Typography.LetterSpacing = -1000.000000000000000000
        States.Disabled.Typography.LineHeight = -1.000000000000000000
        States.Disabled.Typography.LetterSpacing = -1000.000000000000000000
        States.Selected.Background.Color = 15591910
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
        Name = 'previa'
        Appearance.Typography.LineHeight = 1.670000000000000000
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
      end
      item
        Name = 'vazio'
        Appearance.Typography.LineHeight = -1.000000000000000000
        Appearance.Typography.LetterSpacing = -1000.000000000000000000
        Appearance.Spacing.Padding.All = 16
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
        StyleName = 'raiz-lateral'
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
        Control = flexContatos
        StyleName = 'area-rolagem'
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
        Control = edtPesquisa
        StyleName = 'pesquisa'
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
        Control = btnTodas
        StyleName = 'filtro'
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
        Control = btnNaoLidas
        StyleName = 'filtro'
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
        Control = flexContato0
        StyleName = 'contato'
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
        Control = lblAvatar0
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
        Control = lblNome0
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
        Control = lblPrevia0
        StyleName = 'previa'
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
        Control = lblNaoLidas0
        StyleName = 'nao-lidas'
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
        Control = flexContato1
        StyleName = 'contato'
      end
      item
        Appearance.Background.Color = 15720159
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
        Control = lblAvatar1
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
        Control = lblNome1
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
        Control = lblPrevia1
        StyleName = 'previa'
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
        Control = lblNaoLidas1
        StyleName = 'nao-lidas'
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
        Control = flexContato2
        StyleName = 'contato'
      end
      item
        Appearance.Background.Color = 13820916
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
        Control = lblAvatar2
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
        Control = lblNome2
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
        Control = lblPrevia2
        StyleName = 'previa'
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
        Control = lblNaoLidas2
        StyleName = 'nao-lidas'
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
        Control = flexContato3
        StyleName = 'contato'
      end
      item
        Appearance.Background.Color = 15326958
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
        Control = lblAvatar3
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
        Control = lblNome3
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
        Control = lblPrevia3
        StyleName = 'previa'
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
        Control = lblNaoLidas3
        StyleName = 'nao-lidas'
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
        Control = flexContato4
        StyleName = 'contato'
      end
      item
        Appearance.Background.Color = 15985113
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
        Control = lblAvatar4
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
        Control = lblNome4
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
        Control = lblPrevia4
        StyleName = 'previa'
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
        Control = lblNaoLidas4
        StyleName = 'nao-lidas'
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
        Control = lblVazio
        StyleName = 'vazio'
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
    Left = 152
    Top = 40
  end
end
