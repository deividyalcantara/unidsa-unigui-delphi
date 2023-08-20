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
    constructor Create(AFuncao: string);
    destructor Destroy; override;
    procedure SetVariavel(value: string);
    function GetVariavel: string;
    procedure FunctionName(name: string);
    procedure Add(APar: string; AValor: string; ACondicao: Boolean = True; AAspas: Boolean = True; AAspasDuplas: Boolean = True); overload;
    procedure Add(APar: string; AValor: Integer; ACondicao: Boolean = True; AAspas: Boolean = False; AAspasDuplas: Boolean = True); overload;
    procedure Add(APar: string; AValor: Boolean; ACondicao: Boolean = True; AAspas: Boolean = False; AAspasDuplas: Boolean = True); overload;
    procedure Execute;
    function JQuery: string;
    procedure Clear;
  end;

implementation

{ TJQuery }

procedure TJQuery.Add(APar: string; AValor: string; ACondicao: Boolean = True; AAspas: Boolean = True; AAspasDuplas: Boolean = True);
begin
  if not ACondicao then
    Exit;

  FComando := FComando + IIfStr(FComando <> '', ', ', ' ') + APar + ': ';

  if AAspas then begin
    if AAspasDuplas then
      FComando := FComando + '"' + AValor + '"'
    else
      FComando := FComando + QuotedStr(AValor);
  end
  else
    FComando := FComando + AValor;
end;

procedure TJQuery.Add(APar: string; AValor: Boolean; ACondicao: Boolean = True; AAspas: Boolean = False; AAspasDuplas: Boolean = True);
begin
  Add(APar, IIfStr(AValor, 'true', 'false'), ACondicao, AAspas, AAspasDuplas);
end;

procedure TJQuery.Add(APar: string; AValor: Integer; ACondicao: Boolean = True; AAspas: Boolean = False; AAspasDuplas: Boolean = True);
begin
  Add(APar, IntToStr(AValor), ACondicao, AAspas, AAspasDuplas);
end;

procedure TJQuery.Clear;
begin
  FComando := '';
  FVariavel := '';
end;

constructor TJQuery.Create(AFuncao: string);
begin
  FFuncao := AFuncao;
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
