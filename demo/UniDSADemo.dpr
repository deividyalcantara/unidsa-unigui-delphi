program UniDSADemo;

uses
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  FrameMenuLateral in 'View\FrameMenuLateral.pas' {FrMenuLateral: TUniFrame},
  Funcoes in 'Library\Funcoes.pas',
  FrameHome in 'View\FrameHome.pas' {FrHome: TUniFrame},
  FormContribuicoes in 'View\FormContribuicoes.pas' {FrmContribuicoes: TUniForm},
  FrameToast in 'View\FrameToast.pas' {FrToast: TUniFrame},
  FrameLeitorQRCode in 'View\FrameLeitorQRCode.pas' {FrLeitorQrCode: TUniFrame},
  FormLeitorQrCode in 'View\FormLeitorQrCode.pas' {FrmLeitorQrCode: TUniForm},
  FrameConfirm in 'View\FrameConfirm.pas' {FrConfirm: TUniFrame},
  Login in 'Login.pas' {FormLogin: TUniLoginForm};

{$R *.res}

{$I UniDSA.inc}
{$INCLUDE UniDSA.inc}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.

