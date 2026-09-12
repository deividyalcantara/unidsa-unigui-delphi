unit FrameMensagem;

{ Frame de uma mensagem. Todos os controles são criados pelo DFM; em execução,
  a conversa instancia somente este frame pronto e preenche seu conteúdo. }

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  uniGUIFrame,
  uniGUIClasses,
  uniGUIBaseClasses,
  uniLabel,
  UniDSABase,
  UniDSAFlexPanel,
  UniDSAStyle,
  DadosChat;

type
  TFrMensagem = class(TUniFrame)
    // A linha decide o alinhamento; o balão recebe o estilo enviado/recebido.
    flexLinha: TUniDSAFlexPanel;
    flexBalao: TUniDSAFlexPanel;
    lblMensagem: TUniLabel;
    lblHorario: TUniLabel;
    EstiloMensagem: TUniDSAStyle;
  public
    // Preenche o modelo visual e escolhe a receita correspondente ao remetente.
    procedure ExibirMensagem(const Mensagem: TMensagemChat);
  end;

implementation

{$R *.dfm}

procedure TFrMensagem.ExibirMensagem(const Mensagem: TMensagemChat);
begin
  // O próprio frame recebe o estilo que garante largura e altura automáticas.
  EstiloMensagem.StyleItems[0].Control := Self;

  // TUniLabel interpreta & como acelerador; duplicá-lo preserva o texto literal.
  lblMensagem.Caption := StringReplace(Mensagem.Texto, '&', '&&', [rfReplaceAll]);
  lblHorario.Caption := FormatDateTime('dd/mm hh:nn', Mensagem.DataHora);

  if Mensagem.EnviadaPorMim then begin
    flexLinha.Flex.JustifyContent := fjEnd;
    EstiloMensagem.StyleItems.FindByControl(flexBalao).StyleName := 'MensagemEnviada';
    lblHorario.Caption := lblHorario.Caption + ' · você';
  end
  else begin
    flexLinha.Flex.JustifyContent := fjStart;
    EstiloMensagem.StyleItems.FindByControl(flexBalao).StyleName := 'mensagem-recebida';
  end;
end;

end.