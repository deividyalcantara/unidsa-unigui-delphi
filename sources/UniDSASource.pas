unit UniDSASource;

interface

uses
  uniGUIClasses, uniGUITypes;

type
  TTypeUniDSASource = (Toast, Confirm, MenuSiderbar, QrCodeReader, MenuLateral,
    Login, Kanban, Tour, Flex, FormStyle, ResponsivePageControl);

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
    UniAddCSSLibrary(cFolder + '/qrcode_reader/css/style.css?v=1.1.4', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/qrcode_reader/js/qrcode_library.js', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/qrcode_reader/js/script.js?v=1.1.1', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.MenuLateral then begin
    // Keep both assets on the same revision when the menu markup/API changes.
    UniAddCSSLibrary(cFolder + '/menu_lateral/css/style.css?v=2', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/menu_lateral/js/script.js?v=2', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Login then begin
    UniAddCSSLibrary(cFolder + '/login/css/style.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/login/js/script.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Kanban then begin
    UniAddCSSLibrary(cFolder + '/kanban/css/style.css?v=1.0.5', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/kanban/js/script.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.Tour then begin
    UniAddCSSLibrary(cFolder + '/tour/css/style.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/tour/js/script.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if AComponent = TTypeUniDSASource.FormStyle then begin
    UniAddCSSLibrary(cFolder + '/form-style/css/style.css?v=4', True, [upoFolderUni, upoPlatformDesktop]);
    UniAddJSLibrary(cFolder + '/form-style/js/script.js?v=4', True, [upoFolderUni, upoPlatformDesktop]);
  end
  else if AComponent = TTypeUniDSASource.Flex then begin
    UniAddCSSLibrary(cFolder + '/flex/css/unidsa-flex.css?v=1.0.5', True, [upoFolderUni, upoPlatformDesktop]);
    UniAddJSLibrary(cFolder + '/flex/js/unidsa-flex.js?v=1.0.5', True, [upoFolderUni, upoPlatformDesktop]);
  end
  else if AComponent = TTypeUniDSASource.ResponsivePageControl then begin
    UniAddCSSLibrary(cFolder + '/responsive-page-control/css/style.css?v=1.1.3', True, [upoFolderUni, upoPlatformDesktop]);
    UniAddJSLibrary(cFolder + '/responsive-page-control/js/script.js?v=1.1.2', True, [upoFolderUni, upoPlatformDesktop]);
  end;
end;

end.
