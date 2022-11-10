unit UniDSAJQuery;

interface

uses
  JSON, uniGUIApplication, UniDSALibrary, System.SysUtils;

type
  TJQuery = class
  private
    FFuncao: string;
    FComando: string;
    FVariavel: string;

  public
    constructor Create(funcao: string);
    destructor Destroy; override;

    procedure SetVariavel(value: string);
    function GetVariavel: string;

    procedure FunctionName(name: string);
    procedure Add(par: string; valor: string; condicao: Boolean = True; aspas: Boolean = True; aspas_duplas: Boolean = True); overload;
    procedure Add(par: string; valor: Integer; condicao: Boolean = True; aspas: Boolean = False; aspas_duplas: Boolean = True); overload;
    procedure Add(par: string; valor: Boolean; condicao: Boolean = True; aspas: Boolean = False; aspas_duplas: Boolean = True); overload;

    procedure Execute;
    function JQuery: string;
    procedure Clear;

  end;

implementation

{ TJQuery }

procedure TJQuery.Add(par: string; valor: string; condicao: Boolean = True; aspas: Boolean = True; aspas_duplas: Boolean = True);
begin
  if not condicao then
    Exit;

  FComando := FComando + IIfStr(FComando <> '', ', ', ' ') + par + ': ';

  if aspas then begin
    if aspas_duplas then
      FComando := FComando + '"' + valor + '"'
    else
      FComando := FComando + QuotedStr(valor);
  end
  else
    FComando := FComando + valor;
end;

procedure TJQuery.Add(par: string; valor: Boolean; condicao: Boolean = True; aspas: Boolean = False; aspas_duplas: Boolean = True);
begin
  Add(par, IIfStr(valor, 'true', 'false'), condicao, aspas, aspas_duplas);
end;

procedure TJQuery.Add(par: string; valor: Integer; condicao: Boolean = True; aspas: Boolean = False; aspas_duplas: Boolean = True);
begin
  Add(par, IntToStr(valor), condicao, aspas, aspas_duplas);
end;

procedure TJQuery.Clear;
begin
  FComando := '';
  FVariavel := '';
end;

constructor TJQuery.Create(funcao: string);
begin
  FFuncao := funcao;
  FComando := '';
end;

destructor TJQuery.Destroy;
begin
end;

procedure TJQuery.Execute;
begin
  UniSession.AddJS(JQuery);
end;

procedure TJQuery.FunctionName(name: string);
begin
  FFuncao := name;
end;

function TJQuery.GetVariavel: string;
begin
  Result := FVariavel;
end;

function TJQuery.JQuery: string;
begin
  Result :=
    IIfStr(FVariavel <> '', 'var ' + FVariavel + ' = ', '') +
    '$.' + FFuncao +  '( ' +
      '{'+
         FComando +
      '}' +
    ')';
end;

procedure TJQuery.SetVariavel(value: string);
begin
  FVariavel := value;
end;

end.
