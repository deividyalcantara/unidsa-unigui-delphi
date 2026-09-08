unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, uniGUIFrame,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, FormContribuicoes,
  uniGUIClasses, uniGUIForm, UniDSAMenuLateral, uniGUIBaseClasses, UniDSABaseControl,
  UniDSABase, UniDSAConfirm, FrameToast, FrameLeitorQRCode,
  UniDSAToast, FrameHome, FrameMenuLateral, uniPanel, uniGUIRegClasses,
  FrameConfirm, FrameKanban, FrameFlexPanel, UniDSAExecuteFunction,
  UniDSAFlexPanel, DemoUI, uniPageControl;

type
  TMainForm = class(TUniForm)
    mlMenu: TUniDSAMenuLateral;
    Toast: TUniDSAToast;
    Confirm: TUniDSAConfirm;
    flexShell: TUniDSAFlexPanel;
    flexContent: TUniDSAFlexPanel;
    procedure mlMenuClickLogo(Sender: TObject);
    procedure mlMenuClickLogoff(Sender: TObject);
    procedure UniFormAfterShow(Sender: TObject);
    procedure ToastAfterHidden(Sender: TObject);
    procedure mlMenuMenu1ClickNotification(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure mlMenuMenu1Click(Sender: TObject);
    procedure mlMenuMenu0Click(Sender: TObject);
    procedure mlMenuSearchEnter(Text: string);
    procedure mlMenuMenu6Click(Sender: TObject);
    procedure mlMenuMenu2Click(Sender: TObject);
    procedure mlMenuMenu4Click(Sender: TObject);
    procedure mlMenuMenu3Click(Sender: TObject);
    procedure mlMenuKanbanClick(Sender: TObject);
    procedure mlMenuFlexClick(Sender: TObject);
    procedure UniFormScreenResize(Sender: TObject; AWidth, AHeight: Integer);
  private
    FFrame: TUniFrame;
    FCompact: Boolean;

    procedure ConfigurarMenuComponentes;
    procedure MostrarMenu(ATipoFrame: TUniFrameClass);
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

{ TMainForm }

procedure TMainForm.mlMenuClickLogoff(Sender: TObject);
begin
  Confirm.Clear;
  Confirm.ClearEvents;
  Confirm.Title := 'Logoff';
  Confirm.Content := '<span style=''font-size:14px;''>Deseja sair do sistema?</span>';
  Confirm.BoxWidth := 'min(480px, calc(100vw - 32px))';

  with Confirm.Buttons.AddItem do begin
    Text := 'Sim';
    BtnClass := 'btn-red';
    OnClickRef :=
      procedure (Sender: TObject)
      begin
        UniApplication.Terminate('O usuário realizou o logoff do sistema: ' + TUniDSAConfirmButtonItem(Sender).Text + '');
      end;
  end;

  with Confirm.Buttons.AddItem do begin
    Text := 'Não';
    BtnClass := 'btn-blue';
  end;

  Confirm.Show;
end;

procedure TMainForm.mlMenuMenu0Click(Sender: TObject);
begin
  MostrarMenu(TFrHome);
end;

procedure TMainForm.mlMenuMenu1Click(Sender: TObject);
begin
  MostrarMenu(TFrMenuLateral);
end;

procedure TMainForm.mlMenuMenu1ClickNotification(Sender: TObject);
var
  LMenuItem: TUniDSAMenuLateralMenuItem;
begin
  LMenuItem := TUniDSAMenuLateralMenuItem(Sender);

  if LMenuItem.NotificationCount > 0 then begin
    Confirm.Clear;
    Confirm.ClearEvents;

    Confirm.Title := 'Menu Lateral';
    Confirm.BoxWidth := 'min(480px, calc(100vw - 32px))';
    Confirm.Draggable := False;
    Confirm.&Type := Green;
    Confirm.Icon := LMenuItem.Icon;
    Confirm.Content :=
      '<span style=''font-size: 13px;''>' +
      '  O componente <b>Menu Lateral</b> foi adicionado a paleta do UniDSA.<p> '  +
      '  <b>Contribua</b> com o projeto para continuarmos criando novos componentes.<p> ' +
      '  Deseja contribuir com o <span style=''color: #2ecc71; font-weight: bold;''>PROJETO</span>?' +
      '</span>';
    Confirm.Theme := Supervan;

    with Confirm.Buttons.AddItem do begin
      Text := 'Sim';
      BtnClass := 'btn-green';
      OnClickRef :=
        procedure (Sender: TObject)
        begin
          LMenuItem.ClearNotification;
          FormContribuicoes.Contribuir;
        end;
    end;

    with Confirm.Buttons.AddItem do begin
      Text := 'Não';
      BtnClass := 'btn-red';
      OnClickRef :=
        procedure (Sender: TObject)
        begin
          LMenuItem.ClearNotification;
          mlMenu.Menu.IndexOf('Apoie o projeto').IncNotification;
        end;
    end;

    Confirm.Show;
  end;
end;

procedure TMainForm.mlMenuMenu2Click(Sender: TObject);
begin
  MostrarMenu(TFrToast);
end;

procedure TMainForm.mlMenuMenu3Click(Sender: TObject);
begin
  MostrarMenu(TFrConfirm);
end;

procedure TMainForm.mlMenuMenu4Click(Sender: TObject);
begin
  MostrarMenu(TFrLeitorQrCode);
end;

procedure TMainForm.mlMenuKanbanClick(Sender: TObject);
begin
  MostrarMenu(TFrKanban);
end;

procedure TMainForm.mlMenuFlexClick(Sender: TObject);
begin
  MostrarMenu(TFrFlexPanel);
end;

procedure TMainForm.mlMenuMenu6Click(Sender: TObject);
begin
  FormContribuicoes.Contribuir;
end;

procedure TMainForm.mlMenuSearchEnter(Text: string);
begin
  if FFrame is TFrMenuLateral then begin
    TFrMenuLateral(FFrame).edtMenuValorPesquisado.Text := Text;
  end;
end;

procedure TMainForm.MostrarMenu(ATipoFrame: TUniFrameClass);
var
  LPage: TUniDSAFlexPanel;
  LTabs: TUniTabSheet;
begin
  FreeAndNil(FFrame);

  FFrame := TUniFrameClass(ATipoFrame).Create(Self);
  FFrame.Parent := flexContent;
  FFrame.ParentAlignmentControl := False;
  FFrame.AlignmentControl := uniAlignmentClient;
  FFrame.Layout := 'fit';
  FFrame.Align := TAlign.alClient;
  with flexContent.FlexItems.Add do begin
    Control := FFrame.FormRegion;
    Grow := 1;
    Basis := '0px';
  end;
  DemoPrepare(FFrame);

  if FFrame is TFrToast then begin
    with TFrToast(FFrame) do begin
      UniLabel3.Caption := 'Configure a notificação abaixo e use Mostrar para testar.';
      DemoProperties(FFrame, flexDemoPage, Toast, 'Comportamento da notificação',
        ['Icon', 'Position.Position', 'ShowHideTransition', 'HideAfter',
         'AllowToastClose', 'Stack.Enabled', 'Stack.Value', 'TextAlign',
         'Loader.Enabled', 'Loader.Background', 'BgColor.Enabled', 'BgColor.Color',
         'TextColor.Enabled', 'TextColor.Color']);
    end;
  end
  else if FFrame is TFrConfirm then begin
    with TFrConfirm(FFrame) do begin
      UniLabel3.Caption := 'Aplique as propriedades e abra o diálogo para comparar o resultado.';
      Confirm.BoxWidth := 'min(480px, calc(100vw - 32px))';
      DemoProperties(FFrame, flexDemoPage, Confirm, 'Aparência e interação do diálogo',
        ['Theme', 'Type', 'Icon', 'Draggable', 'Close.CloseIcon', 'EscapeKey',
         'Dismiss.BackgroundDismiss', 'Animation.Enabled', 'Animation.Animation',
         'Animation.AnimationSpeed', 'TypeAnimated']);
    end;
  end
  else if FFrame is TFrMenuLateral then begin
    with TFrMenuLateral(FFrame) do
      DemoProperties(FFrame, flexDemoPage, mlMenu, 'Propriedades adicionais do menu',
        ['SelectedTheme', 'Style.PaddingTop', 'Style.PaddingLeft',
         'Style.PaddingRight', 'Style.PaddingBottom', 'Logo.Visible',
         'Search.Visible', 'Profile.Visible', 'Theme.Visible']);
  end
  else if FFrame is TFrKanban then begin
    with TFrKanban(FFrame) do begin
      Kanban.Height := 560;
      DemoProperties(FFrame, flexDemoPage, Kanban, 'Comportamento do quadro',
        ['ReadOnly', 'EmptyText', 'WIPLimitMessage', 'MoveDeniedMessage']);
      DemoProperties(FFrame, flexDemoPage, Kanban.Columns[1], 'Coluna em andamento',
        ['Caption', 'Description', 'WIPLimit', 'AllowDrop', 'AccentColor']);
    end;
  end
  else if FFrame is TFrLeitorQrCode then begin
    with TFrLeitorQrCode(FFrame) do begin
      qrcLeitor.Height := 380;
      DemoProperties(FFrame, flexDemoPage, qrcLeitor, 'Opções da próxima leitura única',
        ['FPS', 'QrBox']);
      DemoText(FFrame, flexDemoPage,
        'A câmera depende da permissão do navegador. Use localhost ou HTTPS. ' +
        'A leitura única abre uma janela adaptável.', 'demo-muted');
    end;
  end
  else if FFrame is TFrHome then begin
    with TFrHome(FFrame) do begin
      UniLabel1.Caption := 'Explore o UniDSA';
      UniLabel2.Caption := 'Componentes nativos, layouts flexíveis e exemplos prontos para experimentar.';
      LPage := DemoPanel(FFrame, flexDemoPage, 'demo-card');
      LPage.Flex.Padding := 24;
      DemoText(FFrame, LPage, 'Um laboratório para cada componente', 'demo-section-title');
      DemoText(FFrame, LPage, 'Escolha um componente no menu. Edite propriedades, ' +
        'aplique os valores e veja o comportamento real sem sair da página.', 'demo-muted');
      DemoText(FFrame, LPage, 'Layout responsivo', 'demo-section-title');
      DemoText(FFrame, LPage, 'Os campos se reorganizam conforme o espaço do painel. ' +
        'Em telas pequenas, o menu recolhe e as seções passam para uma coluna.', 'demo-muted');
      DemoText(FFrame, LPage, 'Navegação acessível', 'demo-section-title');
      DemoText(FFrame, LPage, 'Use Tab para percorrer os controles. As ações mantêm ' +
        'indicação de foco e os valores aplicados recebem uma confirmação na tela.', 'demo-muted');
    end;
  end
  else if FFrame is TFrFlexPanel then begin
    with TFrFlexPanel(FFrame) do begin
      flexLabComandos.Flex.AutoHeight := True;
      flexAlinhamentoComandos.Flex.AutoHeight := True;
      for LPage in TArray<TUniDSAFlexPanel>.Create(flexCadastro, flexEndereco,
        flexResumo, flexMetricaVendas, flexMetricaPedidos, flexMetricaClientes,
        flexDashboardDetalhes) do begin
        DemoClass(LPage, 'demo-card');
        LPage.Flex.AutoHeight := True;
        LPage.FlexItem.Shrink := 0;
      end;
      LTabs := TUniTabSheet.Create(FFrame);
      LTabs.PageControl := pcExemplos;
      LTabs.Caption := 'Personalizar abas';
      LTabs.ParentAlignmentControl := False;
      LTabs.AlignmentControl := uniAlignmentClient;
      LTabs.Layout := 'fit';
      LPage := DemoPanel(FFrame, LTabs, 'demo-page');
      LPage.Align := alClient;
      LPage.Flex.AutoHeight := False;
      LPage.Flex.Overflow := foAuto;
      LPage.Flex.Padding := 16;
      DemoProperties(FFrame, LPage, pcExemplos, 'Navegação e cores das abas',
        ['TabAlignment', 'KeepActiveTabVisible', 'TabColors.BackgroundColor',
         'TabColors.TextColor', 'TabColors.HoverColor', 'TabColors.HoverTextColor',
         'TabColors.ActiveColor', 'TabColors.ActiveTextColor',
         'TabColors.ActiveHoverColor', 'TabColors.FocusColor', 'TabColors.MenuColor']);
    end;
  end;
  if FCompact and (mlMenu.MenuState <> mlmMinimize) then
    mlMenu.MenuState := mlmMinimize;
end;

procedure TMainForm.ToastAfterHidden(Sender: TObject);
var
  LItem: TUniDSAMenuLateralMenuItem;
begin
  LItem := mlMenu.Menu.IndexOf('Menu Lateral');
  if Assigned(LItem) then
    LItem.IncNotification;
end;

procedure TMainForm.UniFormAfterShow(Sender: TObject);
begin
  with Toast do begin
    Toast.Clear;
    Heading := 'UniDSA - Componente';
    Text := 'O componente ''Menu Lateral'' foi adicionado a paleta UniDSA.';
    HideAfter := 2000;
    AllowToastClose := False;
    Position.Position := TUniDSAToastTypePosition.BottomRight;
    Show;
  end;
end;

procedure TMainForm.ConfigurarMenuComponentes;
var
  LGroup: TUniDSAMenuLateralMenuItem;

  procedure AddComponent(const ACaption, AIcon: string; AOnClick: TNotifyEvent);
  var
    LItem: TUniDSAMenuLateralMenuItem;
  begin
    LItem := LGroup.SubItems.AddItem;
    LItem.Caption := ACaption;
    LItem.Icon := AIcon;
    LItem.OnClick := AOnClick;
  end;
begin
  // Build here so opening the demo with an older IDE package cannot erase its navigation.
  mlMenu.Menu.BeginUpdate;
  try
    LGroup := mlMenu.Menu.IndexOf('Componentes');
    if not Assigned(LGroup) then begin
      LGroup := mlMenu.Menu.AddItem;
      LGroup.Caption := 'Componentes';
    end;
    LGroup.Icon := 'fas fa-layer-group';
    LGroup.Expanded := True;
    LGroup.SubItems.Clear;
    AddComponent('Menu Lateral', 'fas fa-bars', mlMenuMenu1Click);
    LGroup.SubItems.IndexOf('Menu Lateral').OnClickNotification := mlMenuMenu1ClickNotification;
    AddComponent('Toast', 'fas fa-bell', mlMenuMenu2Click);
    AddComponent('Confirm', 'fas fa-check-square', mlMenuMenu3Click);
    AddComponent('QrCode Reader', 'fas fa-qrcode', mlMenuMenu4Click);
    AddComponent('Kanban', 'fas fa-columns', mlMenuKanbanClick);
    AddComponent('FlexPanel', 'fas fa-th-large', mlMenuFlexClick);
  finally
    mlMenu.Menu.EndUpdate;
  end;
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  DemoClass(flexShell, 'demo-shell');
  DemoClass(flexContent, 'demo-shell demo-content');
  with flexShell.FlexItems.Add do begin
    Control := mlMenu;
    Shrink := 0;
  end;
  OnScreenResize := UniFormScreenResize;
  ConfigurarMenuComponentes;
  MostrarMenu(TFrHome);
  UniFormScreenResize(Self, UniApplication.ScreenWidth, UniApplication.ScreenHeight);
end;

procedure TMainForm.UniFormScreenResize(Sender: TObject; AWidth, AHeight: Integer);
var
  LCompact: Boolean;
begin
  if AWidth <= 0 then Exit;
  LCompact := AWidth < 900;
  if LCompact = FCompact then Exit;
  FCompact := LCompact;
  if FCompact then
    mlMenu.MenuState := mlmMinimize
  else
    mlMenu.MenuState := mlmMaximize;
end;

procedure TMainForm.mlMenuClickLogo(Sender: TObject);
begin
  mlMenu.MinimizeMaximize;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
