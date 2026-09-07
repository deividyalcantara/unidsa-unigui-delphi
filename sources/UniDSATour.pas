unit UniDSATour;

interface

uses
  System.SysUtils, System.Classes, uniGUIClasses, uniGUITypes,
  uniGUIApplication,
  UniDSABase, UniDSASource, UniDSAWebUtils;

type
  TUniDSATour = class;
  TUniDSATourPlacement = (tpAuto, tpTop, tpRight, tpBottom, tpLeft);

  TUniDSATourStep = class(TCollectionItem)
  private
    FID: string;
    FCaption: string;
    FContent: string;
    FTarget: TUniControl;
    FTargetSelector: string;
    FPlacement: TUniDSATourPlacement;
    FAllowInteraction: Boolean;
    FPadding: Integer;
    FBorderRadius: Integer;
    procedure SetID(const Value: string);
    procedure SetCaption(const Value: string);
    procedure SetContent(const Value: string);
    procedure SetTarget(const Value: TUniControl);
    procedure SetTargetSelector(const Value: string);
    function GetTour: TUniDSATour;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property Tour: TUniDSATour read GetTour;
  published
    property ID: string read FID write SetID;
    property Caption: string read FCaption write SetCaption;
    property Content: string read FContent write SetContent;
    property Target: TUniControl read FTarget write SetTarget;
    property TargetSelector: string read FTargetSelector write SetTargetSelector;
    property Placement: TUniDSATourPlacement read FPlacement write FPlacement default tpAuto;
    property AllowInteraction: Boolean read FAllowInteraction write FAllowInteraction default False;
    property Padding: Integer read FPadding write FPadding default -1;
    property BorderRadius: Integer read FBorderRadius write FBorderRadius default 0;
  end;

  TUniDSATourSteps = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TUniDSATourStep;
    procedure SetItem(Index: Integer; const Value: TUniDSATourStep);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TUniDSATourStep;
    property Items[Index: Integer]: TUniDSATourStep read GetItem write SetItem; default;
  end;

  TUniDSATourStepEvent = procedure(Sender: TObject; AStep: TUniDSATourStep) of object;

  TUniDSATour = class(TUniDSABaseComponent)
  private
    FDestroying: Boolean;
    FSteps: TUniDSATourSteps;
    FAutoStart: Boolean;
    FActiveStep: Integer;
    FShowProgress: Boolean;
    FAllowSkip: Boolean;
    FKeyboardNavigation: Boolean;
    FCloseOnEscape: Boolean;
    FScrollToTarget: Boolean;
    FOverlayOpacity: Double;
    FSpotlightPadding: Integer;
    FBorderRadius: Integer;
    FAutoStartDelay: Integer;
    FWaitForTarget: Boolean;
    FTargetWaitTimeout: Integer;
    FTargetWaitInterval: Integer;
    FBackCaption: string;
    FNextCaption: string;
    FFinishCaption: string;
    FSkipCaption: string;
    FOnStart: TNotifyEvent;
    FOnStepChange: TUniDSATourStepEvent;
    FOnFinish: TNotifyEvent;
    FOnSkip: TNotifyEvent;
    FOnTargetNotFound: TUniDSATourStepEvent;
    procedure SetSteps(const Value: TUniDSATourSteps);
    procedure SetActiveStep(const Value: Integer);
    procedure SetAutoStartDelay(const Value: Integer);
    procedure SetTargetWaitTimeout(const Value: Integer);
    procedure SetTargetWaitInterval(const Value: Integer);
    procedure SetOverlayOpacity(const Value: Double);
    procedure SetSpotlightPadding(const Value: Integer);
    procedure SetBorderRadius(const Value: Integer);
    function PlacementJS(APlacement: TUniDSATourPlacement): string;
    function BuildOptions: string;
    function BuildStartScript(ADelay: Integer): string;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure AJAXEvent(var EventName: string; var Params: TUniStrings); override;
    procedure LoadCompleted; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Start;
    procedure Stop;
    procedure Next;
    procedure Previous;
    procedure GoToStep(AIndex: Integer);
  published
    property Steps: TUniDSATourSteps read FSteps write SetSteps;
    property AutoStart: Boolean read FAutoStart write FAutoStart default False;
    property AutoStartDelay: Integer read FAutoStartDelay write SetAutoStartDelay default 350;
    property WaitForTarget: Boolean read FWaitForTarget write FWaitForTarget default True;
    property TargetWaitTimeout: Integer read FTargetWaitTimeout write SetTargetWaitTimeout default 5000;
    property TargetWaitInterval: Integer read FTargetWaitInterval write SetTargetWaitInterval default 100;
    property ActiveStep: Integer read FActiveStep write SetActiveStep default 0;
    property ShowProgress: Boolean read FShowProgress write FShowProgress default True;
    property AllowSkip: Boolean read FAllowSkip write FAllowSkip default True;
    property KeyboardNavigation: Boolean read FKeyboardNavigation write FKeyboardNavigation default True;
    property CloseOnEscape: Boolean read FCloseOnEscape write FCloseOnEscape default True;
    property ScrollToTarget: Boolean read FScrollToTarget write FScrollToTarget default True;
    property OverlayOpacity: Double read FOverlayOpacity write SetOverlayOpacity;
    property SpotlightPadding: Integer read FSpotlightPadding write SetSpotlightPadding default 8;
    property BorderRadius: Integer read FBorderRadius write SetBorderRadius default 12;
    property BackCaption: string read FBackCaption write FBackCaption;
    property NextCaption: string read FNextCaption write FNextCaption;
    property FinishCaption: string read FFinishCaption write FFinishCaption;
    property SkipCaption: string read FSkipCaption write FSkipCaption;
    property OnStart: TNotifyEvent read FOnStart write FOnStart;
    property OnStepChange: TUniDSATourStepEvent read FOnStepChange write FOnStepChange;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
    property OnSkip: TNotifyEvent read FOnSkip write FOnSkip;
    property OnTargetNotFound: TUniDSATourStepEvent read FOnTargetNotFound write FOnTargetNotFound;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSATour]);
end;

function UniqueTourStepID(ACollection: TCollection): string;
var N,I: Integer; Used: Boolean;
begin
  N:=ACollection.Count;
  repeat
    Result:='tour_step_'+IntToStr(N); Used:=False;
    for I:=0 to ACollection.Count-1 do
      if SameText(TUniDSATourStep(ACollection.Items[I]).FID,Result) then begin Used:=True; Break; end;
    Inc(N);
  until not Used;
end;

{ TUniDSATourStep }

procedure TUniDSATourStep.Assign(Source: TPersistent);
begin
  if Source is TUniDSATourStep then
  begin
    FID := TUniDSATourStep(Source).FID;
    FCaption := TUniDSATourStep(Source).FCaption;
    FContent := TUniDSATourStep(Source).FContent;
    SetTarget(TUniDSATourStep(Source).FTarget);
    FTargetSelector := TUniDSATourStep(Source).FTargetSelector;
    FPlacement := TUniDSATourStep(Source).FPlacement;
    FAllowInteraction := TUniDSATourStep(Source).FAllowInteraction;
    FPadding := TUniDSATourStep(Source).FPadding;
    FBorderRadius := TUniDSATourStep(Source).FBorderRadius;
    Changed(False);
  end
  else
    inherited;
end;

constructor TUniDSATourStep.Create(Collection: TCollection);
begin
  inherited;
  FID:=UniqueTourStepID(Collection);
  FCaption:='Passo '+IntToStr(Index+1);
  FPlacement:=tpAuto;
  FAllowInteraction:=False;
  FPadding:=-1;
  FBorderRadius:=0;
end;

function TUniDSATourStep.GetDisplayName: string;
begin if FCaption<>'' then Result:=FCaption else Result:=inherited GetDisplayName; end;

function TUniDSATourStep.GetTour: TUniDSATour;
begin
  Result:=nil;
  if Assigned(Collection) and (Collection is TOwnedCollection) and
     (TOwnedCollection(Collection).Owner is TUniDSATour) then
    Result:=TUniDSATour(TOwnedCollection(Collection).Owner);
end;

procedure TUniDSATourStep.SetCaption(const Value: string); begin if FCaption<>Value then begin FCaption:=Value; Changed(False); end; end;
procedure TUniDSATourStep.SetContent(const Value: string); begin if FContent<>Value then begin FContent:=Value; Changed(False); end; end;
procedure TUniDSATourStep.SetTargetSelector(const Value: string); begin if FTargetSelector<>Value then begin FTargetSelector:=Value; Changed(False); end; end;

procedure TUniDSATourStep.SetID(const Value: string);
var I: Integer;
begin
  if Trim(Value)='' then raise EConvertError.Create('O ID do passo do Tour não pode ser vazio.');
  if Assigned(Collection) then
    for I:=0 to Collection.Count-1 do
      if (Collection.Items[I]<>Self) and SameText(TUniDSATourStep(Collection.Items[I]).FID,Value) then
        raise EConvertError.CreateFmt('Já existe um passo do Tour com ID "%s".',[Value]);
  if FID<>Value then begin FID:=Value; Changed(False); end;
end;

procedure TUniDSATourStep.SetTarget(const Value: TUniControl);
var
  LTour: TUniDSATour;
begin
  if FTarget<>Value then
  begin
    LTour:=Tour;
    if Assigned(FTarget) and Assigned(LTour) then
      FTarget.RemoveFreeNotification(LTour);
    FTarget:=Value;
    if Assigned(FTarget) and Assigned(LTour) then
      FTarget.FreeNotification(LTour);
    Changed(False);
  end;
end;

{ TUniDSATourSteps }

constructor TUniDSATourSteps.Create(AOwner: TPersistent); begin inherited Create(AOwner,TUniDSATourStep); end;
function TUniDSATourSteps.Add: TUniDSATourStep; begin Result:=TUniDSATourStep(inherited Add); end;
function TUniDSATourSteps.GetItem(Index: Integer): TUniDSATourStep; begin Result:=TUniDSATourStep(inherited Items[Index]); end;
procedure TUniDSATourSteps.SetItem(Index: Integer; const Value: TUniDSATourStep); begin inherited Items[Index]:=Value; end;

{ TUniDSATour }

constructor TUniDSATour.Create(AOwner: TComponent);
begin
  inherited;
  FSteps:=TUniDSATourSteps.Create(Self);
  FAutoStart:=False; FAutoStartDelay:=350; FWaitForTarget:=True; FTargetWaitTimeout:=5000; FTargetWaitInterval:=100;
  FActiveStep:=0; FShowProgress:=True;
  FAllowSkip:=True; FKeyboardNavigation:=True; FCloseOnEscape:=True; FScrollToTarget:=True;
  FOverlayOpacity:=0.62; FSpotlightPadding:=8; FBorderRadius:=12;
  FBackCaption:='Voltar'; FNextCaption:='Próximo'; FFinishCaption:='Concluir'; FSkipCaption:='Pular';
end;

destructor TUniDSATour.Destroy;
var
  I: Integer;
  LSteps: TUniDSATourSteps;
begin
  FDestroying:=True;
  LSteps:=FSteps;
  if Assigned(LSteps) then
    for I:=0 to LSteps.Count-1 do
      if Assigned(LSteps[I].FTarget) then
      begin
        LSteps[I].FTarget.RemoveFreeNotification(Self);
        LSteps[I].FTarget:=nil;
      end;
  try
    { O Designer dispara Notification dentro de TComponent.Destroy. FSteps deve
      permanecer válido até a remoção do componente de seu Owner terminar. }
    inherited;
  finally
    FSteps:=nil;
    LSteps.Free;
  end;
end;

procedure TUniDSATour.SetSteps(const Value: TUniDSATourSteps); begin if Assigned(Value) then FSteps.Assign(Value); end;
procedure TUniDSATour.SetActiveStep(const Value: Integer); begin if FSteps.Count=0 then FActiveStep:=0 else FActiveStep:=UniDSAClamp(Value,0,FSteps.Count-1); end;
procedure TUniDSATour.SetAutoStartDelay(const Value: Integer); begin if Value<0 then FAutoStartDelay:=0 else FAutoStartDelay:=Value; end;
procedure TUniDSATour.SetTargetWaitTimeout(const Value: Integer); begin if Value<0 then FTargetWaitTimeout:=0 else FTargetWaitTimeout:=Value; end;
procedure TUniDSATour.SetTargetWaitInterval(const Value: Integer); begin if Value<25 then FTargetWaitInterval:=25 else FTargetWaitInterval:=Value; end;
procedure TUniDSATour.SetOverlayOpacity(const Value: Double); begin if Value<0 then FOverlayOpacity:=0 else if Value>0.92 then FOverlayOpacity:=0.92 else FOverlayOpacity:=Value; end;
procedure TUniDSATour.SetSpotlightPadding(const Value: Integer); begin if Value<0 then FSpotlightPadding:=0 else FSpotlightPadding:=Value; end;
procedure TUniDSATour.SetBorderRadius(const Value: Integer); begin if Value<0 then FBorderRadius:=0 else FBorderRadius:=Value; end;

procedure TUniDSATour.Notification(AComponent: TComponent; Operation: TOperation);
var I: Integer;
begin
  if (not FDestroying) and Assigned(FSteps) and (Operation=opRemove) then
    for I:=0 to FSteps.Count-1 do if FSteps[I].FTarget=AComponent then FSteps[I].FTarget:=nil;
  inherited;
end;

function TUniDSATour.PlacementJS(APlacement: TUniDSATourPlacement): string;
begin
  case APlacement of tpTop:Result:='top'; tpRight:Result:='right'; tpBottom:Result:='bottom'; tpLeft:Result:='left'; else Result:='auto'; end;
end;

function FloatToJS(const V: Double): string;
begin
  Result := StringReplace(FloatToStr(V), ',', '.', [rfReplaceAll]);
end;

function TUniDSATour.BuildOptions: string;
var B: TStringBuilder; I,Pad,Radius: Integer; S: TUniDSATourStep; TargetName: string;
begin
  B:=TStringBuilder.Create;
  try
    B.Append('{startStep:'+IntToStr(FActiveStep)+',showProgress:'+UniDSABoolJS(FShowProgress)+',allowSkip:'+UniDSABoolJS(FAllowSkip)+
      ',keyboardNavigation:'+UniDSABoolJS(FKeyboardNavigation)+',closeOnEscape:'+UniDSABoolJS(FCloseOnEscape)+',scrollToTarget:'+UniDSABoolJS(FScrollToTarget)+
      ',waitForTarget:'+UniDSABoolJS(FWaitForTarget)+',targetWaitTimeout:'+IntToStr(FTargetWaitTimeout)+',targetWaitInterval:'+IntToStr(FTargetWaitInterval)+
      ',overlayOpacity:'+FloatToJS(FOverlayOpacity)+',padding:'+IntToStr(FSpotlightPadding)+',radius:'+IntToStr(FBorderRadius)+
      ',backCaption:'+UniDSAJSString(FBackCaption)+',nextCaption:'+UniDSAJSString(FNextCaption)+',finishCaption:'+UniDSAJSString(FFinishCaption)+',skipCaption:'+UniDSAJSString(FSkipCaption)+',steps:[');
    for I:=0 to FSteps.Count-1 do
    begin
      S:=FSteps[I]; if I>0 then B.Append(','); TargetName:=''; if Assigned(S.Target) then TargetName:=S.Target.JSName;
      Pad:=S.Padding; Radius:=S.BorderRadius;
      B.Append('{id:'+UniDSAJSString(S.ID)+',title:'+UniDSAJSString(S.Caption)+',content:'+UniDSAJSString(S.Content)+',target:'+UniDSAJSString(TargetName)+
        ',selector:'+UniDSAJSString(S.TargetSelector)+',placement:'+UniDSAJSString(PlacementJS(S.Placement))+',allowInteraction:'+UniDSABoolJS(S.AllowInteraction));
      if Pad>=0 then B.Append(',padding:'+IntToStr(Pad));
      if Radius>0 then B.Append(',radius:'+IntToStr(Radius));
      B.Append('}');
    end;
    B.Append(']}'); Result:=B.ToString;
  finally B.Free; end;
end;

function TUniDSATour.BuildStartScript(ADelay: Integer): string;
var
  LTimeout: Integer;
begin
  if ADelay < 0 then
    ADelay := 0;

  { Também aguardamos a própria biblioteca JS. Normalmente ela já está carregada,
    mas isso evita perder o AutoStart caso o browser ainda esteja processando os
    assets publicados. }
  LTimeout := FTargetWaitTimeout;
  if LTimeout < 5000 then
    LTimeout := 5000;

  Result :=
    '(function(){var __dsaDelay=' + IntToStr(ADelay) +
    ',__dsaLeft=' + IntToStr(LTimeout) +
    ',__dsaRun=function(){' +
      'if(window.UniDSATour&&typeof window.UniDSATour.start==="function"){' +
        'window.UniDSATour.start(' + JSName + ',' + BuildOptions + ');return;' +
      '}' +
      'if(__dsaLeft<=0){return;}' +
      '__dsaLeft-=100;setTimeout(__dsaRun,100);' +
    '};setTimeout(__dsaRun,__dsaDelay);})();';
end;

procedure TUniDSATour.Start;
begin
  if (not WebMode) or (FSteps.Count=0) then Exit;
  FActiveStep:=UniDSAClamp(FActiveStep,0,FSteps.Count-1);
  UniSession.AddJS(BuildStartScript(0));
end;

procedure TUniDSATour.Stop; begin if WebMode then UniSession.AddJS('if(window.UniDSATour){window.UniDSATour.stop();}'); end;
procedure TUniDSATour.Next; begin if WebMode then UniSession.AddJS('if(window.UniDSATour){window.UniDSATour.next();}'); end;
procedure TUniDSATour.Previous; begin if WebMode then UniSession.AddJS('if(window.UniDSATour){window.UniDSATour.previous();}'); end;
procedure TUniDSATour.GoToStep(AIndex: Integer); begin SetActiveStep(AIndex); if WebMode then UniSession.AddJS('if(window.UniDSATour){window.UniDSATour.goTo('+IntToStr(FActiveStep)+');}'); end;

procedure TUniDSATour.AJAXEvent(var EventName: string; var Params: TUniStrings);
var I: Integer;
begin
  inherited;
  I:=StrToIntDef(Params.Values['step'],FActiveStep);
  if FSteps.Count>0 then FActiveStep:=UniDSAClamp(I,0,FSteps.Count-1) else FActiveStep:=0;
  if EventName='UniDSATourStart' then begin if Assigned(FOnStart) then FOnStart(Self); end
  else if EventName='UniDSATourStepChange' then begin if (FActiveStep<FSteps.Count) and Assigned(FOnStepChange) then FOnStepChange(Self,FSteps[FActiveStep]); end
  else if EventName='UniDSATourFinish' then begin if Assigned(FOnFinish) then FOnFinish(Self); end
  else if EventName='UniDSATourSkip' then begin if Assigned(FOnSkip) then FOnSkip(Self); end
  else if EventName='UniDSATourTargetNotFound' then begin
    if (FActiveStep<FSteps.Count) and Assigned(FOnTargetNotFound) then
      FOnTargetNotFound(Self,FSteps[FActiveStep]);
  end;
end;

procedure TUniDSATour.LoadCompleted;
begin
  inherited;
  if FAutoStart and WebMode and (FSteps.Count>0) then
    UniSession.AddJS(BuildStartScript(FAutoStartDelay));
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.Tour);

end.
