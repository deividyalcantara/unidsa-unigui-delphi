unit UniDSASignature;

interface

uses
  System.Classes, System.SysUtils, Vcl.Graphics, uniGUIClasses, uniGUITypes,
  UniDSABaseControl;

type
  TUniDSASignatureFormat = (sfPNG, sfJPEG);

  TUniDSASignature = class;

  TUniDSASignatureStyle = class(TPersistent)
  private
    FOwner: TUniDSASignature;
    FBackgroundColor: TColor;
    FBorderColor: TColor;
    FTextColor: TColor;
    FMutedColor: TColor;
    FPrimaryColor: TColor;
    FBorderRadius: Integer;
    FMaxWidth: Integer;
    procedure Changed;
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
    procedure SetMutedColor(const Value: TColor);
    procedure SetPrimaryColor(const Value: TColor);
    procedure SetBorderRadius(const Value: Integer);
    procedure SetMaxWidth(const Value: Integer);
  public
    constructor Create(AOwner: TUniDSASignature);
    procedure Assign(Source: TPersistent); override;
  published
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default clWhite;
    property BorderColor: TColor read FBorderColor write SetBorderColor default $00EEE4DB;
    property TextColor: TColor read FTextColor write SetTextColor default $00493325;
    property MutedColor: TColor read FMutedColor write SetMutedColor default $008B7464;
    property PrimaryColor: TColor read FPrimaryColor write SetPrimaryColor default $00EB6325;
    property BorderRadius: Integer read FBorderRadius write SetBorderRadius default 16;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 900;
  end;

  TUniDSASignature = class(TUniDSABaseControl)
  private
    FValue: string;
    FEmpty: Boolean;
    FPenColor: TColor;
    FPenWidth: Integer;
    FCanvasHeight: Integer;
    FReadOnly: Boolean;
    FRequired: Boolean;
    FShowToolbar: Boolean;
    FPlaceholder: string;
    FFileName: string;
    FFormat: TUniDSASignatureFormat;
    FStyle: TUniDSASignatureStyle;
    FOnChange: TNotifyEvent;
    FOnBeginDraw: TNotifyEvent;
    FOnEndDraw: TNotifyEvent;
    function RootID: string;
    function OptionsJSON: string;
    procedure PrepareHTML;
    procedure PrepareJS;
    procedure RefreshSignature;
    procedure SetValue(const Value: string);
    procedure SetPenColor(const Value: TColor);
    procedure SetPenWidth(const Value: Integer);
    procedure SetCanvasHeight(const Value: Integer);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetRequired(const Value: Boolean);
    procedure SetShowToolbar(const Value: Boolean);
    procedure SetPlaceholder(const Value: string);
    procedure SetFileName(const Value: string);
    procedure SetFormat(const Value: TUniDSASignatureFormat);
    procedure SetStyle(const Value: TUniDSASignatureStyle);
  protected
    procedure ConfigJSClasses(ALoading: Boolean); override;
    procedure JSEventHandler(AEventName: string; AParams: TUniStrings); override;
    procedure LoadCompleted; override;
    procedure WebCreate; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Undo;
    procedure Redo;
    procedure Download;
    procedure RequestValue;
    function IsValid: Boolean;
    property Empty: Boolean read FEmpty;
  published
    property Align;
    property Anchors;
    property Value: string read FValue write SetValue;
    property PenColor: TColor read FPenColor write SetPenColor default $00493325;
    property PenWidth: Integer read FPenWidth write SetPenWidth default 3;
    property CanvasHeight: Integer read FCanvasHeight write SetCanvasHeight default 260;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Required: Boolean read FRequired write SetRequired default False;
    property ShowToolbar: Boolean read FShowToolbar write SetShowToolbar default True;
    property Placeholder: string read FPlaceholder write SetPlaceholder;
    property FileName: string read FFileName write SetFileName;
    property Format: TUniDSASignatureFormat read FFormat write SetFormat default sfPNG;
    property Style: TUniDSASignatureStyle read FStyle write SetStyle;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnBeginDraw: TNotifyEvent read FOnBeginDraw write FOnBeginDraw;
    property OnEndDraw: TNotifyEvent read FOnEndDraw write FOnEndDraw;
  end;

procedure Register;

implementation

uses
  System.NetEncoding, UniDSASource, UniDSAWebUtils;

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSASignature]);
end;

function SignatureFormatName(const Value: TUniDSASignatureFormat): string;
begin
  if Value = sfJPEG then
    Result := 'jpeg'
  else
    Result := 'png';
end;

constructor TUniDSASignatureStyle.Create(AOwner: TUniDSASignature);
begin
  inherited Create;
  FOwner := AOwner;
  FBackgroundColor := clWhite;
  FBorderColor := $00EEE4DB;
  FTextColor := $00493325;
  FMutedColor := $008B7464;
  FPrimaryColor := $00EB6325;
  FBorderRadius := 16;
  FMaxWidth := 900;
end;

procedure TUniDSASignatureStyle.Assign(Source: TPersistent);
var
  LSource: TUniDSASignatureStyle;
begin
  if Source is TUniDSASignatureStyle then begin
    LSource := TUniDSASignatureStyle(Source);
    FBackgroundColor := LSource.BackgroundColor;
    FBorderColor := LSource.BorderColor;
    FTextColor := LSource.TextColor;
    FMutedColor := LSource.MutedColor;
    FPrimaryColor := LSource.PrimaryColor;
    FBorderRadius := LSource.BorderRadius;
    FMaxWidth := LSource.MaxWidth;
    Changed;
  end else
    inherited;
end;

procedure TUniDSASignatureStyle.Changed;
begin
  if Assigned(FOwner) then FOwner.RefreshSignature;
end;

procedure TUniDSASignatureStyle.SetBackgroundColor(const Value: TColor);
begin FBackgroundColor := Value; Changed; end;

procedure TUniDSASignatureStyle.SetBorderColor(const Value: TColor);
begin FBorderColor := Value; Changed; end;

procedure TUniDSASignatureStyle.SetTextColor(const Value: TColor);
begin FTextColor := Value; Changed; end;

procedure TUniDSASignatureStyle.SetMutedColor(const Value: TColor);
begin FMutedColor := Value; Changed; end;

procedure TUniDSASignatureStyle.SetPrimaryColor(const Value: TColor);
begin FPrimaryColor := Value; Changed; end;

procedure TUniDSASignatureStyle.SetBorderRadius(const Value: Integer);
begin FBorderRadius := UniDSAClamp(Value, 0, 40); Changed; end;

procedure TUniDSASignatureStyle.SetMaxWidth(const Value: Integer);
begin FMaxWidth := UniDSAClamp(Value, 280, 1600); Changed; end;

constructor TUniDSASignature.Create(AOwner: TComponent);
begin
  inherited;
  Width := 520;
  Height := 330;
  FEmpty := True;
  FPenColor := $00493325;
  FPenWidth := 3;
  FCanvasHeight := 260;
  FShowToolbar := True;
  FPlaceholder := 'Assine dentro da área indicada';
  FFileName := 'assinatura';
  FFormat := sfPNG;
  FStyle := TUniDSASignatureStyle.Create(Self);
end;

destructor TUniDSASignature.Destroy;
begin
  FreeAndNil(FStyle);
  inherited;
end;

procedure TUniDSASignature.ConfigJSClasses(ALoading: Boolean);
begin
  inherited;
  JSObjects.DefaultJSClassName := 'Ext.form.Label';
end;

function TUniDSASignature.RootID: string;
begin
  Result := 'unidsa-signature-' + JSName;
end;

function TUniDSASignature.OptionsJSON: string;
begin
  Result := '{' +
    'penColor:' + UniDSAJSString(UniDSAColorToCSS(FPenColor)) + ',' +
    'penWidth:' + IntToStr(FPenWidth) + ',' +
    'canvasHeight:' + IntToStr(FCanvasHeight) + ',' +
    'readOnly:' + UniDSABoolJS(FReadOnly) + ',' +
    'required:' + UniDSABoolJS(FRequired) + ',' +
    'showToolbar:' + UniDSABoolJS(FShowToolbar) + ',' +
    'placeholder:' + UniDSAJSString(FPlaceholder) + ',' +
    'fileName:' + UniDSAJSString(FFileName) + ',' +
    'format:' + UniDSAJSString(SignatureFormatName(FFormat)) + ',' +
    'background:' + UniDSAJSString(UniDSAColorToCSS(FStyle.BackgroundColor)) + ',' +
    'border:' + UniDSAJSString(UniDSAColorToCSS(FStyle.BorderColor)) + ',' +
    'textColor:' + UniDSAJSString(UniDSAColorToCSS(FStyle.TextColor)) + ',' +
    'muted:' + UniDSAJSString(UniDSAColorToCSS(FStyle.MutedColor)) + ',' +
    'primary:' + UniDSAJSString(UniDSAColorToCSS(FStyle.PrimaryColor)) + ',' +
    'borderRadius:' + IntToStr(FStyle.BorderRadius) + ',' +
    'maxWidth:' + IntToStr(FStyle.MaxWidth) + '}';
end;

procedure TUniDSASignature.PrepareHTML;
var
  LHTML: TStringBuilder;
begin
  if not WebMode then Exit;
  LHTML := TStringBuilder.Create;
  try
    LHTML.Append('<div id="' + RootID + '" class="unidsa-signature is-empty" role="region" aria-label="Area de assinatura">');
    LHTML.Append('<div class="unidsa-signature__canvas-wrap"><canvas aria-label="Assine usando mouse, toque ou caneta"></canvas>');
    LHTML.Append('<div class="unidsa-signature__guide"></div><div class="unidsa-signature__placeholder"></div></div>');
    LHTML.Append('<div class="unidsa-signature__toolbar">');
    LHTML.Append('<button type="button" class="unidsa-signature__button" data-signature-action="undo">Desfazer</button>');
    LHTML.Append('<button type="button" class="unidsa-signature__button" data-signature-action="redo">Refazer</button>');
    LHTML.Append('<button type="button" class="unidsa-signature__button" data-signature-action="clear">Limpar</button>');
    LHTML.Append('<button type="button" class="unidsa-signature__button" data-signature-action="download">Baixar</button>');
    LHTML.Append('<span class="unidsa-signature__status" aria-live="polite"></span></div></div>');
    Caption := LHTML.ToString;
  finally
    FreeAndNil(LHTML);
  end;
end;

procedure TUniDSASignature.PrepareJS;
begin
  if WebMode then
    UniSession.AddJS('if(window.UniDSASignature){window.UniDSASignature.init(' +
      UniDSAJSString(RootID) + ',' + JSName + ',' + OptionsJSON + ');}');
end;

procedure TUniDSASignature.LoadCompleted;
begin
  inherited;
  PrepareHTML;
  PrepareJS;
  if WebMode and (FValue <> '') then
    UniSession.AddJS('window.UniDSASignature.load(' + UniDSAJSString(RootID) + ',' +
      UniDSAJSString(FValue) + ');');
end;

procedure TUniDSASignature.RefreshSignature;
begin
  if WebMode and not IsLoading and not IsDesigning then PrepareJS;
end;

procedure TUniDSASignature.Clear;
begin
  FValue := '';
  FEmpty := True;
  JS('UniDSASignature.clear(' + UniDSAJSString(RootID) + ',true);');
end;

procedure TUniDSASignature.Undo;
begin JS('UniDSASignature.undo(' + UniDSAJSString(RootID) + ');'); end;

procedure TUniDSASignature.Redo;
begin JS('UniDSASignature.redo(' + UniDSAJSString(RootID) + ');'); end;

procedure TUniDSASignature.Download;
begin JS('UniDSASignature.download(' + UniDSAJSString(RootID) + ',' + UniDSAJSString(FFileName) + ');'); end;

procedure TUniDSASignature.RequestValue;
begin JS('UniDSASignature.requestValue(' + UniDSAJSString(RootID) + ');'); end;

function TUniDSASignature.IsValid: Boolean;
begin
  Result := not FRequired or not FEmpty;
end;

procedure TUniDSASignature.JSEventHandler(AEventName: string; AParams: TUniStrings);
begin
  inherited;
  if AEventName = 'UniDSASignatureChange' then begin
    FEmpty := AParams.Values['Empty'] = '1';
    FValue := TNetEncoding.URL.Decode(AParams.Values['Value']);
    if Assigned(FOnChange) then FOnChange(Self);
  end
  else if AEventName = 'UniDSASignatureBeginDraw' then begin
    if Assigned(FOnBeginDraw) then FOnBeginDraw(Self);
  end
  else if AEventName = 'UniDSASignatureEndDraw' then begin
    if Assigned(FOnEndDraw) then FOnEndDraw(Self);
  end;
end;

procedure TUniDSASignature.SetValue(const Value: string);
begin
  FValue := Value;
  FEmpty := Value = '';
  if WebMode and not IsLoading and not IsDesigning then
    JS('UniDSASignature.load(' + UniDSAJSString(RootID) + ',' + UniDSAJSString(Value) + ');');
end;

procedure TUniDSASignature.SetPenColor(const Value: TColor);
begin FPenColor := Value; RefreshSignature; end;

procedure TUniDSASignature.SetPenWidth(const Value: Integer);
begin FPenWidth := UniDSAClamp(Value, 1, 20); RefreshSignature; end;

procedure TUniDSASignature.SetCanvasHeight(const Value: Integer);
begin FCanvasHeight := UniDSAClamp(Value, 160, 720); RefreshSignature; end;

procedure TUniDSASignature.SetReadOnly(const Value: Boolean);
begin FReadOnly := Value; RefreshSignature; end;

procedure TUniDSASignature.SetRequired(const Value: Boolean);
begin FRequired := Value; RefreshSignature; end;

procedure TUniDSASignature.SetShowToolbar(const Value: Boolean);
begin FShowToolbar := Value; RefreshSignature; end;

procedure TUniDSASignature.SetPlaceholder(const Value: string);
begin FPlaceholder := Value; RefreshSignature; end;

procedure TUniDSASignature.SetFileName(const Value: string);
begin FFileName := Value; RefreshSignature; end;

procedure TUniDSASignature.SetFormat(const Value: TUniDSASignatureFormat);
begin FFormat := Value; RefreshSignature; end;

procedure TUniDSASignature.SetStyle(const Value: TUniDSASignatureStyle);
begin FStyle.Assign(Value); end;

procedure TUniDSASignature.WebCreate;
begin
  inherited;
  JSCls := 'x-unidsa-signature';
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.Signature);

end.
