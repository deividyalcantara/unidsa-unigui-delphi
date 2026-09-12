unit Main;

{ Formulário principal. Ele conecta os frames e controla a navegação responsiva
  somente com eventos Delphi. }

interface

uses
  System.Classes,
  uniGUIClasses,
  uniGUIForm,
  uniGUIBaseClasses,
  uniGUIFrame,
  uniPanel,
  uniTimer,
  uniGUIRegClasses,
  UniDSAStyle,
  UniDSAFocusControl,
  FrameContatos,
  FrameConversa;

const
  LarguraMaximaCelular = 700;

type
  TMainForm = class(TUniForm)
    EstiloAplicacao: TUniDSAStyle;
    ControleFoco: TUniDSAFocusControl;
    TemporizadorInicializacao: TUniTimer;
    Contatos: TFrContatos;
    Conversa: TFrConversa;
    procedure CriarFormulario(Remetente: TObject);
    procedure InicializarAplicacao(Remetente: TObject);
    procedure RedimensionarTela(Remetente: TObject; Largura, Altura: Integer);
  private
    FConversaAberta: Boolean;
    // Eventos que mantêm a lista de contatos e a conversa sincronizadas.
    procedure ContatoSelecionado(Remetente: TObject; Indice: Integer);
    procedure MensagemEnviada(Remetente: TObject; Indice: Integer;
      const Texto: string);
    procedure VoltarAosContatos(Remetente: TObject);
    procedure AtualizarNavegacao(LarguraTela: Integer);
  end;

implementation

{$R *.dfm}

uses
  uniGUIVars,
  uniGUIApplication;

procedure TMainForm.CriarFormulario(Remetente: TObject);
begin
  // Os frames já estão no DFM; aqui são ligados somente os eventos de aplicação.
  Contatos.AoSelecionarContato := ContatoSelecionado;
  Conversa.AoEnviarMensagem := MensagemEnviada;
  Conversa.AoVoltar := VoltarAosContatos;

  FConversaAberta := False;
  Contatos.SelecionarContato(0);
  AtualizarNavegacao(UniApplication.ScreenWidth);
end;

procedure TMainForm.InicializarAplicacao(Remetente: TObject);
begin
  // O timer está no DFM e dispara uma única requisição depois que a página abriu.
  // Assim toda a inicialização permanece em Delphi, sem AddJS ou Ajax manual.
  TemporizadorInicializacao.Enabled := False;
  Contatos.RemoverPrevias;
  Conversa.RemoverPrevias;
  // Neste momento o navegador já informou suas dimensões ao uniGUI.
  AtualizarNavegacao(UniApplication.ScreenWidth);
end;

procedure TMainForm.RedimensionarTela(Remetente: TObject; Largura,
  Altura: Integer);
begin
  AtualizarNavegacao(Largura);
end;

procedure TMainForm.AtualizarNavegacao(LarguraTela: Integer);
begin
  if (LarguraTela > 0) and (LarguraTela <= LarguraMaximaCelular) then
  begin
    Contatos.Visible := not FConversaAberta;
    Conversa.Visible := FConversaAberta;
  end
  else
  begin
    Contatos.Visible := True;
    Conversa.Visible := True;
  end;
end;

procedure TMainForm.ContatoSelecionado(Remetente: TObject; Indice: Integer);
begin
  Conversa.SelecionarConversa(Indice);
  FConversaAberta := True;
  AtualizarNavegacao(UniApplication.ScreenWidth);
end;

procedure TMainForm.MensagemEnviada(Remetente: TObject; Indice: Integer;
  const Texto: string);
begin
  // Atualiza a prévia do contato sem recarregar os demais componentes.
  Contatos.AtualizarPrevia(Indice, Texto);
end;

procedure TMainForm.VoltarAosContatos(Remetente: TObject);
begin
  FConversaAberta := False;
  AtualizarNavegacao(UniApplication.ScreenWidth);
end;

initialization
  // Define este formulário como a tela principal da aplicação.
  RegisterAppFormClass(TMainForm);

end.