object FrSignature: TFrSignature
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
      Height = 580
      Flex.AutoHeight = True
      Flex.Direction = fdColumn
      Flex.Wrap = fwNoWrap
      Flex.Gap = 10
      Flex.Overflow = foVisible
      FlexItem.Shrink = 0
      object lblTitle: TUniLabel
        Width = 300
        Height = 36
        Caption = 'Signature'
        ParentFont = False
        Font.Height = 30
        Font.Style = [fsBold]
      end
      object lblSubtitle: TUniLabel
        Width = 620
        Height = 24
        Caption = 'Capture assinaturas com mouse, toque ou caneta em qualquer tela'
        ParentFont = False
        Font.Color = clGray
        Font.Height = -15
      end
      object flexCard: TUniDSAFlexPanel
        Tag = 100
        Width = 720
        Height = 480
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
          Caption = 'Assinatura do respons'#225'vel'
        end
        object Signature: TUniDSASignature
          Width = 680
          Height = 330
          PenColor = 4797221
          PenWidth = 3
          CanvasHeight = 260
          ReadOnly = False
          Required = True
          ShowToolbar = True
          Placeholder = 'Assine dentro da '#225'rea indicada'
          FileName = 'assinatura-unidsa'
          Format = sfPNG
          OnChange = SignatureChange
        end
        object flexActions: TUniDSAFlexPanel
          Tag = 101
          Width = 680
          Height = 44
          Flex.AutoHeight = True
          Flex.Direction = fdRow
          Flex.Wrap = fwWrap
          Flex.Gap = 10
          Flex.Overflow = foVisible
          FlexItem.Shrink = 0
          object btnValidate: TUniButton
            Width = 130
            Height = 42
            Caption = 'Validar'
            OnClick = btnValidateClick
          end
          object btnRequestValue: TUniButton
            Width = 150
            Height = 42
            Caption = 'Atualizar Base64'
            OnClick = btnRequestValueClick
          end
          object lblStatus: TUniLabel
            Width = 360
            Height = 22
            Caption = 'Aguardando assinatura.'
          end
        end
      end
    end
  end
end
