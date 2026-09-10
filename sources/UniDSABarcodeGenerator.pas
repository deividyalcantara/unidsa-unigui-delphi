unit UniDSABarcodeGenerator;

interface

uses
  System.Classes, System.SysUtils, Vcl.Graphics, uniGUIClasses, uniGUITypes,
  UniDSABaseControl;

type
  TUniDSABarcodeFormat = (bcCode128, bcEAN13, bcEAN8, bcUPCA, bcCode39,
    bcITF14, bcCodabar);
  TUniDSABarcodeExportFormat = (befPNG, befSVG);

  TUniDSABarcodeGenerator = class;

  TUniDSABarcodeGeneratorStyle = class(TPersistent)
  private
    FOwner: TUniDSABarcodeGenerator;
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
    constructor Create(AOwner: TUniDSABarcodeGenerator);
    procedure Assign(Source: TPersistent); override;
  published
    property PanelBackgroundColor: TColor read FPanelBackgroundColor write SetPanelBackgroundColor default $00FCF9F8;
    property SurfaceColor: TColor read FSurfaceColor write SetSurfaceColor default clWhite;
    property BorderColor: TColor read FBorderColor write SetBorderColor default $00EEE4DB;
    property TextColor: TColor read FTextColor write SetTextColor default $00493325;
    property MutedColor: TColor read FMutedColor write SetMutedColor default $008B7464;
    property PrimaryColor: TColor read FPrimaryColor write SetPrimaryColor default $00EB6325;
    property BorderRadius: Integer read FBorderRadius write SetBorderRadius default 16;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 840;
  end;

  TUniDSABarcodeGenerator = class(TUniDSABaseControl)
  private
    FValue: string;
    FFormat: TUniDSABarcodeFormat;
    FBarWidth: Integer;
    FBarHeight: Integer;
    FMargin: Integer;
    FDisplayValue: Boolean;
    FHumanReadableText: string;
    FFontSize: Integer;
    FTextMargin: Integer;
    FLineColor: TColor;
    FBackgroundColor: TColor;
    FExportFormat: TUniDSABarcodeExportFormat;
    FFileName: string;
    FEmptyText: string;
    FShowActions: Boolean;
    FDataURL: string;
    FSVG: string;
    FValid: Boolean;
    FLastError: string;
    FStyle: TUniDSABarcodeGeneratorStyle;
    FOnGenerated: TNotifyEvent;
    FOnError: TNotifyEvent;
    FOnData: TNotifyEvent;
    function RootID: string;
    function OptionsJSON: string;
    procedure PrepareHTML;
    procedure PrepareJS;
    procedure SetValue(const Value: string);
    procedure SetFormat(const Value: TUniDSABarcodeFormat);
    procedure SetBarWidth(const Value: Integer);
    procedure SetBarHeight(const Value: Integer);
    procedure SetMargin(const Value: Integer);
    procedure SetDisplayValue(const Value: Boolean);
    procedure SetHumanReadableText(const Value: string);
    procedure SetFontSize(const Value: Integer);
    procedure SetTextMargin(const Value: Integer);
    procedure SetLineColor(const Value: TColor);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetExportFormat(const Value: TUniDSABarcodeExportFormat);
    procedure SetFileName(const Value: string);
    procedure SetEmptyText(const Value: string);
    procedure SetShowActions(const Value: Boolean);
    procedure SetStyle(const Value: TUniDSABarcodeGeneratorStyle);
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
    property Valid: Boolean read FValid;
    property LastError: string read FLastError;
  published
    property Align;
    property Anchors;
    property Value: string read FValue write SetValue;
    property Format: TUniDSABarcodeFormat read FFormat write SetFormat default bcCode128;
    property BarWidth: Integer read FBarWidth write SetBarWidth default 2;
    property BarHeight: Integer read FBarHeight write SetBarHeight default 100;
    property Margin: Integer read FMargin write SetMargin default 12;
    property DisplayValue: Boolean read FDisplayValue write SetDisplayValue default True;
    property HumanReadableText: string read FHumanReadableText write SetHumanReadableText;
    property FontSize: Integer read FFontSize write SetFontSize default 18;
    property TextMargin: Integer read FTextMargin write SetTextMargin default 4;
    property LineColor: TColor read FLineColor write SetLineColor default clBlack;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default clWhite;
    property ExportFormat: TUniDSABarcodeExportFormat read FExportFormat write SetExportFormat default befPNG;
    property FileName: string read FFileName write SetFileName;
    property EmptyText: string read FEmptyText write SetEmptyText;
    property ShowActions: Boolean read FShowActions write SetShowActions default True;
    property Style: TUniDSABarcodeGeneratorStyle read FStyle write SetStyle;
    property OnGenerated: TNotifyEvent read FOnGenerated write FOnGenerated;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnData: TNotifyEvent read FOnData write FOnData;
  end;

procedure Register;

implementation

uses
  System.NetEncoding, UniDSASource, UniDSAWebUtils;

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSABarcodeGenerator]);
end;

function BarcodeFormatName(const Value: TUniDSABarcodeFormat): string;
begin
  case Value of
    bcEAN13: Result := 'EAN13';
    bcEAN8: Result := 'EAN8';
    bcUPCA: Result := 'UPC';
    bcCode39: Result := 'CODE39';
    bcITF14: Result := 'ITF14';
    bcCodabar: Result := 'codabar';
  else
    Result := 'CODE128';
  end;
end;

function ExportFormatName(const Value: TUniDSABarcodeExportFormat): string;
begin
  if Value = befSVG then Result := 'svg' else Result := 'png';
end;

constructor TUniDSABarcodeGeneratorStyle.Create(AOwner: TUniDSABarcodeGenerator);
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
  FMaxWidth := 840;
end;

procedure TUniDSABarcodeGeneratorStyle.Assign(Source: TPersistent);
var
  LSource: TUniDSABarcodeGeneratorStyle;
begin
  if Source is TUniDSABarcodeGeneratorStyle then begin
    LSource := TUniDSABarcodeGeneratorStyle(Source);
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

procedure TUniDSABarcodeGeneratorStyle.Changed;
begin
  if Assigned(FOwner) then FOwner.Generate;
end;

procedure TUniDSABarcodeGeneratorStyle.SetPanelBackgroundColor(const Value: TColor);
begin FPanelBackgroundColor := Value; Changed; end;

procedure TUniDSABarcodeGeneratorStyle.SetSurfaceColor(const Value: TColor);
begin FSurfaceColor := Value; Changed; end;

procedure TUniDSABarcodeGeneratorStyle.SetBorderColor(const Value: TColor);
begin FBorderColor := Value; Changed; end;

procedure TUniDSABarcodeGeneratorStyle.SetTextColor(const Value: TColor);
begin FTextColor := Value; Changed; end;

procedure TUniDSABarcodeGeneratorStyle.SetMutedColor(const Value: TColor);
begin FMutedColor := Value; Changed; end;

procedure TUniDSABarcodeGeneratorStyle.SetPrimaryColor(const Value: TColor);
begin FPrimaryColor := Value; Changed; end;

procedure TUniDSABarcodeGeneratorStyle.SetBorderRadius(const Value: Integer);
begin FBorderRadius := UniDSAClamp(Value, 0, 40); Changed; end;

procedure TUniDSABarcodeGeneratorStyle.SetMaxWidth(const Value: Integer);
begin FMaxWidth := UniDSAClamp(Value, 320, 1800); Changed; end;

constructor TUniDSABarcodeGenerator.Create(AOwner: TComponent);
begin
  inherited;
  Width := 640;
  Height := 310;
  FValue := '7891234567895';
  FFormat := bcCode128;
  FBarWidth := 2;
  FBarHeight := 100;
  FMargin := 12;
  FDisplayValue := True;
  FFontSize := 18;
  FTextMargin := 4;
  FLineColor := clBlack;
  FBackgroundColor := clWhite;
  FExportFormat := befPNG;
  FFileName := 'barcode';
  FEmptyText := 'Informe um valor para gerar o codigo de barras.';
  FShowActions := True;
  FStyle := TUniDSABarcodeGeneratorStyle.Create(Self);
end;

destructor TUniDSABarcodeGenerator.Destroy;
begin
  FreeAndNil(FStyle);
  inherited;
end;

procedure TUniDSABarcodeGenerator.ConfigJSClasses(ALoading: Boolean);
begin
  inherited;
  JSObjects.DefaultJSClassName := 'Ext.form.Label';
end;

function TUniDSABarcodeGenerator.RootID: string;
begin
  Result := 'unidsa-barcode-generator-' + JSName;
end;

function TUniDSABarcodeGenerator.OptionsJSON: string;
begin
  Result := '{' +
    'value:' + UniDSAJSString(FValue) + ',' +
    'format:' + UniDSAJSString(BarcodeFormatName(FFormat)) + ',' +
    'barWidth:' + IntToStr(FBarWidth) + ',' +
    'barHeight:' + IntToStr(FBarHeight) + ',' +
    'margin:' + IntToStr(FMargin) + ',' +
    'displayValue:' + UniDSABoolJS(FDisplayValue) + ',' +
    'humanReadableText:' + UniDSAJSString(FHumanReadableText) + ',' +
    'fontSize:' + IntToStr(FFontSize) + ',' +
    'textMargin:' + IntToStr(FTextMargin) + ',' +
    'lineColor:' + UniDSAJSString(UniDSAColorToCSS(FLineColor)) + ',' +
    'background:' + UniDSAJSString(UniDSAColorToCSS(FBackgroundColor)) + ',' +
    'exportFormat:' + UniDSAJSString(ExportFormatName(FExportFormat)) + ',' +
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

procedure TUniDSABarcodeGenerator.PrepareHTML;
var
  LHTML: TStringBuilder;
begin
  if not WebMode then Exit;
  LHTML := TStringBuilder.Create;
  try
    LHTML.Append('<div id="' + RootID + '" class="unidsa-barcode-generator" role="region" aria-label="Gerador de codigo de barras">');
    LHTML.Append('<div class="unidsa-barcode-generator__preview"><svg xmlns="http://www.w3.org/2000/svg"></svg>');
    LHTML.Append('<div class="unidsa-barcode-generator__empty"></div></div>');
    LHTML.Append('<div class="unidsa-barcode-generator__actions">');
    LHTML.Append('<button type="button" class="unidsa-barcode-generator__button" data-barcode-action="download">Baixar</button>');
    LHTML.Append('<button type="button" class="unidsa-barcode-generator__button" data-barcode-action="copy">Copiar imagem</button></div>');
    LHTML.Append('<div class="unidsa-barcode-generator__status" aria-live="polite"></div></div>');
    Caption := LHTML.ToString;
  finally
    FreeAndNil(LHTML);
  end;
end;

procedure TUniDSABarcodeGenerator.PrepareJS;
begin
  if WebMode then
    UniSession.AddJS('if(window.UniDSABarcodeGenerator){window.UniDSABarcodeGenerator.init(' +
      UniDSAJSString(RootID) + ',' + JSName + ',' + OptionsJSON + ');}');
end;

procedure TUniDSABarcodeGenerator.LoadCompleted;
begin
  inherited;
  PrepareHTML;
  PrepareJS;
end;

procedure TUniDSABarcodeGenerator.Generate;
begin
  if WebMode and not IsLoading and not IsDesigning then PrepareJS;
end;

procedure TUniDSABarcodeGenerator.Download;
begin
  JS('UniDSABarcodeGenerator.download(' + UniDSAJSString(RootID) + ',' +
    UniDSAJSString(ExportFormatName(FExportFormat)) + ',' + UniDSAJSString(FFileName) + ');');
end;

procedure TUniDSABarcodeGenerator.CopyToClipboard;
begin
  JS('UniDSABarcodeGenerator.copy(' + UniDSAJSString(RootID) + ');');
end;

procedure TUniDSABarcodeGenerator.RequestData;
begin
  JS('UniDSABarcodeGenerator.requestData(' + UniDSAJSString(RootID) + ');');
end;

procedure TUniDSABarcodeGenerator.JSEventHandler(AEventName: string; AParams: TUniStrings);
begin
  inherited;
  if AEventName = 'UniDSABarcodeGenerated' then begin
    FValid := True;
    FLastError := '';
    if Assigned(FOnGenerated) then FOnGenerated(Self);
  end
  else if AEventName = 'UniDSABarcodeError' then begin
    FValid := False;
    FLastError := TNetEncoding.URL.Decode(AParams.Values['Message']);
    if Assigned(FOnError) then FOnError(Self);
  end
  else if AEventName = 'UniDSABarcodeData' then begin
    FValid := SameText(AParams.Values['Valid'], 'true');
    FDataURL := TNetEncoding.URL.Decode(AParams.Values['DataURL']);
    FSVG := TNetEncoding.URL.Decode(AParams.Values['SVG']);
    if Assigned(FOnData) then FOnData(Self);
  end;
end;

procedure TUniDSABarcodeGenerator.SetValue(const Value: string);
begin FValue := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetFormat(const Value: TUniDSABarcodeFormat);
begin FFormat := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetBarWidth(const Value: Integer);
begin FBarWidth := UniDSAClamp(Value, 1, 8); Generate; end;

procedure TUniDSABarcodeGenerator.SetBarHeight(const Value: Integer);
begin FBarHeight := UniDSAClamp(Value, 30, 400); Generate; end;

procedure TUniDSABarcodeGenerator.SetMargin(const Value: Integer);
begin FMargin := UniDSAClamp(Value, 0, 60); Generate; end;

procedure TUniDSABarcodeGenerator.SetDisplayValue(const Value: Boolean);
begin FDisplayValue := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetHumanReadableText(const Value: string);
begin FHumanReadableText := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetFontSize(const Value: Integer);
begin FFontSize := UniDSAClamp(Value, 8, 72); Generate; end;

procedure TUniDSABarcodeGenerator.SetTextMargin(const Value: Integer);
begin FTextMargin := UniDSAClamp(Value, 0, 40); Generate; end;

procedure TUniDSABarcodeGenerator.SetLineColor(const Value: TColor);
begin FLineColor := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetBackgroundColor(const Value: TColor);
begin FBackgroundColor := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetExportFormat(const Value: TUniDSABarcodeExportFormat);
begin FExportFormat := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetFileName(const Value: string);
begin FFileName := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetEmptyText(const Value: string);
begin FEmptyText := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetShowActions(const Value: Boolean);
begin FShowActions := Value; Generate; end;

procedure TUniDSABarcodeGenerator.SetStyle(const Value: TUniDSABarcodeGeneratorStyle);
begin FStyle.Assign(Value); end;

procedure TUniDSABarcodeGenerator.WebCreate;
begin
  inherited;
  JSCls := 'x-unidsa-barcode-generator';
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.BarcodeGenerator);

end.
