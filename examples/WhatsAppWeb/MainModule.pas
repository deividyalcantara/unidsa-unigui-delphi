unit MainModule;

{ Módulo de dados criado por sessão. O exemplo não usa banco de dados, mas mantém
  esta unit para seguir a estrutura normal de uma aplicação uniGUI. }

interface

uses
  System.Classes,
  uniGUIMainModule;

type
  TUniMainModule = class(TUniGUIMainModule)
  end;

implementation

{$R *.dfm}

uses
  uniGUIVars;

initialization
  // Registra a classe que o uniGUI instancia separadamente para cada sessão.
  RegisterMainModuleClass(TUniMainModule);

end.