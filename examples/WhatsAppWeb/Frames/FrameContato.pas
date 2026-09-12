unit FrameContato;

{ Frame visual de um contato. Ele permanece totalmente montado no DFM para servir
  como referência no designer e como modelo reutilizável em outras aplicações. }

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  uniGUIFrame,
  uniGUIClasses,
  uniGUIBaseClasses,
  uniLabel,
  UniDSABase,
  UniDSAFlexPanel,
  UniDSAStyle;

type
  TFrContato = class(TUniFrame)
    // flexContato organiza avatar e detalhes; flexDetalhes empilha nome e prévia.
    flexContato: TUniDSAFlexPanel;
    flexDetalhes: TUniDSAFlexPanel;
    lblAvatar: TUniLabel;
    lblNome: TUniLabel;
    lblPrevia: TUniLabel;
    lblNaoLidas: TUniLabel;
    // Styles define as receitas; StyleItems associa cada receita a um controle.
    EstiloContato: TUniDSAStyle;
  end;

implementation

{$R *.dfm}

end.