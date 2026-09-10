object FrQrCodeGenerator: TFrQrCodeGenerator
  Width = 900
  Height = 720
  object flexDemoPage: TUniDSAFlexPanel
    Tag = 120
    Width = 900
    Height = 720
    Align = alClient
    Flex.Direction = fdColumn
    Flex.Wrap = fwNoWrap
    Flex.Gap = 20
    Flex.Padding = 24
    Flex.Overflow = foAuto
    object flexPrincipal: TUniDSAFlexPanel
      Tag = 110
      Width = 760
      Height = 600
      Flex.AutoHeight = True
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 10
      Flex.Overflow = foVisible
      FlexItem.Shrink = 0
      object lblTitle: TUniLabel
        Width = 300
        Height = 36
        Caption = 'QR Code Generator'
        ParentFont = False
        Font.Height = 30
        Font.Style = [fsBold]
      end
      object lblSubtitle: TUniLabel
        Width = 620
        Height = 24
        Caption = 'Crie QR Codes personalizados, responsivos e prontos para exporta'#231#227'o'
        ParentFont = False
        Font.Color = clGray
        Font.Height = -15
      end
      object flexCard: TUniDSAFlexPanel
        Tag = 100
        Width = 720
        Height = 520
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
          Width = 220
          Height = 28
          Caption = 'Conte'#250'do e visualiza'#231#227'o'
        end
        object flexInput: TUniDSAFlexPanel
          Tag = 101
          Width = 680
          Height = 48
          Flex.AutoHeight = True
          Flex.Direction = fdRow
          Flex.Wrap = fwWrap
          Flex.Gap = 10
          Flex.Overflow = foVisible
          FlexItem.Shrink = 0
          object edtContent: TUniEdit
            Width = 430
            Height = 42
            Text = 'https://github.com/deividyalcantara/unidsa-unigui-delphi'
            EmptyText = 'Texto, URL, PIX ou outro conte'#250'do'
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
        object QrGenerator: TUniDSAQrCodeGenerator
          Width = 680
          Height = 390
          Text = 'https://github.com/deividyalcantara/unidsa-unigui-delphi'
          Size = 280
          Margin = 4
          ErrorCorrection = qecMedium
          ModuleStyle = qmsSquare
          ForegroundColor = clBlack
          BackgroundColor = clWhite
          LogoSize = 20
          ExportFormat = qefPNG
          FileName = 'unidsa-qrcode'
          EmptyText = 'Informe um conte'#250'do para gerar o QR Code.'
          ShowActions = True
          OnGenerated = QrGeneratorGenerated
          OnData = QrGeneratorData
        end
        object lblStatus: TUniLabel
          Width = 660
          Height = 22
          Caption = 'Use Baixar, Copiar imagem ou Obter dados.'
        end
      end
    end
  end
end
