unit UniDSAFlexPanel;

interface

uses
  System.Classes, System.SysUtils, System.Math, Vcl.Controls, Vcl.Graphics,
  uniGUIClasses, uniGUITypes;

type
  TUniDSAFlexDirection = (fdRow, fdRowReverse, fdColumn, fdColumnReverse);
  TUniDSAFlexWrap = (fwNoWrap, fwWrap, fwWrapReverse);
  TUniDSAFlexJustify = (fjStart, fjCenter, fjEnd, fjSpaceBetween,
    fjSpaceAround, fjSpaceEvenly);
  TUniDSAFlexAlign = (faStretch, faStart, faCenter, faEnd, faBaseline);
  TUniDSAFlexAlignSelf = (fasAuto, fasStretch, fasStart, fasCenter, fasEnd,
    fasBaseline);
  TUniDSAFlexOverflow = (foVisible, foHidden, foAuto, foScroll);
  TUniDSADesignPreview = (dpAuto, dpPhone, dpTablet, dpDesktop, dpWide);
  TUniDSABreakpoint = (bpXS, bpSM, bpMD, bpLG, bpXL, bpXXL);

  TUniDSAFlexPanel = class;
  TUniDSAFlexChildItem = class;

  TUniDSAFlexOptions = class(TPersistent)
  private
    FOwner: TUniDSAFlexPanel;
    FDirection: TUniDSAFlexDirection;
    FWrap: TUniDSAFlexWrap;
    FJustifyContent: TUniDSAFlexJustify;
    FAlignItems: TUniDSAFlexAlign;
    FAlignContent: TUniDSAFlexAlign;
    FGap: Integer;
    FRowGap: Integer;
    FColumnGap: Integer;
    FPadding: Integer;
    FColumns: Integer;
    FDefaultSpan: Integer;
    FOverflow: TUniDSAFlexOverflow;
    FAutoHeight: Boolean;
    FAutoWidth: Boolean;
    procedure Changed;
    procedure SetDirection(const Value: TUniDSAFlexDirection);
    procedure SetWrap(const Value: TUniDSAFlexWrap);
    procedure SetJustifyContent(const Value: TUniDSAFlexJustify);
    procedure SetAlignItems(const Value: TUniDSAFlexAlign);
    procedure SetAlignContent(const Value: TUniDSAFlexAlign);
    procedure SetGap(const Value: Integer);
    procedure SetRowGap(const Value: Integer);
    procedure SetColumnGap(const Value: Integer);
    procedure SetPadding(const Value: Integer);
    procedure SetColumns(const Value: Integer);
    procedure SetDefaultSpan(const Value: Integer);
    procedure SetOverflow(const Value: TUniDSAFlexOverflow);
    procedure SetAutoHeight(const Value: Boolean);
    procedure SetAutoWidth(const Value: Boolean);
  public
    constructor Create(AOwner: TUniDSAFlexPanel);
    procedure Assign(Source: TPersistent); override;
    function EffectiveRowGap: Integer;
    function EffectiveColumnGap: Integer;
  published
    property Direction: TUniDSAFlexDirection read FDirection write SetDirection default fdRow;
    property Wrap: TUniDSAFlexWrap read FWrap write SetWrap default fwWrap;
    property JustifyContent: TUniDSAFlexJustify read FJustifyContent write SetJustifyContent default fjStart;
    property AlignItems: TUniDSAFlexAlign read FAlignItems write SetAlignItems default faStretch;
    property AlignContent: TUniDSAFlexAlign read FAlignContent write SetAlignContent default faStretch;
    property Gap: Integer read FGap write SetGap default 12;
    property RowGap: Integer read FRowGap write SetRowGap default -1;
    property ColumnGap: Integer read FColumnGap write SetColumnGap default -1;
    property Padding: Integer read FPadding write SetPadding default 0;
    property Columns: Integer read FColumns write SetColumns default 12;
    property DefaultSpan: Integer read FDefaultSpan write SetDefaultSpan default 0;
    property Overflow: TUniDSAFlexOverflow read FOverflow write SetOverflow default foVisible;
    property AutoHeight: Boolean read FAutoHeight write SetAutoHeight default False;
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth default False;
  end;

  TUniDSAFlexItemOptions = class(TPersistent)
  private
    FOwner: TUniDSAFlexPanel;
    FGrow: Integer;
    FShrink: Integer;
    FBasis: string;
    FOrder: Integer;
    FAlignSelf: TUniDSAFlexAlignSelf;
    procedure Changed;
    procedure SetGrow(const Value: Integer);
    procedure SetShrink(const Value: Integer);
    procedure SetBasis(const Value: string);
    procedure SetOrder(const Value: Integer);
    procedure SetAlignSelf(const Value: TUniDSAFlexAlignSelf);
  public
    constructor Create(AOwner: TUniDSAFlexPanel);
    procedure Assign(Source: TPersistent); override;
  published
    property Grow: Integer read FGrow write SetGrow default 0;
    property Shrink: Integer read FShrink write SetShrink default 1;
    property Basis: string read FBasis write SetBasis;
    property Order: Integer read FOrder write SetOrder default 0;
    property AlignSelf: TUniDSAFlexAlignSelf read FAlignSelf write SetAlignSelf default fasAuto;
  end;

  TUniDSAResponsiveSpan = class(TPersistent)
  private
    FOwner: TUniDSAFlexPanel;
    FSpan: Integer;
    procedure SetSpan(const Value: Integer);
  public
    constructor Create(AOwner: TUniDSAFlexPanel; ADefaultSpan: Integer = 0);
    procedure Assign(Source: TPersistent); override;
  published
    property Span: Integer read FSpan write SetSpan default 0;
  end;

  TUniDSAResponsiveOptions = class(TPersistent)
  private
    FOwner: TUniDSAFlexPanel;
    FXS: TUniDSAResponsiveSpan;
    FSM: TUniDSAResponsiveSpan;
    FMD: TUniDSAResponsiveSpan;
    FLG: TUniDSAResponsiveSpan;
    FXL: TUniDSAResponsiveSpan;
    FXXL: TUniDSAResponsiveSpan;
    procedure SetXS(const Value: TUniDSAResponsiveSpan);
    procedure SetSM(const Value: TUniDSAResponsiveSpan);
    procedure SetMD(const Value: TUniDSAResponsiveSpan);
    procedure SetLG(const Value: TUniDSAResponsiveSpan);
    procedure SetXL(const Value: TUniDSAResponsiveSpan);
    procedure SetXXL(const Value: TUniDSAResponsiveSpan);
  public
    constructor Create(AOwner: TUniDSAFlexPanel);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function SpanFor(ABreakpoint: TUniDSABreakpoint): Integer;
  published
    property XS: TUniDSAResponsiveSpan read FXS write SetXS;
    property SM: TUniDSAResponsiveSpan read FSM write SetSM;
    property MD: TUniDSAResponsiveSpan read FMD write SetMD;
    property LG: TUniDSAResponsiveSpan read FLG write SetLG;
    property XL: TUniDSAResponsiveSpan read FXL write SetXL;
    property XXL: TUniDSAResponsiveSpan read FXXL write SetXXL;
  end;

  TUniDSAFlexChildSpan = class(TPersistent)
  private
    FOwner: TUniDSAFlexChildItem;
    FSpan: Integer;
    procedure SetSpan(const Value: Integer);
  public
    constructor Create(AOwner: TUniDSAFlexChildItem);
    procedure Assign(Source: TPersistent); override;
  published
    property Span: Integer read FSpan write SetSpan default 0;
  end;

  TUniDSAFlexChildResponsiveOptions = class(TPersistent)
  private
    FOwner: TUniDSAFlexChildItem;
    FXS: TUniDSAFlexChildSpan;
    FSM: TUniDSAFlexChildSpan;
    FMD: TUniDSAFlexChildSpan;
    FLG: TUniDSAFlexChildSpan;
    FXL: TUniDSAFlexChildSpan;
    FXXL: TUniDSAFlexChildSpan;
    procedure SetXS(const Value: TUniDSAFlexChildSpan);
    procedure SetSM(const Value: TUniDSAFlexChildSpan);
    procedure SetMD(const Value: TUniDSAFlexChildSpan);
    procedure SetLG(const Value: TUniDSAFlexChildSpan);
    procedure SetXL(const Value: TUniDSAFlexChildSpan);
    procedure SetXXL(const Value: TUniDSAFlexChildSpan);
  public
    constructor Create(AOwner: TUniDSAFlexChildItem);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function SpanFor(ABreakpoint: TUniDSABreakpoint): Integer;
  published
    property XS: TUniDSAFlexChildSpan read FXS write SetXS;
    property SM: TUniDSAFlexChildSpan read FSM write SetSM;
    property MD: TUniDSAFlexChildSpan read FMD write SetMD;
    property LG: TUniDSAFlexChildSpan read FLG write SetLG;
    property XL: TUniDSAFlexChildSpan read FXL write SetXL;
    property XXL: TUniDSAFlexChildSpan read FXXL write SetXXL;
  end;

  TUniDSAFlexChildItem = class(TCollectionItem)
  private
    FControl: TUniControl;
    FGrow: Integer;
    FShrink: Integer;
    FBasis: string;
    FOrder: Integer;
    FAlignSelf: TUniDSAFlexAlignSelf;
    FResponsive: TUniDSAFlexChildResponsiveOptions;
    procedure Changed;
    procedure SetControl(const Value: TUniControl);
    procedure SetGrow(const Value: Integer);
    procedure SetShrink(const Value: Integer);
    procedure SetBasis(const Value: string);
    procedure SetOrder(const Value: Integer);
    procedure SetAlignSelf(const Value: TUniDSAFlexAlignSelf);
    procedure SetResponsive(const Value: TUniDSAFlexChildResponsiveOptions);
    function OwnerPanel: TUniDSAFlexPanel;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Control: TUniControl read FControl write SetControl;
    property Grow: Integer read FGrow write SetGrow default 0;
    property Shrink: Integer read FShrink write SetShrink default 1;
    property Basis: string read FBasis write SetBasis;
    property Order: Integer read FOrder write SetOrder default 0;
    property AlignSelf: TUniDSAFlexAlignSelf read FAlignSelf write SetAlignSelf default fasAuto;
    property Responsive: TUniDSAFlexChildResponsiveOptions read FResponsive write SetResponsive;
  end;

  TUniDSAFlexChildItems = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TUniDSAFlexChildItem;
    procedure SetItem(Index: Integer; const Value: TUniDSAFlexChildItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TUniDSAFlexPanel);
    function Add: TUniDSAFlexChildItem;
    function FindByControl(AControl: TControl): TUniDSAFlexChildItem;
    property Items[Index: Integer]: TUniDSAFlexChildItem read GetItem write SetItem; default;
  end;

  TUniDSAFlexPanel = class(TUniCustomContainerPanel)
  private
    FFlex: TUniDSAFlexOptions;
    FFlexItem: TUniDSAFlexItemOptions;
    FResponsive: TUniDSAResponsiveOptions;
    FFlexItems: TUniDSAFlexChildItems;
    FDesignPreview: TUniDSADesignPreview;
    FUpdatingDesignLayout: Boolean;
    procedure SetFlex(const Value: TUniDSAFlexOptions);
    procedure SetFlexItem(const Value: TUniDSAFlexItemOptions);
    procedure SetResponsive(const Value: TUniDSAResponsiveOptions);
    procedure SetFlexItems(const Value: TUniDSAFlexChildItems);
    procedure SetDesignPreview(const Value: TUniDSADesignPreview);
    function BuildContainerConfig: string;
    function BuildItemConfig: string;
    function BuildChildItemsConfig: string;
    function DesignBreakpoint: TUniDSABreakpoint;
    function DesignChildSpan(AControl: TControl): Integer;
    function DesignChildOrder(AControl: TControl): Integer;
    function DesignChildAlignSelf(AControl: TControl): TUniDSAFlexAlignSelf;
    procedure UpdateDesignLayout;
  protected
    procedure InitComponent; override;
    procedure ConfigJSClasses(ALoading: Boolean); override;
    function VCLControlClassName: string; override;
    function GetDesignJSClassName(const AJSClassName: string): string; override;
    procedure LoadCompleted; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function InsertControl(AControl: TControl): TControl; override;
    procedure RemoveControl(AControl: TControl); override;
    procedure RefreshFlex;
    procedure RefreshFlexItem;
    procedure RefreshFlexItems;
    procedure RolarParaFim;
  published
    property Flex: TUniDSAFlexOptions read FFlex write SetFlex;
    property FlexItem: TUniDSAFlexItemOptions read FFlexItem write SetFlexItem;
    property Responsive: TUniDSAResponsiveOptions read FResponsive write SetResponsive;
    property FlexItems: TUniDSAFlexChildItems read FFlexItems write SetFlexItems;
    property DesignPreview: TUniDSADesignPreview read FDesignPreview write SetDesignPreview default dpAuto;
    property Align;
    property Anchors;
    property ParentColor;
    property Color;
    property TabOrder;
    property TabStop;
    property ClientEvents;
    property ScreenMask;
    property LayoutConfig;
    property Visible;
    property Enabled;
    property Hint;
    property ShowHint;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnAjaxEvent;
  end;

procedure Register;

implementation

uses
  UniDSASource, UniDSAWebUtils;

function ClampInt(const AValue, AMin, AMax: Integer): Integer;
begin
  if AValue < AMin then Result := AMin
  else if AValue > AMax then Result := AMax
  else Result := AValue;
end;

function FlexDirectionJS(const Value: TUniDSAFlexDirection): string;
begin
  case Value of
    fdRowReverse: Result := 'row-reverse';
    fdColumn: Result := 'column';
    fdColumnReverse: Result := 'column-reverse';
  else Result := 'row'; end;
end;

function FlexWrapJS(const Value: TUniDSAFlexWrap): string;
begin
  case Value of
    fwNoWrap: Result := 'nowrap';
    fwWrapReverse: Result := 'wrap-reverse';
  else Result := 'wrap'; end;
end;

function FlexJustifyJS(const Value: TUniDSAFlexJustify): string;
begin
  case Value of
    fjCenter: Result := 'center';
    fjEnd: Result := 'flex-end';
    fjSpaceBetween: Result := 'space-between';
    fjSpaceAround: Result := 'space-around';
    fjSpaceEvenly: Result := 'space-evenly';
  else Result := 'flex-start'; end;
end;

function FlexAlignJS(const Value: TUniDSAFlexAlign): string;
begin
  case Value of
    faStart: Result := 'flex-start';
    faCenter: Result := 'center';
    faEnd: Result := 'flex-end';
    faBaseline: Result := 'baseline';
  else Result := 'stretch'; end;
end;

function FlexAlignSelfJS(const Value: TUniDSAFlexAlignSelf): string;
begin
  case Value of
    fasStretch: Result := 'stretch';
    fasStart: Result := 'flex-start';
    fasCenter: Result := 'center';
    fasEnd: Result := 'flex-end';
    fasBaseline: Result := 'baseline';
  else Result := 'auto'; end;
end;

function FlexOverflowJS(const Value: TUniDSAFlexOverflow): string;
begin
  case Value of
    foHidden: Result := 'hidden';
    foAuto: Result := 'auto';
    foScroll: Result := 'scroll';
  else Result := 'visible'; end;
end;

{ TUniDSAFlexOptions }

constructor TUniDSAFlexOptions.Create(AOwner: TUniDSAFlexPanel);
begin
  inherited Create;
  FOwner := AOwner;
  FDirection := fdRow;
  FWrap := fwWrap;
  FJustifyContent := fjStart;
  FAlignItems := faStretch;
  FAlignContent := faStretch;
  FGap := 12;
  FRowGap := -1;
  FColumnGap := -1;
  FColumns := 12;
  FDefaultSpan := 0;
  FOverflow := foVisible;
end;

procedure TUniDSAFlexOptions.Assign(Source: TPersistent);
var LSource: TUniDSAFlexOptions;
begin
  if Source is TUniDSAFlexOptions then
  begin
    LSource := TUniDSAFlexOptions(Source);
    FDirection := LSource.FDirection;
    FWrap := LSource.FWrap;
    FJustifyContent := LSource.FJustifyContent;
    FAlignItems := LSource.FAlignItems;
    FAlignContent := LSource.FAlignContent;
    FGap := LSource.FGap;
    FRowGap := LSource.FRowGap;
    FColumnGap := LSource.FColumnGap;
    FPadding := LSource.FPadding;
    FColumns := LSource.FColumns;
    FDefaultSpan := LSource.FDefaultSpan;
    FOverflow := LSource.FOverflow;
    FAutoHeight := LSource.FAutoHeight;
    FAutoWidth := LSource.FAutoWidth;
    Changed;
  end else inherited;
end;

procedure TUniDSAFlexOptions.Changed;
begin
  if Assigned(FOwner) then FOwner.RefreshFlex;
end;

function TUniDSAFlexOptions.EffectiveColumnGap: Integer;
begin
  if FColumnGap >= 0 then Result := FColumnGap else Result := FGap;
end;

function TUniDSAFlexOptions.EffectiveRowGap: Integer;
begin
  if FRowGap >= 0 then Result := FRowGap else Result := FGap;
end;

procedure TUniDSAFlexOptions.SetAlignContent(const Value: TUniDSAFlexAlign);
begin if FAlignContent <> Value then begin FAlignContent := Value; Changed; end; end;
procedure TUniDSAFlexOptions.SetAlignItems(const Value: TUniDSAFlexAlign);
begin if FAlignItems <> Value then begin FAlignItems := Value; Changed; end; end;

procedure TUniDSAFlexOptions.SetAutoHeight(const Value: Boolean);
begin if FAutoHeight <> Value then begin FAutoHeight := Value; Changed; end; end;

procedure TUniDSAFlexOptions.SetAutoWidth(const Value: Boolean);
begin if FAutoWidth <> Value then begin FAutoWidth := Value; Changed; end; end;

procedure TUniDSAFlexOptions.SetColumnGap(const Value: Integer);
var LValue: Integer;
begin LValue := Max(-1, Value); if FColumnGap <> LValue then begin FColumnGap := LValue; Changed; end; end;

procedure TUniDSAFlexOptions.SetColumns(const Value: Integer);
var LValue: Integer;
begin LValue := ClampInt(Value, 1, 24); if FColumns <> LValue then begin FColumns := LValue; Changed; end; end;

procedure TUniDSAFlexOptions.SetDefaultSpan(const Value: Integer);
var LValue: Integer;
begin LValue := ClampInt(Value, 0, FColumns); if FDefaultSpan <> LValue then begin FDefaultSpan := LValue; Changed; end; end;

procedure TUniDSAFlexOptions.SetDirection(const Value: TUniDSAFlexDirection);
begin if FDirection <> Value then begin FDirection := Value; Changed; end; end;

procedure TUniDSAFlexOptions.SetGap(const Value: Integer);
var LValue: Integer;
begin LValue := Max(0, Value); if FGap <> LValue then begin FGap := LValue; Changed; end; end;

procedure TUniDSAFlexOptions.SetJustifyContent(const Value: TUniDSAFlexJustify);
begin if FJustifyContent <> Value then begin FJustifyContent := Value; Changed; end; end;
procedure TUniDSAFlexOptions.SetOverflow(const Value: TUniDSAFlexOverflow);
begin if FOverflow <> Value then begin FOverflow := Value; Changed; end; end;

procedure TUniDSAFlexOptions.SetPadding(const Value: Integer);
var LValue: Integer;
begin LValue := Max(0, Value); if FPadding <> LValue then begin FPadding := LValue; Changed; end; end;

procedure TUniDSAFlexOptions.SetRowGap(const Value: Integer);
var LValue: Integer;
begin LValue := Max(-1, Value); if FRowGap <> LValue then begin FRowGap := LValue; Changed; end; end;

procedure TUniDSAFlexOptions.SetWrap(const Value: TUniDSAFlexWrap);
begin if FWrap <> Value then begin FWrap := Value; Changed; end; end;

{ TUniDSAFlexItemOptions }

constructor TUniDSAFlexItemOptions.Create(AOwner: TUniDSAFlexPanel);
begin inherited Create; FOwner := AOwner; FShrink := 1; FBasis := 'auto'; FAlignSelf := fasAuto; end;

procedure TUniDSAFlexItemOptions.Assign(Source: TPersistent);
var LSource: TUniDSAFlexItemOptions;
begin
  if Source is TUniDSAFlexItemOptions then
  begin
    LSource := TUniDSAFlexItemOptions(Source);
    FGrow := LSource.FGrow; FShrink := LSource.FShrink; FBasis := LSource.FBasis;
    FOrder := LSource.FOrder; FAlignSelf := LSource.FAlignSelf; Changed;
  end else inherited;
end;

procedure TUniDSAFlexItemOptions.Changed;
begin if Assigned(FOwner) then FOwner.RefreshFlexItem; end;
procedure TUniDSAFlexItemOptions.SetAlignSelf(const Value: TUniDSAFlexAlignSelf);
begin if FAlignSelf <> Value then begin FAlignSelf := Value; Changed; end; end;

procedure TUniDSAFlexItemOptions.SetBasis(const Value: string);
var LValue: string;
begin LValue := Trim(Value); if LValue = '' then LValue := 'auto'; if FBasis <> LValue then begin FBasis := LValue; Changed; end; end;

procedure TUniDSAFlexItemOptions.SetGrow(const Value: Integer);
var LValue: Integer;
begin LValue := Max(0, Value); if FGrow <> LValue then begin FGrow := LValue; Changed; end; end;
procedure TUniDSAFlexItemOptions.SetOrder(const Value: Integer);
begin if FOrder <> Value then begin FOrder := Value; Changed; end; end;

procedure TUniDSAFlexItemOptions.SetShrink(const Value: Integer);
var LValue: Integer;
begin LValue := Max(0, Value); if FShrink <> LValue then begin FShrink := LValue; Changed; end; end;

{ TUniDSAResponsiveSpan }

constructor TUniDSAResponsiveSpan.Create(AOwner: TUniDSAFlexPanel; ADefaultSpan: Integer);
begin inherited Create; FOwner := AOwner; FSpan := ClampInt(ADefaultSpan, 0, 24); end;

procedure TUniDSAResponsiveSpan.Assign(Source: TPersistent);
begin if Source is TUniDSAResponsiveSpan then SetSpan(TUniDSAResponsiveSpan(Source).FSpan) else inherited; end;

procedure TUniDSAResponsiveSpan.SetSpan(const Value: Integer);
var LValue: Integer;
begin
  LValue := ClampInt(Value, 0, 24);
  if FSpan <> LValue then begin FSpan := LValue; if Assigned(FOwner) then FOwner.RefreshFlexItem; end;
end;

{ TUniDSAResponsiveOptions }

constructor TUniDSAResponsiveOptions.Create(AOwner: TUniDSAFlexPanel);
begin
  inherited Create; FOwner := AOwner;
  FXS := TUniDSAResponsiveSpan.Create(AOwner, 12);
  FSM := TUniDSAResponsiveSpan.Create(AOwner); FMD := TUniDSAResponsiveSpan.Create(AOwner);
  FLG := TUniDSAResponsiveSpan.Create(AOwner); FXL := TUniDSAResponsiveSpan.Create(AOwner);
  FXXL := TUniDSAResponsiveSpan.Create(AOwner);
end;

destructor TUniDSAResponsiveOptions.Destroy;
begin FXXL.Free; FXL.Free; FLG.Free; FMD.Free; FSM.Free; FXS.Free; inherited; end;

procedure TUniDSAResponsiveOptions.Assign(Source: TPersistent);
var LSource: TUniDSAResponsiveOptions;
begin
  if Source is TUniDSAResponsiveOptions then
  begin
    LSource := TUniDSAResponsiveOptions(Source);
    FXS.Assign(LSource.FXS); FSM.Assign(LSource.FSM); FMD.Assign(LSource.FMD);
    FLG.Assign(LSource.FLG); FXL.Assign(LSource.FXL); FXXL.Assign(LSource.FXXL);
  end else inherited;
end;

procedure TUniDSAResponsiveOptions.SetLG(const Value: TUniDSAResponsiveSpan); begin FLG.Assign(Value); end;
procedure TUniDSAResponsiveOptions.SetMD(const Value: TUniDSAResponsiveSpan); begin FMD.Assign(Value); end;
procedure TUniDSAResponsiveOptions.SetSM(const Value: TUniDSAResponsiveSpan); begin FSM.Assign(Value); end;
procedure TUniDSAResponsiveOptions.SetXL(const Value: TUniDSAResponsiveSpan); begin FXL.Assign(Value); end;
procedure TUniDSAResponsiveOptions.SetXS(const Value: TUniDSAResponsiveSpan); begin FXS.Assign(Value); end;
procedure TUniDSAResponsiveOptions.SetXXL(const Value: TUniDSAResponsiveSpan); begin FXXL.Assign(Value); end;

function TUniDSAResponsiveOptions.SpanFor(ABreakpoint: TUniDSABreakpoint): Integer;
var LSpans: array[TUniDSABreakpoint] of Integer; LBreakpoint: TUniDSABreakpoint;
begin
  LSpans[bpXS] := FXS.Span; LSpans[bpSM] := FSM.Span; LSpans[bpMD] := FMD.Span;
  LSpans[bpLG] := FLG.Span; LSpans[bpXL] := FXL.Span; LSpans[bpXXL] := FXXL.Span;
  Result := 0;
  for LBreakpoint := bpXS to ABreakpoint do if LSpans[LBreakpoint] > 0 then Result := LSpans[LBreakpoint];
end;

{ TUniDSAFlexChildSpan }

constructor TUniDSAFlexChildSpan.Create(AOwner: TUniDSAFlexChildItem);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TUniDSAFlexChildSpan.Assign(Source: TPersistent);
begin
  if Source is TUniDSAFlexChildSpan then
    SetSpan(TUniDSAFlexChildSpan(Source).FSpan)
  else
    inherited;
end;

procedure TUniDSAFlexChildSpan.SetSpan(const Value: Integer);
var
  LValue: Integer;
begin
  LValue := ClampInt(Value, 0, 24);
  if FSpan <> LValue then
  begin
    FSpan := LValue;
    if Assigned(FOwner) then
      FOwner.Changed;
  end;
end;

{ TUniDSAFlexChildResponsiveOptions }

constructor TUniDSAFlexChildResponsiveOptions.Create(AOwner: TUniDSAFlexChildItem);
begin
  inherited Create;
  FOwner := AOwner;
  FXS := TUniDSAFlexChildSpan.Create(AOwner);
  FSM := TUniDSAFlexChildSpan.Create(AOwner);
  FMD := TUniDSAFlexChildSpan.Create(AOwner);
  FLG := TUniDSAFlexChildSpan.Create(AOwner);
  FXL := TUniDSAFlexChildSpan.Create(AOwner);
  FXXL := TUniDSAFlexChildSpan.Create(AOwner);
end;

destructor TUniDSAFlexChildResponsiveOptions.Destroy;
begin
  FXXL.Free;
  FXL.Free;
  FLG.Free;
  FMD.Free;
  FSM.Free;
  FXS.Free;
  inherited;
end;

procedure TUniDSAFlexChildResponsiveOptions.Assign(Source: TPersistent);
var
  LSource: TUniDSAFlexChildResponsiveOptions;
begin
  if Source is TUniDSAFlexChildResponsiveOptions then
  begin
    LSource := TUniDSAFlexChildResponsiveOptions(Source);
    FXS.Assign(LSource.FXS);
    FSM.Assign(LSource.FSM);
    FMD.Assign(LSource.FMD);
    FLG.Assign(LSource.FLG);
    FXL.Assign(LSource.FXL);
    FXXL.Assign(LSource.FXXL);
  end
  else
    inherited;
end;

procedure TUniDSAFlexChildResponsiveOptions.SetLG(const Value: TUniDSAFlexChildSpan);
begin FLG.Assign(Value); end;
procedure TUniDSAFlexChildResponsiveOptions.SetMD(const Value: TUniDSAFlexChildSpan);
begin FMD.Assign(Value); end;
procedure TUniDSAFlexChildResponsiveOptions.SetSM(const Value: TUniDSAFlexChildSpan);
begin FSM.Assign(Value); end;
procedure TUniDSAFlexChildResponsiveOptions.SetXL(const Value: TUniDSAFlexChildSpan);
begin FXL.Assign(Value); end;
procedure TUniDSAFlexChildResponsiveOptions.SetXS(const Value: TUniDSAFlexChildSpan);
begin FXS.Assign(Value); end;
procedure TUniDSAFlexChildResponsiveOptions.SetXXL(const Value: TUniDSAFlexChildSpan);
begin FXXL.Assign(Value); end;

function TUniDSAFlexChildResponsiveOptions.SpanFor(
  ABreakpoint: TUniDSABreakpoint): Integer;
var
  LSpans: array[TUniDSABreakpoint] of Integer;
  LBreakpoint: TUniDSABreakpoint;
begin
  LSpans[bpXS] := FXS.Span;
  LSpans[bpSM] := FSM.Span;
  LSpans[bpMD] := FMD.Span;
  LSpans[bpLG] := FLG.Span;
  LSpans[bpXL] := FXL.Span;
  LSpans[bpXXL] := FXXL.Span;
  Result := 0;
  for LBreakpoint := bpXS to ABreakpoint do
    if LSpans[LBreakpoint] > 0 then
      Result := LSpans[LBreakpoint];
end;

{ TUniDSAFlexChildItem }

constructor TUniDSAFlexChildItem.Create(Collection: TCollection);
begin
  inherited;
  FShrink := 1;
  FBasis := 'auto';
  FAlignSelf := fasAuto;
  FResponsive := TUniDSAFlexChildResponsiveOptions.Create(Self);
end;

destructor TUniDSAFlexChildItem.Destroy;
var
  LOwner: TUniDSAFlexPanel;
begin
  LOwner := OwnerPanel;
  if Assigned(FControl) and Assigned(LOwner) then
    FControl.RemoveFreeNotification(LOwner);
  FResponsive.Free;
  inherited;
end;

procedure TUniDSAFlexChildItem.Assign(Source: TPersistent);
var
  LSource: TUniDSAFlexChildItem;
begin
  if Source is TUniDSAFlexChildItem then
  begin
    LSource := TUniDSAFlexChildItem(Source);
    SetControl(LSource.FControl);
    FGrow := LSource.FGrow;
    FShrink := LSource.FShrink;
    FBasis := LSource.FBasis;
    FOrder := LSource.FOrder;
    FAlignSelf := LSource.FAlignSelf;
    FResponsive.Assign(LSource.FResponsive);
    Changed;
  end
  else
    inherited;
end;

procedure TUniDSAFlexChildItem.Changed;
begin
  inherited Changed(False);
end;

function TUniDSAFlexChildItem.GetDisplayName: string;
begin
  if Assigned(FControl) and (FControl.Name <> '') then
    Result := FControl.Name
  else
    Result := inherited GetDisplayName;
end;

function TUniDSAFlexChildItem.OwnerPanel: TUniDSAFlexPanel;
begin
  if Assigned(Collection) and (Collection.Owner is TUniDSAFlexPanel) then
    Result := TUniDSAFlexPanel(Collection.Owner)
  else
    Result := nil;
end;

procedure TUniDSAFlexChildItem.SetAlignSelf(const Value: TUniDSAFlexAlignSelf);
begin
  if FAlignSelf <> Value then
  begin
    FAlignSelf := Value;
    Changed;
  end;
end;

procedure TUniDSAFlexChildItem.SetBasis(const Value: string);
var
  LValue: string;
begin
  LValue := Trim(Value);
  if LValue = '' then
    LValue := 'auto';
  if FBasis <> LValue then
  begin
    FBasis := LValue;
    Changed;
  end;
end;

procedure TUniDSAFlexChildItem.SetControl(const Value: TUniControl);
var
  LExisting: TUniDSAFlexChildItem;
  LOwner: TUniDSAFlexPanel;
begin
  if FControl = Value then
    Exit;
  LOwner := OwnerPanel;
  if Assigned(Value) and Assigned(LOwner) then
  begin
    LExisting := LOwner.FlexItems.FindByControl(Value);
    if Assigned(LExisting) and (LExisting <> Self) then
      raise EComponentError.CreateFmt(
        'O controle %s ja possui uma entrada em FlexItems.', [Value.Name]);
  end;
  if Assigned(FControl) and Assigned(LOwner) then
    FControl.RemoveFreeNotification(LOwner);
  FControl := Value;
  if Assigned(FControl) and Assigned(LOwner) then
    FControl.FreeNotification(LOwner);
  Changed;
end;

procedure TUniDSAFlexChildItem.SetGrow(const Value: Integer);
var
  LValue: Integer;
begin
  LValue := Max(0, Value);
  if FGrow <> LValue then
  begin
    FGrow := LValue;
    Changed;
  end;
end;

procedure TUniDSAFlexChildItem.SetOrder(const Value: Integer);
begin
  if FOrder <> Value then
  begin
    FOrder := Value;
    Changed;
  end;
end;

procedure TUniDSAFlexChildItem.SetResponsive(
  const Value: TUniDSAFlexChildResponsiveOptions);
begin
  FResponsive.Assign(Value);
end;

procedure TUniDSAFlexChildItem.SetShrink(const Value: Integer);
var
  LValue: Integer;
begin
  LValue := Max(0, Value);
  if FShrink <> LValue then
  begin
    FShrink := LValue;
    Changed;
  end;
end;

{ TUniDSAFlexChildItems }

constructor TUniDSAFlexChildItems.Create(AOwner: TUniDSAFlexPanel);
begin
  inherited Create(AOwner, TUniDSAFlexChildItem);
end;

function TUniDSAFlexChildItems.Add: TUniDSAFlexChildItem;
begin
  Result := inherited Add as TUniDSAFlexChildItem;
end;

function TUniDSAFlexChildItems.FindByControl(
  AControl: TControl): TUniDSAFlexChildItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Control = AControl then
      Exit(Items[I]);
end;

function TUniDSAFlexChildItems.GetItem(Index: Integer): TUniDSAFlexChildItem;
begin
  Result := inherited GetItem(Index) as TUniDSAFlexChildItem;
end;

procedure TUniDSAFlexChildItems.SetItem(Index: Integer;
  const Value: TUniDSAFlexChildItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TUniDSAFlexChildItems.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner is TUniDSAFlexPanel then
    TUniDSAFlexPanel(Owner).RefreshFlexItems;
end;

{ TUniDSAFlexPanel }

constructor TUniDSAFlexPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csSetCaption];
  FFlex := TUniDSAFlexOptions.Create(Self);
  FFlexItem := TUniDSAFlexItemOptions.Create(Self);
  FResponsive := TUniDSAResponsiveOptions.Create(Self);
  FFlexItems := TUniDSAFlexChildItems.Create(Self);
  FDesignPreview := dpAuto;
  ParentAlignmentControl := False;
  AlignmentControl := uniAlignmentClient;
  Layout := 'auto';
  Width := 320;
  Height := 160;
end;

destructor TUniDSAFlexPanel.Destroy;
begin
  FFlexItems.Free;
  FResponsive.Free;
  FFlexItem.Free;
  FFlex.Free;
  inherited;
end;

function TUniDSAFlexPanel.BuildContainerConfig: string;
begin
  Result := '{direction:' + UniDSAJSString(FlexDirectionJS(FFlex.Direction)) +
    ',wrap:' + UniDSAJSString(FlexWrapJS(FFlex.Wrap)) +
    ',justifyContent:' + UniDSAJSString(FlexJustifyJS(FFlex.JustifyContent)) +
    ',alignItems:' + UniDSAJSString(FlexAlignJS(FFlex.AlignItems)) +
    ',alignContent:' + UniDSAJSString(FlexAlignJS(FFlex.AlignContent)) +
    ',gap:' + IntToStr(FFlex.Gap) + ',rowGap:' + IntToStr(FFlex.EffectiveRowGap) +
    ',columnGap:' + IntToStr(FFlex.EffectiveColumnGap) + ',padding:' + IntToStr(FFlex.Padding) +
    ',columns:' + IntToStr(FFlex.Columns) + ',defaultSpan:' + IntToStr(FFlex.DefaultSpan) +
    ',overflow:' + UniDSAJSString(FlexOverflowJS(FFlex.Overflow)) +
    ',autoHeight:' + LowerCase(BoolToStr(FFlex.AutoHeight, True)) +
    ',autoWidth:' + LowerCase(BoolToStr(FFlex.AutoWidth, True)) +
    ',breakpoints:{sm:576,md:768,lg:992,xl:1200,xxl:1400}}';
end;

function TUniDSAFlexPanel.BuildItemConfig: string;
begin
  Result := '{grow:' + IntToStr(FFlexItem.Grow) + ',shrink:' + IntToStr(FFlexItem.Shrink) +
    ',basis:' + UniDSAJSString(FFlexItem.Basis) + ',order:' + IntToStr(FFlexItem.Order) +
    ',alignSelf:' + UniDSAJSString(FlexAlignSelfJS(FFlexItem.AlignSelf)) +
    ',spans:{xs:' + IntToStr(FResponsive.XS.Span) + ',sm:' + IntToStr(FResponsive.SM.Span) +
    ',md:' + IntToStr(FResponsive.MD.Span) + ',lg:' + IntToStr(FResponsive.LG.Span) +
    ',xl:' + IntToStr(FResponsive.XL.Span) + ',xxl:' + IntToStr(FResponsive.XXL.Span) + '}}';
end;

function TUniDSAFlexPanel.BuildChildItemsConfig: string;
var
  I: Integer;
  LItem: TUniDSAFlexChildItem;
  LHasItem: Boolean;
begin
  Result := '{';
  LHasItem := False;
  for I := 0 to FFlexItems.Count - 1 do
  begin
    LItem := FFlexItems[I];
    { O FormRegion de um TUniFrame pertence ao frame no VCL, embora seu
      componente Ext JS seja filho deste FlexPanel. O runtime percorre somente
      os próprios itens, portanto referências externas são ignoradas com segurança. }
    if not Assigned(LItem.Control) or (LItem.Control.JSId = '') then
      Continue;
    if LHasItem then
      Result := Result + ',';
    Result := Result + UniDSAJSString(LItem.Control.JSId) + ':{grow:' +
      IntToStr(LItem.Grow) + ',shrink:' + IntToStr(LItem.Shrink) +
      ',basis:' + UniDSAJSString(LItem.Basis) + ',order:' +
      IntToStr(LItem.Order) + ',alignSelf:' +
      UniDSAJSString(FlexAlignSelfJS(LItem.AlignSelf)) + ',spans:{xs:' +
      IntToStr(LItem.Responsive.XS.Span) + ',sm:' +
      IntToStr(LItem.Responsive.SM.Span) + ',md:' +
      IntToStr(LItem.Responsive.MD.Span) + ',lg:' +
      IntToStr(LItem.Responsive.LG.Span) + ',xl:' +
      IntToStr(LItem.Responsive.XL.Span) + ',xxl:' +
      IntToStr(LItem.Responsive.XXL.Span) + '}}';
    LHasItem := True;
  end;
  Result := Result + '}';
end;

procedure TUniDSAFlexPanel.ConfigJSClasses(ALoading: Boolean);
begin JSObjects.DefaultJSClassName := 'UniDSA.container.Flex'; end;

function TUniDSAFlexPanel.DesignBreakpoint: TUniDSABreakpoint;
begin
  case FDesignPreview of
    dpPhone: Result := bpXS; dpTablet: Result := bpMD; dpDesktop: Result := bpLG; dpWide: Result := bpXXL;
  else
    if Width >= 1400 then Result := bpXXL else if Width >= 1200 then Result := bpXL
    else if Width >= 992 then Result := bpLG else if Width >= 768 then Result := bpMD
    else if Width >= 576 then Result := bpSM else Result := bpXS;
  end;
end;

function TUniDSAFlexPanel.DesignChildSpan(AControl: TControl): Integer;
var
  LItem: TUniDSAFlexChildItem;
begin
  LItem := FFlexItems.FindByControl(AControl);
  if Assigned(LItem) then
    Result := LItem.Responsive.SpanFor(DesignBreakpoint)
  else if AControl is TUniDSAFlexPanel then
    Result := TUniDSAFlexPanel(AControl).Responsive.SpanFor(DesignBreakpoint)
  else
    Result := 0;
  if Result = 0 then
    Result := FFlex.DefaultSpan;
  Result := ClampInt(Result, 0, FFlex.Columns);
end;

function TUniDSAFlexPanel.DesignChildOrder(AControl: TControl): Integer;
var
  LItem: TUniDSAFlexChildItem;
begin
  LItem := FFlexItems.FindByControl(AControl);
  if Assigned(LItem) then
    Result := LItem.Order
  else if AControl is TUniDSAFlexPanel then
    Result := TUniDSAFlexPanel(AControl).FlexItem.Order
  else
    Result := 0;
end;

function TUniDSAFlexPanel.DesignChildAlignSelf(
  AControl: TControl): TUniDSAFlexAlignSelf;
var
  LItem: TUniDSAFlexChildItem;
begin
  LItem := FFlexItems.FindByControl(AControl);
  if Assigned(LItem) then
    Result := LItem.AlignSelf
  else if AControl is TUniDSAFlexPanel then
    Result := TUniDSAFlexPanel(AControl).FlexItem.AlignSelf
  else
    Result := fasAuto;
end;

function TUniDSAFlexPanel.GetDesignJSClassName(const AJSClassName: string): string;
begin Result := 'Ext.container.Container'; end;

function TUniDSAFlexPanel.InsertControl(AControl: TControl): TControl;
begin
  Result := inherited InsertControl(AControl);
  RefreshFlexItems;
end;

procedure TUniDSAFlexPanel.InitComponent;
begin
  // LoadCompleted exceptions are collected as native alerts by uniGUI.
  // InitComponent runs before JSCreateControl, including during AJAX form creation.
  UniDSASource.CheckAssets(Self);
  inherited;
end;

procedure TUniDSAFlexPanel.LoadCompleted;
begin
  inherited;
  UpdateDesignLayout;
  JSConfig('dsaFlex', [JSStatement(BuildContainerConfig)]);
  JSConfig('dsaFlexItem', [JSStatement(BuildItemConfig)]);
  JSConfig('dsaFlexItems', [JSStatement(BuildChildItemsConfig)]);
end;

procedure TUniDSAFlexPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if (Operation = opRemove) and Assigned(FFlexItems) then
    for I := FFlexItems.Count - 1 downto 0 do
      if FFlexItems[I].Control = AComponent then
        FFlexItems[I].Control := nil;
end;

procedure TUniDSAFlexPanel.RefreshFlex;
begin
  UpdateDesignLayout;
  if WebMode and (not IsLoading) then JSCall('setDsaFlexConfig', [JSStatement(BuildContainerConfig)]);
end;

procedure TUniDSAFlexPanel.RefreshFlexItem;
begin
  UpdateDesignLayout;
  if Assigned(Parent) and (Parent is TUniDSAFlexPanel) then TUniDSAFlexPanel(Parent).UpdateDesignLayout;
  if WebMode and (not IsLoading) then JSCall('setDsaFlexItemConfig', [JSStatement(BuildItemConfig)]);
end;

procedure TUniDSAFlexPanel.RefreshFlexItems;
begin
  UpdateDesignLayout;
  if WebMode and (not IsLoading) then
    JSCall('setDsaFlexItemsConfig', [JSStatement(BuildChildItemsConfig)]);
end;

procedure TUniDSAFlexPanel.RolarParaFim;
begin
  if WebMode and (not IsLoading) then
    JSCall('scrollToEnd', []);
end;

procedure TUniDSAFlexPanel.RemoveControl(AControl: TControl);
begin
  inherited RemoveControl(AControl);
  RefreshFlexItems;
end;

procedure TUniDSAFlexPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  LSizeChanged: Boolean;
begin
  LSizeChanged := (Width <> AWidth) or (Height <> AHeight);
  inherited;
  UpdateDesignLayout;
  if LSizeChanged and (csDesigning in ComponentState) and
    not (csLoading in ComponentState) and (Parent is TUniDSAFlexPanel) then
    TUniDSAFlexPanel(Parent).UpdateDesignLayout;
end;

procedure TUniDSAFlexPanel.SetDesignPreview(const Value: TUniDSADesignPreview);
begin if FDesignPreview <> Value then begin FDesignPreview := Value; UpdateDesignLayout; end; end;
procedure TUniDSAFlexPanel.SetFlex(const Value: TUniDSAFlexOptions); begin FFlex.Assign(Value); end;
procedure TUniDSAFlexPanel.SetFlexItem(const Value: TUniDSAFlexItemOptions); begin FFlexItem.Assign(Value); end;
procedure TUniDSAFlexPanel.SetFlexItems(const Value: TUniDSAFlexChildItems); begin FFlexItems.Assign(Value); end;
procedure TUniDSAFlexPanel.SetResponsive(const Value: TUniDSAResponsiveOptions); begin FResponsive.Assign(Value); end;

procedure TUniDSAFlexPanel.UpdateDesignLayout;
type
  TPreviewItem = record
    Control: TControl;
    MainSize, CrossSize: Integer;
  end;
  TPreviewLine = record
    First, Count, MainSize: Integer;
    CrossSize: Double;
  end;
var
  LControls: TList;
  LControl: TControl;
  LItems: TArray<TPreviewItem>;
  LLines: TArray<TPreviewLine>;
  I, J, LLineIndex, LOrder, LCompareIndex, LPadding, LMainGap, LCrossGap,
    LAvailableWidth, LMainExtent, LCrossExtent, LWidth, LHeight, LSpan,
    LContentWidth, LContentHeight, LMainPos, LCrossPos, LCrossSize: Integer;
  LIsColumn, LReverse, LWrapReverse, LAutoMain, LAutoCross, LSizeChanged: Boolean;
  LCrossTotal, LCrossCursor, LMainCursor, LFree, LExtraGap, LOffset: Double;
  LAlign: TUniDSAFlexAlign;

  function EffectiveAlign(AControl: TControl): TUniDSAFlexAlign;
  begin
    case DesignChildAlignSelf(AControl) of
      fasStretch: Result := faStretch;
      fasStart: Result := faStart;
      fasCenter: Result := faCenter;
      fasEnd: Result := faEnd;
      fasBaseline: Result := faBaseline;
    else
      Result := FFlex.AlignItems;
    end;
    if (Result = faStretch) and (AControl is TUniDSAFlexPanel) then
      if ((not LIsColumn) and TUniDSAFlexPanel(AControl).Flex.AutoHeight) or
         (LIsColumn and TUniDSAFlexPanel(AControl).Flex.AutoWidth) then
        Result := faStart;
  end;

  function NaturalWidth(AControl: TControl): Integer;
  var
    Panel: TUniDSAFlexPanel;
    K, Count, ChildWidth: Integer;
  begin
    Result := AControl.Width;
    if not (AControl is TUniDSAFlexPanel) then Exit;
    Panel := TUniDSAFlexPanel(AControl);
    Result := 0;
    Count := 0;
    // Column stretching clears the declared CSS width. Empty FlexPanels have
    // no intrinsic width; nested contents still contribute to their line.
    for K := 0 to Panel.ControlCount - 1 do
      if Panel.Controls[K].Visible then
      begin
        ChildWidth := Panel.Controls[K].Width;
        if Panel.Flex.Direction in [fdColumn, fdColumnReverse] then
          Result := Max(Result, ChildWidth)
        else
        begin
          if Count > 0 then Inc(Result, Panel.Flex.EffectiveColumnGap);
          Inc(Result, ChildWidth);
        end;
        Inc(Count);
      end;
    Inc(Result, 2 * Panel.Flex.Padding);
  end;
  procedure DistributeMain(AFree: Double; ACount: Integer);
  begin
    LOffset := 0;
    LExtraGap := 0;
    case FFlex.JustifyContent of
      fjCenter: LOffset := AFree / 2;
      fjEnd: LOffset := AFree;
      fjSpaceBetween:
        if (ACount > 1) and (AFree > 0) then
          LExtraGap := AFree / (ACount - 1);
      fjSpaceAround:
        begin
          LOffset := AFree / 2;
          if AFree > 0 then
          begin
            LExtraGap := AFree / ACount;
            LOffset := LExtraGap / 2;
          end;
        end;
      fjSpaceEvenly:
        begin
          LOffset := AFree / 2;
          if AFree > 0 then
          begin
            LExtraGap := AFree / (ACount + 1);
            LOffset := LExtraGap;
          end;
        end;
    end;
  end;
begin
  if FUpdatingDesignLayout or not (csDesigning in ComponentState) or
    (csLoading in ComponentState) or (csDestroying in ComponentState) or
    not Assigned(FFlex) or not Assigned(Parent) then Exit;
  FUpdatingDesignLayout := True;
  LControls := TList.Create;
  try
    for I := 0 to ControlCount - 1 do
      if Controls[I].Visible then LControls.Add(Controls[I]);
    // Keep source order for equal Order values. Reverse changes the axis, not
    // the order in which items are collected into flex lines.
    for I := 1 to LControls.Count - 1 do
    begin
      LControl := TControl(LControls[I]);
      LOrder := DesignChildOrder(LControl);
      LCompareIndex := I - 1;
      while (LCompareIndex >= 0) and
        (DesignChildOrder(TControl(LControls[LCompareIndex])) > LOrder) do
      begin
        LControls[LCompareIndex + 1] := LControls[LCompareIndex];
        Dec(LCompareIndex);
      end;
      LControls[LCompareIndex + 1] := LControl;
    end;
    LPadding := FFlex.Padding;
    LIsColumn := FFlex.Direction in [fdColumn, fdColumnReverse];
    LReverse := FFlex.Direction in [fdRowReverse, fdColumnReverse];
    LWrapReverse := FFlex.Wrap = fwWrapReverse;
    LSizeChanged := False;
    if LIsColumn then
    begin
      LMainGap := FFlex.EffectiveRowGap;
      LCrossGap := FFlex.EffectiveColumnGap;
      LAutoMain := FFlex.AutoHeight;
      LAutoCross := FFlex.AutoWidth;
    end
    else
    begin
      LMainGap := FFlex.EffectiveColumnGap;
      LCrossGap := FFlex.EffectiveRowGap;
      LAutoMain := False; // fit-content width still wraps at the parent's width.
      LAutoCross := FFlex.AutoHeight;
    end;

    if FFlex.AutoWidth then
    begin
      LContentWidth := 0;
      for I := 0 to LControls.Count - 1 do
        if LIsColumn then
          LContentWidth := Max(LContentWidth, TControl(LControls[I]).Width)
        else
        begin
          Inc(LContentWidth, Max(1, TControl(LControls[I]).Width));
          if I > 0 then Inc(LContentWidth, LMainGap);
        end;
      LContentWidth := Min(Max(1, LContentWidth + 2 * LPadding),
        Max(1, Parent.ClientWidth));
      if Width <> LContentWidth then
      begin
        inherited SetBounds(Left, Top, LContentWidth, Height);
        LSizeChanged := True;
      end;
    end;
    LAvailableWidth := Max(1, Width - 2 * LPadding);
    if LIsColumn then
    begin
      LMainExtent := Max(0, Height - 2 * LPadding);
      LCrossExtent := LAvailableWidth;
    end
    else
    begin
      LMainExtent := LAvailableWidth;
      LCrossExtent := Max(0, Height - 2 * LPadding);
    end;

    SetLength(LItems, LControls.Count);
    SetLength(LLines, LControls.Count);
    LLineIndex := -1;
    for I := 0 to LControls.Count - 1 do
    begin
      LControl := TControl(LControls[I]);
      LWidth := Max(1, LControl.Width);
      if not LIsColumn then
      begin
        LSpan := DesignChildSpan(LControl);
        if LSpan > 0 then
          LWidth := Max(1, Round((LAvailableWidth + LMainGap) *
            LSpan / Max(1, FFlex.Columns) - LMainGap));
      end;
      // Measure nested AutoHeight panels after applying their responsive width.
      if LWidth <> LControl.Width then
        LControl.SetBounds(LControl.Left, LControl.Top, LWidth, LControl.Height);
      LHeight := Max(1, LControl.Height);
      LItems[I].Control := LControl;
      if LIsColumn and (EffectiveAlign(LControl) = faStretch) then
        LWidth := NaturalWidth(LControl);
      if LIsColumn then
      begin
        LItems[I].MainSize := LHeight;
        LItems[I].CrossSize := LWidth;
      end
      else
      begin
        LItems[I].MainSize := LWidth;
        LItems[I].CrossSize := LHeight;
      end;
      if (LLineIndex < 0) or ((FFlex.Wrap <> fwNoWrap) and not LAutoMain and
        (LLines[LLineIndex].MainSize + LMainGap + LItems[I].MainSize > LMainExtent)) then
      begin
        Inc(LLineIndex);
        LLines[LLineIndex].First := I;
      end;
      with LLines[LLineIndex] do
      begin
        if Count > 0 then Inc(MainSize, LMainGap);
        Inc(Count);
        Inc(MainSize, LItems[I].MainSize);
        CrossSize := Max(CrossSize, LItems[I].CrossSize);
      end;
    end;
    SetLength(LLines, LLineIndex + 1);
    LCrossTotal := 0;
    for I := 0 to High(LLines) do
    begin
      if I > 0 then LCrossTotal := LCrossTotal + LCrossGap;
      LCrossTotal := LCrossTotal + LLines[I].CrossSize;
    end;
    if LAutoMain then
    begin
      LMainExtent := 0;
      for I := 0 to High(LLines) do
        LMainExtent := Max(LMainExtent, LLines[I].MainSize);
    end;
    if LAutoCross then LCrossExtent := Round(LCrossTotal);
    LContentWidth := Width;
    LContentHeight := Height;
    if FFlex.AutoHeight then
      if LIsColumn then LContentHeight := Max(1, LMainExtent + 2 * LPadding)
      else LContentHeight := Max(1, LCrossExtent + 2 * LPadding);
    if FFlex.AutoWidth and LIsColumn then
      LContentWidth := Max(1, LCrossExtent + 2 * LPadding);
    if (Width <> LContentWidth) or (Height <> LContentHeight) then
    begin
      inherited SetBounds(Left, Top, LContentWidth, LContentHeight);
      LSizeChanged := True;
    end;

    LCrossCursor := 0;
    LFree := LCrossExtent - LCrossTotal;
    if (FFlex.Wrap = fwNoWrap) and (Length(LLines) = 1) then
      LLines[0].CrossSize := LCrossExtent
    else
      case FFlex.AlignContent of
        faCenter: LCrossCursor := LFree / 2;
        faEnd: LCrossCursor := LFree;
        faStretch:
          if (LFree > 0) and (Length(LLines) > 0) then
            for I := 0 to High(LLines) do
              LLines[I].CrossSize := LLines[I].CrossSize + LFree / Length(LLines);
      end;

    for I := 0 to High(LLines) do
    begin
      DistributeMain(LMainExtent - LLines[I].MainSize, LLines[I].Count);
      LMainCursor := LOffset;
      for J := LLines[I].First to LLines[I].First + LLines[I].Count - 1 do
      begin
        LControl := LItems[J].Control;
        LCrossSize := LItems[J].CrossSize;
        LAlign := EffectiveAlign(LControl);
        // The browser explicitly stretches widths in column containers. Row
        // children retain their declared heights, including AutoHeight panels.
        if LIsColumn and (LAlign = faStretch) then
          LCrossSize := Max(1, Round(LLines[I].CrossSize));
        LOffset := 0;
        case LAlign of
          faCenter: LOffset := (LLines[I].CrossSize - LCrossSize) / 2;
          faEnd: LOffset := LLines[I].CrossSize - LCrossSize;
        end;
        LMainPos := Round(LMainCursor);
        LCrossPos := Round(LCrossCursor + LOffset);
        if LReverse then LMainPos := LMainExtent - LMainPos - LItems[J].MainSize;
        if LWrapReverse then LCrossPos := LCrossExtent - LCrossPos - LCrossSize;
        if LIsColumn then
          LControl.SetBounds(LPadding + LCrossPos, LPadding + LMainPos,
            LCrossSize, LItems[J].MainSize)
        else
          LControl.SetBounds(LPadding + LMainPos, LPadding + LCrossPos,
            LItems[J].MainSize, LCrossSize);
        LMainCursor := LMainCursor + LItems[J].MainSize + LMainGap + LExtraGap;
      end;
      LCrossCursor := LCrossCursor + LLines[I].CrossSize + LCrossGap;
    end;
    if LSizeChanged and (Parent is TUniDSAFlexPanel) then
      TUniDSAFlexPanel(Parent).UpdateDesignLayout;
  finally
    LControls.Free;
    FUpdatingDesignLayout := False;
  end;
end;

function TUniDSAFlexPanel.VCLControlClassName: string;
begin Result := 'TVCLPanel'; end;

procedure Register;
begin RegisterComponents('UniDSA', [TUniDSAFlexPanel]); end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.Flex);

end.
