unit UniDSAQrCodeReader;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSABaseControl, UniDSAJQuery, uniGUITypes,
 System.TypInfo, UniDSALibrary, System.Variants, Vcl.Graphics, UniDSASource, UniDSABrowser;

type
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
    FQrCodeReader: TJQuery;
    FText: string;
    FSingleRead: Boolean;
    FOnAfterReading: TNotifyEvent;
    FQrBox: Integer;
    FFPS: Integer;
    FSupportedFormats: TUniDSAQrCodeReaderSupportedFormats;

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
    property OnAfterReading: TNotifyEvent read FOnAfterReading write FOnAfterReading;
  end;

procedure Register;

implementation

{ TUniDSAQrCodeReader }

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
  FQrCodeReader := TJQuery.Create('qrCodeReader');
  FSupportedFormats := TUniDSAQrCodeReaderSupportedFormats.Create;
end;

destructor TUniDSAQrCodeReader.Destroy;
begin
  inherited;
  FreeAndNil(FQrCodeReader);
  FreeAndNil(FSupportedFormats);
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
        Append('<div id="uni-dsa-qrcode-reader-qr-reader-' + Self.JSName + '"  style="width:' + IntToStr(Round(Self.Width)) + 'px"></div>');

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
      '    "uni-dsa-qrcode-reader-qr-reader-' + Self.JSName + '", { fps: ' + IntToStr(FPS) + ', qrbox: ' + IntToStr(FQrBox) + ', formatsToSupport: formatsToSupport }); ' +
      '    html5QrcodeScanner.render(onScanSuccess); ' +
      '  }); ' +
      '}); '
    );
  end;
end;

procedure TUniDSAQrCodeReader.Start;
begin
  JS('$("#uni-dsa-qrcode-reader-qr-reader-' + Self.JSName + '").find("#html5-qrcode-button-camera-start").click();');
end;

procedure TUniDSAQrCodeReader.Stop;
begin
  JS('$("#uni-dsa-qrcode-reader-qr-reader-' + Self.JSName + '").find("#html5-qrcode-button-camera-stop").click();');
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
