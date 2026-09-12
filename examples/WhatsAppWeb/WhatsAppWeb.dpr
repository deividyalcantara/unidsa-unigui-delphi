program WhatsAppWeb;

{ Projeto demonstrativo: toda a interface visual fica nos formulários e frames.
  O DPR apenas registra as units e inicia o servidor uniGUI. }

uses
  Vcl.Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  DadosChat in 'DadosChat.pas',
  FrameContato in 'Frames\FrameContato.pas' {FrContato: TUniFrame},
  FrameContatos in 'Frames\FrameContatos.pas' {FrContatos: TUniFrame},
  FrameMensagem in 'Frames\FrameMensagem.pas' {FrMensagem: TUniFrame},
  FrameConversa in 'Frames\FrameConversa.pas' {FrConversa: TUniFrame},
  Main in 'Main.pas' {MainForm: TUniForm};

begin
  // Cria o servidor; cada acesso ao site recebe seu próprio MainModule e MainForm.
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.