unit UniDSAStyleDesign;

interface

uses System.Classes, System.TypInfo, DesignIntf, DesignEditors, UniDSAStyle;

procedure Register;

implementation

uses System.SysUtils, Vcl.Forms, Vcl.StdCtrls, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs;

type
  TUniDSAStyleCSSProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

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

function TUniDSAStyleCSSProperty.GetAttributes: TPropertyAttributes;
begin Result := [paDialog]; end;

function TUniDSAStyleCSSProperty.GetValue: string;
begin Result := '(Cole CSS...)'; end;

procedure TUniDSAStyleCSSProperty.Edit;
var Dialog: TForm; Memo: TMemo; Footer: TPanel; Button: TButton; Hint: TLabel;
  Mode: TRadioGroup; Target: TPersistent; Rule: TUniDSAStyleRule;
begin
  Dialog := TForm.CreateNew(nil);
  try
    Dialog.Caption := 'Importar CSS para as propriedades do Style';
    Dialog.Position := poScreenCenter; Dialog.Width := 760; Dialog.Height := 580;
    Dialog.BorderIcons := [biSystemMenu, biMaximize];
    Hint := TLabel.Create(Dialog); Hint.Parent := Dialog; Hint.Align := alTop;
    Hint.AutoSize := False; Hint.Height := 72; Hint.WordWrap := True;
    Hint.Caption := 'Cole as declaracoes ou um seletor com seus estados :hover, :active, :focus e :disabled. ' +
      'Substituir limpa Appearance, States, Responsive e CustomCSS deste item antes de importar. ' +
      'Nome e associacoes sao preservados. Declaracoes sem conversao ficam em CustomCSS.';
    Mode := TRadioGroup.Create(Dialog); Mode.Parent := Dialog; Mode.Align := alBottom;
    Mode.Height := 62; Mode.Caption := 'Como importar'; Mode.Columns := 2;
    Mode.Items.Add('Substituir estilo'); Mode.Items.Add('Mesclar com o atual');
    Mode.ItemIndex := 0;
    Footer := TPanel.Create(Dialog); Footer.Parent := Dialog; Footer.Align := alBottom;
    Footer.Height := 44; Footer.BevelOuter := bvNone;
    Button := TButton.Create(Dialog); Button.Parent := Footer; Button.Align := alRight;
    Button.Width := 110; Button.Caption := 'Cancelar'; Button.Cancel := True; Button.ModalResult := mrCancel;
    Button := TButton.Create(Dialog); Button.Parent := Footer; Button.Align := alRight;
    Button.Width := 110; Button.Caption := 'Importar'; Button.ModalResult := mrOk;
    Memo := TMemo.Create(Dialog); Memo.Parent := Dialog; Memo.Align := alClient;
    Memo.ScrollBars := ssBoth; Memo.WordWrap := False; Memo.WantTabs := True;
    Memo.Font.Name := 'Consolas'; Memo.Font.Size := 10;
    Dialog.ActiveControl := Memo;
    while Dialog.ShowModal = mrOk do begin
      try
        if Trim(Memo.Text) = '' then Exit;
        Target := GetComponent(0);
        if Target is TUniDSANamedStyle then Rule := TUniDSANamedStyle(Target).Rule
        else Rule := Target as TUniDSAStyleRule;
        Rule.LoadCSS(Memo.Text, Mode.ItemIndex = 0);
        Designer.Modified;
        Break;
      except on E: EArgumentException do MessageDlg(E.Message, mtError, [mbOK], 0); end;
    end;
  finally Dialog.Free; end;
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
  RegisterPropertyEditor(TypeInfo(string), TUniDSAStyleRule, 'ImportCSS', TUniDSAStyleCSSProperty);
  RegisterPropertyEditor(TypeInfo(string), TUniDSANamedStyle, 'ImportCSS', TUniDSAStyleCSSProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TUniDSAStyleItem, 'Control', TUniDSAStyleControlProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TUniDSAStyle, 'TargetContainer', TUniDSAStyleControlProperty);
  RegisterPropertyEditor(TypeInfo(string), TUniDSAStyleItem, 'StyleName', TUniDSAStyleNameProperty);
  RegisterComponentEditor(TUniDSAStyle, TUniDSAStyleEditor);
end;

end.
