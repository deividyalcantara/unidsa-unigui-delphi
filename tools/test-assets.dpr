program TestAssets;
{$APPTYPE CONSOLE}
uses
  System.SysUtils, System.Classes, System.IOUtils,
  UniDSASource, UniDSAToast, UniDSAConfirm, UniDSAQrCodeReader,
  UniDSAMenuLateral, UniDSALogin, UniDSAKanban, UniDSATour,
  UniDSAFlexPanel, UniDSAFormStyle, UniDSAResponsivePageControl,
  UniDSAQrCodeGenerator, UniDSASignature, UniDSABarcodeGenerator,
  UniDSAStyle, UniDSAFocusControl;
type
  TInheritedFormStyle = class(TUniDSAFormStyle);
procedure Check(Value: Boolean; const Message: string);
begin
  if not Value then raise Exception.Create(Message);
end;
procedure PutFile(const FileName: string);
begin
  ForceDirectories(ExtractFilePath(FileName));
  TFile.WriteAllText(FileName, 'fixture');
end;
procedure TestMessage;
var
  HTML, MessageText, OutputFolder: string;
begin
  OutputFolder := ExtractFilePath(ParamStr(0));
  MessageText := AssetError(TUniDSAFormStyle,
    TPath.Combine(OutputFolder, 'missing-message-files'));
  HTML := AssetErrorHTML('<img src=x onerror=alert(1)>&"');
  Check(Pos('<img', HTML) = 0, 'Message HTML must escape markup');
  Check(Pos('&lt;img', HTML) > 0, 'Escaped detail missing');
  Check(Pos('&amp;', HTML) > 0, 'Message ampersands must be escaped');
  Check(Pos('<link', HTML) = 0, 'Message must not load external CSS');
  Check(Pos('<script', HTML) = 0, 'Initial message must work without JavaScript');
  Check(Pos('<style>', HTML) > 0, 'Message CSS must be embedded');
  Check(Pos('backdrop-filter', HTML) = 0, 'Message must use an opaque background');
  OutputFolder := ExtractFilePath(ParamStr(0));
  TFile.WriteAllText(TPath.Combine(OutputFolder, 'message-preview.html'), AssetErrorHTML(MessageText), TEncoding.UTF8);
  TFile.WriteAllText(TPath.Combine(OutputFolder, 'message-preview.js'), AssetErrorScript(MessageText), TEncoding.UTF8);
end;
procedure TestComponent(AClass: TClass; const FilesFolder, RelativeFiles: string);
var
  Files: TArray<string>;
  RelativeFile, FileName, ErrorText: string;
begin
  Files := RelativeFiles.Split(['|']);
  for RelativeFile in Files do
    PutFile(TPath.Combine(FilesFolder, StringReplace('dsa/' + RelativeFile, '/', PathDelim, [rfReplaceAll])));
  Check(AssetError(AClass, FilesFolder) = '', AClass.ClassName + ': complete files rejected');
  for RelativeFile in Files do
  begin
    FileName := TPath.Combine(FilesFolder, StringReplace('dsa/' + RelativeFile, '/', PathDelim, [rfReplaceAll]));
    TFile.Delete(FileName);
    try
      ErrorText := AssetError(AClass, FilesFolder);
      Check(Pos('arquivo ausente: ' + ExtractFileName(FileName), ErrorText) > 0,
        AClass.ClassName + ': missing file not identified: ' + RelativeFile);
      Check(Pos(AClass.ClassName, ErrorText) > 0, 'Component name missing');
      Check(Pos(FilesFolder, ErrorText) = 0, 'Physical FilesFolder must not be displayed');
      Check(Pos('dsa/' + RelativeFile, ErrorText) = 0, 'Asset directory must not be displayed');
    finally
      PutFile(FileName);
    end;
  end;
  Check(AssetError(AClass, IncludeTrailingPathDelimiter(FilesFolder)) = '',
    'Trailing separator must be accepted');
end;
const
  Classes: array[0..12] of TClass = (
    TUniDSAToast, TUniDSAConfirm, TUniDSAQrCodeReader, TUniDSAMenuLateral,
    TUniDSALogin, TUniDSAKanban, TUniDSATour, TUniDSAFlexPanel,
    TUniDSAFormStyle, TUniDSAResponsivePageControl, TUniDSAQrCodeGenerator,
    TUniDSASignature, TUniDSABarcodeGenerator);
  RequiredFiles: array[0..12] of string = (
    'css/jquery.toast.css|js/jquery.toast.js',
    'dist/jquery-confirm.min.css|dist/jquery-confirm.min.js|css/dsa.css',
    'qrcode_reader/css/style.css|qrcode_reader/js/qrcode_library.js|qrcode_reader/js/script.js',
    'menu_lateral/css/style.css|menu_lateral/js/script.js',
    'login/css/style.css|login/js/script.js',
    'kanban/css/style.css|kanban/js/script.js',
    'tour/css/style.css|tour/js/script.js',
    'flex/css/unidsa-flex.css|flex/js/unidsa-flex.js',
    'form-style/css/style.css|form-style/js/script.js',
    'responsive-page-control/css/style.css|responsive-page-control/js/script.js',
    'qrcode_generator/css/style.css|qrcode_generator/js/qrcode.js|qrcode_generator/js/script.js',
    'signature/css/style.css|signature/js/script.js',
    'barcode_generator/css/style.css|barcode_generator/js/JsBarcode.all.min.js|barcode_generator/js/script.js');
var
  TestRoot, FilesFolder, ErrorText: string;
  Id: TGUID;
  I: Integer;
begin
  try
    TestMessage;
    CreateGUID(Id);
    TestRoot := TPath.Combine(ExtractFilePath(ParamStr(0)), 'fixtures-' + GUIDToString(Id));
    FilesFolder := TPath.Combine(TestRoot, 'custom files');
    for I := Low(Classes) to High(Classes) do
    begin
      ErrorText := AssetError(Classes[I], FilesFolder);
      Check(Pos('pasta "dsa" ausente', ErrorText) > 0, Classes[I].ClassName + ': absent folder ignored');
      Check(Pos('Copie a pasta "dsa" completa', ErrorText) > 0, 'Recovery instructions missing');
      Check(Pos(FilesFolder, ErrorText) = 0, 'Missing folder message must not disclose its location');
      Check(Pos('ServerModule.FilesFolder', ErrorText) = 0, 'Configuration address must not be displayed');
    end;
    Check(AssetError(TUniDSAStyle, FilesFolder) = '', 'Embedded Style must not require files');
    Check(AssetError(TUniDSAFocusControl, FilesFolder) = '', 'Embedded FocusControl must not require files');
    Check(AssetError(TComponent, FilesFolder) = '', 'Unrelated component must be ignored');
    Check(AssetError(nil, FilesFolder) = '', 'Nil class must be ignored');
    Check(Pos('TInheritedFormStyle', AssetError(TInheritedFormStyle, FilesFolder)) > 0,
      'Inherited components must retain validation');
    UniDSASource.CheckAssets(nil);
    for I := Low(Classes) to High(Classes) do
      TestComponent(Classes[I], FilesFolder, RequiredFiles[I]);
    Check(AssetError(TInheritedFormStyle, FilesFolder) = '', 'Inherited valid component rejected');
    Writeln('PASS: 13 components, missing folder, every required CSS/JS file, version queries, custom FilesFolder, inherited components and embedded runtimes.');
  except
    on E: Exception do begin Writeln(E.ClassName + ': ' + E.Message); Halt(1); end;
  end;
end.