unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, uniGUIFrame,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, FormContribuicoes,
  uniGUIClasses, uniGUIForm, UniDSAMenuLateral, uniGUIBaseClasses, UniDSABaseControl,
  UniDSABase, UniDSAConfirm, FrameToast, FrameLeitorQRCode,
  UniDSAToast, FrameHome, FrameMenuLateral, uniPanel, uniGUIRegClasses, FrameConfirm, UniDSAExecuteFunction;

type
  TMainForm = class(TUniForm)
    mlMenu: TUniDSAMenuLateral;
    Toast: TUniDSAToast;
    Confirm: TUniDSAConfirm;
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
  private
    FFrame: TUniFrame;

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
  Confirm.BoxWidth := '30%';

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
    Confirm.BoxWidth := '30%';
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

procedure TMainForm.mlMenuMenu6Click(Sender: TObject);
begin
  FormContribuicoes.Contribuir;
end;

procedure TMainForm.mlMenuSearchEnter(Text: string);
begin
  if mlMenu.SelectedMenu = mlMenu.Menu.IndexOf('Menu Lateral') then begin
    TFrMenuLateral(FFrame).edtMenuValorPesquisado.Text := Text;
  end;
end;

procedure TMainForm.MostrarMenu(ATipoFrame: TUniFrameClass);
begin
  if Assigned(FFrame) then
    FFrame.Free;

  FFrame := TUniFrameClass(ATipoFrame).Create(Self);
  FFrame.Parent := Self;
  FFrame.Align := TAlign.alClient;
end;

procedure TMainForm.ToastAfterHidden(Sender: TObject);
begin
  mlMenu.Menu.IndexOf('Menu Lateral').IncNotification;
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

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  MostrarMenu(TFrHome);
end;

procedure TMainForm.mlMenuClickLogo(Sender: TObject);
begin
  mlMenu.MinimizeMaximize;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
