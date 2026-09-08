unit UniDSAResponsivePageControl;

interface

uses
  System.Classes, Vcl.Graphics, uniPageControl;

type
  TUniDSATabOverflowMode = (tomMenu, tomScroller);
  TUniDSATabAlignment = (taCenter, taStart, taEnd);
  TUniDSAResponsivePageControl = class;

  TUniDSATabColors = class(TPersistent)
  private
    FOwner: TUniDSAResponsivePageControl;
    FBackgroundColor: TColor;
    FBorderColor: TColor;
    FTabColor: TColor;
    FTextColor: TColor;
    FHoverColor: TColor;
    FHoverTextColor: TColor;
    FActiveColor: TColor;
    FActiveTextColor: TColor;
    FActiveHoverColor: TColor;
    FFocusColor: TColor;
    FMenuColor: TColor;
    FDisabledTextColor: TColor;
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetTabColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
    procedure SetHoverColor(const Value: TColor);
    procedure SetHoverTextColor(const Value: TColor);
    procedure SetActiveColor(const Value: TColor);
    procedure SetActiveTextColor(const Value: TColor);
    procedure SetActiveHoverColor(const Value: TColor);
    procedure SetFocusColor(const Value: TColor);
    procedure SetMenuColor(const Value: TColor);
    procedure SetDisabledTextColor(const Value: TColor);
  public
    constructor Create(AOwner: TUniDSAResponsivePageControl);
    procedure Assign(Source: TPersistent); override;
  published
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default $00F9F5F1;
    property BorderColor: TColor read FBorderColor write SetBorderColor default $00F0E8E2;
    property TabColor: TColor read FTabColor write SetTabColor default clNone;
    property TextColor: TColor read FTextColor write SetTextColor default $00554133;
    property HoverColor: TColor read FHoverColor write SetHoverColor default clWhite;
    property HoverTextColor: TColor read FHoverTextColor write SetHoverTextColor default $002A170F;
    property ActiveColor: TColor read FActiveColor write SetActiveColor default $00EB6325;
    property ActiveTextColor: TColor read FActiveTextColor write SetActiveTextColor default clWhite;
    property ActiveHoverColor: TColor read FActiveHoverColor write SetActiveHoverColor default $00D84E1D;
    property FocusColor: TColor read FFocusColor write SetFocusColor default $00FDBF93;
    property MenuColor: TColor read FMenuColor write SetMenuColor default clWhite;
    property DisabledTextColor: TColor read FDisabledTextColor write SetDisabledTextColor default $00B8A394;
  end;

  TUniDSAResponsivePageControl = class(TUniPageControl)
  private
    FReady: Boolean;
    FTabColors: TUniDSATabColors;
    FTabAlignment: TUniDSATabAlignment;
    FTabOverflowMode: TUniDSATabOverflowMode;
    FKeepActiveTabVisible: Boolean;
    procedure SetTabColors(const Value: TUniDSATabColors);
    procedure SetTabAlignment(const Value: TUniDSATabAlignment);
    procedure SetTabOverflowMode(const Value: TUniDSATabOverflowMode);
    procedure SetKeepActiveTabVisible(const Value: Boolean);
    function OptionsJSON: string;
  protected
    procedure ConfigCreate; override;
    procedure LoadCompleted; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Apply;
  published
    property TabColors: TUniDSATabColors read FTabColors write SetTabColors;
    property TabAlignment: TUniDSATabAlignment read FTabAlignment
      write SetTabAlignment default taCenter;
    property TabOverflowMode: TUniDSATabOverflowMode read FTabOverflowMode
      write SetTabOverflowMode default tomMenu;
    property KeepActiveTabVisible: Boolean read FKeepActiveTabVisible
      write SetKeepActiveTabVisible default True;
  end;

procedure Register;

implementation

uses
  System.JSON, UniDSASource, UniDSAWebUtils;

constructor TUniDSATabColors.Create(AOwner: TUniDSAResponsivePageControl);
begin
  inherited Create;
  FOwner := AOwner;
  FBackgroundColor := $00F9F5F1;
  FBorderColor := $00F0E8E2;
  FTabColor := clNone;
  FTextColor := $00554133;
  FHoverColor := clWhite;
  FHoverTextColor := $002A170F;
  FActiveColor := $00EB6325;
  FActiveTextColor := clWhite;
  FActiveHoverColor := $00D84E1D;
  FFocusColor := $00FDBF93;
  FMenuColor := clWhite;
  FDisabledTextColor := $00B8A394;
end;

procedure TUniDSATabColors.Assign(Source: TPersistent);
begin
  if Source is TUniDSATabColors then begin
    FBackgroundColor := TUniDSATabColors(Source).FBackgroundColor;
    FBorderColor := TUniDSATabColors(Source).FBorderColor;
    FTabColor := TUniDSATabColors(Source).FTabColor;
    FTextColor := TUniDSATabColors(Source).FTextColor;
    FHoverColor := TUniDSATabColors(Source).FHoverColor;
    FHoverTextColor := TUniDSATabColors(Source).FHoverTextColor;
    FActiveColor := TUniDSATabColors(Source).FActiveColor;
    FActiveTextColor := TUniDSATabColors(Source).FActiveTextColor;
    FActiveHoverColor := TUniDSATabColors(Source).FActiveHoverColor;
    FFocusColor := TUniDSATabColors(Source).FFocusColor;
    FMenuColor := TUniDSATabColors(Source).FMenuColor;
    FDisabledTextColor := TUniDSATabColors(Source).FDisabledTextColor;
    FOwner.Apply;
  end
  else inherited;
end;

procedure TUniDSATabColors.SetBackgroundColor(const Value: TColor);
begin
  if FBackgroundColor = Value then Exit;
  FBackgroundColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetBorderColor(const Value: TColor);
begin
  if FBorderColor = Value then Exit;
  FBorderColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetTabColor(const Value: TColor);
begin
  if FTabColor = Value then Exit;
  FTabColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetTextColor(const Value: TColor);
begin
  if FTextColor = Value then Exit;
  FTextColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetHoverColor(const Value: TColor);
begin
  if FHoverColor = Value then Exit;
  FHoverColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetHoverTextColor(const Value: TColor);
begin
  if FHoverTextColor = Value then Exit;
  FHoverTextColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetActiveColor(const Value: TColor);
begin
  if FActiveColor = Value then Exit;
  FActiveColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetActiveTextColor(const Value: TColor);
begin
  if FActiveTextColor = Value then Exit;
  FActiveTextColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetActiveHoverColor(const Value: TColor);
begin
  if FActiveHoverColor = Value then Exit;
  FActiveHoverColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetFocusColor(const Value: TColor);
begin
  if FFocusColor = Value then Exit;
  FFocusColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetMenuColor(const Value: TColor);
begin
  if FMenuColor = Value then Exit;
  FMenuColor := Value;
  FOwner.Apply;
end;

procedure TUniDSATabColors.SetDisabledTextColor(const Value: TColor);
begin
  if FDisabledTextColor = Value then Exit;
  FDisabledTextColor := Value;
  FOwner.Apply;
end;

constructor TUniDSAResponsivePageControl.Create(AOwner: TComponent);
begin
  inherited;
  FTabColors := TUniDSATabColors.Create(Self);
  FTabAlignment := taCenter;
  FTabOverflowMode := tomMenu;
  FKeepActiveTabVisible := True;
end;

destructor TUniDSAResponsivePageControl.Destroy;
begin
  FReady := False;
  FTabColors.Free;
  inherited;
end;

function TUniDSAResponsivePageControl.OptionsJSON: string;
const
  CAlignment: array[TUniDSATabAlignment] of string = ('center', 'start', 'end');
  COverflow: array[TUniDSATabOverflowMode] of string = ('menu', 'scroller');
var
  LOptions, LColors: TJSONObject;

  procedure AddColor(const AName: string; AColor: TColor);
  begin
    if AColor = clNone then
      LColors.AddPair(AName, 'transparent')
    else
      LColors.AddPair(AName, UniDSAColorToCSS(AColor));
  end;

begin
  LOptions := TJSONObject.Create;
  try
    LOptions.AddPair('alignment', CAlignment[FTabAlignment]);
    LOptions.AddPair('overflow', COverflow[FTabOverflowMode]);
    LOptions.AddPair('keepActiveVisible', TJSONBool.Create(FKeepActiveTabVisible));
    LColors := TJSONObject.Create;
    LOptions.AddPair('colors', LColors);
    AddColor('background', FTabColors.BackgroundColor);
    AddColor('border', FTabColors.BorderColor);
    AddColor('tab', FTabColors.TabColor);
    AddColor('text', FTabColors.TextColor);
    AddColor('hover', FTabColors.HoverColor);
    AddColor('hover-text', FTabColors.HoverTextColor);
    AddColor('accent', FTabColors.ActiveColor);
    AddColor('active-text', FTabColors.ActiveTextColor);
    AddColor('accent-hover', FTabColors.ActiveHoverColor);
    AddColor('focus', FTabColors.FocusColor);
    AddColor('surface', FTabColors.MenuColor);
    AddColor('disabled', FTabColors.DisabledTextColor);
    Result := LOptions.ToJSON;
  finally
    LOptions.Free;
  end;
end;

procedure TUniDSAResponsivePageControl.ConfigCreate;
begin
  inherited;
  JSConfig('cls', ['dsa-responsive-page-control'], GetContainer);
end;

procedure TUniDSAResponsivePageControl.LoadCompleted;
const
  COverflow: array[TUniDSATabOverflowMode] of string = ('menu', 'scroller');
begin
  inherited;
  JSConfig('tabBar', [JSObject([
    'cls', 'dsa-tabs-bar',
    'layout', JSObject(['align', 'middle', 'pack', 'center',
      'overflowHandler', COverflow[FTabOverflowMode]])
  ])], GetContainer);
  JSConfig('dsaTabs', [JSStatement(OptionsJSON)], GetContainer);
  JSConfig('listeners', [JSObject([
    'afterrender', JSObject(['fn', JSFunction('cmp',
      'Ext.defer(function(){UniDSAResponsiveTabs.attach(cmp,cmp.dsaTabs);},1);')])
  ])], GetContainer);
  FReady := True;
end;

procedure TUniDSAResponsivePageControl.Apply;
begin
  if not FReady or not WebMode or IsLoading or
     (csDestroying in ComponentState) then Exit;
  JSCallGlobal('UniDSAResponsiveTabs.attach',
    [GetContainer, JSStatement(OptionsJSON)]);
end;

procedure TUniDSAResponsivePageControl.SetTabColors(const Value: TUniDSATabColors);
begin
  FTabColors.Assign(Value);
end;

procedure TUniDSAResponsivePageControl.SetTabAlignment(const Value: TUniDSATabAlignment);
begin
  if FTabAlignment = Value then Exit;
  FTabAlignment := Value;
  Apply;
end;

procedure TUniDSAResponsivePageControl.SetTabOverflowMode(const Value: TUniDSATabOverflowMode);
begin
  if FTabOverflowMode = Value then Exit;
  FTabOverflowMode := Value;
end;

procedure TUniDSAResponsivePageControl.SetKeepActiveTabVisible(const Value: Boolean);
begin
  if FKeepActiveTabVisible = Value then Exit;
  FKeepActiveTabVisible := Value;
  Apply;
end;

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAResponsivePageControl]);
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.ResponsivePageControl);

end.
