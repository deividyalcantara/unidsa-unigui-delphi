object FrFlexPanel: TFrFlexPanel
  Left = 0
  Top = 0
  Width = 946
  Height = 855
  OnCreate = UniFrameCreate
  Color = 16579066
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object lblTitulo: TUniLabel
    AlignWithMargins = True
    Left = 20
    Top = 20
    Width = 181
    Height = 30
    Hint = ''
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Margins.Bottom = 0
    Caption = 'TUniDSAFlexPanel'
    Align = alTop
    ParentFont = False
    Font.Height = 30
    Font.Style = [fsBold]
    ParentColor = False
    Color = 16579066
    TabOrder = 0
  end
  object lblDescricao: TUniLabel
    AlignWithMargins = True
    Left = 20
    Top = 50
    Width = 558
    Height = 20
    Hint = ''
    Margins.Left = 20
    Margins.Top = 0
    Margins.Right = 20
    Margins.Bottom = 0
    Caption = 
      'Paineis Flex responsivos e componentes nativos do uniGUI organiz' +
      'ados pelo Flexbox'
    Align = alTop
    ParentFont = False
    Font.Color = clGray
    Font.Height = -15
    ParentColor = False
    Color = 16579066
    TabOrder = 1
  end
  object pcExemplos: TUniPageControl
    AlignWithMargins = True
    Left = 20
    Top = 84
    Width = 906
    Height = 751
    Hint = ''
    Margins.Left = 20
    Margins.Top = 14
    Margins.Right = 20
    Margins.Bottom = 20
    ActivePage = tabGrade
    Align = alClient
    TabOrder = 2
    object tabGrade: TUniTabSheet
      Hint = ''
      Caption = 'Grade responsiva'
      object flexGrade: TUniDSAFlexPanel
        Left = 0
        Top = 0
        Width = 898
        Height = 723
        Hint = ''
        Flex.Gap = 16
        Flex.Padding = 16
        Flex.Overflow = foAuto
        FlexItem.Basis = 'auto'
        Responsive.XS.Span = 12
        Align = alClient
        ParentColor = False
        Color = 16579066
        TabOrder = 0
        object flexCadastro: TUniDSAFlexPanel
          Left = 16
          Top = 16
          Width = 425
          Height = 236
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 8
          Flex.Padding = 18
          Flex.AutoHeight = True
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          Responsive.MD.Span = 6
          Responsive.LG.Span = 4
          ParentColor = False
          Color = clWhite
          TabOrder = 0
          object lblCadastroTitulo: TUniLabel
            Left = 18
            Top = 18
            Width = 116
            Height = 21
            Hint = ''
            Caption = 'Dados pessoais'
            ParentFont = False
            Font.Height = -16
            Font.Style = [fsBold]
            TabOrder = 0
          end
          object lblCadastroNome: TUniLabel
            Left = 18
            Top = 47
            Width = 30
            Height = 13
            Hint = ''
            Caption = 'Nome'
            TabOrder = 1
          end
          object edtCadastroNome: TUniEdit
            Left = 18
            Top = 68
            Width = 389
            Height = 30
            Hint = ''
            Text = ''
            TabOrder = 2
            EmptyText = 'Nome completo'
          end
          object lblCadastroEmail: TUniLabel
            Left = 18
            Top = 106
            Width = 31
            Height = 13
            Hint = ''
            Caption = 'E-mail'
            TabOrder = 3
          end
          object edtCadastroEmail: TUniEdit
            Left = 18
            Top = 127
            Width = 389
            Height = 30
            Hint = ''
            Text = ''
            TabOrder = 4
            EmptyText = 'nome@empresa.com'
          end
          object btnSalvarCadastro: TUniButton
            Left = 18
            Top = 165
            Width = 389
            Height = 32
            Hint = ''
            Caption = 'Salvar cadastro'
            TabOrder = 5
            OnClick = btnSalvarCadastroClick
          end
          object lblCadastroStatus: TUniLabel
            Left = 18
            Top = 205
            Width = 228
            Height = 13
            Hint = ''
            Caption = 'Formulario inserido dentro de um FlexPanel.'
            ParentFont = False
            Font.Color = clGray
            TabOrder = 6
          end
        end
        object flexEndereco: TUniDSAFlexPanel
          Left = 457
          Top = 16
          Width = 425
          Height = 265
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 8
          Flex.Padding = 18
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          Responsive.MD.Span = 6
          Responsive.LG.Span = 4
          ParentColor = False
          Color = clWhite
          TabOrder = 1
          object lblEnderecoTitulo: TUniLabel
            Left = 18
            Top = 18
            Width = 71
            Height = 21
            Hint = ''
            Caption = 'Endereco'
            ParentFont = False
            Font.Height = -16
            Font.Style = [fsBold]
            TabOrder = 0
          end
          object lblEnderecoCidade: TUniLabel
            Left = 18
            Top = 47
            Width = 36
            Height = 13
            Hint = ''
            Caption = 'Cidade'
            TabOrder = 1
          end
          object edtEnderecoCidade: TUniEdit
            Left = 18
            Top = 68
            Width = 389
            Height = 30
            Hint = ''
            Text = 'Sao Paulo'
            TabOrder = 2
          end
          object lblEnderecoEstado: TUniLabel
            Left = 18
            Top = 106
            Width = 35
            Height = 13
            Hint = ''
            Caption = 'Estado'
            TabOrder = 3
          end
          object cbEnderecoEstado: TUniComboBox
            Left = 18
            Top = 127
            Width = 389
            Height = 30
            Hint = ''
            Style = csDropDownList
            Text = 'SP'
            Items.Strings = (
              'SP'
              'RJ'
              'MG'
              'PR')
            ItemIndex = 0
            TabOrder = 4
            IconItems = <>
          end
          object chkEnderecoPrincipal: TUniCheckBox
            Left = 18
            Top = 165
            Width = 389
            Height = 24
            Hint = ''
            Checked = True
            Caption = 'Endereco principal'
            TabOrder = 5
          end
        end
        object flexResumo: TUniDSAFlexPanel
          Left = 16
          Top = 297
          Width = 866
          Height = 265
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Padding = 18
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          Responsive.MD.Span = 12
          Responsive.LG.Span = 4
          ParentColor = False
          Color = clWhite
          TabOrder = 2
          object lblResumoTitulo: TUniLabel
            Left = 18
            Top = 18
            Width = 61
            Height = 21
            Hint = ''
            Caption = 'Resumo'
            ParentFont = False
            Font.Height = -16
            Font.Style = [fsBold]
            TabOrder = 0
          end
          object lblResumoTexto: TUniLabel
            Left = 18
            Top = 51
            Width = 830
            Height = 36
            Hint = ''
            AutoSize = False
            Caption = 'Progresso atual: 40%. Redimensione a janela para testar a grade.'
            TabOrder = 1
          end
          object prgResumo: TUniProgressBar
            Left = 18
            Top = 99
            Width = 830
            Hint = ''
            Position = 40
            Text = ''
            TabOrder = 2
          end
          object btnAvancarProgresso: TUniButton
            Left = 18
            Top = 133
            Width = 830
            Height = 32
            Hint = ''
            Caption = 'Avancar progresso'
            TabOrder = 3
            OnClick = btnAvancarProgressoClick
          end
        end
      end
    end
    object tabComponentes: TUniTabSheet
      Hint = ''
      Caption = 'Controles uniGUI'
      object flexComponentes: TUniDSAFlexPanel
        Left = 0
        Top = 0
        Width = 898
        Height = 723
        Hint = ''
        Flex.AlignItems = faCenter
        Flex.AlignContent = faStart
        Flex.Gap = 14
        Flex.Padding = 24
        Flex.Overflow = foAuto
        FlexItem.Basis = 'auto'
        Responsive.XS.Span = 12
        FlexItems = <
          item
            Control = lblComponentes
            Order = -1
            AlignSelf = fasStretch
            Responsive.XS.Span = 12
          end
          item
            Control = edtPesquisa
            Responsive.XS.Span = 12
            Responsive.SM.Span = 6
            Responsive.MD.Span = 3
          end
          item
            Control = cbCategoria
            Responsive.XS.Span = 12
            Responsive.SM.Span = 6
            Responsive.MD.Span = 3
          end
          item
            Control = chkSomenteAtivos
            Responsive.XS.Span = 12
            Responsive.SM.Span = 6
            Responsive.MD.Span = 2
          end
          item
            Control = btnPesquisar
            Responsive.XS.Span = 6
            Responsive.SM.Span = 3
            Responsive.MD.Span = 2
          end
          item
            Control = btnLimparFiltros
            Responsive.XS.Span = 6
            Responsive.SM.Span = 3
            Responsive.MD.Span = 2
          end
          item
            Control = prgPesquisa
            Responsive.XS.Span = 12
            Responsive.MD.Span = 5
          end
          item
            Control = lblPesquisaStatus
            Responsive.XS.Span = 12
            Responsive.MD.Span = 7
          end>
        Align = alClient
        ParentColor = False
        Color = clWhite
        TabOrder = 0
        object lblComponentes: TUniLabel
          Left = 24
          Top = 24
          Width = 930
          Height = 20
          Hint = ''
          Caption = 
            'Todos os itens abaixo sao componentes uniGUI diretamente dentro ' +
            'de uma TUniDSAFlexPanel. Diminua a janela e veja a quebra automa' +
            'tica.'
          ParentFont = False
          Font.Height = -15
          TabOrder = 0
        end
        object edtPesquisa: TUniEdit
          Left = 24
          Top = 58
          Width = 230
          Height = 34
          Hint = ''
          Text = ''
          TabOrder = 1
          EmptyText = 'Digite para pesquisar'
        end
        object cbCategoria: TUniComboBox
          Left = 268
          Top = 58
          Width = 180
          Height = 34
          Hint = ''
          Style = csDropDownList
          Text = 'Todas as categorias'
          Items.Strings = (
            'Todas as categorias'
            'Clientes'
            'Pedidos'
            'Financeiro')
          ItemIndex = 0
          TabOrder = 2
          IconItems = <>
        end
        object chkSomenteAtivos: TUniCheckBox
          Left = 462
          Top = 58
          Width = 130
          Height = 24
          Hint = ''
          Checked = True
          Caption = 'Somente ativos'
          TabOrder = 3
        end
        object btnPesquisar: TUniButton
          Left = 606
          Top = 58
          Width = 110
          Height = 34
          Hint = ''
          Caption = 'Pesquisar'
          TabOrder = 4
          OnClick = btnPesquisarClick
        end
        object btnLimparFiltros: TUniButton
          Left = 730
          Top = 58
          Width = 120
          Height = 34
          Hint = ''
          Caption = 'Limpar filtros'
          TabOrder = 5
          OnClick = btnLimparFiltrosClick
        end
        object prgPesquisa: TUniProgressBar
          Left = 24
          Top = 106
          Width = 320
          Hint = ''
          Position = 25
          Text = ''
          TabOrder = 6
        end
        object lblPesquisaStatus: TUniLabel
          Left = 358
          Top = 106
          Width = 301
          Height = 13
          Hint = ''
          Caption = 'A linha usa gap, alinhamento central e quebra automatica.'
          ParentFont = False
          Font.Color = clGray
          TabOrder = 7
        end
      end
    end
    object tabAninhadas: TUniTabSheet
      Hint = ''
      Caption = 'FlexPanels aninhados'
      object flexDashboard: TUniDSAFlexPanel
        Left = 0
        Top = 0
        Width = 898
        Height = 723
        Hint = ''
        Flex.AlignContent = faStart
        Flex.Gap = 16
        Flex.Padding = 16
        Flex.Overflow = foAuto
        FlexItem.Basis = 'auto'
        Responsive.XS.Span = 12
        Align = alClient
        ParentColor = False
        Color = 16579066
        TabOrder = 0
        object flexDashboardCabecalho: TUniDSAFlexPanel
          Left = 16
          Top = 16
          Width = 866
          Height = 66
          Hint = ''
          Flex.JustifyContent = fjSpaceBetween
          Flex.AlignItems = faCenter
          Flex.Padding = 16
          Flex.AutoHeight = True
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          ParentColor = False
          Color = clWhite
          TabOrder = 0
          object lblDashboardTitulo: TUniLabel
            Left = 16
            Top = 16
            Width = 144
            Height = 25
            Hint = ''
            Caption = 'Painel comercial'
            ParentFont = False
            Font.Height = -19
            Font.Style = [fsBold]
            TabOrder = 0
          end
          object lblDashboardPeriodo: TUniLabel
            Left = 172
            Top = 16
            Width = 78
            Height = 13
            Hint = ''
            Caption = 'Ultimos 30 dias'
            ParentFont = False
            Font.Color = clGray
            TabOrder = 1
          end
          object btnAtualizarDashboard: TUniButton
            Left = 262
            Top = 16
            Width = 134
            Height = 34
            Hint = ''
            Caption = 'Atualizar dados'
            TabOrder = 2
            OnClick = btnAtualizarDashboardClick
          end
        end
        object flexMetricaVendas: TUniDSAFlexPanel
          Left = 16
          Top = 98
          Width = 425
          Height = 125
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 8
          Flex.Padding = 18
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          Responsive.SM.Span = 6
          Responsive.LG.Span = 4
          ParentColor = False
          Color = clWhite
          TabOrder = 1
          object lblVendasTitulo: TUniLabel
            Left = 18
            Top = 18
            Width = 66
            Height = 13
            Hint = ''
            Caption = 'Faturamento'
            ParentFont = False
            Font.Color = clGray
            TabOrder = 0
          end
          object lblVendasValor: TUniLabel
            Left = 18
            Top = 39
            Width = 114
            Height = 32
            Hint = ''
            Caption = 'R$ 42.580'
            ParentFont = False
            Font.Height = -24
            Font.Style = [fsBold]
            TabOrder = 1
          end
        end
        object flexMetricaPedidos: TUniDSAFlexPanel
          Left = 457
          Top = 98
          Width = 425
          Height = 125
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 8
          Flex.Padding = 18
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          Responsive.SM.Span = 6
          Responsive.LG.Span = 4
          ParentColor = False
          Color = clWhite
          TabOrder = 2
          object lblPedidosTitulo: TUniLabel
            Left = 18
            Top = 18
            Width = 41
            Height = 13
            Hint = ''
            Caption = 'Pedidos'
            ParentFont = False
            Font.Color = clGray
            TabOrder = 0
          end
          object lblPedidosValor: TUniLabel
            Left = 18
            Top = 39
            Width = 42
            Height = 32
            Hint = ''
            Caption = '164'
            ParentFont = False
            Font.Height = -24
            Font.Style = [fsBold]
            TabOrder = 1
          end
        end
        object flexMetricaClientes: TUniDSAFlexPanel
          Left = 16
          Top = 239
          Width = 866
          Height = 125
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 8
          Flex.Padding = 18
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          Responsive.SM.Span = 12
          Responsive.LG.Span = 4
          ParentColor = False
          Color = clWhite
          TabOrder = 3
          object lblClientesTitulo: TUniLabel
            Left = 18
            Top = 18
            Width = 74
            Height = 13
            Hint = ''
            Caption = 'Novos clientes'
            ParentFont = False
            Font.Color = clGray
            TabOrder = 0
          end
          object lblClientesValor: TUniLabel
            Left = 18
            Top = 39
            Width = 28
            Height = 32
            Hint = ''
            Caption = '58'
            ParentFont = False
            Font.Height = -24
            Font.Style = [fsBold]
            TabOrder = 1
          end
        end
        object flexDashboardDetalhes: TUniDSAFlexPanel
          Left = 16
          Top = 380
          Width = 866
          Height = 230
          Hint = ''
          Flex.Direction = fdColumn
          Flex.Wrap = fwNoWrap
          Flex.Gap = 10
          Flex.Padding = 18
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          ParentColor = False
          Color = clWhite
          TabOrder = 4
          object lblDetalhesTitulo: TUniLabel
            Left = 18
            Top = 18
            Width = 153
            Height = 21
            Hint = ''
            Caption = 'Composicao interna'
            ParentFont = False
            Font.Height = -16
            Font.Style = [fsBold]
            TabOrder = 0
          end
          object memDetalhes: TUniMemo
            Left = 18
            Top = 49
            Width = 830
            Height = 120
            Hint = ''
            Lines.Strings = (
              'Esta area e outro TUniDSAFlexPanel dentro da grade principal.'
              'Ela contem um TUniLabel e um TUniMemo nativos do uniGUI.'
              'FlexPanels podem ser aninhados quantas vezes o layout precisar.')
            ReadOnly = True
            TabOrder = 1
          end
        end
      end
    end
    object tabAlinhamento: TUniTabSheet
      Hint = ''
      Caption = 'Alinhamento dinamico'
      object flexAlinhamentoPagina: TUniDSAFlexPanel
        Left = 0
        Top = 0
        Width = 898
        Height = 723
        Hint = ''
        Flex.Direction = fdColumn
        Flex.Wrap = fwNoWrap
        Flex.Gap = 18
        Flex.Padding = 24
        Flex.Overflow = foAuto
        FlexItem.Basis = 'auto'
        Responsive.XS.Span = 12
        Align = alClient
        ParentColor = False
        Color = 16579066
        TabOrder = 0
        object flexAlinhamentoExemplo: TUniDSAFlexPanel
          Left = 24
          Top = 24
          Width = 850
          Height = 260
          Hint = ''
          Flex.JustifyContent = fjSpaceBetween
          Flex.AlignItems = faCenter
          Flex.Padding = 24
          FlexItem.Grow = 1
          FlexItem.Basis = '0'
          Responsive.XS.Span = 12
          ParentColor = False
          Color = clWhite
          TabOrder = 0
          object lblAlinhamentoTitulo: TUniLabel
            Left = 24
            Top = 24
            Width = 802
            Height = 24
            Hint = ''
            AutoSize = False
            Caption = 'Este container muda as propriedades Flex em runtime'
            ParentFont = False
            Font.Height = -16
            Font.Style = [fsBold]
            TabOrder = 0
          end
          object btnAlinharUm: TUniButton
            Left = 24
            Top = 60
            Width = 130
            Height = 42
            Hint = ''
            Caption = 'Primeiro item'
            TabOrder = 1
          end
          object btnAlinharDois: TUniButton
            Left = 166
            Top = 60
            Width = 130
            Height = 42
            Hint = ''
            Caption = 'Segundo item'
            TabOrder = 2
          end
          object btnAlinharTres: TUniButton
            Left = 308
            Top = 60
            Width = 130
            Height = 42
            Hint = ''
            Caption = 'Terceiro item'
            TabOrder = 3
          end
        end
        object flexAlinhamentoComandos: TUniDSAFlexPanel
          Left = 24
          Top = 302
          Width = 850
          Height = 110
          Hint = ''
          Flex.AlignItems = faCenter
          Flex.Padding = 16
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          ParentColor = False
          Color = clWhite
          TabOrder = 1
          object lblAlinhamentoAjuda: TUniLabel
            Left = 16
            Top = 16
            Width = 818
            Height = 20
            Hint = ''
            AutoSize = False
            Caption = 
              'Os botoes abaixo alteram Direction e JustifyContent e atualizam ' +
              'o navegador.'
            TabOrder = 0
          end
          object btnAlternarDirecao: TUniButton
            Left = 16
            Top = 48
            Width = 190
            Height = 34
            Hint = ''
            Caption = 'Usar direcao em coluna'
            TabOrder = 1
            OnClick = btnAlternarDirecaoClick
          end
          object btnAlternarJustificacao: TUniButton
            Left = 218
            Top = 48
            Width = 170
            Height = 34
            Hint = ''
            Caption = 'Centralizar itens'
            TabOrder = 2
            OnClick = btnAlternarJustificacaoClick
          end
        end
      end
    end
    object tabLaboratorio: TUniTabSheet
      Hint = ''
      Caption = 'Laboratorio de propriedades'
      object flexLabPagina: TUniDSAFlexPanel
        Left = 0
        Top = 0
        Width = 898
        Height = 723
        Hint = ''
        Flex.Direction = fdColumn
        Flex.Wrap = fwNoWrap
        Flex.Padding = 16
        Flex.Overflow = foAuto
        FlexItem.Basis = 'auto'
        Responsive.XS.Span = 12
        Align = alClient
        ParentColor = False
        Color = 16579066
        TabOrder = 0
        object lblLabIntroducao: TUniLabel
          Left = 16
          Top = 16
          Width = 866
          Height = 72
          Hint = ''
          AutoSize = False
          Caption = 
            'Escolha a propriedade, o alvo e o valor. As alteracoes de FlexIt' +
            'em e Responsive podem ser aplicadas a um painel ou a todos os fi' +
            'lhos. RowGap/ColumnGap = -1 usa Gap; Span = 0 herda o breakpoint' +
            ' anterior.'
          ParentFont = False
          Font.Height = -14
          TabOrder = 0
        end
        object flexLabComandos: TUniDSAFlexPanel
          Left = 16
          Top = 100
          Width = 866
          Height = 105
          Hint = ''
          Flex.AlignItems = faCenter
          Flex.AlignContent = faStart
          Flex.Gap = 8
          Flex.Padding = 12
          Flex.Overflow = foAuto
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          ParentColor = False
          Color = clWhite
          TabOrder = 1
          object lblLabPropriedade: TUniLabel
            Left = 12
            Top = 12
            Width = 90
            Height = 32
            Hint = ''
            AutoSize = False
            Caption = 'Propriedade:'
            TabOrder = 0
          end
          object cbLabPropriedade: TUniComboBox
            Left = 110
            Top = 12
            Width = 230
            Height = 32
            Hint = ''
            Style = csDropDownList
            Text = 'Pai.Flex.Direction'
            Items.Strings = (
              'Pai.Flex.Direction'
              'Pai.Flex.Wrap'
              'Pai.Flex.JustifyContent'
              'Pai.Flex.AlignItems'
              'Pai.Flex.AlignContent'
              'Pai.Flex.Gap'
              'Pai.Flex.RowGap'
              'Pai.Flex.ColumnGap'
              'Pai.Flex.Padding'
              'Pai.Flex.Columns'
              'Pai.Flex.DefaultSpan'
              'Pai.Flex.Overflow'
              'Pai.Flex.AutoHeight'
              'Pai.Flex.AutoWidth'
              'Alvo.FlexItem.Grow'
              'Alvo.FlexItem.Shrink'
              'Alvo.FlexItem.Basis'
              'Alvo.FlexItem.Order'
              'Alvo.FlexItem.AlignSelf'
              'Alvo.Responsive.XS.Span'
              'Alvo.Responsive.SM.Span'
              'Alvo.Responsive.MD.Span'
              'Alvo.Responsive.LG.Span'
              'Alvo.Responsive.XL.Span'
              'Alvo.Responsive.XXL.Span')
            ItemIndex = 0
            TabOrder = 1
            IconItems = <>
            OnChange = cbLabPropriedadeChange
          end
          object lblLabAlvo: TUniLabel
            Left = 348
            Top = 12
            Width = 42
            Height = 32
            Hint = ''
            Enabled = False
            AutoSize = False
            Caption = 'Alvo:'
            TabOrder = 2
          end
          object cbLabAlvo: TUniComboBox
            Left = 398
            Top = 12
            Width = 170
            Height = 32
            Hint = ''
            Enabled = False
            Style = csDropDownList
            Text = 'Todos os filhos'
            Items.Strings = (
              'Filho selecionado'
              'Irmao A'
              'Irmao B'
              'Todos os filhos')
            ItemIndex = 3
            TabOrder = 3
            IconItems = <>
            OnChange = cbLabAlvoChange
          end
          object lblLabValor: TUniLabel
            Left = 576
            Top = 12
            Width = 42
            Height = 32
            Hint = ''
            AutoSize = False
            Caption = 'Valor:'
            TabOrder = 4
          end
          object cbLabValor: TUniComboBox
            Left = 626
            Top = 12
            Width = 180
            Height = 32
            Hint = ''
            Style = csDropDownList
            Text = 'fdRow'
            Items.Strings = (
              'fdRow'
              'fdRowReverse'
              'fdColumn'
              'fdColumnReverse')
            ItemIndex = 0
            TabOrder = 5
            IconItems = <>
            OnChange = cbLabValorChange
          end
          object btnLabRestaurar: TUniButton
            Left = 12
            Top = 52
            Width = 130
            Height = 32
            Hint = ''
            Caption = 'Restaurar valores'
            TabOrder = 6
            OnClick = btnLabRestaurarClick
          end
        end
        object memLabResumo: TUniMemo
          Left = 16
          Top = 217
          Width = 866
          Height = 126
          Hint = ''
          Lines.Strings = (
            'As propriedades atuais do pai e do filho aparecem aqui.'
            
              'Use a lista acima para testar todos os valores descritos no manu' +
              'al.')
          ReadOnly = True
          TabOrder = 2
        end
        object flexLabPai: TUniDSAFlexPanel
          Left = 16
          Top = 355
          Width = 866
          Height = 341
          Hint = 'FlexPanel pai'
          Flex.Padding = 16
          FlexItem.Basis = 'auto'
          Responsive.XS.Span = 12
          ParentColor = False
          Color = 15132390
          TabOrder = 3
          object flexLabFilho: TUniDSAFlexPanel
            Left = 16
            Top = 16
            Width = 270
            Height = 160
            Hint = 'FlexPanel filho selecionado'
            Flex.Direction = fdColumn
            Flex.Wrap = fwNoWrap
            Flex.Gap = 8
            Flex.Padding = 16
            FlexItem.Basis = 'auto'
            Responsive.XS.Span = 12
            Responsive.MD.Span = 4
            ParentColor = False
            Color = clWhitesmoke
            TabOrder = 0
            object lblLabFilhoTitulo: TUniLabel
              Left = 16
              Top = 16
              Width = 238
              Height = 24
              Hint = ''
              AutoSize = False
              Caption = 'FILHO SELECIONADO'
              ParentFont = False
              Font.Height = -15
              Font.Style = [fsBold]
              TabOrder = 0
            end
            object lblLabFilhoTexto: TUniLabel
              Left = 16
              Top = 48
              Width = 238
              Height = 56
              Hint = ''
              AutoSize = False
              Caption = 'FlexItem e Responsive deste painel mudam pelas opcoes acima.'
              TabOrder = 1
            end
          end
          object flexLabIrmaoA: TUniDSAFlexPanel
            Left = 298
            Top = 16
            Width = 270
            Height = 160
            Hint = 'FlexPanel irmao A'
            Flex.Direction = fdColumn
            Flex.Wrap = fwNoWrap
            Flex.Gap = 8
            Flex.Padding = 16
            FlexItem.Basis = 'auto'
            Responsive.XS.Span = 12
            Responsive.MD.Span = 4
            ParentColor = False
            Color = 15592941
            TabOrder = 1
            object lblLabIrmaoATitulo: TUniLabel
              Left = 16
              Top = 16
              Width = 238
              Height = 24
              Hint = ''
              AutoSize = False
              Caption = 'IRMAO A'
              ParentFont = False
              Font.Height = -15
              Font.Style = [fsBold]
              TabOrder = 0
            end
            object lblLabIrmaoATexto: TUniLabel
              Left = 16
              Top = 48
              Width = 238
              Height = 56
              Hint = ''
              AutoSize = False
              Caption = 'Ajuda a visualizar Direction, Wrap, Gap e alinhamentos do pai.'
              TabOrder = 1
            end
          end
          object flexLabIrmaoB: TUniDSAFlexPanel
            Left = 580
            Top = 16
            Width = 270
            Height = 160
            Hint = 'FlexPanel irmao B'
            Flex.Direction = fdColumn
            Flex.Wrap = fwNoWrap
            Flex.Gap = 8
            Flex.Padding = 16
            FlexItem.Basis = 'auto'
            Responsive.XS.Span = 12
            Responsive.MD.Span = 4
            ParentColor = False
            Color = clHoneydew
            TabOrder = 2
            object lblLabIrmaoBTitulo: TUniLabel
              Left = 16
              Top = 16
              Width = 238
              Height = 24
              Hint = ''
              AutoSize = False
              Caption = 'IRMAO B'
              ParentFont = False
              Font.Height = -15
              Font.Style = [fsBold]
              TabOrder = 0
            end
            object lblLabIrmaoBTexto: TUniLabel
              Left = 16
              Top = 48
              Width = 238
              Height = 56
              Hint = ''
              AutoSize = False
              Caption = 'Permanece como referencia enquanto o filho selecionado muda.'
              TabOrder = 1
            end
          end
        end
      end
    end
  end
  object ConfirmarRestauracao: TUniDSAConfirm
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
    BoxWidth = '35%'
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
    TypeConfirm = Confirm
    Type = Orange
    Left = 856
    Top = 24
  end
end
