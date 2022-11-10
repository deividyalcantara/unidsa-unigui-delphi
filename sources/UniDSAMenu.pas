unit UniDSAMenu;

interface

uses
  UniDSAConfirm, UniDSAToast, UniDSABrowser, DesignEditors, DesignIntf, System.Classes;

type
  TUniDSAConfirmMenu = class(TComponentEditor)
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure Edit; override;
    destructor Destroy; override;
  end;

  TUniDSAToastMenu = class(TComponentEditor)
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure Edit; override;
    destructor Destroy; override;
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponentEditor(TUniDSAConfirm, TUniDSAConfirmMenu);
  RegisterComponentEditor(TUniDSAToast, TUniDSAToastMenu);
end;

{ TUniDSAConfirmMenu }

destructor TUniDSAConfirmMenu.Destroy;
begin
  inherited;
end;

procedure TUniDSAConfirmMenu.Edit;
begin
  inherited;
end;

procedure TUniDSAConfirmMenu.ExecuteVerb(Index: Integer);
var
  funcao: string;
begin
  inherited;

  if TUniDSAConfirm(Component).TypeConfirm = TUniDSAConfirmTypeConfirm.Alert then
    funcao := 'alert'
  else if TUniDSAConfirm(Component).TypeConfirm = TUniDSAConfirmTypeConfirm.Dialog then
    funcao := 'dialog'
  else
    funcao := 'confirm';

  case Index of
    0: begin
         TUniDSAConfirm(Component).Prepare;
         TUniDSAConfirm(Component).ConfirmProperty.FunctionName(funcao);
         UniDSABrowser.Navegar(TUniDSAConfirm(Component).ConfirmProperty.JQuery);
       end;
    1: begin
         UniDSABrowser.Navegar('https://fontawesome.com/v4/icons', UniDSABrowser.TUniDSABrowserMode.bmSite);
       end;
  end;
end;

function TUniDSAConfirmMenu.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Testar';
    1: Result := '&Fonte Awesome';
  end;
end;

function TUniDSAConfirmMenu.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TUniDSAToastMenu }

constructor TUniDSAToastMenu.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited;

end;

destructor TUniDSAToastMenu.Destroy;
begin

  inherited;
end;

procedure TUniDSAToastMenu.Edit;
begin
  inherited;
  ExecuteVerb(0);
end;

procedure TUniDSAToastMenu.ExecuteVerb(Index: Integer);
begin
  inherited;
  case Index of
    0: begin
         TUniDSAToast(Component).Prepare;
         UniDSABrowser.Navegar(TUniDSAToast(Component).Toast.JQuery);
       end;
  end;
end;

function TUniDSAToastMenu.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Testar';
  end;
end;

function TUniDSAToastMenu.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.
