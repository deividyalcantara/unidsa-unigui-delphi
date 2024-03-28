unit UniDSAToast;

interface

uses
  System.SysUtils, System.Classes, uniGUIBaseClasses, uniGUIClasses, UniDSAJQuery, UniDSALibrary,
  System.UITypes, uniGUITypes, System.TypInfo, Vcl.Graphics, UniDSASource,  UniDSABase,
  UniDSAColor;

type
  TUniDSAToastTypeTextAlign = (Left, Right, Center);
  TUniDSAToastTypeIcon = (Info, Error, Warning, Success);
  TUniDSAToastTypeHideTransition = (Slide, Fade, Plain);
  TUniDSAToastTypePosition = (
    BottomLeft,
    BottomRight,
    BottomCenter,
    TopRight,
    TopLeft,
    TopCenter,
    MidCenter,
    Custom
  );

  TUniDSAToastStack = class(TPersistent)
  private
    FEnabled: Boolean;
    FValue: Integer;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property Value: Integer read FValue write FValue;
  end;

  TUniDSAToastFixedPosition = class(TPersistent)
  private
    FLeft: Integer;
    FTop: Integer;
    FRight: Integer;
    FBottom: Integer;
  published
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property Right: Integer read FRight write FRight;
    property Bottom: Integer read FBottom write FBottom;
  end;

  TUniDSAToastPosition = class(TPersistent)
    private
      FFPosition: TUniDSAToastTypePosition;
      FCustom: TUniDSAToastFixedPosition;
    public
      constructor Create;
      destructor Destroy; override;
    published
      property Position: TUniDSAToastTypePosition read FFPosition write FFPosition;
      property Custom: TUniDSAToastFixedPosition read FCustom write FCustom;
  end;

  TUniDSAToastLoader = class(TPersistent)
  private
    FEnabled: Boolean;
    FBackground: TColor;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property Background: TColor read FBackground write FBackground;
  end;

  TUniDSAToast = class(TUniDSABaseComponent)
  private
    FToast: TJQuery;
    FText: string;
    FShowHideTransition: TUniDSAToastTypeHideTransition;
    FHeading: string;
    FIcon: TUniDSAToastTypeIcon;
    FHideAfter: Integer;
    FAllowToastClose: Boolean;
    FStack: TUniDSAToastStack;
    FBgColor: TUniDSAColor;
    FTextColor: TUniDSAColor;
    FTextAlign: TUniDSAToastTypeTextAlign;
    FPosition: TUniDSAToastPosition;
    FLoader: TUniDSAToastLoader;
    FOnBeforeShow: TNotifyEvent;
    FOnAfterShown: TNotifyEvent;
    FOnBeforeHide: TNotifyEvent;
    FOnAfterHidden: TNotifyEvent;
    function ValueTypePosition(tipo: TUniDSAToastTypePosition): string;
  protected
    procedure AJAXEvent(var EventName: string; var Params: TUniStrings); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Reset;
    procedure Show;
    procedure Prepare;
  published
    property Text: string read FText write FText;
    property Heading: string read FHeading write FHeading;
    property Icon: TUniDSAToastTypeIcon read FIcon write FIcon;
    property ShowHideTransition: TUniDSAToastTypeHideTransition read FShowHideTransition write FShowHideTransition;
    property HideAfter: Integer read FHideAfter write FHideAfter;
    property AllowToastClose: Boolean read FAllowToastClose write FAllowToastClose;
    property Stack: TUniDSAToastStack read FStack write FStack;
    property BgColor: TUniDSAColor read FBgColor write FBgColor;
    property TextColor: TUniDSAColor read FTextColor write FTextColor;
    property TextAlign: TUniDSAToastTypeTextAlign read FTextAlign write FTextAlign;
    property Position: TUniDSAToastPosition read FPosition write FPosition;
    property Loader: TUniDSAToastLoader read FLoader write FLoader;
    property OnBeforeShow: TNotifyEvent read FOnBeforeShow write FOnBeforeShow;
    property OnAfterShown: TNotifyEvent read FOnAfterShown write FOnAfterShown;
    property OnBeforeHide: TNotifyEvent read FOnBeforeHide write FOnBeforeHide;
    property OnAfterHidden: TNotifyEvent read FOnAfterHidden write FOnAfterHidden;
    property Toast: TJQuery read FToast write FToast;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAToast]);
end;

{ TUniDSAToast }

procedure TUniDSAToast.AJAXEvent(var EventName: string; var Params: TUniStrings);
begin
  inherited;
  if EventName = 'UniDSAToastBeforeShow' then begin
    if Assigned(FOnBeforeShow) then
      FOnBeforeShow(Self);
  end;

  if EventName = 'UniDSAToastAfterShown' then begin
    if Assigned(FOnAfterShown) then
      FOnAfterShown(Self);
  end;

  if EventName = 'UniDSAToastBeforeHide' then begin
    if Assigned(FOnBeforeHide) then
      FOnBeforeHide(Self);
  end;

  if EventName = 'UniDSAToastAfterHidden' then begin
    if Assigned(FOnAfterHidden) then
      FOnAfterHidden(Self);
  end;
end;

procedure TUniDSAToast.Clear;
begin
  Reset;
end;

constructor TUniDSAToast.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStack := TUniDSAToastStack.Create;
  FPosition := TUniDSAToastPosition.Create;
  FLoader := TUniDSAToastLoader.Create;
  FToast := TJQuery.Create('toast');
  FBgColor := TUniDSAColor.Create;
  FTextColor := TUniDSAColor.Create;

  Reset;
end;

destructor TUniDSAToast.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FStack);
  FreeAndNil(FPosition);
  FreeAndNil(FLoader);
  FreeAndNil(FToast);
  FreeAndNil(FBgColor);
  FreeAndNil(FTextColor);
end;

procedure TUniDSAToast.Prepare;
begin
  with FToast do begin
    Clear;

    Add('text', FText, True, True, True);
    Add('heading', FHeading, FHeading <> '', True, True);
    Add('showHideTransition', GetEnumName(TypeInfo(TUniDSAToastTypeHideTransition), Integer(FShowHideTransition)));
    Add('icon', AnsiLowerCase(GetEnumName(TypeInfo(TUniDSAToastTypeIcon), Integer(FIcon))));
    Add('hideAfter', FHideAfter);
    Add('allowToastClose', FAllowToastClose);

    if FStack.FEnabled then
      Add('stack', FStack.FValue)
    else
      Add('stack', FStack.FEnabled);

    Add('bgColor', ColorToHex(FBgColor.Color), FBgColor.Enabled);

    Add('loader', FLoader.Enabled);
    Add('loaderBg', ColorToHex(FLoader.Background), (FLoader.Enabled) and (FLoader.FBackground <> clAqua));
    Add('textColor', ColorToHex(FTextColor.Color), FTextColor.Enabled);
    Add('textAlign', AnsiLowerCase(GetEnumName(TypeInfo(TUniDSAToastTypeTextAlign), Integer(FTextAlign))));

    if FPosition.FFPosition = TUniDSAToastTypePosition.Custom then begin
      Add(
        'position',
        '{ ' +
           ' left: ' + IIfStr(FPosition.FCustom.FLeft = 0, QuotedStr('auto'), IntToStr(FPosition.FCustom.FLeft)) + ', ' +
           ' right: ' + IIfStr(FPosition.FCustom.FRight = 0, QuotedStr('auto'), IntToStr(FPosition.FCustom.FRight)) + ', ' +
           ' top: ' + IIfStr(FPosition.FCustom.FTop = 0, QuotedStr('auto'), IntToStr(FPosition.FCustom.FTop)) + ', ' +
           ' bottom: ' + IIfStr(FPosition.FCustom.FBottom = 0, QuotedStr('auto'), IntToStr(FPosition.FCustom.FBottom)) +
        '} ',
        True,
        False
      );
    end
    else
      Add('position', ValueTypePosition(FPosition.FFPosition));

    Add(
      'beforeShow',
      AjaxRequest('UniDSAToastBeforeShow'),
      Assigned(FOnBeforeShow),
      False
    );

    Add(
      'afterShown',
      AjaxRequest('UniDSAToastAfterShown'),
      Assigned(FOnAfterShown),
      False
    );

    Add(
      'beforeHide',
      AjaxRequest('UniDSAToastBeforeHide'),
      Assigned(FOnBeforeHide),
      False
    );

    Add(
      'afterHidden',
      AjaxRequest('UniDSAToastAfterHidden'),
      Assigned(FOnAfterHidden),
      False
    );
  end;
end;

procedure TUniDSAToast.Reset;
begin
  FText := '';
  FShowHideTransition := TUniDSAToastTypeHideTransition.Fade;
  FHeading := '';
  FIcon := TUniDSAToastTypeIcon.Success;
  FHideAfter := 3000;
  FAllowToastClose := True;
  FStack.FEnabled := True;
  FStack.FValue := 5;
  FTextAlign := TUniDSAToastTypeTextAlign.Left;
  FPosition.FFPosition := TUniDSAToastTypePosition.BottomLeft;
  FLoader.Enabled := True;
  FLoader.Background := clAqua;
end;

procedure TUniDSAToast.Show;
begin
  Prepare;
  FToast.Execute;
end;

function TUniDSAToast.ValueTypePosition(tipo: TUniDSAToastTypePosition): string;
begin
  if tipo = TUniDSAToastTypePosition.BottomLeft then
    Result := 'bottom-left'
  else if tipo = TUniDSAToastTypePosition.BottomRight then
    Result := 'bottom-right'
  else if tipo = TUniDSAToastTypePosition.BottomCenter then
    Result := 'bottom-center'
  else if tipo = TUniDSAToastTypePosition.TopRight then
    Result := 'top-right'
  else if tipo = TUniDSAToastTypePosition.TopLeft then
    Result := 'top-left'
  else if tipo = TUniDSAToastTypePosition.TopCenter then
    Result := 'top-center'
  else if tipo = TUniDSAToastTypePosition.MidCenter then
    Result := 'mid-center'
  else if tipo = TUniDSAToastTypePosition.Custom then
    Result := 'custom';
end;

{ TUniDSAToastPosition }

constructor TUniDSAToastPosition.Create;
begin
  FCustom := TUniDSAToastFixedPosition.Create;
end;

destructor TUniDSAToastPosition.Destroy;
begin
  FreeAndNil(FCustom);
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.Toast);

end.
