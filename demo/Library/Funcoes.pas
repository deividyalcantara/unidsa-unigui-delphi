unit Funcoes;

interface

uses
  System.SysUtils, System.TypInfo, uniButton;

type
  TFuncoes = class
  public
    class procedure AlternarLegendaBotao(var ABotao: TUniButton; const ALegenda1, ALegenda2: string);
  end;

implementation

{ TFuncoes }

{ TFuncoes }

class procedure TFuncoes.AlternarLegendaBotao(var ABotao: TUniButton; const ALegenda1, ALegenda2: string);
begin
  if ABotao.Caption = ALegenda1 then
    ABotao.Caption := ALegenda2
  else
    ABotao.Caption := ALegenda1;
end;

end.

