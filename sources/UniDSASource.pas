unit UniDSASource;

interface

uses
  uniGUIClasses, uniGUITypes;

type
  TTypeUniDSASource = (Toast, Confirm, MenuSiderbar);

procedure GetLink(Component: TTypeUniDSASource);

implementation

const
  {$IFDEF DEBUG}
     cFolder = '/files/dsa';
  {$ELSE}
     cFolder = './files/dsa';
  {$ENDIF}

procedure GetLink(Component: TTypeUniDSASource);
begin
  if component = TTypeUniDSASource.Toast then begin
    UniAddCSSLibrary(cFolder + '/css/jquery.toast.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/js/jquery.toast.js', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if component = TTypeUniDSASource.Confirm then begin
    UniAddCSSLibrary(cFolder + '/dist/jquery-confirm.min.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddCSSLibrary('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/dist/jquery-confirm.min.js', True, [upoFolderUni, upoPlatformBoth]);
    UniAddCSSLibrary(cFolder + '/css/dsa.css', True, [upoFolderUni, upoPlatformBoth]);
  end
  else if component = TTypeUniDSASource.MenuSiderbar then begin
    UniAddCSSLibrary(cFolder + '/menu/menu_1/style.css', True, [upoFolderUni, upoPlatformBoth]);
    UniAddJSLibrary(cFolder + '/menu/menu_1/meuscript.js', True, [upoFolderUni, upoPlatformBoth]);
  end;
end;

end.
