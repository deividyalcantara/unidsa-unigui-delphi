unit FrameFlexPanel;

interface

uses
  System.SysUtils, System.Classes, System.TypInfo, Vcl.Controls, Vcl.Forms, uniGUIFrame,
  uniGUIBaseClasses, uniGUIClasses, uniLabel, uniPageControl, uniEdit,
  uniComboBox, uniButton, uniCheckBox, uniProgressBar, uniMemo,
  UniDSAFlexPanel, UniDSAConfirm, uniMultiItem, uniPanel, UniDSAExecuteFunction, UniDSABase, uniDateTimePicker;

type
  TFrFlexPanel = class(TUniFrame)
    lblTitulo: TUniLabel;
    lblDescricao: TUniLabel;
    pcExemplos: TUniPageControl;
    tabGrade: TUniTabSheet;
    flexGrade: TUniDSAFlexPanel;
    flexCadastro: TUniDSAFlexPanel;
    lblCadastroTitulo: TUniLabel;
    lblCadastroNome: TUniLabel;
    edtCadastroNome: TUniEdit;
    lblCadastroEmail: TUniLabel;
    edtCadastroEmail: TUniEdit;
    btnSalvarCadastro: TUniButton;
    lblCadastroStatus: TUniLabel;
    flexEndereco: TUniDSAFlexPanel;
    lblEnderecoTitulo: TUniLabel;
    lblEnderecoCidade: TUniLabel;
    edtEnderecoCidade: TUniEdit;
    lblEnderecoEstado: TUniLabel;
    cbEnderecoEstado: TUniComboBox;
    chkEnderecoPrincipal: TUniCheckBox;
    flexResumo: TUniDSAFlexPanel;
    lblResumoTitulo: TUniLabel;
    lblResumoTexto: TUniLabel;
    prgResumo: TUniProgressBar;
    btnAvancarProgresso: TUniButton;
    tabComponentes: TUniTabSheet;
    flexComponentes: TUniDSAFlexPanel;
    lblComponentes: TUniLabel;
    edtPesquisa: TUniEdit;
    cbCategoria: TUniComboBox;
    chkSomenteAtivos: TUniCheckBox;
    btnPesquisar: TUniButton;
    btnLimparFiltros: TUniButton;
    prgPesquisa: TUniProgressBar;
    lblPesquisaStatus: TUniLabel;
    tabAninhadas: TUniTabSheet;
    flexDashboard: TUniDSAFlexPanel;
    flexDashboardCabecalho: TUniDSAFlexPanel;
    lblDashboardTitulo: TUniLabel;
    lblDashboardPeriodo: TUniLabel;
    btnAtualizarDashboard: TUniButton;
    flexMetricaVendas: TUniDSAFlexPanel;
    lblVendasTitulo: TUniLabel;
    lblVendasValor: TUniLabel;
    flexMetricaPedidos: TUniDSAFlexPanel;
    lblPedidosTitulo: TUniLabel;
    lblPedidosValor: TUniLabel;
    flexMetricaClientes: TUniDSAFlexPanel;
    lblClientesTitulo: TUniLabel;
    lblClientesValor: TUniLabel;
    flexDashboardDetalhes: TUniDSAFlexPanel;
    lblDetalhesTitulo: TUniLabel;
    memDetalhes: TUniMemo;
    tabAlinhamento: TUniTabSheet;
    flexAlinhamentoPagina: TUniDSAFlexPanel;
    flexAlinhamentoExemplo: TUniDSAFlexPanel;
    lblAlinhamentoTitulo: TUniLabel;
    btnAlinharUm: TUniButton;
    btnAlinharDois: TUniButton;
    btnAlinharTres: TUniButton;
    flexAlinhamentoComandos: TUniDSAFlexPanel;
    lblAlinhamentoAjuda: TUniLabel;
    btnAlternarDirecao: TUniButton;
    btnAlternarJustificacao: TUniButton;
    tabLaboratorio: TUniTabSheet;
    flexLabPagina: TUniDSAFlexPanel;
    lblLabIntroducao: TUniLabel;
    flexLabComandos: TUniDSAFlexPanel;
    lblLabPropriedade: TUniLabel;
    cbLabPropriedade: TUniComboBox;
    lblLabAlvo: TUniLabel;
    cbLabAlvo: TUniComboBox;
    lblLabValor: TUniLabel;
    cbLabValor: TUniComboBox;
    btnLabRestaurar: TUniButton;
    memLabResumo: TUniMemo;
    flexLabPai: TUniDSAFlexPanel;
    flexLabFilho: TUniDSAFlexPanel;
    lblLabFilhoTitulo: TUniLabel;
    lblLabFilhoTexto: TUniLabel;
    flexLabIrmaoA: TUniDSAFlexPanel;
    lblLabIrmaoATitulo: TUniLabel;
    lblLabIrmaoATexto: TUniLabel;
    flexLabIrmaoB: TUniDSAFlexPanel;
    lblLabIrmaoBTitulo: TUniLabel;
    lblLabIrmaoBTexto: TUniLabel;
    ConfirmarRestauracao: TUniDSAConfirm;
    procedure UniFrameCreate(Sender: TObject);
    procedure btnSalvarCadastroClick(Sender: TObject);
    procedure btnAvancarProgressoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnLimparFiltrosClick(Sender: TObject);
    procedure btnAtualizarDashboardClick(Sender: TObject);
    procedure btnAlternarDirecaoClick(Sender: TObject);
    procedure btnAlternarJustificacaoClick(Sender: TObject);
    procedure cbLabPropriedadeChange(Sender: TObject);
    procedure cbLabAlvoChange(Sender: TObject);
    procedure cbLabValorChange(Sender: TObject);
    procedure btnLabRestaurarClick(Sender: TObject);
  private
    FAtualizandoLaboratorio: Boolean;
    procedure CarregarValoresLaboratorio;
    procedure PreencherValores(const AValores: array of string;
      const AValorAtual: string);
    function PainelAlvoLaboratorio: TUniDSAFlexPanel;
    procedure AplicarValorAoPainelLaboratorio(APainel: TUniDSAFlexPanel;
      APropriedade, AIndice, ANumero: Integer; const AValor: string);
    procedure AplicarValorLaboratorio;
    procedure RestaurarItemLaboratorio(APainel: TUniDSAFlexPanel);
    function ResumoItemLaboratorio(const ANome: string;
      APainel: TUniDSAFlexPanel): string;
    procedure RestaurarLaboratorio;
    procedure AtualizarResumoLaboratorio(const AAlteracao: string);
  end;

implementation

{$R *.dfm}

function TFrFlexPanel.PainelAlvoLaboratorio: TUniDSAFlexPanel;
begin
  case cbLabAlvo.ItemIndex of
    1: Result := flexLabIrmaoA;
    2: Result := flexLabIrmaoB;
  else
    Result := flexLabFilho;
  end;
end;

procedure TFrFlexPanel.PreencherValores(const AValores: array of string;
  const AValorAtual: string);
var
  I: Integer;
begin
  FAtualizandoLaboratorio := True;
  try
    cbLabValor.Items.BeginUpdate;
    try
      cbLabValor.Items.Clear;
      for I := Low(AValores) to High(AValores) do
        cbLabValor.Items.Add(AValores[I]);
    finally
      cbLabValor.Items.EndUpdate;
    end;
    cbLabValor.ItemIndex := cbLabValor.Items.IndexOf(AValorAtual);
    if (cbLabValor.ItemIndex < 0) and (cbLabValor.Items.Count > 0) then
      cbLabValor.ItemIndex := 0;
  finally
    FAtualizandoLaboratorio := False;
  end;
end;

procedure TFrFlexPanel.CarregarValoresLaboratorio;
var
  LAlvo: TUniDSAFlexPanel;
begin
  LAlvo := PainelAlvoLaboratorio;
  lblLabAlvo.Enabled := cbLabPropriedade.ItemIndex >= 14;
  cbLabAlvo.Enabled := cbLabPropriedade.ItemIndex >= 14;

  case cbLabPropriedade.ItemIndex of
    0: PreencherValores(['fdRow', 'fdRowReverse', 'fdColumn',
      'fdColumnReverse'], GetEnumName(TypeInfo(TUniDSAFlexDirection),
      Ord(flexLabPai.Flex.Direction)));
    1: PreencherValores(['fwNoWrap', 'fwWrap', 'fwWrapReverse'],
      GetEnumName(TypeInfo(TUniDSAFlexWrap), Ord(flexLabPai.Flex.Wrap)));
    2: PreencherValores(['fjStart', 'fjCenter', 'fjEnd', 'fjSpaceBetween',
      'fjSpaceAround', 'fjSpaceEvenly'], GetEnumName(TypeInfo(TUniDSAFlexJustify),
      Ord(flexLabPai.Flex.JustifyContent)));
    3: PreencherValores(['faStretch', 'faStart', 'faCenter', 'faEnd',
      'faBaseline'], GetEnumName(TypeInfo(TUniDSAFlexAlign),
      Ord(flexLabPai.Flex.AlignItems)));
    4: PreencherValores(['faStretch', 'faStart', 'faCenter', 'faEnd',
      'faBaseline'], GetEnumName(TypeInfo(TUniDSAFlexAlign),
      Ord(flexLabPai.Flex.AlignContent)));
    5: PreencherValores(['0', '4', '8', '12', '16', '24', '32'],
      IntToStr(flexLabPai.Flex.Gap));
    6: PreencherValores(['-1', '0', '4', '8', '12', '16', '24', '32'],
      IntToStr(flexLabPai.Flex.RowGap));
    7: PreencherValores(['-1', '0', '4', '8', '12', '16', '24', '32'],
      IntToStr(flexLabPai.Flex.ColumnGap));
    8: PreencherValores(['0', '4', '8', '12', '16', '24', '32'],
      IntToStr(flexLabPai.Flex.Padding));
    9: PreencherValores(['4', '8', '12', '16', '24'],
      IntToStr(flexLabPai.Flex.Columns));
    10: PreencherValores(['0', '1', '2', '3', '4', '6', '8', '12', '16', '24'],
      IntToStr(flexLabPai.Flex.DefaultSpan));
    11: PreencherValores(['foVisible', 'foHidden', 'foAuto', 'foScroll'],
      GetEnumName(TypeInfo(TUniDSAFlexOverflow), Ord(flexLabPai.Flex.Overflow)));
    12: PreencherValores(['False', 'True'],
      BoolToStr(flexLabPai.Flex.AutoHeight, True));
    13: PreencherValores(['False', 'True'],
      BoolToStr(flexLabPai.Flex.AutoWidth, True));
    14: PreencherValores(['0', '1', '2', '3'],
      IntToStr(LAlvo.FlexItem.Grow));
    15: PreencherValores(['0', '1', '2', '3'],
      IntToStr(LAlvo.FlexItem.Shrink));
    16: PreencherValores(['auto', '0', '120px', '200px', '25%', '50%', '100%'],
      LAlvo.FlexItem.Basis);
    17: PreencherValores(['-2', '-1', '0', '1', '2'],
      IntToStr(LAlvo.FlexItem.Order));
    18: PreencherValores(['fasAuto', 'fasStretch', 'fasStart', 'fasCenter',
      'fasEnd', 'fasBaseline'], GetEnumName(TypeInfo(TUniDSAFlexAlignSelf),
      Ord(LAlvo.FlexItem.AlignSelf)));
    19: PreencherValores(['0', '1', '2', '3', '4', '6', '8', '12', '16', '24'],
      IntToStr(LAlvo.Responsive.XS.Span));
    20: PreencherValores(['0', '1', '2', '3', '4', '6', '8', '12', '16', '24'],
      IntToStr(LAlvo.Responsive.SM.Span));
    21: PreencherValores(['0', '1', '2', '3', '4', '6', '8', '12', '16', '24'],
      IntToStr(LAlvo.Responsive.MD.Span));
    22: PreencherValores(['0', '1', '2', '3', '4', '6', '8', '12', '16', '24'],
      IntToStr(LAlvo.Responsive.LG.Span));
    23: PreencherValores(['0', '1', '2', '3', '4', '6', '8', '12', '16', '24'],
      IntToStr(LAlvo.Responsive.XL.Span));
    24: PreencherValores(['0', '1', '2', '3', '4', '6', '8', '12', '16', '24'],
      IntToStr(LAlvo.Responsive.XXL.Span));
  end;
end;

procedure TFrFlexPanel.AplicarValorAoPainelLaboratorio(
  APainel: TUniDSAFlexPanel; APropriedade, AIndice, ANumero: Integer;
  const AValor: string);
begin
  if not Assigned(APainel) then
    Exit;

  case APropriedade of
    14: APainel.FlexItem.Grow := ANumero;
    15: APainel.FlexItem.Shrink := ANumero;
    16: APainel.FlexItem.Basis := AValor;
    17: APainel.FlexItem.Order := ANumero;
    18: APainel.FlexItem.AlignSelf := TUniDSAFlexAlignSelf(AIndice);
    19: APainel.Responsive.XS.Span := ANumero;
    20: APainel.Responsive.SM.Span := ANumero;
    21: APainel.Responsive.MD.Span := ANumero;
    22: APainel.Responsive.LG.Span := ANumero;
    23: APainel.Responsive.XL.Span := ANumero;
    24: APainel.Responsive.XXL.Span := ANumero;
  end;
end;

procedure TFrFlexPanel.AplicarValorLaboratorio;
var
  LIndice, LNumero, LPropriedade: Integer;
  LAlteracao: string;
begin
  if FAtualizandoLaboratorio or (cbLabValor.ItemIndex < 0) then
    Exit;

  LIndice := cbLabValor.ItemIndex;
  LNumero := StrToIntDef(cbLabValor.Text, 0);
  LPropriedade := cbLabPropriedade.ItemIndex;
  case LPropriedade of
    0: flexLabPai.Flex.Direction := TUniDSAFlexDirection(LIndice);
    1: flexLabPai.Flex.Wrap := TUniDSAFlexWrap(LIndice);
    2: flexLabPai.Flex.JustifyContent := TUniDSAFlexJustify(LIndice);
    3: flexLabPai.Flex.AlignItems := TUniDSAFlexAlign(LIndice);
    4: flexLabPai.Flex.AlignContent := TUniDSAFlexAlign(LIndice);
    5: flexLabPai.Flex.Gap := LNumero;
    6: flexLabPai.Flex.RowGap := LNumero;
    7: flexLabPai.Flex.ColumnGap := LNumero;
    8: flexLabPai.Flex.Padding := LNumero;
    9: flexLabPai.Flex.Columns := LNumero;
    10: flexLabPai.Flex.DefaultSpan := LNumero;
    11: flexLabPai.Flex.Overflow := TUniDSAFlexOverflow(LIndice);
    12: flexLabPai.Flex.AutoHeight := LIndice = 1;
    13: flexLabPai.Flex.AutoWidth := LIndice = 1;
  else
    if cbLabAlvo.ItemIndex = 3 then
    begin
      AplicarValorAoPainelLaboratorio(flexLabFilho, LPropriedade,
        LIndice, LNumero, cbLabValor.Text);
      AplicarValorAoPainelLaboratorio(flexLabIrmaoA, LPropriedade,
        LIndice, LNumero, cbLabValor.Text);
      AplicarValorAoPainelLaboratorio(flexLabIrmaoB, LPropriedade,
        LIndice, LNumero, cbLabValor.Text);
    end
    else
      AplicarValorAoPainelLaboratorio(PainelAlvoLaboratorio, LPropriedade,
        LIndice, LNumero, cbLabValor.Text);
  end;

  LAlteracao := cbLabPropriedade.Text + ' = ' + cbLabValor.Text;
  if LPropriedade >= 14 then
    LAlteracao := cbLabAlvo.Text + ': ' + LAlteracao;
  AtualizarResumoLaboratorio(LAlteracao);
end;

function TFrFlexPanel.ResumoItemLaboratorio(const ANome: string;
  APainel: TUniDSAFlexPanel): string;
begin
  Result := Format(
    '%s: Grow=%d | Shrink=%d | Basis=%s | Order=%d | AlignSelf=%s | XS=%d | SM=%d | MD=%d | LG=%d | XL=%d | XXL=%d', [
    ANome, APainel.FlexItem.Grow, APainel.FlexItem.Shrink,
    APainel.FlexItem.Basis, APainel.FlexItem.Order,
    GetEnumName(TypeInfo(TUniDSAFlexAlignSelf), Ord(APainel.FlexItem.AlignSelf)),
    APainel.Responsive.XS.Span, APainel.Responsive.SM.Span,
    APainel.Responsive.MD.Span, APainel.Responsive.LG.Span,
    APainel.Responsive.XL.Span, APainel.Responsive.XXL.Span]);
end;

procedure TFrFlexPanel.AtualizarResumoLaboratorio(const AAlteracao: string);
begin
  memLabResumo.Lines.Text :=
    'Alteracao: ' + AAlteracao + sLineBreak +
    Format('PAI Flex: Direction=%s | Wrap=%s | JustifyContent=%s | AlignItems=%s | AlignContent=%s', [
      GetEnumName(TypeInfo(TUniDSAFlexDirection), Ord(flexLabPai.Flex.Direction)),
      GetEnumName(TypeInfo(TUniDSAFlexWrap), Ord(flexLabPai.Flex.Wrap)),
      GetEnumName(TypeInfo(TUniDSAFlexJustify), Ord(flexLabPai.Flex.JustifyContent)),
      GetEnumName(TypeInfo(TUniDSAFlexAlign), Ord(flexLabPai.Flex.AlignItems)),
      GetEnumName(TypeInfo(TUniDSAFlexAlign), Ord(flexLabPai.Flex.AlignContent))]) + sLineBreak +
    Format('PAI Espacos: Gap=%d | RowGap=%d | ColumnGap=%d | Padding=%d | Columns=%d | DefaultSpan=%d | Overflow=%s | AutoHeight=%s | AutoWidth=%s', [
      flexLabPai.Flex.Gap, flexLabPai.Flex.RowGap, flexLabPai.Flex.ColumnGap,
      flexLabPai.Flex.Padding, flexLabPai.Flex.Columns, flexLabPai.Flex.DefaultSpan,
      GetEnumName(TypeInfo(TUniDSAFlexOverflow), Ord(flexLabPai.Flex.Overflow)),
      BoolToStr(flexLabPai.Flex.AutoHeight, True),
      BoolToStr(flexLabPai.Flex.AutoWidth, True)]) + sLineBreak +
    ResumoItemLaboratorio('FILHO SELECIONADO', flexLabFilho) + sLineBreak +
    ResumoItemLaboratorio('IRMAO A', flexLabIrmaoA) + sLineBreak +
    ResumoItemLaboratorio('IRMAO B', flexLabIrmaoB);
end;

procedure TFrFlexPanel.RestaurarItemLaboratorio(APainel: TUniDSAFlexPanel);
begin
  APainel.FlexItem.Grow := 0;
  APainel.FlexItem.Shrink := 1;
  APainel.FlexItem.Basis := 'auto';
  APainel.FlexItem.Order := 0;
  APainel.FlexItem.AlignSelf := fasAuto;
  APainel.Responsive.XS.Span := 12;
  APainel.Responsive.SM.Span := 0;
  APainel.Responsive.MD.Span := 4;
  APainel.Responsive.LG.Span := 0;
  APainel.Responsive.XL.Span := 0;
  APainel.Responsive.XXL.Span := 0;
end;

procedure TFrFlexPanel.RestaurarLaboratorio;
begin
  flexLabPai.Flex.Direction := fdRow;
  flexLabPai.Flex.Wrap := fwWrap;
  flexLabPai.Flex.JustifyContent := fjStart;
  flexLabPai.Flex.AlignItems := faStretch;
  flexLabPai.Flex.AlignContent := faStretch;
  flexLabPai.Flex.Gap := 12;
  flexLabPai.Flex.RowGap := -1;
  flexLabPai.Flex.ColumnGap := -1;
  flexLabPai.Flex.Padding := 16;
  flexLabPai.Flex.Columns := 12;
  flexLabPai.Flex.DefaultSpan := 0;
  flexLabPai.Flex.Overflow := foVisible;
  flexLabPai.Flex.AutoHeight := False;
  flexLabPai.Flex.AutoWidth := False;

  RestaurarItemLaboratorio(flexLabFilho);
  RestaurarItemLaboratorio(flexLabIrmaoA);
  RestaurarItemLaboratorio(flexLabIrmaoB);

  cbLabPropriedade.ItemIndex := 0;
  cbLabAlvo.ItemIndex := 3;
  CarregarValoresLaboratorio;
  AtualizarResumoLaboratorio('valores restaurados');
end;

procedure TFrFlexPanel.UniFrameCreate(Sender: TObject);
begin
  cbLabPropriedade.ItemIndex := 0;
  cbLabAlvo.ItemIndex := 3;
  CarregarValoresLaboratorio;
  AtualizarResumoLaboratorio('estado inicial');
end;

procedure TFrFlexPanel.cbLabPropriedadeChange(Sender: TObject);
begin
  CarregarValoresLaboratorio;
end;

procedure TFrFlexPanel.cbLabAlvoChange(Sender: TObject);
begin
  CarregarValoresLaboratorio;
  AtualizarResumoLaboratorio('alvo selecionado: ' + cbLabAlvo.Text);
end;

procedure TFrFlexPanel.cbLabValorChange(Sender: TObject);
begin
  AplicarValorLaboratorio;
end;

procedure TFrFlexPanel.btnLabRestaurarClick(Sender: TObject);
begin
  ConfirmarRestauracao.Clear;
  ConfirmarRestauracao.ClearEvents;
  ConfirmarRestauracao.Title := 'Restaurar propriedades';
  ConfirmarRestauracao.Content :=
    'As propriedades do painel pai e de todos os filhos voltarao aos ' +
    'valores iniciais. Deseja continuar?';
  ConfirmarRestauracao.BoxWidth := '420px';
  ConfirmarRestauracao.Draggable := False;
  ConfirmarRestauracao.&Type := Orange;

  with ConfirmarRestauracao.Buttons.AddItem do begin
    Text := 'Restaurar';
    BtnClass := 'btn-red';
    OnClickRef :=
      procedure(Sender: TObject)
      begin
        RestaurarLaboratorio;
      end;
  end;

  with ConfirmarRestauracao.Buttons.AddItem do begin
    Text := 'Cancelar';
    BtnClass := 'btn-blue';
  end;

  ConfirmarRestauracao.Show;
end;

procedure TFrFlexPanel.btnSalvarCadastroClick(Sender: TObject);
begin
  if Trim(edtCadastroNome.Text) = '' then begin
    lblCadastroStatus.Caption := 'Informe o nome antes de salvar.';
    edtCadastroNome.SetFocus;
    Exit;
  end;

  lblCadastroStatus.Caption := Format(
    'Cadastro de %s salvo dentro da grade Flex.',
    [Trim(edtCadastroNome.Text)]
  );
end;

procedure TFrFlexPanel.btnAvancarProgressoClick(Sender: TObject);
begin
  if prgResumo.Position >= 100 then
    prgResumo.Position := 0
  else
    prgResumo.Position := prgResumo.Position + 10;

  lblResumoTexto.Caption := Format(
    'Progresso atual: %d%%. Redimensione a janela para testar a grade.',
    [prgResumo.Position]
  );
end;

procedure TFrFlexPanel.btnPesquisarClick(Sender: TObject);
begin
  prgPesquisa.Position := 100;
  lblPesquisaStatus.Caption := Format(
    'Pesquisa executada: "%s".',
    [Trim(edtPesquisa.Text)]
  );
end;

procedure TFrFlexPanel.btnLimparFiltrosClick(Sender: TObject);
begin
  edtPesquisa.Clear;
  cbCategoria.ItemIndex := -1;
  chkSomenteAtivos.Checked := False;
  prgPesquisa.Position := 0;
  lblPesquisaStatus.Caption := 'Filtros limpos. Os controles continuam no fluxo Flex.';
end;

procedure TFrFlexPanel.btnAtualizarDashboardClick(Sender: TObject);
begin
  lblVendasValor.Caption := 'R$ 48.920';
  lblPedidosValor.Caption := '186';
  lblClientesValor.Caption := '72';
  memDetalhes.Lines.Text :=
    'Dashboard atualizado em ' + FormatDateTime('hh:nn:ss', Now) + sLineBreak +
    'Os FlexPanels internos preservaram o layout responsivo.';
end;

procedure TFrFlexPanel.btnAlternarDirecaoClick(Sender: TObject);
begin
  if flexAlinhamentoExemplo.Flex.Direction = fdRow then begin
    flexAlinhamentoExemplo.Flex.Direction := fdColumn;
    btnAlternarDirecao.Caption := 'Usar direcao em linha';
  end
  else begin
    flexAlinhamentoExemplo.Flex.Direction := fdRow;
    btnAlternarDirecao.Caption := 'Usar direcao em coluna';
  end;
end;

procedure TFrFlexPanel.btnAlternarJustificacaoClick(Sender: TObject);
begin
  if flexAlinhamentoExemplo.Flex.JustifyContent = fjSpaceBetween then begin
    flexAlinhamentoExemplo.Flex.JustifyContent := fjCenter;
    btnAlternarJustificacao.Caption := 'Distribuir espaco';
  end
  else begin
    flexAlinhamentoExemplo.Flex.JustifyContent := fjSpaceBetween;
    btnAlternarJustificacao.Caption := 'Centralizar itens';
  end;
end;

end.
