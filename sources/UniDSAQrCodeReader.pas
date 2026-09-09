unit UniDSAQrCodeReader;

interface

uses
  System.SysUtils, System.Classes, uniGUIClasses, UniDSABaseControl,
  UniDSAExecuteFunction, uniGUITypes, System.TypInfo, UniDSALibrary,
  System.Variants, Vcl.Graphics, UniDSASource, UniDSAWebUtils;

type
  TUniDSAQrCodeReader = class;

  TUniDSAQrCodeReaderStyle = class(TPersistent)
  private
    FOwner: TUniDSAQrCodeReader;
    FBackgroundColor: TColor;
    FSurfaceColor: TColor;
    FBorderColor: TColor;
    FTextColor: TColor;
    FMutedColor: TColor;
    FPrimaryColor: TColor;
    FBorderRadius: Integer;
    FMaxWidth: Integer;
    FVideoMaxHeight: Integer;
    procedure Changed;
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetSurfaceColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
    procedure SetMutedColor(const Value: TColor);
    procedure SetPrimaryColor(const Value: TColor);
    procedure SetBorderRadius(const Value: Integer);
    procedure SetMaxWidth(const Value: Integer);
    procedure SetVideoMaxHeight(const Value: Integer);
  public
    constructor Create(AOwner: TUniDSAQrCodeReader);
    procedure Assign(Source: TPersistent); override;
  published
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default $00FBF9F6;
    property SurfaceColor: TColor read FSurfaceColor write SetSurfaceColor default clWhite;
    property BorderColor: TColor read FBorderColor write SetBorderColor default $00E8E2DB;
    property TextColor: TColor read FTextColor write SetTextColor default $003B2E23;
    property MutedColor: TColor read FMutedColor write SetMutedColor default $00766A5E;
    property PrimaryColor: TColor read FPrimaryColor write SetPrimaryColor default $00EB6325;
    property BorderRadius: Integer read FBorderRadius write SetBorderRadius default 16;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 720;
    property VideoMaxHeight: Integer read FVideoMaxHeight write SetVideoMaxHeight default 420;
  end;

  TUniDSAQrCodeReaderSupportedFormats = class(TPersistent)
  private
    FQR_CODE: Boolean;
    FAZTEC: Boolean;
    FCODABAR: Boolean;
    FCODE_39: Boolean;
    FCODE_93: Boolean;
    FCODE_128: Boolean;
    FDATA_MATRIX: Boolean;
    FMAXICODE: Boolean;
    FITF: Boolean;
    FEAN_13: Boolean;
    FEAN_8: Boolean;
    FPDF_417: Boolean;
    FRSS_14: Boolean;
    FRSS_EXPANDED: Boolean;
    FUPC_A: Boolean;
    FUPC_E: Boolean;
    FUPC_EAN_EXTENSION: Boolean;

  public
    constructor Create;
    destructor Destroy; override;
  published
    property QR_CODE: Boolean read FQR_CODE write FQR_CODE;
    property AZTEC: Boolean read FAZTEC write FAZTEC;
    property CODABAR: Boolean read FCODABAR write FCODABAR;
    property CODE_39: Boolean read FCODE_39 write FCODE_39;
    property CODE_93: Boolean read FCODE_93 write FCODE_93;
    property CODE_128: Boolean read FCODE_128 write FCODE_128;
    property DATA_MATRIX: Boolean read FDATA_MATRIX write FDATA_MATRIX;
    property MAXICODE: Boolean read FMAXICODE write FMAXICODE;
    property ITF: Boolean read FITF write FITF;
    property EAN_13: Boolean read FEAN_13 write FEAN_13;
    property EAN_8: Boolean read FEAN_8 write FEAN_8;
    property PDF_417: Boolean read FPDF_417 write FPDF_417;
    property RSS_14: Boolean read FRSS_14 write FRSS_14;
    property RSS_EXPANDED: Boolean read FRSS_EXPANDED write FRSS_EXPANDED;
    property UPC_A: Boolean read FUPC_A write FUPC_A;
    property UPC_E: Boolean read FUPC_E write FUPC_E;
    property UPC_EAN_EXTENSION: Boolean read FUPC_EAN_EXTENSION write FUPC_EAN_EXTENSION;
  end;

  TUniDSAQrCodeReader = class(TUniDSABaseControl)
  private
    FQrCodeReader: TExecuteFunction;
    FText: string;
    FSingleRead: Boolean;
    FOnAfterReading: TNotifyEvent;
    FQrBox: Integer;
    FFPS: Integer;
    FSupportedFormats: TUniDSAQrCodeReaderSupportedFormats;
    FStyle: TUniDSAQrCodeReaderStyle;

    function RootID: string;
    function StyleJSON: string;
    procedure SetStyle(const Value: TUniDSAQrCodeReaderStyle);
    procedure PrepareHtml;
    procedure PrepareJS;
    procedure NovoCaption(const Value: string);
  protected
    procedure JSEventHandler(AEventName: string; AParams: TUniStrings); override;
    procedure ConfigJSClasses(ALoading: Boolean); override;
    procedure InternalSetCaption(const Value: string); override;
    procedure LoadCompleted; override;
    procedure WebCreate; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplyStyle;
  published
    procedure Stop;
    procedure Start;
    property Align;
    property Text: string read FText write FText;
    property Result: string read FText write FText;
    property SingleRead: Boolean read FSingleRead write FSingleRead;
    property QrBox: Integer read FQrBox write FQrBox;
    property FPS: Integer read FFPS write FFPS;
    property SupportedFormats: TUniDSAQrCodeReaderSupportedFormats read FSupportedFormats write FSupportedFormats;
    property Style: TUniDSAQrCodeReaderStyle read FStyle write SetStyle;
    property OnAfterReading: TNotifyEvent read FOnAfterReading write FOnAfterReading;
  end;

procedure Register;

implementation

{ TUniDSAQrCodeReader }

function ClampStyleValue(const AValue, AMin, AMax: Integer): Integer;
begin
  Result := UniDSAClamp(AValue, AMin, AMax);
end;

constructor TUniDSAQrCodeReaderStyle.Create(AOwner: TUniDSAQrCodeReader);
begin
  inherited Create;
  FOwner := AOwner;
  FBackgroundColor := $00FBF9F6;
  FSurfaceColor := clWhite;
  FBorderColor := $00E8E2DB;
  FTextColor := $003B2E23;
  FMutedColor := $00766A5E;
  FPrimaryColor := $00EB6325;
  FBorderRadius := 16;
  FMaxWidth := 720;
  FVideoMaxHeight := 420;
end;

procedure TUniDSAQrCodeReaderStyle.Assign(Source: TPersistent);
var
  LSource: TUniDSAQrCodeReaderStyle;
begin
  if Source is TUniDSAQrCodeReaderStyle then begin
    LSource := TUniDSAQrCodeReaderStyle(Source);
    FBackgroundColor := LSource.BackgroundColor;
    FSurfaceColor := LSource.SurfaceColor;
    FBorderColor := LSource.BorderColor;
    FTextColor := LSource.TextColor;
    FMutedColor := LSource.MutedColor;
    FPrimaryColor := LSource.PrimaryColor;
    FBorderRadius := LSource.BorderRadius;
    FMaxWidth := LSource.MaxWidth;
    FVideoMaxHeight := LSource.VideoMaxHeight;
    Changed;
  end else
    inherited;
end;

procedure TUniDSAQrCodeReaderStyle.Changed;
begin
  if Assigned(FOwner) then FOwner.ApplyStyle;
end;

procedure TUniDSAQrCodeReaderStyle.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
  Changed;
end;

procedure TUniDSAQrCodeReaderStyle.SetSurfaceColor(const Value: TColor);
begin
  FSurfaceColor := Value;
  Changed;
end;

procedure TUniDSAQrCodeReaderStyle.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Changed;
end;

procedure TUniDSAQrCodeReaderStyle.SetTextColor(const Value: TColor);
begin
  FTextColor := Value;
  Changed;
end;

procedure TUniDSAQrCodeReaderStyle.SetMutedColor(const Value: TColor);
begin
  FMutedColor := Value;
  Changed;
end;

procedure TUniDSAQrCodeReaderStyle.SetPrimaryColor(const Value: TColor);
begin
  FPrimaryColor := Value;
  Changed;
end;

procedure TUniDSAQrCodeReaderStyle.SetBorderRadius(const Value: Integer);
begin
  FBorderRadius := ClampStyleValue(Value, 0, 40);
  Changed;
end;

procedure TUniDSAQrCodeReaderStyle.SetMaxWidth(const Value: Integer);
begin
  FMaxWidth := ClampStyleValue(Value, 280, 1600);
  Changed;
end;

procedure TUniDSAQrCodeReaderStyle.SetVideoMaxHeight(const Value: Integer);
begin
  FVideoMaxHeight := ClampStyleValue(Value, 180, 900);
  Changed;
end;

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAQrCodeReader]);
end;

procedure TUniDSAQrCodeReader.JSEventHandler(AEventName: string; AParams: TUniStrings);
begin
  inherited;
  if AEventName = 'UniDSAQrCodeReaderAfterReading' then begin
    FText := AParams.Values['Resultado'];

    if Assigned(FOnAfterReading) then
      FOnAfterReading(Self);
  end;
end;

procedure TUniDSAQrCodeReader.LoadCompleted;
begin
  inherited;
  PrepareHTML;
  PrepareJS;
end;

procedure TUniDSAQrCodeReader.NovoCaption(const Value: string);
begin
  JSProperty('html', [Caption, False], 'setText');
end;

procedure TUniDSAQrCodeReader.ConfigJSClasses(ALoading: Boolean);
begin
  inherited;
  JSObjects.DefaultJSClassName:='Ext.form.Label';
end;

constructor TUniDSAQrCodeReader.Create(AOwner: TComponent);
begin
  inherited;
  FText := '';
  FSingleRead := True;
  Self.Height := 100;
  Self.Width := 100;
  FQrBox := 250;
  FFPS := 10;
  FQrCodeReader := TExecuteFunction.Create('qrCodeReader');
  FSupportedFormats := TUniDSAQrCodeReaderSupportedFormats.Create;
  FStyle := TUniDSAQrCodeReaderStyle.Create(Self);
end;

destructor TUniDSAQrCodeReader.Destroy;
begin
  FreeAndNil(FQrCodeReader);
  FreeAndNil(FSupportedFormats);
  FreeAndNil(FStyle);
  inherited;
end;

procedure TUniDSAQrCodeReader.InternalSetCaption(const Value: string);
begin
  inherited;
  if not IsDesigning then
  begin
    InternalSetText(Value);

    if not IsLoading then
      NovoCaption(Value);
  end;
end;

procedure TUniDSAQrCodeReader.PrepareHtml;
var
  LHTML: TStringBuilder;
begin
  if WebMode then begin
    LHTML := TStringBuilder.Create;

    try
      with LHTML do begin
        Append('<div id="' + RootID + '" class="unidsa-qrcode-reader"></div>');

        Caption := LHTML.ToString;
      end;
    finally
      FreeAndNil(LHTML);
    end;
  end;
end;

procedure TUniDSAQrCodeReader.PrepareJS;
begin
  if WebMode then begin
    JSCode(
      '$(document).ready(function(){ ' +
      '  function docReady(fn) { ' +
      '    if (document.readyState === "complete" ' +
      '      || document.readyState === "interactive") { ' +
      '      setTimeout(fn, 1); ' +
      '    } else { ' +
      '      document.addEventListener("DOMContentLoaded", fn); ' +
      '    } ' +
      '} ' +

      'const formatsToSupport = [ ' +
      '  ' + IIfVar(FSupportedFormats.QR_CODE, 'Html5QrcodeSupportedFormats.QR_CODE,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.AZTEC, 'Html5QrcodeSupportedFormats.AZTEC,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.CODABAR, 'Html5QrcodeSupportedFormats.CODABAR,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.CODE_39, 'Html5QrcodeSupportedFormats.CODE_39,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.CODE_93, 'Html5QrcodeSupportedFormats.CODE_93,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.CODE_128, 'Html5QrcodeSupportedFormats.CODE_128,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.DATA_MATRIX, 'Html5QrcodeSupportedFormats.DATA_MATRIX,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.MAXICODE, 'Html5QrcodeSupportedFormats.MAXICODE,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.ITF, 'Html5QrcodeSupportedFormats.ITF,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.EAN_13, 'Html5QrcodeSupportedFormats.EAN_13,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.EAN_8, 'Html5QrcodeSupportedFormats.EAN_8,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.PDF_417, 'Html5QrcodeSupportedFormats.PDF_417,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.RSS_14, 'Html5QrcodeSupportedFormats.RSS_14,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.RSS_EXPANDED, 'Html5QrcodeSupportedFormats.RSS_EXPANDED,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.UPC_A, 'Html5QrcodeSupportedFormats.UPC_A,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.UPC_E, 'Html5QrcodeSupportedFormats.UPC_E,', ' ' ) +
      '  ' + IIfVar(FSupportedFormats.UPC_EAN_EXTENSION, 'Html5QrcodeSupportedFormats.UPC_EAN_EXTENSION,', ' ' ) +
      ']; ' +

      '  docReady(function () { ' +
      '  var lastResult, countResults = 0; ' +
      '  function onScanSuccess(decodedText, decodedResult) { ' +
      '    if (decodedText !== lastResult) { ' +
      '      ++countResults; ' +
      '      lastResult = decodedText; ' +

      '      ajaxRequest('+ Self.JSName + ', "UniDSAQrCodeReaderAfterReading", ["Resultado=" + lastResult]); ' +
      '  ' + IIfVar(not SingleRead, ' ', 'html5QrcodeScanner.clear(); ' ) +
      '    } ' +
      '  } ' +

      '  var html5QrcodeScanner = new Html5QrcodeScanner( ' +
      '    "' + RootID + '", { fps: ' + IntToStr(FPS) + ', qrbox: ' + IntToStr(FQrBox) + ', formatsToSupport: formatsToSupport }); ' +
      '    html5QrcodeScanner.render(onScanSuccess); ' +
      '    UniDSAQrCodeReader.attach("' + RootID + '", ' + StyleJSON + '); ' +
      '  }); ' +
      '}); '
    );
  end;
end;

function TUniDSAQrCodeReader.RootID: string;
begin
  Result := 'uni-dsa-qrcode-reader-qr-reader-' + JSName;
end;

function TUniDSAQrCodeReader.StyleJSON: string;
begin
  Result := '{' +
    '"background":' + UniDSAJSString(UniDSAColorToCSS(FStyle.BackgroundColor)) + ',' +
    '"surface":' + UniDSAJSString(UniDSAColorToCSS(FStyle.SurfaceColor)) + ',' +
    '"border":' + UniDSAJSString(UniDSAColorToCSS(FStyle.BorderColor)) + ',' +
    '"text":' + UniDSAJSString(UniDSAColorToCSS(FStyle.TextColor)) + ',' +
    '"muted":' + UniDSAJSString(UniDSAColorToCSS(FStyle.MutedColor)) + ',' +
    '"primary":' + UniDSAJSString(UniDSAColorToCSS(FStyle.PrimaryColor)) + ',' +
    '"radius":' + IntToStr(FStyle.BorderRadius) + ',' +
    '"maxWidth":' + IntToStr(FStyle.MaxWidth) + ',' +
    '"videoMaxHeight":' + IntToStr(FStyle.VideoMaxHeight) + '}';
end;

procedure TUniDSAQrCodeReader.ApplyStyle;
begin
  if WebMode and not IsLoading and Assigned(FStyle) then
    JS('UniDSAQrCodeReader.attach(' + UniDSAJSString(RootID) + ',' + StyleJSON + ');');
end;

procedure TUniDSAQrCodeReader.SetStyle(const Value: TUniDSAQrCodeReaderStyle);
begin
  FStyle.Assign(Value);
end;

procedure TUniDSAQrCodeReader.Start;
begin
  JS('$("#' + RootID + '").find("#html5-qrcode-button-camera-start").click();');
end;

procedure TUniDSAQrCodeReader.Stop;
begin
  JS('$("#' + RootID + '").find("#html5-qrcode-button-camera-stop").click();');
end;

procedure TUniDSAQrCodeReader.WebCreate;
begin
  inherited;
  JSCls:='x-uni-dsa-qrcode-reader';
end;

{ TUniDSAQrCodeReaderSupportedFormats }

constructor TUniDSAQrCodeReaderSupportedFormats.Create;
begin
  FQR_CODE := True;
  FAZTEC := True;
  FCODABAR := True;
  FCODE_39 := True;
  FCODE_93 := True;
  FCODE_128 := True;
  FDATA_MATRIX := True;
  FMAXICODE := True;
  FITF := True;
  FEAN_13 := True;
  FEAN_8 := True;
  FPDF_417 := True;
  FRSS_14 := True;
  FRSS_EXPANDED := True;
  FUPC_A := True;
  FUPC_E := True;
  FUPC_EAN_EXTENSION := True;
end;

destructor TUniDSAQrCodeReaderSupportedFormats.Destroy;
begin
  inherited;
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.QrCodeReader);

end.
