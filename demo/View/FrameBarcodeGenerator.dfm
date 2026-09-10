object FrBarcodeGenerator: TFrBarcodeGenerator
  Width = 980
  Height = 720
  object flexDemoPage: TUniDSAFlexPanel
    Tag = 120
    Width = 980
    Height = 720
    Align = alClient
    Flex.Direction = fdColumn
    Flex.Wrap = fwNoWrap
    Flex.Gap = 20
    Flex.Padding = 24
    Flex.Overflow = foAuto
    object flexPrincipal: TUniDSAFlexPanel
      Tag = 110
      Width = 840
      Height = 550
      Flex.AutoHeight = True
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 10
      Flex.Overflow = foVisible
      FlexItem.Shrink = 0
      object lblTitle: TUniLabel
        Width = 380
        Height = 36
        Caption = 'Barcode Generator'
        ParentFont = False
        Font.Height = 30
        Font.Style = [fsBold]
      end
      object lblSubtitle: TUniLabel
        Width = 720
        Height = 24
        Caption = 'Gere c'#243'digos de barras profissionais para produtos, etiquetas e log'#237'stica'
        ParentFont = False
        Font.Color = clGray
        Font.Height = -15
      end
      object flexCard: TUniDSAFlexPanel
        Tag = 100
        Width = 840
        Height = 455
        Flex.AutoHeight = True
        Flex.Direction = fdColumn
        Flex.Wrap = fwNoWrap
        Flex.Gap = 16
        Flex.Padding = 20
        Flex.Overflow = foVisible
        FlexItem.Shrink = 0
        Color = clWhite
        object lblSection: TUniLabel
          Tag = 100
          Width = 260
          Height = 28
          Caption = 'Conte'#250'do e visualiza'#231#227'o'
        end
        object flexInput: TUniDSAFlexPanel
          Tag = 101
          Width = 800
          Height = 48
          Flex.AutoHeight = True
          Flex.Direction = fdRow
          Flex.Wrap = fwWrap
          Flex.Gap = 10
          Flex.Overflow = foVisible
          FlexItem.Shrink = 0
          object edtValue: TUniEdit
            Width = 500
            Height = 42
            Text = '7891234567895'
            EmptyText = 'N'#250'mero do produto, pedido ou etiqueta'
          end
          object btnGenerate: TUniButton
            Width = 110
            Height = 42
            Caption = 'Gerar'
            OnClick = btnGenerateClick
          end
          object btnRequestData: TUniButton
            Width = 130
            Height = 42
            Caption = 'Obter dados'
            OnClick = btnRequestDataClick
          end
        end
        object BarcodeGenerator: TUniDSABarcodeGenerator
          Width = 800
          Height = 275
          Value = '7891234567895'
          Format = bcCode128
          BarWidth = 2
          BarHeight = 100
          Margin = 12
          DisplayValue = True
          FontSize = 18
          TextMargin = 4
          LineColor = clBlack
          BackgroundColor = clWhite
          ExportFormat = befPNG
          FileName = 'unidsa-barcode'
          EmptyText = 'Informe um valor para gerar o codigo de barras.'
          ShowActions = True
          OnGenerated = BarcodeGeneratorGenerated
          OnError = BarcodeGeneratorError
          OnData = BarcodeGeneratorData
        end
        object lblStatus: TUniLabel
          Width = 780
          Height = 22
          Caption = 'Use Baixar, Copiar imagem ou Obter dados.'
        end
      end
    end
  end
end
