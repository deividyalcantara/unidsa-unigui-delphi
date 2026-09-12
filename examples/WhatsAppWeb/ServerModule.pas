unit ServerModule;

{ Configuração global do servidor uniGUI. As propriedades de porta, tema e arquivos
  adicionais permanecem no ServerModule.dfm para serem editáveis no Object Inspector. }

interface

uses
  System.Classes,
  System.SysUtils,
  uniGUIServer,
  uniGUIMainModule,
  uniGUIApplication,
  uIdCustomHTTPServer,
  uniGUITypes;

type
  TUniServerModule = class(TUniGUIServerModule)
  protected
    // Executado uma única vez, durante a inicialização do servidor.
    procedure FirstInit; override;
  end;

implementation

{$R *.dfm}

uses
  uniGUIVars;

procedure TUniServerModule.FirstInit;
begin
  // Inicializa a infraestrutura padrão do uniGUI com os valores gravados no DFM.
  InitServerModule(Self);
end;

initialization
  // Informa ao framework qual ServerModule deve ser criado pelo executável.
  RegisterServerModuleClass(TUniServerModule);

end.