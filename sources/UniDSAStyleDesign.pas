unit UniDSAStyleDesign;

interface

uses System.Classes, System.TypInfo, DesignIntf, DesignEditors, UniDSAStyle;

procedure Register;

implementation

type
  TUniDSAStyleControlProperty = class(TComponentProperty)
  private
    FProc: TGetStrProc;
    procedure FilterName(const Name: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TUniDSAStyleNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TUniDSAStyleEditor = class(TComponentEditor)
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

procedure TUniDSAStyleControlProperty.FilterName(const Name: string);
begin
  if TUniDSAStyle.SupportsControl(Designer.GetComponent(Name)) then FProc(Name);
end;

procedure TUniDSAStyleControlProperty.GetValues(Proc: TGetStrProc);
begin
  FProc := Proc;
  try Designer.GetComponentNames(GetTypeData(TypeInfo(TComponent)), FilterName);
  finally FProc := nil; end;
end;

function TUniDSAStyleNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList, paSortList];
end;

procedure TUniDSAStyleNameProperty.GetValues(Proc: TGetStrProc);
var Item: TUniDSAStyleItem; Manager: TUniDSAStyle; I: Integer;
begin
  Item := GetComponent(0) as TUniDSAStyleItem;
  Manager := TOwnedCollection(Item.Collection).Owner as TUniDSAStyle;
  for I := 0 to Manager.Styles.Count - 1 do Proc(Manager.Styles[I].Name);
end;

function TUniDSAStyleEditor.GetVerbCount: Integer;
begin Result := 1; end;

function TUniDSAStyleEditor.GetVerb(Index: Integer): string;
begin Result := 'Validar estilos e controles'; end;

procedure TUniDSAStyleEditor.ExecuteVerb(Index: Integer);
begin
  (Component as TUniDSAStyle).Validate;
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TComponent), TUniDSAStyleItem, 'Control', TUniDSAStyleControlProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TUniDSAStyle, 'TargetContainer', TUniDSAStyleControlProperty);
  RegisterPropertyEditor(TypeInfo(string), TUniDSAStyleItem, 'StyleName', TUniDSAStyleNameProperty);
  RegisterComponentEditor(TUniDSAStyle, TUniDSAStyleEditor);
end;

end.
