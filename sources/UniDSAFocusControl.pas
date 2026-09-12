unit UniDSAFocusControl;

interface

uses System.Classes, UniDSABase;

type
  TUniDSAFocusControl = class(TUniDSABaseComponent)
  private
    FEnabled: Boolean;
    FReady: Boolean;
    procedure SetEnabled(Value: Boolean);
  protected
    procedure LoadCompleted; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Apply;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

procedure Register;

implementation

uses System.JSON, uniGUIClasses, uniGUIForm, uniGUIFrame, uniGUIJSUtils;

{$I UniDSAFocusControlRuntime.inc}

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAFocusControl]);
end;

constructor TUniDSAFocusControl.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
end;

destructor TUniDSAFocusControl.Destroy;
var Key: TJSONString;
begin
  if FReady and WebMode and Assigned(Owner) and not (csDestroying in Owner.ComponentState) then
  begin
    Key := TJSONString.Create(JSName);
    try UniSession.AddJS('if(window.UniDSAFocusControl)UniDSAFocusControl.detach(' + Key.ToJSON + ');');
    finally Key.Free; end;
  end;
  inherited;
end;

procedure TUniDSAFocusControl.SetEnabled(Value: Boolean);
begin
  if FEnabled = Value then Exit;
  FEnabled := Value;
  Apply;
end;

procedure TUniDSAFocusControl.Apply;
var C: TComponent; Root: string; Config: TJSONObject; Key: TJSONString;
begin
  if not FReady or not WebMode or (csLoading in ComponentState) or
    (csDestroying in ComponentState) or
    (Assigned(Owner) and (csDestroying in Owner.ComponentState)) then Exit;
  C := Owner;
  while Assigned(C) and not (C is TUniForm) and not (C is TUniFrame) do C := C.Owner;
  Root := '';
  if C is TUniForm then Root := TUniForm(C).WebForm.ActivePanel.JSName
  else if C is TUniFrame then Root := TUniFrame(C).FormRegion.JSName;
  if Root = '' then Exit;
  Config := TJSONObject.Create;
  Key := TJSONString.Create(JSName);
  try
    Config.AddPair('root', RemoveJSDelimeter(Root) + '_id');
    Config.AddPair('enabled', TJSONBool.Create(FEnabled));
    UniSession.AddJS('UniDSAFocusControl.attach(' + Key.ToJSON + ',' + Config.ToJSON + ');');
  finally Key.Free; Config.Free; end;
end;

procedure TUniDSAFocusControl.LoadCompleted;
begin
  inherited;
  UniSession.AddJS(UniDSAFocusControlRuntime);
  FReady := True;
  Apply;
end;

end.
