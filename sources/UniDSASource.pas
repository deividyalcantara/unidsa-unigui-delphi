unit UniDSASource;

interface

uses
  System.Classes, uniGUIClasses, uniGUITypes;

type
  TTypeUniDSASource = (Toast, Confirm, MenuSiderbar, QrCodeReader, MenuLateral,
    Login, Kanban, Tour, Flex, FormStyle, ResponsivePageControl,
    QrCodeGenerator, Signature, BarcodeGenerator);

procedure GetLink(AComponent: TTypeUniDSASource);
function AssetError(AComponentClass: TClass; const AFilesFolder: string): string;
function AssetErrorHTML(const AMessage: string; ACanDismiss: Boolean = False): string;
function AssetErrorScript(const AMessage: string): string;
procedure CheckAssets(AComponent: TComponent);

implementation

uses
  System.SysUtils, uniGUIApplication, uniGUIServer, UniDSAWebUtils;

var
  AssetFiles: array[TTypeUniDSASource] of TArray<string>;

const
  {$IFDEF DEBUG}
     cFolder = '/files/dsa';
  {$ELSE}
     cFolder = './files/dsa';
  {$ENDIF}

function AssetType(AComponentClass: TClass; out AType: TTypeUniDSASource): Boolean;
const
  ComponentClasses: array[TTypeUniDSASource] of string = (
    'TUniDSAToast', 'TUniDSAConfirm', '', 'TUniDSAQrCodeReader',
    'TUniDSAMenuLateral', 'TUniDSALogin', 'TUniDSAKanban', 'TUniDSATour',
    'TUniDSAFlexPanel', 'TUniDSAFormStyle', 'TUniDSAResponsivePageControl',
    'TUniDSAQrCodeGenerator', 'TUniDSASignature', 'TUniDSABarcodeGenerator');
var
  Kind: TTypeUniDSASource;
begin
  while Assigned(AComponentClass) do
  begin
    for Kind := Low(TTypeUniDSASource) to High(TTypeUniDSASource) do
      if SameText(AComponentClass.ClassName, ComponentClasses[Kind]) then
      begin
        AType := Kind;
        Exit(True);
      end;
    AComponentClass := AComponentClass.ClassParent;
  end;
  Result := False;
end;

function AssetError(AComponentClass: TClass; const AFilesFolder: string): string;
var
  Kind: TTypeUniDSASource;
  Root, RelativeFile, FileName: string;
begin
  Result := '';
  // Embedded runtimes (Style/FocusControl) do not require the dsa folder.
  if not AssetType(AComponentClass, Kind) or (Length(AssetFiles[Kind]) = 0) then Exit;
  Root := IncludeTrailingPathDelimiter(AFilesFolder) + 'dsa';
  if not DirectoryExists(Root) then
    Result := 'UniDSA: pasta "dsa" ausente.'
  else
    for RelativeFile in AssetFiles[Kind] do
    begin
      FileName := IncludeTrailingPathDelimiter(Root) +
        StringReplace(RelativeFile, '/', PathDelim, [rfReplaceAll]);
      if not FileExists(FileName) then
      begin
        Result := 'UniDSA: arquivo ausente: ' + ExtractFileName(FileName) + '.';
        Break;
      end;
    end;
  if Result <> '' then
    Result := Result + sLineBreak + 'Componente: ' + AComponentClass.ClassName + '.' +
      sLineBreak + 'Copie a pasta "dsa" completa do UniDSA para a aplica' + #231#227 + 'o' +
      ' e recarregue a tela.';
end;

function AssetErrorHTML(const AMessage: string; ACanDismiss: Boolean): string;
const
  CMessageHTML =
    '<section id="dsa-assets-message" role="alertdialog" aria-modal="true" aria-labelledby="dsa-assets-title" aria-describedby="dsa-assets-details" tabindex="-1">' + #10 +
    '<style>' + #10 +
    '#dsa-assets-message,#dsa-assets-message *{box-sizing:border-box}' + #10 +
    '#dsa-assets-message{position:fixed;inset:0;z-index:2147483647;display:flex;overflow:auto;padding:32px 20px;background:#f0f4f9;color:#172b45;font:400 15px/1.6 "Segoe UI",Arial,sans-serif;text-align:left}' + #10 +
    '#dsa-assets-message .dsa-assets-card{width:100%;max-width:520px;margin:auto;padding:36px;background:#fff;border:1px solid #dde5ee;border-radius:24px;box-shadow:0 16px 48px rgba(28,52,84,.09)}' + #10 +
    '#dsa-assets-message .dsa-assets-icon{display:flex;align-items:center;justify-content:center;width:60px;height:60px;margin-bottom:24px;border-radius:18px;background:#fff4df;color:#aa6a10}' + #10 +
    '#dsa-assets-message svg{width:30px;height:30px;display:block}' + #10 +
    '#dsa-assets-message .dsa-assets-label{margin:0 0 8px;color:#61758c;font-size:11px;font-weight:700;letter-spacing:1.8px;text-transform:uppercase}' + #10 +
    '#dsa-assets-message h1{margin:0 0 12px;font-size:28px;line-height:1.2;font-weight:650;letter-spacing:-.7px;color:#172b45}' + #10 +
    '#dsa-assets-message .dsa-assets-description{margin:0 0 24px;color:#61758c;font-size:15px}' + #10 +
    '#dsa-assets-message .dsa-assets-details{margin:0;padding:18px 20px;border:1px solid #e3eaf2;border-radius:12px;background:#f7f9fc;color:#40546c;font:400 13px/1.8 "Segoe UI",Arial,sans-serif;white-space:pre-wrap;overflow-wrap:anywhere}' + #10 +
    '#dsa-assets-message .dsa-assets-actions{display:flex;flex-wrap:wrap;gap:12px;margin-top:28px}' + #10 +
    '#dsa-assets-message .dsa-assets-action{display:inline-flex;min-height:46px;align-items:center;justify-content:center;padding:10px 20px;border:1px solid transparent;border-radius:10px;background:#1766d5;color:#fff;font:600 14px/1.5 "Segoe UI",Arial,sans-serif;text-decoration:none;cursor:pointer}' + #10 +
    '#dsa-assets-message .dsa-assets-action:hover{background:#1255b6}' + #10 +
    '#dsa-assets-message .dsa-assets-action:focus-visible{outline:3px solid #81adf0;outline-offset:3px}' + #10 +
    '#dsa-assets-message .dsa-assets-secondary{background:#fff;border-color:#dce5f0;color:#40546c}' + #10 +
    '#dsa-assets-message .dsa-assets-secondary:hover{background:#f0f4f9}' + #10 +
    '#dsa-assets-message .dsa-assets-footer{margin:22px 0 0;color:#75869a;font-size:12px}' + #10 +
    '@media(max-width:540px){#dsa-assets-message{padding:20px 14px}#dsa-assets-message .dsa-assets-card{padding:26px 22px;border-radius:20px}#dsa-assets-message h1{font-size:25px}#dsa-assets-message .dsa-assets-action{flex:1}}' + #10 +
    '</style>' + #10 +
    '<div class="dsa-assets-card">' + #10 +
    '<div class="dsa-assets-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M20 11V7a2 2 0 0 0-2-2h-7L9 3H4a2 2 0 0 0-2 2v13a2 2 0 0 0 2 2h8"/><path d="M16 14h6M19 11v6"/><path d="M16 21h6"/></svg></div>' + #10 +
    '<p class="dsa-assets-label">UniDSA &middot; Arquivos do componente</p>' + #10 +
    '<h1 id="dsa-assets-title">Faltam alguns arquivos</h1>' + #10 +
    '<p class="dsa-assets-description">Os recursos necess&aacute;rios para abrir esta tela ainda n&atilde;o est&atilde;o dispon&iacute;veis.</p>' + #10 +
    '<div id="dsa-assets-details" class="dsa-assets-details">{{message}}</div>' + #10 +
    '<div class="dsa-assets-actions">' + #10 +
    '<a class="dsa-assets-action" data-dsa-reload href="[###url###]" target="_top" autofocus>Recarregar tela</a>' + #10 +
    '{{dismiss}}' + #10 +
    '</div>' + #10 +
    '<p class="dsa-assets-footer">Depois de adicionar os arquivos, recarregue para tentar novamente.</p>' + #10 +
    '</div>' + #10 +
    '</section>';
var
  Dismiss: string;
begin
  if ACanDismiss then
    Dismiss := '<button type="button" class="dsa-assets-action dsa-assets-secondary" data-dsa-dismiss>Voltar</button>'
  else
    Dismiss := '';
  Result := StringReplace(CMessageHTML, '{{dismiss}}', Dismiss, [rfReplaceAll]);
  Result := StringReplace(Result, '{{message}}', UniDSAHtmlEncode(AMessage), [rfReplaceAll]);
  if not ACanDismiss then
    Result := '<meta name="viewport" content="width=device-width,initial-scale=1">' + Result;
end;

function AssetErrorScript(const AMessage: string): string;
const
  CMessageScript =
    '(function(html){' + #10 +
    '  var previous=document.activeElement,old=document.getElementById("dsa-assets-message");' + #10 +
    '  if(old&&old.dsaPreviousFocus)previous=old.dsaPreviousFocus;' + #10 +
    '  if(old){if(old.dsaDispose)old.dsaDispose(false);else old.remove();}' + #10 +
    '  var holder=document.createElement("div");holder.innerHTML=html;' + #10 +
    '  var notice=holder.firstElementChild;' + #10 +
    '  document.body.appendChild(notice);' + #10 +
    '  var reload=notice.querySelector("[data-dsa-reload]"),close=notice.querySelector("[data-dsa-dismiss]");' + #10 +
    '  function dispose(restore){' + #10 +
    '    document.removeEventListener("keydown",keydown,true);' + #10 +
    '    document.removeEventListener("focusin",focusin,true);' + #10 +
    '    notice.remove();' + #10 +
    '    if(restore&&previous&&previous.isConnected)previous.focus();' + #10 +
    '  }' + #10 +
    '  function keydown(event){' + #10 +
    '    if(event.key==="Escape"){event.preventDefault();event.stopPropagation();dispose(true);}' + #10 +
    '    else if(event.key==="Tab"){' + #10 +
    '      event.preventDefault();event.stopPropagation();' + #10 +
    '      (document.activeElement===reload?close:reload).focus();' + #10 +
    '    }' + #10 +
    '  }' + #10 +
    '  function focusin(event){if(!notice.contains(event.target))reload.focus();}' + #10 +
    '  notice.dsaPreviousFocus=previous;' + #10 +
    '  notice.dsaDispose=dispose;' + #10 +
    '  reload.href=window.location.href;' + #10 +
    '  reload.removeAttribute("target");' + #10 +
    '  reload.onclick=function(event){event.preventDefault();window.location.reload();};' + #10 +
    '  close.onclick=function(){dispose(true);};' + #10 +
    '  document.addEventListener("keydown",keydown,true);' + #10 +
    '  document.addEventListener("focusin",focusin,true);' + #10 +
    '  reload.focus();' + #10 +
    '})(';
begin
  Result := CMessageScript + UniDSAJSString(AssetErrorHTML(AMessage, True)) + ');';
end;

procedure CheckAssets(AComponent: TComponent);
var
  Session: TUniGUISession;
  MessageText: string;
begin
  if not Assigned(AComponent) or (csDesigning in AComponent.ComponentState) then Exit;
  Session := UniSession;
  if not Assigned(Session) or not (Session.ServerModule is TUniGUIServerModule) then Exit;
  MessageText := AssetError(AComponent.ClassType,
    TUniGUIServerModule(Session.ServerModule).FilesFolderPath);
  if MessageText <> '' then
  begin
    if Session.IsAjax then
      Session.AddJS(AssetErrorScript(MessageText))
    else
      raise Exception.Create(AssetErrorHTML(MessageText));
    // Stop this form before any JavaScript requiring the missing assets is emitted.
    Abort;
  end;
end;

procedure GetLink(AComponent: TTypeUniDSASource);
  procedure RememberAsset(const AURL: string);
  var
    RelativeFile, Existing: string;
    QueryAt, Count: Integer;
  begin
    // Remote libraries are not files inside the application's FilesFolder.
    if Copy(AURL, 1, Length(cFolder) + 1) <> cFolder + '/' then Exit;
    RelativeFile := Copy(AURL, Length(cFolder) + 2, MaxInt);
    QueryAt := Pos('?', RelativeFile);
    if QueryAt > 0 then SetLength(RelativeFile, QueryAt - 1);
    for Existing in AssetFiles[AComponent] do
      if Existing = RelativeFile then Exit;
    Count := Length(AssetFiles[AComponent]);
    SetLength(AssetFiles[AComponent], Count + 1);
    AssetFiles[AComponent][Count] := RelativeFile;
  end;

  procedure AddCSS(const AURL: string; Custom: Boolean; Options: TUniLibraryFileOptions);
  begin
    RememberAsset(AURL);
    UniAddCSSLibrary(AURL, Custom, Options);
  end;

  procedure AddJS(const AURL: string; Custom: Boolean; Options: TUniLibraryFileOptions);
  begin
    RememberAsset(AURL);
    UniAddJSLibrary(AURL, Custom, Options);
  end;
begin
  if AComponent = TTypeUniDSASource.Toast then begin
    AddCSS(cFolder + '/css/jquery.toast.css', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/js/jquery.toast.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Confirm then begin
    AddCSS(cFolder + '/dist/jquery-confirm.min.css', True, [upoFolderUni, upoPlatformBoth]);
    AddCSS('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/dist/jquery-confirm.min.js', True, [upoFolderUni, upoPlatformBoth]);
    AddCSS(cFolder + '/css/dsa.css', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.QrCodeReader then begin
    AddCSS(cFolder + '/qrcode_reader/css/style.css?v=1.1.4', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/qrcode_reader/js/qrcode_library.js', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/qrcode_reader/js/script.js?v=1.1.2', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.MenuLateral then begin
    // Keep both assets on the same revision when the menu markup/API changes.
    AddCSS(cFolder + '/menu_lateral/css/style.css?v=2', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/menu_lateral/js/script.js?v=2', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Login then begin
    AddCSS(cFolder + '/login/css/style.css', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/login/js/script.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Kanban then begin
    AddCSS(cFolder + '/kanban/css/style.css?v=1.0.5', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/kanban/js/script.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Tour then begin
    AddCSS(cFolder + '/tour/css/style.css', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/tour/js/script.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.FormStyle then begin
    AddCSS(cFolder + '/form-style/css/style.css?v=5', True, [upoFolderUni, upoPlatformDesktop]);
    AddJS(cFolder + '/form-style/js/script.js?v=5', True, [upoFolderUni, upoPlatformDesktop]);
  end
  else if AComponent = TTypeUniDSASource.Flex then begin
    AddCSS(cFolder + '/flex/css/unidsa-flex.css?v=1.0.8', True, [upoFolderUni, upoPlatformDesktop]);
    AddJS(cFolder + '/flex/js/unidsa-flex.js?v=1.0.8', True, [upoFolderUni, upoPlatformDesktop]);
  end
  else if AComponent = TTypeUniDSASource.ResponsivePageControl then begin
    AddCSS(cFolder + '/responsive-page-control/css/style.css?v=1.1.3', True, [upoFolderUni, upoPlatformDesktop]);
    AddJS(cFolder + '/responsive-page-control/js/script.js?v=1.1.2', True, [upoFolderUni, upoPlatformDesktop]);
  end
  else if AComponent = TTypeUniDSASource.QrCodeGenerator then begin
    AddCSS(cFolder + '/qrcode_generator/css/style.css?v=1', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/qrcode_generator/js/qrcode.js?v=2.0.4', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/qrcode_generator/js/script.js?v=1.1', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Signature then begin
    AddCSS(cFolder + '/signature/css/style.css?v=1', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/signature/js/script.js?v=1', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.BarcodeGenerator then begin
    AddCSS(cFolder + '/barcode_generator/css/style.css?v=1', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/barcode_generator/js/JsBarcode.all.min.js?v=3.12.3', True, [upoFolderUni, upoPlatformBoth]);
    AddJS(cFolder + '/barcode_generator/js/script.js?v=1.0.1', True, [upoFolderUni, upoPlatformBoth]);
  end;
end;

end.
