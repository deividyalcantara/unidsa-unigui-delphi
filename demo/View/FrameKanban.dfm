object FrKanban: TFrKanban
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
    object lblTitulo: TUniLabel
      AlignWithMargins = True
      Left = 20
      Top = 20
      Width = 75
      Height = 30
      Hint = ''
      Margins.Left = 20
      Margins.Top = 20
      Margins.Right = 20
      Margins.Bottom = 0
      Caption = 'Kanban'
      ParentFont = False
      Font.Height = 30
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 0
      Align = alNone
    end
    object lblDescricao: TUniLabel
      AlignWithMargins = True
      Left = 20
      Top = 50
      Width = 370
      Height = 20
      Hint = ''
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Caption = 'Organize e mova os cart'#245'es entre as etapas do trabalho'
      ParentFont = False
      Font.Color = clGray
      Font.Height = -15
      ParentColor = False
      Color = clBtnFace
      TabOrder = 1
      Align = alNone
    end
    object pnlNovoCartao: TUniDSAFlexPanel
      AlignWithMargins = True
      Left = 20
      Top = 80
      Width = 906
      Height = 38
      Hint = ''
      Margins.Left = 20
      Margins.Top = 10
      Margins.Right = 20
      Margins.Bottom = 0
      TabOrder = 2
      Tag = 101
      Flex.AutoHeight = True
      Flex.Gap = 10
      Flex.AlignContent = faStart
      Flex.Overflow = foVisible
      Flex.Direction = fdRow
      Flex.Wrap = fwWrap
      FlexItem.Shrink = 0
      ParentColor = False
      Color = 16579066
      Align = alNone
      object flexFieldedtNovoCartaoID: TUniDSAFlexPanel
        Tag = 102
        Flex.Direction = fdColumn
        Flex.Wrap = fwNoWrap
        Flex.AutoHeight = True
        Flex.Gap = 8
        FlexItem.Shrink = 0
        object lblFieldedtNovoCartaoID: TUniLabel
          Caption = 'ID do cartao'
          Height = 22
        end
        object edtNovoCartaoID: TUniEdit
          Left = 0
          Top = 0
          Width = 190
          Height = 38
          Hint = ''
          Text = ''
          TabOrder = 1
          EmptyText = 'ID do cart'#227'o'
          Align = alNone
        end
      end
      object flexFieldedtNovoCartao: TUniDSAFlexPanel
        Tag = 102
        Flex.Direction = fdColumn
        Flex.Wrap = fwNoWrap
        Flex.AutoHeight = True
        Flex.Gap = 8
        FlexItem.Shrink = 0
        object lblFieldedtNovoCartao: TUniLabel
          Caption = 'Titulo do cartao'
          Height = 22
        end
        object edtNovoCartao: TUniEdit
          Left = 198
          Top = 0
          Width = 300
          Height = 38
          Hint = ''
          Text = ''
          TabOrder = 2
          EmptyText = 'Digite o t'#237'tulo do cart'#227'o'
          Align = alNone
        end
      end
      object flexFieldbtnNovoCartao: TUniDSAFlexPanel
        Tag = 102
        Flex.Direction = fdColumn
        Flex.Wrap = fwNoWrap
        Flex.AutoHeight = True
        Flex.Gap = 8
        FlexItem.Shrink = 0
        object btnNovoCartao: TUniButton
          Left = 506
          Top = 0
          Width = 130
          Height = 38
          Hint = ''
          Caption = '+ Novo cart'#227'o'
          TabOrder = 3
          OnClick = btnNovoCartaoClick
          Align = alNone
        end
      end
    end
    object Kanban: TUniDSAKanban
      AlignWithMargins = True
      Left = 20
      Top = 133
      Width = 906
      Height = 513
      Hint = ''
      Margins.Left = 20
      Margins.Top = 15
      Margins.Right = 20
      Margins.Bottom = 0
      Columns = <
        item
          ID = 'a_fazer'
          Caption = 'A fazer'
          Description = 'Atividades aguardando in'#237'cio'
          AccentColor = 15426341
        end
        item
          ID = 'em_andamento'
          Caption = 'Em andamento'
          Description = 'Trabalho em execu'#231#227'o'
          AccentColor = 626935
          WIPLimit = 3
        end
        item
          ID = 'concluido'
          Caption = 'Conclu'#237'do'
          Description = 'Entregas finalizadas'
          AccentColor = 6993682
        end>
      Cards = <
        item
          ID = 'card_requisitos'
          ColumnID = 'a_fazer'
          Caption = 'Revisar requisitos'
          Description = 'Confirmar o escopo com a equipe.'
          Tag = 'Planejamento'
          Badge = 'Alta'
          Footer = 'Respons'#225'vel: Ana'
        end
        item
          ID = 'card_prototipo'
          ColumnID = 'a_fazer'
          Caption = 'Validar prot'#243'tipo'
          Description = 'Revisar os fluxos principais da interface.'
          Tag = 'Design'
          Badge = 'M'#233'dia'
          Footer = 'Respons'#225'vel: Bruno'
          SortOrder = 1
        end
        item
          ID = 'card_api'
          ColumnID = 'em_andamento'
          Caption = 'Implementar integra'#231#227'o'
          Description = 'Conectar o formul'#225'rio ao servi'#231'o de dados.'
          Tag = 'Desenvolvimento'
          Badge = 'Em curso'
          Footer = 'Respons'#225'vel: Carla'
        end
        item
          ID = 'card_testes'
          ColumnID = 'em_andamento'
          Caption = 'Executar testes'
          Description = 'Cobrir cen'#225'rios de movimenta'#231#227'o dos cart'#245'es.'
          Tag = 'Qualidade'
          Badge = 'Em curso'
          Footer = 'Respons'#225'vel: Diego'
          SortOrder = 1
        end
        item
          ID = 'card_estrutura'
          ColumnID = 'concluido'
          Caption = 'Criar estrutura inicial'
          Description = 'Componentes e estilos b'#225'sicos preparados.'
          Tag = 'Desenvolvimento'
          Badge = 'Finalizado'
          Footer = 'Conclu'#237'do hoje'
        end>
      EmptyText = 'Nenhum cart'#227'o nesta coluna'
      WIPLimitMessage = 'Esta coluna atingiu o limite de cart'#245'es.'
      MoveDeniedMessage = 'Esta movimenta'#231#227'o n'#227'o '#233' permitida.'
      OnCardClick = KanbanCardClick
      OnCardMove = KanbanCardMove
      OnCardMoved = KanbanCardMoved
      Align = alNone
    end
    object lblStatus: TUniLabel
      AlignWithMargins = True
      Left = 20
      Top = 652
      Width = 294
      Height = 13
      Hint = ''
      Margins.Left = 20
      Margins.Top = 6
      Margins.Right = 20
      Margins.Bottom = 15
      Caption = 'Arraste um cart'#227'o para outra coluna ou altere sua ordem.'
      ParentFont = False
      Font.Color = clGray
      Font.Height = -12
      ParentColor = False
      Color = clBtnFace
      TabOrder = 3
      Align = alNone
    end
  end
end
