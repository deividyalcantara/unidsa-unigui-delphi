unit UniDSABrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Graphics, Vcl.Buttons
  {$IF CompilerVersion >= 34.0}
  ,Winapi.WebView2, Winapi.ActiveX, Vcl.Edge
  {$IFEND}
  ;

type
  TUniDSABrowserMode = (bmJQuery, bmSite);

  TFormUniDSABrowser = class(TForm)
    {$IF CompilerVersion >= 34.0}ebUniDSABrowser: TEdgeBrowser;{$IFEND}
    procedure btnUniDSARecarregarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FCommand: string;
    FMode: TUniDSABrowserMode;
    procedure Execute;
  end;

procedure Navegar(AComando: string; ATipo: TUniDSABrowserMode = TUniDSABrowserMode.bmJQuery);

implementation

procedure Navegar(AComando: string; ATipo: TUniDSABrowserMode = TUniDSABrowserMode.bmJQuery);
var
  LForm: TFormUniDSABrowser;
begin
  {$IF CompilerVersion < 34.0}
    ShowMessage('O teste via IDE só está disponível a partir da versão "Delphi 10.4 Sydney"!');
    Exit;
  {$IFEND}

  LForm := TFormUniDSABrowser.Create(Application);

  with LForm do begin
    FCommand := AComando;
    FMode := ATipo;
    ShowModal;
  end;

  LForm.Free;
end;

{$R *.dfm}

procedure TFormUniDSABrowser.Execute;
begin
   {$IF CompilerVersion >= 34.0}
     ebUniDSABrowser.Navigate('');
     ebUniDSABrowser.NavigateToString(

    '<!DOCTYPE html> ' +
    '<html> ' +
    ' ' +
    '<head> ' +
    '  <meta charset="utf-8"> ' +
    '  <meta http-equiv="X-UA-Compatible" content="IE=edge"> ' +
    '  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" ' +
    '    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> ' +
    '  <title>Page Title</title> ' +
    '  <meta name="viewport" content="width=device-width, initial-scale=1"> ' +
    '  <script src="https://code.jquery.com/jquery-1.11.2.js"></script> ' +
    '  <link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.css"> ' +
    '  <link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css">   ' +
    '  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.js"></script> ' +
    '  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>  ' +
    '  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> ' +
    '  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script> ' +
    '  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> ' +
    '  <style> ' +
    '    body { ' +
    '      margin: 0px; ' +
    '    } ' +
    ' ' +
    '    .container { ' +
    '      width: 100vw; ' +
    '      height: 100vh; ' +
    '      display: flex; ' +
    '      flex-direction: row; ' +
    '      justify-content: center; ' +
    '      align-items: center; ' +
    '    } ' +
    ' ' +
    '    .container-button { ' +
    '      display: table-cell; ' +
    '      text-align: center; ' +
    '      vertical-align: middle; ' +
    '    } ' +
    '  </style> ' +
    '</head> ' +
    ' ' +
    '<body> ' +
    '  <p></p> ' +
    '  <div class="container"> ' +
    '    <div class="container-button"> <button class="btn btn-primary" onclick="ExecuteComponent()">TESTAR</button> ' +
    '      <p></p> ' +
    '      <form action="https://www.paypal.com/donate" method="post" target="_top"> ' +
    '        <input name="hosted_button_id" value="PK5SSJBMVEZML" type="hidden">  ' +
    '        <input ' +
    '          src="https://www.paypalobjects.com/pt_BR/BR/i/btn/btn_donateCC_LG.gif" ' +
    '          name="submit" ' +
    '          title="PayPal - The safer, easier way to pay online!"  ' +
    '          alt="Faça doações com o botão do PayPal"  ' +
    '          type="image" ' +
    '          border="0" ' +
    '        > ' +
    '        <img alt="" src="https://www.paypal.com/pt_BR/i/scr/pixel.gif" height="1" width="1" border="0"> ' +
    '      </form> ' +
    '    </div> ' +
    '  </div> ' +
    '  <script> ' +

        'function ExecuteComponent() {' +
           FCommand +
        ' } ' +
      '</script>' +

      '</body>' +
      '</html>'
    );
  {$IFEND}
end;

procedure TFormUniDSABrowser.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F5 then
    Execute;
end;

procedure TFormUniDSABrowser.FormShow(Sender: TObject);
begin
  {$IF CompilerVersion > 34.0}
    if FMode = TUniDSABrowserMode.bmJQuery then
      Execute
    else
      ebUniDSABrowser.Navigate(FCommand);
  {$IFEND}
end;

procedure TFormUniDSABrowser.btnUniDSARecarregarClick(Sender: TObject);
begin
  Execute;
end;

end.
