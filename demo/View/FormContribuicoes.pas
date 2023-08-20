unit FormContribuicoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame, uniLabel, Vcl.Imaging.pngimage, uniImage, uniButton;

type
  TFrmContribuicoes = class(TUniForm)
    a: TUniContainerPanel;
    UniLabel1: TUniLabel;
    UniImage1: TUniImage;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    b: TUniContainerPanel;
    btnObrigado: TUniButton;
    procedure btnObrigadoClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniFormCreate(Sender: TObject);
  end;

procedure Contribuir;

implementation

uses
  uniGUIApplication;

{$R *.dfm}

procedure Contribuir;
var
  LForm: TFrmContribuicoes;
begin
  LForm := TFrmContribuicoes.Create(UniApplication);
  LForm.ShowModal();
  LForm.Free;
end;

procedure TFrmContribuicoes.btnObrigadoClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmContribuicoes.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFrmContribuicoes.UniFormCreate(Sender: TObject);
begin
  a.Top := 40;
  a.Height := Round(Self.Height - b.Height - 40);
  a.Left := Round((Self.Width / 2) - (a.Width / 2));

  btnObrigado.Top := 0;
  btnObrigado.Height := b.Height;
  btnObrigado.Left := Round((Self.Width / 2) - (btnObrigado.Width / 2));
end;

end.
