unit UniDSAFormStyle;

interface

uses System.Classes, System.SysUtils, Vcl.Graphics, uniGUIClasses, uniGUIForm,
  UniDSABase;

type
  TUniDSAFormStyle = class;
  TUniDSAFormStyleOptions = class(TPersistent)
  private
    FOwner: TUniDSAFormStyle;
  protected
    procedure Changed;
  public
    constructor Create(AOwner: TUniDSAFormStyle); virtual;
  end;

  TUniDSAFormAppearance = class(TUniDSAFormStyleOptions)
  private
    FRadius: Integer;
    FBackgroundColor: TColor;
    FBorderColor: TColor;
    FBorderWidth: Integer;
    FShadow: Boolean;
    procedure SetRadius(const Value: Integer);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetShadow(const Value: Boolean);
  public
    constructor Create(AOwner: TUniDSAFormStyle); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Radius: Integer read FRadius write SetRadius default 18;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default clWhite;
    property BorderColor: TColor read FBorderColor write SetBorderColor default $00E8E2DB;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth default 1;
    property Shadow: Boolean read FShadow write SetShadow default True;
  end;

  TUniDSAFormHeader = class(TUniDSAFormStyleOptions)
  private
    FVisible: Boolean;
    FShowIcon: Boolean;
    FHeight: Integer;
    FFontSize: Integer;
    FBackgroundColor: TColor;
    FTextColor: TColor;
    procedure SetVisible(const Value: Boolean);
    procedure SetShowIcon(const Value: Boolean);
    procedure SetHeight(const Value: Integer);
    procedure SetFontSize(const Value: Integer);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
  public
    constructor Create(AOwner: TUniDSAFormStyle); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Visible: Boolean read FVisible write SetVisible default True;
    property ShowIcon: Boolean read FShowIcon write SetShowIcon default False;
    property Height: Integer read FHeight write SetHeight default 64;
    property FontSize: Integer read FFontSize write SetFontSize default 18;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default clWhite;
    property TextColor: TColor read FTextColor write SetTextColor default $002F2317;
  end;

  TUniDSAFormCloseButton = class(TUniDSAFormStyleOptions)
  private
    FVisible: Boolean;
    FSize: Integer;
    FColor: TColor;
    FHoverColor: TColor;
    FCloseOnEscape: Boolean;
    procedure SetVisible(const Value: Boolean);
    procedure SetSize(const Value: Integer);
    procedure SetColor(const Value: TColor);
    procedure SetHoverColor(const Value: TColor);
    procedure SetCloseOnEscape(const Value: Boolean);
  public
    constructor Create(AOwner: TUniDSAFormStyle); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Visible: Boolean read FVisible write SetVisible default True;
    property Size: Integer read FSize write SetSize default 32;
    property Color: TColor read FColor write SetColor default $006D5847;
    property HoverColor: TColor read FHoverColor write SetHoverColor default $00F6F1EB;
    property CloseOnEscape: Boolean read FCloseOnEscape write SetCloseOnEscape default True;
  end;

  TUniDSAFormBackdrop = class(TUniDSAFormStyleOptions)
  private
    FColor: TColor;
    FOpacity: Integer;
    FCloseOnClick: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetOpacity(const Value: Integer);
    procedure SetCloseOnClick(const Value: Boolean);
  public
    constructor Create(AOwner: TUniDSAFormStyle); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Color: TColor read FColor write SetColor default $002F170F;
    property Opacity: Integer read FOpacity write SetOpacity default 40;
    property CloseOnClick: Boolean read FCloseOnClick write SetCloseOnClick default False;
  end;

  TUniDSAFormSizing = class(TUniDSAFormStyleOptions)
  private
    FMaxWidth: Integer;
    FMaxHeight: Integer;
    FMinHeight: Integer;
    FViewportMargin: Integer;
    FAutoHeight: Boolean;
    procedure SetMaxWidth(const Value: Integer);
    procedure SetMaxHeight(const Value: Integer);
    procedure SetMinHeight(const Value: Integer);
    procedure SetViewportMargin(const Value: Integer);
    procedure SetAutoHeight(const Value: Boolean);
  public
    constructor Create(AOwner: TUniDSAFormStyle); override;
    procedure Assign(Source: TPersistent); override;
  published
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 960;
    property MaxHeight: Integer read FMaxHeight write SetMaxHeight default 800;
    property MinHeight: Integer read FMinHeight write SetMinHeight default 180;
    property ViewportMargin: Integer read FViewportMargin write SetViewportMargin default 24;
    property AutoHeight: Boolean read FAutoHeight write SetAutoHeight default True;
  end;

  { Drop on a TUniForm. No form events or BorderStyle are overwritten. }
  TUniDSAFormStyle = class(TUniDSABaseComponent)
  private
    FReady, FEnabled: Boolean;
    FContentControl, FFooterControl: TUniControl;
    FAppearance: TUniDSAFormAppearance;
    FHeader: TUniDSAFormHeader;
    FCloseButton: TUniDSAFormCloseButton;
    FBackdrop: TUniDSAFormBackdrop;
    FSizing: TUniDSAFormSizing;
    procedure SetAppearance(const Value: TUniDSAFormAppearance);
    procedure SetHeader(const Value: TUniDSAFormHeader);
    procedure SetCloseButton(const Value: TUniDSAFormCloseButton);
    procedure SetBackdrop(const Value: TUniDSAFormBackdrop);
    procedure SetSizing(const Value: TUniDSAFormSizing);
    procedure SetEnabled(const Value: Boolean);
    procedure SetContentControl(const Value: TUniControl);
    procedure SetFooterControl(const Value: TUniControl);
    function OptionsJSON: string;
  protected
    procedure LoadCompleted; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Apply;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property ContentControl: TUniControl read FContentControl write SetContentControl;
    property FooterControl: TUniControl read FFooterControl write SetFooterControl;
    property Appearance: TUniDSAFormAppearance read FAppearance write SetAppearance;
    property Header: TUniDSAFormHeader read FHeader write SetHeader;
    property CloseButton: TUniDSAFormCloseButton read FCloseButton write SetCloseButton;
    property Backdrop: TUniDSAFormBackdrop read FBackdrop write SetBackdrop;
    property Sizing: TUniDSAFormSizing read FSizing write SetSizing;
  end;

procedure Register;

implementation

uses System.JSON, UniDSASource, UniDSAWebUtils, uniGUIApplication;

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAFormStyle]);
end;

constructor TUniDSAFormStyleOptions.Create(AOwner: TUniDSAFormStyle);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TUniDSAFormStyleOptions.Changed;
begin
  if Assigned(FOwner) then FOwner.Apply;
end;

constructor TUniDSAFormAppearance.Create(AOwner: TUniDSAFormStyle);
begin
  inherited;
  FRadius := 18;
  FBackgroundColor := clWhite;
  FBorderColor := $00E8E2DB;
  FBorderWidth := 1;
  FShadow := True;
end;

procedure TUniDSAFormAppearance.Assign(Source: TPersistent);
begin
  if Source is TUniDSAFormAppearance then
  begin
    FRadius := TUniDSAFormAppearance(Source).FRadius;
    FBackgroundColor := TUniDSAFormAppearance(Source).FBackgroundColor;
    FBorderColor := TUniDSAFormAppearance(Source).FBorderColor;
    FBorderWidth := TUniDSAFormAppearance(Source).FBorderWidth;
    FShadow := TUniDSAFormAppearance(Source).FShadow;
    Changed;
  end
  else inherited;
end;

procedure TUniDSAFormAppearance.SetRadius(const Value: Integer);
begin
  FRadius := UniDSAClamp(Value, 0, 80);
  Changed;
end;

procedure TUniDSAFormAppearance.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
  Changed;
end;

procedure TUniDSAFormAppearance.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Changed;
end;

procedure TUniDSAFormAppearance.SetBorderWidth(const Value: Integer);
begin
  FBorderWidth := UniDSAClamp(Value, 0, 8);
  Changed;
end;

procedure TUniDSAFormAppearance.SetShadow(const Value: Boolean);
begin
  FShadow := Value;
  Changed;
end;

constructor TUniDSAFormHeader.Create(AOwner: TUniDSAFormStyle);
begin
  inherited;
  FVisible := True;
  FShowIcon := False;
  FHeight := 64;
  FFontSize := 18;
  FBackgroundColor := clWhite;
  FTextColor := $002F2317;
end;

procedure TUniDSAFormHeader.Assign(Source: TPersistent);
begin
  if Source is TUniDSAFormHeader then
  begin
    FVisible := TUniDSAFormHeader(Source).FVisible;
    FShowIcon := TUniDSAFormHeader(Source).FShowIcon;
    FHeight := TUniDSAFormHeader(Source).FHeight;
    FFontSize := TUniDSAFormHeader(Source).FFontSize;
    FBackgroundColor := TUniDSAFormHeader(Source).FBackgroundColor;
    FTextColor := TUniDSAFormHeader(Source).FTextColor;
    Changed;
  end
  else inherited;
end;

procedure TUniDSAFormHeader.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  Changed;
end;

procedure TUniDSAFormHeader.SetShowIcon(const Value: Boolean);
begin
  FShowIcon := Value;
  Changed;
end;

procedure TUniDSAFormHeader.SetHeight(const Value: Integer);
begin
  FHeight := UniDSAClamp(Value, 40, 160);
  Changed;
end;

procedure TUniDSAFormHeader.SetFontSize(const Value: Integer);
begin
  FFontSize := UniDSAClamp(Value, 10, 48);
  Changed;
end;

procedure TUniDSAFormHeader.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
  Changed;
end;

procedure TUniDSAFormHeader.SetTextColor(const Value: TColor);
begin
  FTextColor := Value;
  Changed;
end;

constructor TUniDSAFormCloseButton.Create(AOwner: TUniDSAFormStyle);
begin
  inherited;
  FVisible := True;
  FSize := 32;
  FColor := $006D5847;
  FHoverColor := $00F6F1EB;
  FCloseOnEscape := True;
end;

procedure TUniDSAFormCloseButton.Assign(Source: TPersistent);
begin
  if Source is TUniDSAFormCloseButton then
  begin
    FVisible := TUniDSAFormCloseButton(Source).FVisible;
    FSize := TUniDSAFormCloseButton(Source).FSize;
    FColor := TUniDSAFormCloseButton(Source).FColor;
    FHoverColor := TUniDSAFormCloseButton(Source).FHoverColor;
    FCloseOnEscape := TUniDSAFormCloseButton(Source).FCloseOnEscape;
    Changed;
  end
  else inherited;
end;

procedure TUniDSAFormCloseButton.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  Changed;
end;

procedure TUniDSAFormCloseButton.SetSize(const Value: Integer);
begin
  FSize := UniDSAClamp(Value, 24, 64);
  Changed;
end;

procedure TUniDSAFormCloseButton.SetColor(const Value: TColor);
begin
  FColor := Value;
  Changed;
end;

procedure TUniDSAFormCloseButton.SetHoverColor(const Value: TColor);
begin
  FHoverColor := Value;
  Changed;
end;

procedure TUniDSAFormCloseButton.SetCloseOnEscape(const Value: Boolean);
begin
  FCloseOnEscape := Value;
  Changed;
end;

constructor TUniDSAFormBackdrop.Create(AOwner: TUniDSAFormStyle);
begin
  inherited;
  FColor := $002F170F;
  FOpacity := 40;
  FCloseOnClick := False;
end;

procedure TUniDSAFormBackdrop.Assign(Source: TPersistent);
begin
  if Source is TUniDSAFormBackdrop then
  begin
    FColor := TUniDSAFormBackdrop(Source).FColor;
    FOpacity := TUniDSAFormBackdrop(Source).FOpacity;
    FCloseOnClick := TUniDSAFormBackdrop(Source).FCloseOnClick;
    Changed;
  end
  else inherited;
end;

procedure TUniDSAFormBackdrop.SetColor(const Value: TColor);
begin
  FColor := Value;
  Changed;
end;

procedure TUniDSAFormBackdrop.SetOpacity(const Value: Integer);
begin
  FOpacity := UniDSAClamp(Value, 0, 90);
  Changed;
end;

procedure TUniDSAFormBackdrop.SetCloseOnClick(const Value: Boolean);
begin
  FCloseOnClick := Value;
  Changed;
end;

constructor TUniDSAFormSizing.Create(AOwner: TUniDSAFormStyle);
begin
  inherited;
  FMaxWidth := 960;
  FMaxHeight := 800;
  FMinHeight := 180;
  FViewportMargin := 24;
  FAutoHeight := True;
end;

procedure TUniDSAFormSizing.Assign(Source: TPersistent);
begin
  if Source is TUniDSAFormSizing then
  begin
    FMaxWidth := TUniDSAFormSizing(Source).FMaxWidth;
    FMaxHeight := TUniDSAFormSizing(Source).FMaxHeight;
    FMinHeight := TUniDSAFormSizing(Source).FMinHeight;
    FViewportMargin := TUniDSAFormSizing(Source).FViewportMargin;
    FAutoHeight := TUniDSAFormSizing(Source).FAutoHeight;
    Changed;
  end
  else inherited;
end;

procedure TUniDSAFormSizing.SetMaxWidth(const Value: Integer);
begin
  FMaxWidth := UniDSAClamp(Value, 240, 4096);
  Changed;
end;

procedure TUniDSAFormSizing.SetMaxHeight(const Value: Integer);
begin
  FMaxHeight := UniDSAClamp(Value, 160, 4096);
  Changed;
end;

procedure TUniDSAFormSizing.SetMinHeight(const Value: Integer);
begin
  FMinHeight := UniDSAClamp(Value, 100, 2048);
  Changed;
end;

procedure TUniDSAFormSizing.SetViewportMargin(const Value: Integer);
begin
  FViewportMargin := UniDSAClamp(Value, 0, 160);
  Changed;
end;

procedure TUniDSAFormSizing.SetAutoHeight(const Value: Boolean);
begin
  FAutoHeight := Value;
  Changed;
end;

constructor TUniDSAFormStyle.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  FAppearance := TUniDSAFormAppearance.Create(Self);
  FHeader := TUniDSAFormHeader.Create(Self);
  FCloseButton := TUniDSAFormCloseButton.Create(Self);
  FBackdrop := TUniDSAFormBackdrop.Create(Self);
  FSizing := TUniDSAFormSizing.Create(Self);
end;

destructor TUniDSAFormStyle.Destroy;
begin
  if FReady and WebMode and (Owner is TUniForm) and
     not (csDestroying in Owner.ComponentState) then
    TUniForm(Owner).JSInterface.JSCode('UniDSAFormStyle.detach(' + #1 + ');');
  FReady := False;
  FreeAndNil(FAppearance);
  FreeAndNil(FHeader);
  FreeAndNil(FCloseButton);
  FreeAndNil(FBackdrop);
  FreeAndNil(FSizing);
  inherited;
end;

procedure TUniDSAFormStyle.SetAppearance(const Value: TUniDSAFormAppearance);
begin
  if Assigned(Value) then FAppearance.Assign(Value);
end;

procedure TUniDSAFormStyle.SetHeader(const Value: TUniDSAFormHeader);
begin
  if Assigned(Value) then FHeader.Assign(Value);
end;

procedure TUniDSAFormStyle.SetCloseButton(const Value: TUniDSAFormCloseButton);
begin
  if Assigned(Value) then FCloseButton.Assign(Value);
end;

procedure TUniDSAFormStyle.SetBackdrop(const Value: TUniDSAFormBackdrop);
begin
  if Assigned(Value) then FBackdrop.Assign(Value);
end;

procedure TUniDSAFormStyle.SetSizing(const Value: TUniDSAFormSizing);
begin
  if Assigned(Value) then FSizing.Assign(Value);
end;

procedure TUniDSAFormStyle.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  Apply;
end;

procedure TUniDSAFormStyle.SetContentControl(const Value: TUniControl);
begin
  if Assigned(FContentControl) then FContentControl.RemoveFreeNotification(Self);
  FContentControl := Value;
  if Assigned(Value) then Value.FreeNotification(Self);
  Apply;
end;

procedure TUniDSAFormStyle.SetFooterControl(const Value: TUniControl);
begin
  if Assigned(FFooterControl) then FFooterControl.RemoveFreeNotification(Self);
  FFooterControl := Value;
  if Assigned(Value) then Value.FreeNotification(Self);
  Apply;
end;

procedure TUniDSAFormStyle.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FContentControl then FContentControl := nil;
    if AComponent = FFooterControl then FFooterControl := nil;
  end;
end;

function TUniDSAFormStyle.OptionsJSON: string;
var O: TJSONObject;
begin
  O := TJSONObject.Create;
  try
    O.AddPair('enabled', TJSONBool.Create(FEnabled));
    O.AddPair('radius', TJSONNumber.Create(FAppearance.Radius));
    O.AddPair('background', UniDSAColorToCSS(FAppearance.BackgroundColor));
    O.AddPair('borderColor', UniDSAColorToCSS(FAppearance.BorderColor));
    O.AddPair('borderWidth', TJSONNumber.Create(FAppearance.BorderWidth));
    O.AddPair('shadow', TJSONBool.Create(FAppearance.Shadow));
    O.AddPair('headerVisible', TJSONBool.Create(FHeader.Visible));
    O.AddPair('showIcon', TJSONBool.Create(FHeader.ShowIcon));
    O.AddPair('headerHeight', TJSONNumber.Create(FHeader.Height));
    O.AddPair('fontSize', TJSONNumber.Create(FHeader.FontSize));
    O.AddPair('headerBackground', UniDSAColorToCSS(FHeader.BackgroundColor));
    O.AddPair('titleColor', UniDSAColorToCSS(FHeader.TextColor));
    O.AddPair('closeVisible', TJSONBool.Create(FCloseButton.Visible));
    O.AddPair('closeSize', TJSONNumber.Create(FCloseButton.Size));
    O.AddPair('closeColor', UniDSAColorToCSS(FCloseButton.Color));
    O.AddPair('closeHover', UniDSAColorToCSS(FCloseButton.HoverColor));
    O.AddPair('escape', TJSONBool.Create(FCloseButton.CloseOnEscape));
    O.AddPair('backdropColor', UniDSAColorToCSS(FBackdrop.Color));
    O.AddPair('backdropOpacity', TJSONNumber.Create(FBackdrop.Opacity));
    O.AddPair('backdropClose', TJSONBool.Create(FBackdrop.CloseOnClick));
    O.AddPair('maxWidth', TJSONNumber.Create(FSizing.MaxWidth));
    O.AddPair('maxHeight', TJSONNumber.Create(FSizing.MaxHeight));
    O.AddPair('minHeight', TJSONNumber.Create(FSizing.MinHeight));
    O.AddPair('margin', TJSONNumber.Create(FSizing.ViewportMargin));
    O.AddPair('autoHeight', TJSONBool.Create(FSizing.AutoHeight));
    if Assigned(FContentControl) then O.AddPair('content', FContentControl.JSName + '_id');
    if Assigned(FFooterControl) then O.AddPair('footer', FFooterControl.JSName + '_id');
    Result := O.ToJSON;
  finally
    O.Free;
  end;
end;

procedure TUniDSAFormStyle.Apply;
var Form: TUniForm;
begin
  if not FReady or not WebMode or (csDestroying in ComponentState) or
     (csLoading in ComponentState) or not (Owner is TUniForm) then Exit;
  Form := TUniForm(Owner);
  Form.JSInterface.JSCode('UniDSAFormStyle.attach(' + #1 + ',' + OptionsJSON + ');');
end;

procedure TUniDSAFormStyle.LoadCompleted;
begin
  inherited;
  FReady := True;
  Apply;
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.FormStyle);

end.
