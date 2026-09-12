object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 760
  ClientWidth = 1200
  Caption = 'UniChat'
  Font.Name = 'Segoe UI'
  Font.Height = -14
  OnCreate = CriarFormulario
  OnScreenResize = RedimensionarTela
  MonitoredKeys.Keys = <>
  inline Contatos: TFrContatos
    Left = 0
    Top = 0
    Width = 350
    Height = 760
    Align = alLeft
    TabOrder = 0
  end
  inline Conversa: TFrConversa
    Left = 350
    Top = 0
    Width = 850
    Height = 760
    Align = alClient
    TabOrder = 1
  end
  object ControleFoco: TUniDSAFocusControl
    Left = 80
    Top = 48
  end
  object EstiloAplicacao: TUniDSAStyle
    Left = 48
    Top = 48
    Styles = <
      item
        Name = 'painel'
        Appearance.Border.Width = 0
        Responsive = <
          item
            MaxWidth = 700
            Appearance.Sizing.Width.Value = 100
            Appearance.Sizing.Width.Units = suVw
            Appearance.Sizing.Height.Value = 100
            Appearance.Sizing.Height.Units = suDvh
            Appearance.Position.Mode = poFixed
            Appearance.Position.Insets.All = 0
          end>
      end>
    StyleItems = <
      item
        Control = Contatos
        StyleName = 'painel'
        Appearance.Border.Right.Width = 1
        Appearance.Border.Right.Color = 14804445
      end
      item
        Control = Conversa
        StyleName = 'painel'
      end>
  end
  object TemporizadorInicializacao: TUniTimer
    Interval = 50
    RunOnce = True
    OnTimer = InicializarAplicacao
    Left = 112
    Top = 48
  end
end
