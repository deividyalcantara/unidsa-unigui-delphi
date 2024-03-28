unit FrameMenuLateral;

interface

uses
  Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrameBase, uniGUIBaseClasses, uniGUIClasses, uniLabel,
  uniButton, uniPanel, UniDSAMenuLateral, uniTimer, MainModule, System.TypInfo, Funcoes, uniGroupBox,
  uniSpinEdit, uniEdit, uniCheckBox, uniScrollBox, UniDSAConfirm;

type
  TFrMenuLateral = class(TFrBase)
    lblSubTitulo: TUniLabel;
    lblTitulo: TUniLabel;
    ucpTemaBorda: TUniContainerPanel;
    TimeTema: TUniTimer;
    ugbTema: TUniGroupBox;
    b2: TUniContainerPanel;
    edtMenuBordaTopo: TUniSpinEdit;
    UniLabel3: TUniLabel;
    b3: TUniContainerPanel;
    edtMenuBordaEsquerda: TUniSpinEdit;
    UniLabel4: TUniLabel;
    b4: TUniContainerPanel;
    edtMenuBordaDireita: TUniSpinEdit;
    UniLabel5: TUniLabel;
    b5: TUniContainerPanel;
    edtMenuBordaInferior: TUniSpinEdit;
    UniLabel6: TUniLabel;
    ucpTemaBotoes: TUniContainerPanel;
    btnVisualizarTemas: TUniButton;
    btnMenuPesquisa: TUniButton;
    btnOcultarTema: TUniButton;
    btnOcultarPerfil: TUniButton;
    ucpTemaArredondamento: TUniContainerPanel;
    c2: TUniContainerPanel;
    edtMenuArredondarTopoEsquerda: TUniSpinEdit;
    UniLabel7: TUniLabel;
    c3: TUniContainerPanel;
    edtMenuArredondarTopoDireita: TUniSpinEdit;
    UniLabel8: TUniLabel;
    c4: TUniContainerPanel;
    edtMenuArredondarInferiorEsquerda: TUniSpinEdit;
    UniLabel9: TUniLabel;
    c5: TUniContainerPanel;
    edtMenuArredondarInferiorDireita: TUniSpinEdit;
    UniLabel10: TUniLabel;
    b1: TUniContainerPanel;
    UniLabel11: TUniLabel;
    c1: TUniContainerPanel;
    UniLabel12: TUniLabel;
    UniPanel2: TUniPanel;
    UniPanel3: TUniPanel;
    ugbLogo: TUniGroupBox;
    UniContainerPanel14: TUniContainerPanel;
    f2: TUniContainerPanel;
    f3: TUniContainerPanel;
    UniLabel14: TUniLabel;
    edtMenuEmpresa: TUniEdit;
    btnMudarImagem: TUniButton;
    f1: TUniContainerPanel;
    UniLabel13: TUniLabel;
    edtMenuImagem: TUniEdit;
    f4: TUniContainerPanel;
    UniButton1: TUniButton;
    f5: TUniContainerPanel;
    edtMenuLogoRedefinir: TUniButton;
    f6: TUniPanel;
    ugbPesquisa: TUniGroupBox;
    UniContainerPanel20: TUniContainerPanel;
    e1: TUniContainerPanel;
    UniLabel16: TUniLabel;
    edtMenuValorPesquisado: TUniEdit;
    e4: TUniContainerPanel;
    ckbMenuPesquisaAutoCompletar: TUniCheckBox;
    e2: TUniContainerPanel;
    UniLabel15: TUniLabel;
    edtMenuTextPrompt: TUniEdit;
    e3: TUniContainerPanel;
    btnMenuTextPrompt: TUniButton;
    e5: TUniContainerPanel;
    btnMenuPesquisaFoco: TUniButton;
    ucpTemaDescricao: TUniContainerPanel;
    d3: TUniContainerPanel;
    btnMenuDescricaoTemaEsquerda: TUniButton;
    d4: TUniContainerPanel;
    UniLabel19: TUniLabel;
    edtMenuDescricaoTemaDireita: TUniEdit;
    d2: TUniContainerPanel;
    lblDescricaoTemaEsquerda: TUniLabel;
    edtMenuDescricaoTemaEsquerda: TUniEdit;
    d5: TUniContainerPanel;
    btnDescricaoTemaDireita: TUniButton;
    d6: TUniContainerPanel;
    btnRedefinirDescricao: TUniButton;
    d7: TUniPanel;
    UniPanel4: TUniPanel;
    d1: TUniContainerPanel;
    UniLabel17: TUniLabel;
    usbPrincipal: TUniScrollBox;
    ugbPerfil: TUniGroupBox;
    UniContainerPanel27: TUniContainerPanel;
    g2: TUniContainerPanel;
    btnMenuImagemPerfil: TUniButton;
    g3: TUniContainerPanel;
    UniLabel18: TUniLabel;
    edtMenuNomePerfil: TUniEdit;
    g1: TUniContainerPanel;
    UniLabel20: TUniLabel;
    edtMenuImagemPerfil: TUniEdit;
    g4: TUniContainerPanel;
    btnMenuNomePerfil: TUniButton;
    g5: TUniContainerPanel;
    UniLabel21: TUniLabel;
    edtMenuEmailPerfil: TUniEdit;
    g6: TUniContainerPanel;
    btnMenuEmailPerfil: TUniButton;
    ugbMenu: TUniGroupBox;
    UniContainerPanel40: TUniContainerPanel;
    btnMenuAdministrativo: TUniButton;
    btnMenuPadrao: TUniButton;
    btnTemaAnterior: TUniButton;
    btnTemaProximo: TUniButton;
    btnOcultarMenu: TUniButton;
    btnSeparador: TUniButton;
    btnNotificacoes: TUniButton;
    procedure TimeTemaTimer(Sender: TObject);
    procedure btnVisualizarTemasClick(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure edtMenuBordaTopoChange(Sender: TObject);
    procedure btnMenuPesquisaClick(Sender: TObject);
    procedure btnOcultarTemaClick(Sender: TObject);
    procedure btnOcultarPerfilClick(Sender: TObject);
    procedure edtMenuArredondarTopoEsquerdaChange(Sender: TObject);
    procedure edtMenuArredondarTopoDireitaChange(Sender: TObject);
    procedure edtMenuArredondarInferiorEsquerdaChange(Sender: TObject);
    procedure edtMenuArredondarInferiorDireitaChange(Sender: TObject);
    procedure btnMudarImagemClick(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure edtMenuLogoRedefinirClick(Sender: TObject);
    procedure btnMenuTextPromptClick(Sender: TObject);
    procedure ckbMenuPesquisaAutoCompletarClick(Sender: TObject);
    procedure btnMenuPesquisaFocoClick(Sender: TObject);
    procedure btnMenuDescricaoTemaEsquerdaClick(Sender: TObject);
    procedure btnDescricaoTemaDireitaClick(Sender: TObject);
    procedure btnRedefinirDescricaoClick(Sender: TObject);
    procedure btnMenuImagemPerfilClick(Sender: TObject);
    procedure btnMenuNomePerfilClick(Sender: TObject);
    procedure btnMenuEmailPerfilClick(Sender: TObject);
    procedure btnTemaAnteriorClick(Sender: TObject);
    procedure btnTemaProximoClick(Sender: TObject);
    procedure btnOcultarMenuClick(Sender: TObject);
    procedure btnMenuPadraoClick(Sender: TObject);
    procedure btnMenuAdministrativoClick(Sender: TObject);
    procedure btnSeparadorClick(Sender: TObject);

    procedure FrameMenuLateralOnMenuClick(Sender: TObject);
    procedure btnNotificacoesClick(Sender: TObject);
  private
    procedure ConfigurarMenus(AUsuarioAdmin: Boolean);
  end;

implementation

{$R *.dfm}

uses Main;

procedure TFrMenuLateral.edtMenuArredondarInferiorDireitaChange(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Style.BorderRadiusBottomRight := TUniSpinEdit(Sender).Value;
end;

procedure TFrMenuLateral.edtMenuArredondarInferiorEsquerdaChange(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Style.BorderRadiusBottomLeft := TUniSpinEdit(Sender).Value;
end;

procedure TFrMenuLateral.edtMenuArredondarTopoDireitaChange(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Style.BorderRadiusTopRight := TUniSpinEdit(Sender).Value;
end;

procedure TFrMenuLateral.edtMenuArredondarTopoEsquerdaChange(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Style.BorderRadiusTopLeft := TUniSpinEdit(Sender).Value;
end;

procedure TFrMenuLateral.edtMenuBordaTopoChange(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Style.BorderTop := edtMenuBordaTopo.Value;
  MainForm.mlMenu.Style.BorderLeft := edtMenuBordaEsquerda.Value;
  MainForm.mlMenu.Style.BorderRight := edtMenuBordaDireita.Value;
  MainForm.mlMenu.Style.BorderBottom := edtMenuBordaInferior.Value;  
end;

procedure TFrMenuLateral.edtMenuLogoRedefinirClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Logo.UrlImage := 'https://i.ibb.co/yhLx7mc/Logo.jpg';
  MainForm.mlMenu.Logo.CompanyName := 'UniDSA - UniGUI';
end;

procedure TFrMenuLateral.FrameMenuLateralOnMenuClick(Sender: TObject);
begin
  with MainForm.Confirm do begin
    Clear;
    ClearEvents;
    Title := 'Menu';
    Draggable := False;
    Content := '<span style=''font-size:14px;''>O Menu <b style=''color: #3498db;''>' + TUniDSAMenuLateralMenuItem(Sender).Caption + '</b> foi selecionado.</span>';
    BoxWidth := '30%';

    with Buttons.AddItem do begin
      Text := 'OK';
      BtnClass := 'btn-default';
    end;

    Show;
  end;
end;

procedure TFrMenuLateral.TimeTemaTimer(Sender: TObject);
var
  LNovoTema: TUniDSAMenuLateralStyleTheme;
begin
  inherited;
  LNovoTema := TUniDSAMenuLateralStyleTheme(Integer(MainForm.mlMenu.SelectedTheme) + 1);

  if Integer(LNovoTema) > 82  then
    LNovoTema := TUniDSAMenuLateralStyleTheme(0);

  MainForm.mlMenu.Theme.StyleLeft := LNovoTema;
  MainForm.mlMenu.SetTheme(LNovoTema);
end;

procedure TFrMenuLateral.UniButton1Click(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Logo.CompanyName := edtMenuEmpresa.Text;
end;

procedure TFrMenuLateral.btnMenuAdministrativoClick(Sender: TObject);
begin
  inherited;
  ConfigurarMenus(True);
end;

procedure TFrMenuLateral.UniFrameCreate(Sender: TObject);
begin
  inherited;
  edtMenuBordaTopo.Value := MainForm.mlMenu.Style.BorderTop;
  edtMenuBordaEsquerda.Value := MainForm.mlMenu.Style.BorderLeft;
  edtMenuBordaDireita.Value := MainForm.mlMenu.Style.BorderRight;
  edtMenuBordaInferior.Value := MainForm.mlMenu.Style.BorderBottom;

  edtMenuArredondarTopoEsquerda.Value := MainForm.mlMenu.Style.BorderRadiusTopLeft;
  edtMenuArredondarTopoDireita.Value := MainForm.mlMenu.Style.BorderRadiusTopRight;
  edtMenuArredondarInferiorEsquerda.Value := MainForm.mlMenu.Style.BorderRadiusBottomLeft;
  edtMenuArredondarInferiorDireita.Value := MainForm.mlMenu.Style.BorderRadiusBottomRight;

  ckbMenuPesquisaAutoCompletar.Checked := MainForm.mlMenu.Search.AutoComplete;
  edtMenuTextPrompt.Text := MainForm.mlMenu.Search.TextPrompt;

  edtMenuDescricaoTemaEsquerda.Text := MainForm.mlMenu.Theme.TitleLeft;
  edtMenuDescricaoTemaDireita.Text := MainForm.mlMenu.Theme.TitleRight;

  edtMenuImagemPerfil.Text := MainForm.mlMenu.Profile.ImageURL;
  edtMenuNomePerfil.Text := MainForm.mlMenu.Profile.Name;
  edtMenuEmailPerfil.Text := MainForm.mlMenu.Profile.Email
end;

procedure TFrMenuLateral.btnDescricaoTemaDireitaClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Theme.TitleRight := edtMenuDescricaoTemaDireita.Text;
end;

procedure TFrMenuLateral.btnMenuDescricaoTemaEsquerdaClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Theme.TitleLeft := edtMenuDescricaoTemaEsquerda.Text;
end;

procedure TFrMenuLateral.btnMenuEmailPerfilClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Profile.Email := edtMenuEmailPerfil.Text;
end;

procedure TFrMenuLateral.btnMenuImagemPerfilClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Profile.ImageURL := edtMenuImagemPerfil.Text;
end;

procedure TFrMenuLateral.btnMenuNomePerfilClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Profile.Name := edtMenuNomePerfil.Text;
end;

procedure TFrMenuLateral.btnMenuPadraoClick(Sender: TObject);
begin
  inherited;
  ConfigurarMenus(False);
end;

procedure TFrMenuLateral.btnMenuPesquisaClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Search.Visible := not MainForm.mlMenu.Search.Visible;
  TFuncoes.AlternarLegendaBotao(btnMenuPesquisa, 'Ocultar Pesquisa...', 'Habilitar Pesquisa...');   
end;

procedure TFrMenuLateral.btnMenuPesquisaFocoClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Search.SetFocus;
end;

procedure TFrMenuLateral.btnMenuTextPromptClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Search.TextPrompt := edtMenuTextPrompt.Text;
end;

procedure TFrMenuLateral.btnMudarImagemClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Logo.UrlImage := edtMenuImagem.Text;
end;

procedure TFrMenuLateral.btnNotificacoesClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Menu.IndexOf('Gestão de Vendas').IncNotification
end;

procedure TFrMenuLateral.btnOcultarMenuClick(Sender: TObject);
begin
  inherited;
  TFuncoes.AlternarLegendaBotao(btnOcultarMenu, 'Ocultar Menu', 'Mostrar Menu');
  MainForm.mlMenu.Visible := not MainForm.mlMenu.Visible; // mlMenu.HideMenu  | mlMenu.ShowMenu
end;

procedure TFrMenuLateral.btnOcultarPerfilClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Profile.Visible := not MainForm.mlMenu.Profile.Visible;
  TFuncoes.AlternarLegendaBotao(btnOcultarPerfil, 'Ocultar Perfil', 'Habilitar Perfil');
end;

procedure TFrMenuLateral.btnOcultarTemaClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Theme.Visible := not MainForm.mlMenu.Theme.Visible;
  TFuncoes.AlternarLegendaBotao(btnOcultarTema, 'Ocultar escolha tema', 'Habilitar escolha tema');   
end;

procedure TFrMenuLateral.btnRedefinirDescricaoClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Theme.TitleLeft := 'Claro';
  MainForm.mlMenu.Theme.TitleRight := 'Escuro';
end;

procedure TFrMenuLateral.btnSeparadorClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Menu.AddItem.Separator := True;
end;

procedure TFrMenuLateral.btnTemaAnteriorClick(Sender: TObject);
var
  LNovoTema: TUniDSAMenuLateralStyleTheme;
begin
  inherited;
  btnVisualizarTemas.Caption := 'Iniciar visualização';
  TimeTema.Enabled := False;

  LNovoTema := TUniDSAMenuLateralStyleTheme(Integer(MainForm.mlMenu.SelectedTheme) - 1);

  if Integer(LNovoTema) < 0  then
    LNovoTema := TUniDSAMenuLateralStyleTheme(0);

  MainForm.mlMenu.Theme.StyleLeft := LNovoTema;
  MainForm.mlMenu.SetTheme(LNovoTema);
end;

procedure TFrMenuLateral.btnTemaProximoClick(Sender: TObject);
var
  LNovoTema: TUniDSAMenuLateralStyleTheme;
begin
  inherited;
  btnVisualizarTemas.Caption := 'Iniciar visualização';
  TimeTema.Enabled := False;

  LNovoTema := TUniDSAMenuLateralStyleTheme(Integer(MainForm.mlMenu.SelectedTheme) + 1);

  if Integer(LNovoTema) > 82  then
    LNovoTema := TUniDSAMenuLateralStyleTheme(0);

  MainForm.mlMenu.Theme.StyleLeft := LNovoTema;
  MainForm.mlMenu.SetTheme(LNovoTema);
end;

procedure TFrMenuLateral.btnVisualizarTemasClick(Sender: TObject);
begin
  inherited;
  TimeTema.Enabled := not TimeTema.Enabled;
  TFuncoes.AlternarLegendaBotao(btnVisualizarTemas, 'Iniciar visualização', 'Parar visualização'); 
end;

procedure TFrMenuLateral.ckbMenuPesquisaAutoCompletarClick(Sender: TObject);
begin
  inherited;
  MainForm.mlMenu.Search.AutoComplete := ckbMenuPesquisaAutoCompletar.Checked;
end;

procedure TFrMenuLateral.ConfigurarMenus(AUsuarioAdmin: Boolean);
begin
  btnNotificacoes.Enabled := True;

  MainForm.mlMenu.Menu.Clear;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Gestão de Vendas';
    Icon := 'fas fa-shopping-cart';
    Hint := 'Menu para ' + Caption;
    NotificationCount := 0;
    Visible := True;
    Enabled := True;
    Separator := False;
    Hidden := False;
    OnClickRef := procedure (Sender: TObject)
    begin
      with MainForm.Confirm do begin
        Clear;
        ClearEvents;
        Theme := Bootstrap;
        Title := 'Menu';
        Draggable := False;
        Content := '<span style=''font-size:14px;''>O Menu <b style=''color: #3498db;''>' + TUniDSAMenuLateralMenuItem(Sender).Caption + '</b> foi selecionado.</span>';
        BoxWidth := '30%';

        with Buttons.AddItem do begin
          Text := 'OK';
          BtnClass := 'btn-default';
        end;

        Show;
      end;
    end;
    OnClickNotificationRef := procedure (Sender: TObject)
    begin
      ClearNotification;

      with MainForm.Confirm do begin
        Clear;
        ClearEvents;
        Theme := Bootstrap;
        Title := Caption;
        Draggable := False;
        Content := '<span style=''font-size:14px;''>Notificações lidas.</span>';
        BoxWidth := '30%';

        with Buttons.AddItem do begin
          Text := 'OK';
          BtnClass := 'btn-default';
        end;

        Show;
      end;
    end;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Pedidos de Vendas';
    Icon := 'fas fa-clipboard-list';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Orçamentos';
    Icon := 'fas fa-file-invoice-dollar';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Faturamento e Cobrança';
    Icon := 'fas fa-file-invoice';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Cadastro de Produtos';
    Icon := 'fas fa-cube';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Controle de Estoque';
    Icon := 'fas fa-boxes';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Preços e Promoções';
    Icon := 'fas fa-tags';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Cadastro de Clientes';
    Icon := 'fas fa-user';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Histórico de Compras';
    Icon := 'fas fa-history';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Gerenciamento de Contas';
    Icon := 'fas fa-briefcase';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Compras';
    Icon := 'fas fa-shopping-bag';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Pedidos de Compra';
    Icon := 'fas fa-shopping-bag';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Fornecedores';
    Icon := 'fas fa-truck';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Controle de Recebimento de Mercadorias';
    Icon := 'fas fa-clipboard-check';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Recursos Humanos';
    Icon := 'fas fa-users';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Cadastro de Funcionários';
    Icon := 'fas fa-users';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Folha de Pagamento';
    Icon := 'fas fa-money-check';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Gerenciamento de Ponto';
    Icon := 'fas fa-clock';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Contabilidade e Finanças';
    Icon := 'fas fa-money-bill-wave';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Contas a Pagar';
    Icon := 'fas fa-file-invoice-dollar';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Contas a Receber';
    Icon := 'fas fa-file-invoice';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Balanço Patrimonial';
    Icon := 'fas fa-balance-scale';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Gestão de Estoques';
    Icon := 'fas fa-archive';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Movimentação de Estoque';
    Icon := 'fas fa-exchange-alt';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Controle de Lotes';
    Icon := 'fas fa-cubes';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Reabastecimento';
    Icon := 'fas fa-retweet';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Produção';
    Icon := 'fas fa-industry';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Ordens de Produção';
    Icon := 'fas fa-industry';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Controle de Processos';
    Icon := 'fas fa-cogs';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Controle de Qualidade';
    Icon := 'fas fa-check-circle';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Logística e Transporte';
    Icon := 'fas fa-truck';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Rastreamento de Cargas';
    Icon := 'fas fa-map-marked-alt';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Gerenciamento de Rotas';
    Icon := 'fas fa-route';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Controle de Entregas';
    Icon := 'fas fa-truck';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Separator := True;
  end;

  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Relatórios e Análises';
    Icon := 'fas fa-chart-bar';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Relatórios de Desempenho';
    Icon := 'fas fa-chart-bar';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Análise de Vendas';
    Icon := 'fas fa-chart-line';
    OnClick := FrameMenuLateralOnMenuClick;
  end;
  with MainForm.mlMenu.Menu.AddItem do begin
    Caption := 'Análise Financeira';
    Icon := 'fas fa-chart-pie';
    OnClick := FrameMenuLateralOnMenuClick;
  end;

  if AUsuarioAdmin then begin
    with MainForm.mlMenu.Menu.AddItem do begin
      Separator := True;
    end;

    with MainForm.mlMenu.Menu.AddItem do begin
      Caption := 'Configurações e Administração';
      Icon := 'fas fa-cog';
      OnClick := FrameMenuLateralOnMenuClick;
    end;
    with MainForm.mlMenu.Menu.AddItem do begin
      Caption := 'Configurações do Sistema';
      Icon := 'fas fa-cog';
      OnClick := FrameMenuLateralOnMenuClick;
    end;
    with MainForm.mlMenu.Menu.AddItem do begin
      Caption := 'Gerenciamento de Usuários';
      Icon := 'fas fa-users-cog';
      OnClick := FrameMenuLateralOnMenuClick;
    end;
    with MainForm.mlMenu.Menu.AddItem do begin
      Caption := 'Configurações de Segurança';
      Icon := 'fas fa-lock';
      OnClick := FrameMenuLateralOnMenuClick;
    end;
  end;
end;

end.
