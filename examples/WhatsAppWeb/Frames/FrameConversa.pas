unit FrameConversa;

{ Área principal da conversa. O cabeçalho, o aviso, o histórico, o compositor e
  quatro mensagens de prévia ficam no DFM. Em execução, as prévias são removidas
  e cada mensagem real usa uma instância do FrameMensagem já desenhado. }

interface

uses
  Winapi.Windows,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Controls,
  Vcl.Forms,
  uniGUIFrame,
  uniGUIClasses,
  uniGUIBaseClasses,
  uniGUITypes,
  uniLabel,
  uniButton,
  uniEdit,
  UniDSABase,
  UniDSAFlexPanel,
  UniDSAStyle,
  DadosChat,
  FrameMensagem;

type
  // Comunica ao formulário principal qual conversa teve a prévia alterada.
  TEventoMensagemEnviada = procedure(Remetente: TObject; Indice: Integer;
    const Texto: string) of object;

  TFrConversa = class(TUniFrame)
    EstiloControles: TUniDSAStyle;
    flexRaiz: TUniDSAFlexPanel;
    flexCabecalho: TUniDSAFlexPanel;
    flexIdentidade: TUniDSAFlexPanel;
    flexHistorico: TUniDSAFlexPanel;
    flexAviso: TUniDSAFlexPanel;
    flexCompositor: TUniDSAFlexPanel;
    flexEntrada: TUniDSAFlexPanel;
    lblAvatar: TUniLabel;
    lblNome: TUniLabel;
    lblStatus: TUniLabel;
    lblAviso: TUniLabel;
    lblDicaCompositor: TUniLabel;
    btnVoltar: TUniButton;
    btnEnviar: TUniButton;
    edtMensagem: TUniEdit;
    PreviaRecebida: TFrMensagem;
    PreviaEnviada: TFrMensagem;
    PreviaRecebidaLonga: TFrMensagem;
    PreviaEnviadaCurta: TFrMensagem;
    procedure CriarFrame(Remetente: TObject);
    procedure ClicarEnviar(Remetente: TObject);
    procedure AlterarMensagem(Remetente: TObject);
    procedure PressionarTeclaMensagem(Remetente: TObject; var Tecla: Word; Modificadores: TShiftState);
    procedure ClicarVoltar(Remetente: TObject);
  private
    // O histórico pertence à sessão e não é compartilhado entre usuários.
    FConversas: TArrayConversas;
    FConversaSelecionada: Integer;
    // A lista possui os frames e os libera ao trocar de conversa.
    FFramesMensagens: TObjectList<TFrMensagem>;
    FSequenciaFrame: Integer;
    procedure ExibirHistorico;
    procedure AdicionarFrameMensagem(const Mensagem: TMensagemChat);
    procedure EnviarMensagem;
  public
    AoEnviarMensagem: TEventoMensagemEnviada;
    AoVoltar: TNotifyEvent;
    procedure RemoverPrevias;
    destructor Destroy; override;
    procedure SelecionarConversa(Indice: Integer);
  end;

implementation

{$R *.dfm}

procedure TFrConversa.CriarFrame(Remetente: TObject);
begin
  // As mensagens inline servem somente para visualizar a composição na IDE.
  PreviaRecebida.Visible := False;
  PreviaEnviada.Visible := False;
  PreviaRecebidaLonga.Visible := False;
  PreviaEnviadaCurta.Visible := False;

  FFramesMensagens := TObjectList<TFrMensagem>.Create(True);
  CarregarConversasDemonstracao(FConversas);
  FConversaSelecionada := -1;
  edtMensagem.MaxLength := LimiteCaracteresMensagem;
end;

procedure TFrConversa.RemoverPrevias;
begin
  // O temporizador do formulário chama este método após o streaming do DFM.
  FreeAndNil(PreviaRecebida);
  FreeAndNil(PreviaEnviada);
  FreeAndNil(PreviaRecebidaLonga);
  FreeAndNil(PreviaEnviadaCurta);

  if FConversaSelecionada < 0 then
    SelecionarConversa(0)
  else
    // A seleção inicial acontece durante o streaming do formulário. Recriar o
    // histórico nessa primeira requisição garante que os frames reais cheguem ao cliente
    // depois que as quatro prévias visuais forem removidas.
    ExibirHistorico;
end;

destructor TFrConversa.Destroy;
begin
  Destroying;
  FreeAndNil(FFramesMensagens);
  inherited;
end;

procedure TFrConversa.SelecionarConversa(Indice: Integer);
begin
  if (Indice < Low(FConversas)) or (Indice > High(FConversas)) then
    Exit;

  if Indice = FConversaSelecionada then
    Exit;

  // Guarda o texto ainda não enviado antes de abrir outra conversa.
  if FConversaSelecionada >= 0 then
    FConversas[FConversaSelecionada].Rascunho := edtMensagem.Text;

  FConversaSelecionada := Indice;
  lblAvatar.Caption := FConversas[Indice].Iniciais;
  lblNome.Caption := FConversas[Indice].Nome;
  lblStatus.Caption := FConversas[Indice].Descricao;
  edtMensagem.Text := FConversas[Indice].Rascunho;
  lblDicaCompositor.Caption := 'Enter para enviar';
  ExibirHistorico;
end;

procedure TFrConversa.AdicionarFrameMensagem(
  const Mensagem: TMensagemChat);
var
  FrameMensagem: TFrMensagem;
  ItemDoFlex: TUniDSAFlexChildItem;
begin
  // A instância traz todos os controles definidos no DFM do FrameMensagem.
  FrameMensagem := TFrMensagem.Create(Self);
  try
    Inc(FSequenciaFrame);
    FrameMensagem.Name := 'Mensagem' + IntToStr(FSequenciaFrame);
    FrameMensagem.Parent := flexHistorico;

    // Em uma coluna flex, Shrink = 0 impede que muitas mensagens virem faixas
    // horizontais. A altura natural permanece e o excedente usa o scroll do pai.
    ItemDoFlex := flexHistorico.FlexItems.Add;
    ItemDoFlex.Shrink := 0;
    ItemDoFlex.Basis := 'auto';
    ItemDoFlex.Responsive.XS.Span := 0;
    // TUniFrame expõe seu controle web por FormRegion (padrão usado no demo).
    ItemDoFlex.Control := FrameMensagem.FormRegion;

    FrameMensagem.ExibirMensagem(Mensagem);
    FFramesMensagens.Add(FrameMensagem);
  except
    FrameMensagem.Free;
    raise;
  end;
end;

procedure TFrConversa.ExibirHistorico;
var
  Mensagem: TMensagemChat;
begin
  // Limpa as associações FlexItems junto com os frames da conversa anterior.
  flexHistorico.FlexItems.Clear;
  FFramesMensagens.Clear;

  // Wrap = NoWrap mantém uma coluna contínua; Overflow = Auto cria a rolagem.
  for Mensagem in FConversas[FConversaSelecionada].Mensagens do
    AdicionarFrameMensagem(Mensagem);

  // Reenvia o mapa quando todos os FormRegions já possuem um JSId.
  flexHistorico.RefreshFlexItems;

  // Depois do layout, posiciona o histórico na mensagem mais recente.
  flexHistorico.RolarParaFim;
end;

procedure TFrConversa.EnviarMensagem;
var
  Texto: string;
begin
  if FConversaSelecionada < 0 then
    Exit;

  Texto := Trim(edtMensagem.Text);
  if Texto = '' then
    Exit;

  if Length(Texto) > LimiteCaracteresMensagem then begin
    lblDicaCompositor.Caption := 'Use até 2.000 caracteres por mensagem.';
    Exit;
  end;

  FConversas[FConversaSelecionada].AdicionarMensagem(Texto, True, Now);
  AdicionarFrameMensagem(FConversas[FConversaSelecionada].Mensagens[
    High(FConversas[FConversaSelecionada].Mensagens)]);
  flexHistorico.RefreshFlexItems;

  edtMensagem.Clear;
  FConversas[FConversaSelecionada].Rascunho := '';
  lblDicaCompositor.Caption := 'Mensagem adicionada à conversa';
  if Assigned(AoEnviarMensagem) then
    AoEnviarMensagem(Self, FConversaSelecionada, Texto);

  flexHistorico.RolarParaFim;
  edtMensagem.SetFocus;
end;

procedure TFrConversa.AlterarMensagem(Remetente: TObject);
begin
  // Mantém um rascunho independente para cada conversa da sessão.
  if FConversaSelecionada >= 0 then
    FConversas[FConversaSelecionada].Rascunho := edtMensagem.Text;
end;

procedure TFrConversa.ClicarEnviar(Remetente: TObject);
begin
  EnviarMensagem;
end;

procedure TFrConversa.PressionarTeclaMensagem(Remetente: TObject; var Tecla: Word;
  Modificadores: TShiftState);
begin
  // Enter envia; combinações com modificadores continuam disponíveis ao controle.
  if (Tecla = VK_RETURN) and (Modificadores = []) then begin
    Tecla := 0;
    EnviarMensagem;
  end;
end;

procedure TFrConversa.ClicarVoltar(Remetente: TObject);
begin
  if Assigned(AoVoltar) then
    AoVoltar(Self);
end;

end.
