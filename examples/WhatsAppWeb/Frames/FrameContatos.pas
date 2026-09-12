unit FrameContatos;

{ Lista lateral de contatos. Os cinco contatos reais do exemplo ficam no DFM,
  portanto podem ser inspecionados e ajustados visualmente no RAD Studio. Os três
  TFrContato inline mostram o frame reutilizável e são removidos após o carregamento. }

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  uniGUIFrame,
  uniGUIClasses,
  uniGUIBaseClasses,
  uniGUITypes,
  uniLabel,
  uniEdit,
  uniButton,
  UniDSABase,
  UniDSAFlexPanel,
  UniDSAStyle,
  DadosChat,
  FrameContato;

type
  // O índice identifica a mesma conversa nas units FrameContatos e DadosChat.
  TEventoContatoSelecionado = procedure(Remetente: TObject;
    Indice: Integer) of object;

  // Agrupa os controles e o estado que pertencem ao mesmo contato.
  TRecContatoVisual = record
    Linha: TUniDSAFlexPanel;
    Nome: TUniLabel;
    Previa: TUniLabel;
    IndicadorNaoLidas: TUniLabel;
    QuantidadeNaoLidas: Integer;
  end;

  TArrayRecContatosVisuais = array of TRecContatoVisual;

  TFrContatos = class(TUniFrame)
    EstiloControles: TUniDSAStyle;
    flexRaiz: TUniDSAFlexPanel;
    flexCabecalho: TUniDSAFlexPanel;
    flexPesquisa: TUniDSAFlexPanel;
    flexFiltros: TUniDSAFlexPanel;
    flexContatos: TUniDSAFlexPanel;
    flexRodape: TUniDSAFlexPanel;
    lblMarca: TUniLabel;
    lblSubtitulo: TUniLabel;
    lblVazio: TUniLabel;
    lblDemonstracao: TUniLabel;
    edtPesquisa: TUniEdit;
    btnTodas: TUniButton;
    btnNaoLidas: TUniButton;
    flexContato0: TUniDSAFlexPanel;
    flexDetalhes0: TUniDSAFlexPanel;
    lblAvatar0: TUniLabel;
    lblNome0: TUniLabel;
    lblPrevia0: TUniLabel;
    lblNaoLidas0: TUniLabel;
    flexContato1: TUniDSAFlexPanel;
    flexDetalhes1: TUniDSAFlexPanel;
    lblAvatar1: TUniLabel;
    lblNome1: TUniLabel;
    lblPrevia1: TUniLabel;
    lblNaoLidas1: TUniLabel;
    flexContato2: TUniDSAFlexPanel;
    flexDetalhes2: TUniDSAFlexPanel;
    lblAvatar2: TUniLabel;
    lblNome2: TUniLabel;
    lblPrevia2: TUniLabel;
    lblNaoLidas2: TUniLabel;
    flexContato3: TUniDSAFlexPanel;
    flexDetalhes3: TUniDSAFlexPanel;
    lblAvatar3: TUniLabel;
    lblNome3: TUniLabel;
    lblPrevia3: TUniLabel;
    lblNaoLidas3: TUniLabel;
    flexContato4: TUniDSAFlexPanel;
    flexDetalhes4: TUniDSAFlexPanel;
    lblAvatar4: TUniLabel;
    lblNome4: TUniLabel;
    lblPrevia4: TUniLabel;
    lblNaoLidas4: TUniLabel;
    PreviaContatoMariana: TFrContato;
    PreviaContatoEquipe: TFrContato;
    PreviaContatoRafael: TFrContato;
    procedure CriarFrame(Remetente: TObject);
    procedure ClicarContato(Remetente: TObject);
    procedure AlterarPesquisa(Remetente: TObject);
    procedure ClicarFiltro(Remetente: TObject);
  private
    FContatosVisuais: TArrayRecContatosVisuais;
    FSomenteNaoLidas: Boolean;
    FSelecionado: Integer;
    procedure AplicarFiltro;
  public
    AoSelecionarContato: TEventoContatoSelecionado;
    procedure RemoverPrevias;
    procedure SelecionarContato(Indice: Integer);
    procedure AtualizarPrevia(Indice: Integer; const Texto: string);
  end;

implementation

{$R *.dfm}

procedure TFrContatos.CriarFrame(Remetente: TObject);
begin
  // As instâncias inline ficam visíveis na IDE e ocultas desde o início da sessão.
  PreviaContatoMariana.Visible := False;
  PreviaContatoEquipe.Visible := False;
  PreviaContatoRafael.Visible := False;

  SetLength(FContatosVisuais, QuantidadeContatos);

  // Relaciona cada record aos componentes declarados no DFM.
  FContatosVisuais[0].Linha := flexContato0;
  FContatosVisuais[0].Nome := lblNome0;
  FContatosVisuais[0].Previa := lblPrevia0;
  FContatosVisuais[0].IndicadorNaoLidas := lblNaoLidas0;

  FContatosVisuais[1].Linha := flexContato1;
  FContatosVisuais[1].Nome := lblNome1;
  FContatosVisuais[1].Previa := lblPrevia1;
  FContatosVisuais[1].IndicadorNaoLidas := lblNaoLidas1;

  FContatosVisuais[2].Linha := flexContato2;
  FContatosVisuais[2].Nome := lblNome2;
  FContatosVisuais[2].Previa := lblPrevia2;
  FContatosVisuais[2].IndicadorNaoLidas := lblNaoLidas2;

  FContatosVisuais[3].Linha := flexContato3;
  FContatosVisuais[3].Nome := lblNome3;
  FContatosVisuais[3].Previa := lblPrevia3;
  FContatosVisuais[3].IndicadorNaoLidas := lblNaoLidas3;

  FContatosVisuais[4].Linha := flexContato4;
  FContatosVisuais[4].Nome := lblNome4;
  FContatosVisuais[4].Previa := lblPrevia4;
  FContatosVisuais[4].IndicadorNaoLidas := lblNaoLidas4;

  // Dados locais usados para demonstrar o filtro de não lidas.
  FContatosVisuais[1].QuantidadeNaoLidas := 2;
  FContatosVisuais[2].QuantidadeNaoLidas := 1;
  FSelecionado := -1;
  FSomenteNaoLidas := False;
  AplicarFiltro;
end;

procedure TFrContatos.RemoverPrevias;
begin
  // O temporizador do formulário chama este método após o streaming do DFM.
  FreeAndNil(PreviaContatoMariana);
  FreeAndNil(PreviaContatoEquipe);
  FreeAndNil(PreviaContatoRafael);
end;

procedure TFrContatos.AplicarFiltro;
var
  Indice: Integer;
  QuantidadeVisiveis: Integer;
  Pesquisa: string;
begin
  Pesquisa := LowerCase(Trim(edtPesquisa.Text));
  QuantidadeVisiveis := 0;

  for Indice := Low(FContatosVisuais) to High(FContatosVisuais) do begin
    FContatosVisuais[Indice].Linha.Visible :=
      ((Pesquisa = '') or
      (Pos(Pesquisa,
      LowerCase(FContatosVisuais[Indice].Nome.Caption)) > 0)) and
      (not FSomenteNaoLidas or
      (FContatosVisuais[Indice].QuantidadeNaoLidas > 0));

    if FContatosVisuais[Indice].Linha.Visible then
      Inc(QuantidadeVisiveis);

    FContatosVisuais[Indice].IndicadorNaoLidas.Visible :=
      FContatosVisuais[Indice].QuantidadeNaoLidas > 0;
  end;

  lblVazio.Visible := QuantidadeVisiveis = 0;

  // Selected aciona States.Selected dos botões em uma única atualização visual.
  EstiloControles.BeginUpdate;
  try
    EstiloControles.StyleItems.FindByControl(btnTodas).Selected := not FSomenteNaoLidas;
    EstiloControles.StyleItems.FindByControl(btnNaoLidas).Selected := FSomenteNaoLidas;
  finally
    EstiloControles.EndUpdate;
  end;
end;

procedure TFrContatos.SelecionarContato(Indice: Integer);
begin
  if
    (Indice < Low(FContatosVisuais)) or
    (Indice > High(FContatosVisuais))
  then
    Exit;

  // Desmarca a linha anterior antes de aplicar States.Selected à nova linha.
  if FSelecionado >= 0 then
    EstiloControles.StyleItems.FindByControl(FContatosVisuais[FSelecionado].Linha).Selected := False;

  FSelecionado := Indice;
  EstiloControles.StyleItems.FindByControl(FContatosVisuais[Indice].Linha).Selected := True;

  // Abrir a conversa limpa seu contador de não lidas.
  FContatosVisuais[Indice].QuantidadeNaoLidas := 0;
  AplicarFiltro;
end;

procedure TFrContatos.ClicarContato(Remetente: TObject);
var
  Indice: Integer;
begin
  // Cada linha guarda seu índice na propriedade Tag configurada no designer.
  Indice := TComponent(Remetente).Tag;
  SelecionarContato(Indice);

  if Assigned(AoSelecionarContato) then
    AoSelecionarContato(Self, Indice);
end;

procedure TFrContatos.AlterarPesquisa(Remetente: TObject);
begin
  AplicarFiltro;
end;

procedure TFrContatos.ClicarFiltro(Remetente: TObject);
begin
  // Tag = 1 identifica o botão "Não lidas"; Tag = 0 identifica "Todas".
  FSomenteNaoLidas := TComponent(Remetente).Tag = 1;
  AplicarFiltro;
end;

procedure TFrContatos.AtualizarPrevia(Indice: Integer; const Texto: string);
begin
  if
    (Indice < Low(FContatosVisuais)) or
    (Indice > High(FContatosVisuais))
  then
    Exit;

  // Atualiza somente a legenda do contato que recebeu a nova mensagem.
  FContatosVisuais[Indice].Previa.Caption :=
    'Você: ' +
    StringReplace(Texto, '&', '&&', [rfReplaceAll]);
end;

end.
