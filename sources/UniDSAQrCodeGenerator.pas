unit UniDSAQrCodeGenerator;

interface

uses
  System.Classes, System.SysUtils, Vcl.Graphics, uniGUIClasses, uniGUITypes,
  UniDSABaseControl;

type
  TUniDSAQrErrorCorrection = (qecLow, qecMedium, qecQuartile, qecHigh);
  TUniDSAQrModuleStyle = (qmsSquare, qmsRounded, qmsDots);
  TUniDSAQrExportFormat = (qefPNG, qefSVG);

  TUniDSAQrCodeGenerator = class;

  TUniDSAQrCodeGeneratorStyle = class(TPersistent)
  private
    FOwner: TUniDSAQrCodeGenerator;
    FPanelBackgroundColor: TColor;
    FSurfaceColor: TColor;
    FBorderColor: TColor;
    FTextColor: TColor;
    FMutedColor: TColor;
    FPrimaryColor: TColor;
    FBorderRadius: Integer;
    FMaxWidth: Integer;
    procedure Changed;
    procedure SetPanelBackgroundColor(const Value: TColor);
    procedure SetSurfaceColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
    procedure SetMutedColor(const Value: TColor);
    procedure SetPrimaryColor(const Value: TColor);
    procedure SetBorderRadius(const Value: Integer);
    procedure SetMaxWidth(const Value: Integer);
  public
    constructor Create(AOwner: TUniDSAQrCodeGenerator);
    procedure Assign(Source: TPersistent); override;
  published
    property PanelBackgroundColor: TColor read FPanelBackgroundColor write SetPanelBackgroundColor default $00FCF9F8;
    property SurfaceColor: TColor read FSurfaceColor write SetSurfaceColor default clWhite;
    property BorderColor: TColor read FBorderColor write SetBorderColor default $00EEE4DB;
    property TextColor: TColor read FTextColor write SetTextColor default $00493325;
    property MutedColor: TColor read FMutedColor write SetMutedColor default $008B7464;
    property PrimaryColor: TColor read FPrimaryColor write SetPrimaryColor default $00EB6325;
    property BorderRadius: Integer read FBorderRadius write SetBorderRadius default 16;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 720;
  end;

  TUniDSAQrCodeGenerator = class(TUniDSABaseControl)
  private
    FText: string;
    FSize: Integer;
    FMargin: Integer;
    FErrorCorrection: TUniDSAQrErrorCorrection;
    FModuleStyle: TUniDSAQrModuleStyle;
    FForegroundColor: TColor;
    FBackgroundColor: TColor;
    FLogoURL: string;
    FLogoSize: Integer;
    FExportFormat: TUniDSAQrExportFormat;
    FFileName: string;
    FEmptyText: string;
    FShowActions: Boolean;
    FDataURL: string;
    FSVG: string;
    FStyle: TUniDSAQrCodeGeneratorStyle;
    FOnGenerated: TNotifyEvent;
    FOnData: TNotifyEvent;
    function RootID: string;
    function OptionsJSON: string;
    procedure PrepareHTML;
    procedure PrepareJS;
    procedure SetQrText(const Value: string);
    procedure SetSize(const Value: Integer);
    procedure SetMargin(const Value: Integer);
    procedure SetErrorCorrection(const Value: TUniDSAQrErrorCorrection);
    procedure SetModuleStyle(const Value: TUniDSAQrModuleStyle);
    procedure SetForegroundColor(const Value: TColor);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetLogoURL(const Value: string);
    procedure SetLogoSize(const Value: Integer);
    procedure SetExportFormat(const Value: TUniDSAQrExportFormat);
    procedure SetFileName(const Value: string);
    procedure SetEmptyText(const Value: string);
    procedure SetShowActions(const Value: Boolean);
    procedure SetStyle(const Value: TUniDSAQrCodeGeneratorStyle);
  protected
    procedure ConfigJSClasses(ALoading: Boolean); override;
    procedure JSEventHandler(AEventName: string; AParams: TUniStrings); override;
    procedure LoadCompleted; override;
    procedure WebCreate; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Generate;
    procedure Download;
    procedure CopyToClipboard;
    procedure RequestData;
    property DataURL: string read FDataURL;
    property SVG: string read FSVG;
  published
    property Align;
    property Anchors;
    property Text: string read FText write SetQrText;
    property Size: Integer read FSize write SetSize default 280;
    property Margin: Integer read FMargin write SetMargin default 4;
    property ErrorCorrection: TUniDSAQrErrorCorrection read FErrorCorrection write SetErrorCorrection default qecMedium;
    property ModuleStyle: TUniDSAQrModuleStyle read FModuleStyle write SetModuleStyle default qmsSquare;
    property ForegroundColor: TColor read FForegroundColor write SetForegroundColor default clBlack;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default clWhite;
    property LogoURL: string read FLogoURL write SetLogoURL;
    property LogoSize: Integer read FLogoSize write SetLogoSize default 20;
    property ExportFormat: TUniDSAQrExportFormat read FExportFormat write SetExportFormat default qefPNG;
    property FileName: string read FFileName write SetFileName;
    property EmptyText: string read FEmptyText write SetEmptyText;
    property ShowActions: Boolean read FShowActions write SetShowActions default True;
    property Style: TUniDSAQrCodeGeneratorStyle read FStyle write SetStyle;
    property OnGenerated: TNotifyEvent read FOnGenerated write FOnGenerated;
    property OnData: TNotifyEvent read FOnData write FOnData;
  end;

procedure Register;

implementation

uses
  System.NetEncoding, UniDSASource, UniDSAWebUtils;

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAQrCodeGenerator]);
end;

function CorrectionName(const Value: TUniDSAQrErrorCorrection): string;
begin
  case Value of
    qecLow: Result := 'L';
    qecQuartile: Result := 'Q';
    qecHigh: Result := 'H';
  else
    Result := 'M';
  end;
end;

function ModuleStyleName(const Value: TUniDSAQrModuleStyle): string;
begin
  case Value of
    qmsRounded: Result := 'rounded';
    qmsDots: Result := 'dots';
  else
    Result := 'square';
  end;
end;

function ExportFormatName(const Value: TUniDSAQrExportFormat): string;
begin
  if Value = qefSVG then
    Result := 'svg'
  else
    Result := 'png';
end;

constructor TUniDSAQrCodeGeneratorStyle.Create(AOwner: TUniDSAQrCodeGenerator);
begin
  inherited Create;
  FOwner := AOwner;
  FPanelBackgroundColor := $00FCF9F8;
  FSurfaceColor := clWhite;
  FBorderColor := $00EEE4DB;
  FTextColor := $00493325;
  FMutedColor := $008B7464;
  FPrimaryColor := $00EB6325;
  FBorderRadius := 16;
  FMaxWidth := 720;
end;

procedure TUniDSAQrCodeGeneratorStyle.Assign(Source: TPersistent);
var
  LSource: TUniDSAQrCodeGeneratorStyle;
begin
  if Source is TUniDSAQrCodeGeneratorStyle then begin
    LSource := TUniDSAQrCodeGeneratorStyle(Source);
    FPanelBackgroundColor := LSource.PanelBackgroundColor;
    FSurfaceColor := LSource.SurfaceColor;
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

procedure TUniDSAQrCodeGeneratorStyle.Changed;
begin
  if Assigned(FOwner) then FOwner.Generate;
end;

procedure TUniDSAQrCodeGeneratorStyle.SetPanelBackgroundColor(const Value: TColor);
begin FPanelBackgroundColor := Value; Changed; end;

procedure TUniDSAQrCodeGeneratorStyle.SetSurfaceColor(const Value: TColor);
begin FSurfaceColor := Value; Changed; end;

procedure TUniDSAQrCodeGeneratorStyle.SetBorderColor(const Value: TColor);
begin FBorderColor := Value; Changed; end;

procedure TUniDSAQrCodeGeneratorStyle.SetTextColor(const Value: TColor);
begin FTextColor := Value; Changed; end;

procedure TUniDSAQrCodeGeneratorStyle.SetMutedColor(const Value: TColor);
begin FMutedColor := Value; Changed; end;

procedure TUniDSAQrCodeGeneratorStyle.SetPrimaryColor(const Value: TColor);
begin FPrimaryColor := Value; Changed; end;

procedure TUniDSAQrCodeGeneratorStyle.SetBorderRadius(const Value: Integer);
begin FBorderRadius := UniDSAClamp(Value, 0, 40); Changed; end;

procedure TUniDSAQrCodeGeneratorStyle.SetMaxWidth(const Value: Integer);
begin FMaxWidth := UniDSAClamp(Value, 280, 1600); Changed; end;

constructor TUniDSAQrCodeGenerator.Create(AOwner: TComponent);
begin
  inherited;
  Width := 420;
  Height := 420;
  FText := 'https://github.com/deividyalcantara/unidsa-unigui-delphi';
  FSize := 280;
  FMargin := 4;
  FErrorCorrection := qecMedium;
  FModuleStyle := qmsSquare;
  FForegroundColor := clBlack;
  FBackgroundColor := clWhite;
  FLogoSize := 20;
  FExportFormat := qefPNG;
  FFileName := 'qrcode';
  FEmptyText := 'Informe um conteúdo para gerar o QR Code.';
  FShowActions := True;
  FStyle := TUniDSAQrCodeGeneratorStyle.Create(Self);
end;

destructor TUniDSAQrCodeGenerator.Destroy;
begin
  FreeAndNil(FStyle);
  inherited;
end;

procedure TUniDSAQrCodeGenerator.ConfigJSClasses(ALoading: Boolean);
begin
  inherited;
  JSObjects.DefaultJSClassName := 'Ext.form.Label';
end;

function TUniDSAQrCodeGenerator.RootID: string;
begin
  Result := 'unidsa-qrcode-generator-' + JSName;
end;

function TUniDSAQrCodeGenerator.OptionsJSON: string;
begin
  Result := '{' +
    'text:' + UniDSAJSString(FText) + ',' +
    'size:' + IntToStr(FSize) + ',' +
    'margin:' + IntToStr(FMargin) + ',' +
    'correction:' + UniDSAJSString(CorrectionName(FErrorCorrection)) + ',' +
    'moduleStyle:' + UniDSAJSString(ModuleStyleName(FModuleStyle)) + ',' +
    'foreground:' + UniDSAJSString(UniDSAColorToCSS(FForegroundColor)) + ',' +
    'background:' + UniDSAJSString(UniDSAColorToCSS(FBackgroundColor)) + ',' +
    'logoUrl:' + UniDSAJSString(FLogoURL) + ',' +
    'logoSize:' + IntToStr(FLogoSize) + ',' +
    'format:' + UniDSAJSString(ExportFormatName(FExportFormat)) + ',' +
    'fileName:' + UniDSAJSString(FFileName) + ',' +
    'emptyText:' + UniDSAJSString(FEmptyText) + ',' +
    'showActions:' + UniDSABoolJS(FShowActions) + ',' +
    'panelBackground:' + UniDSAJSString(UniDSAColorToCSS(FStyle.PanelBackgroundColor)) + ',' +
    'surface:' + UniDSAJSString(UniDSAColorToCSS(FStyle.SurfaceColor)) + ',' +
    'border:' + UniDSAJSString(UniDSAColorToCSS(FStyle.BorderColor)) + ',' +
    'textColor:' + UniDSAJSString(UniDSAColorToCSS(FStyle.TextColor)) + ',' +
    'muted:' + UniDSAJSString(UniDSAColorToCSS(FStyle.MutedColor)) + ',' +
    'primary:' + UniDSAJSString(UniDSAColorToCSS(FStyle.PrimaryColor)) + ',' +
    'borderRadius:' + IntToStr(FStyle.BorderRadius) + ',' +
    'maxWidth:' + IntToStr(FStyle.MaxWidth) + '}';
end;

procedure TUniDSAQrCodeGenerator.PrepareHTML;
var
  LHTML: TStringBuilder;
begin
  if not WebMode then Exit;
  LHTML := TStringBuilder.Create;
  try
    LHTML.Append('<div id="' + RootID + '" class="unidsa-qrcode-generator" role="region" aria-label="Gerador de QR Code">');
    LHTML.Append('<div class="unidsa-qrcode-generator__preview"><canvas aria-label="QR Code gerado"></canvas>');
    LHTML.Append('<div class="unidsa-qrcode-generator__empty"></div></div>');
    LHTML.Append('<div class="unidsa-qrcode-generator__actions">');
    LHTML.Append('<button type="button" class="unidsa-qrcode-generator__button" data-qrgen-action="download">Baixar</button>');
    LHTML.Append('<button type="button" class="unidsa-qrcode-generator__button" data-qrgen-action="copy">Copiar imagem</button></div>');
    LHTML.Append('<div class="unidsa-qrcode-generator__status" aria-live="polite"></div></div>');
    Caption := LHTML.ToString;
  finally
    FreeAndNil(LHTML);
  end;
end;

procedure TUniDSAQrCodeGenerator.PrepareJS;
begin
  if WebMode then
    UniSession.AddJS('if(window.UniDSAQrCodeGenerator){window.UniDSAQrCodeGenerator.init(' +
      UniDSAJSString(RootID) + ',' + JSName + ',' + OptionsJSON + ');}');
end;

procedure TUniDSAQrCodeGenerator.LoadCompleted;
begin
  inherited;
  PrepareHTML;
  PrepareJS;
end;

procedure TUniDSAQrCodeGenerator.Generate;
begin
  if WebMode and not IsLoading and not IsDesigning then PrepareJS;
end;

procedure TUniDSAQrCodeGenerator.Download;
begin
  JS('UniDSAQrCodeGenerator.download(' + UniDSAJSString(RootID) + ',' +
    UniDSAJSString(ExportFormatName(FExportFormat)) + ',' + UniDSAJSString(FFileName) + ');');
end;

procedure TUniDSAQrCodeGenerator.CopyToClipboard;
begin
  JS('UniDSAQrCodeGenerator.copy(' + UniDSAJSString(RootID) + ');');
end;

procedure TUniDSAQrCodeGenerator.RequestData;
begin
  JS('UniDSAQrCodeGenerator.requestData(' + UniDSAJSString(RootID) + ');');
end;

procedure TUniDSAQrCodeGenerator.JSEventHandler(AEventName: string; AParams: TUniStrings);
begin
  inherited;
  if AEventName = 'UniDSAQrCodeGeneratorGenerated' then begin
    if Assigned(FOnGenerated) then FOnGenerated(Self);
  end
  else if AEventName = 'UniDSAQrCodeGeneratorData' then begin
    FDataURL := TNetEncoding.URL.Decode(AParams.Values['DataURL']);
    FSVG := TNetEncoding.URL.Decode(AParams.Values['SVG']);
    if Assigned(FOnData) then FOnData(Self);
  end;
end;

procedure TUniDSAQrCodeGenerator.SetQrText(const Value: string);
begin FText := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetSize(const Value: Integer);
begin FSize := UniDSAClamp(Value, 120, 1200); Generate; end;

procedure TUniDSAQrCodeGenerator.SetMargin(const Value: Integer);
begin FMargin := UniDSAClamp(Value, 4, 20); Generate; end;

procedure TUniDSAQrCodeGenerator.SetErrorCorrection(const Value: TUniDSAQrErrorCorrection);
begin FErrorCorrection := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetModuleStyle(const Value: TUniDSAQrModuleStyle);
begin FModuleStyle := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetForegroundColor(const Value: TColor);
begin FForegroundColor := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetBackgroundColor(const Value: TColor);
begin FBackgroundColor := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetLogoURL(const Value: string);
begin FLogoURL := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetLogoSize(const Value: Integer);
begin FLogoSize := UniDSAClamp(Value, 10, 35); Generate; end;

procedure TUniDSAQrCodeGenerator.SetExportFormat(const Value: TUniDSAQrExportFormat);
begin FExportFormat := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetFileName(const Value: string);
begin FFileName := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetEmptyText(const Value: string);
begin FEmptyText := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetShowActions(const Value: Boolean);
begin FShowActions := Value; Generate; end;

procedure TUniDSAQrCodeGenerator.SetStyle(const Value: TUniDSAQrCodeGeneratorStyle);
begin FStyle.Assign(Value); end;

procedure TUniDSAQrCodeGenerator.WebCreate;
begin
  inherited;
  JSCls := 'x-unidsa-qrcode-generator';
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.QrCodeGenerator);

end.
