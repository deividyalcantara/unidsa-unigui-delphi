unit UniDSASource;

interface

uses
  uniGUIClasses, uniGUITypes;

type
  TTypeUniDSASource = (Toast, Confirm, MenuSiderbar, QrCodeReader, MenuLateral, Login);

procedure GetLink(AComponent: TTypeUniDSASource);

implementation

const
  {$IFDEF DEBUG}
     cFolder = '/files/dsa';
  {$ELSE}
     cFolder = './files/dsa';
  {$ENDIF}

procedure GetLink(AComponent: TTypeUniDSASource);
begin
  if AComponent = TTypeUniDSASource.Toast then begin
    UniAddCSSLibrary(cFolder + '/css/jquery.toast.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/js/jquery.toast.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Confirm then begin
    UniAddCSSLibrary(cFolder + '/dist/jquery-confirm.min.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddCSSLibrary('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/dist/jquery-confirm.min.js', True, [upoFolderUni, upoPlatformBoth]);
    UniAddCSSLibrary(cFolder + '/css/dsa.css', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.QrCodeReader then begin
    UniAddJSLibrary(cFolder + '/qrcode_reader/js/qrcode_library.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.MenuLateral then begin
    UniAddCSSLibrary(cFolder + '/menu_lateral/css/style.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/menu_lateral/js/script.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Login then begin
    UniAddCSSLibrary(cFolder + '/login/css/style.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/login/js/script.js', True, [upoFolderUni, upoPlatformBoth]);
  end;
end;

end.
