unit FormContribuicoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame, uniLabel,
  Vcl.Imaging.pngimage, uniImage, uniButton, UniDSAFlexPanel, UniDSAFormStyle, DemoUI;

type
  TFrmContribuicoes = class(TUniForm)
    flexDemoPage: TUniDSAFlexPanel;
    a: TUniDSAFlexPanel;
    UniLabel1: TUniLabel;
    UniImage1: TUniImage;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    b: TUniDSAFlexPanel;
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
  try
    LForm.ShowModal();
  finally
    LForm.Free;
  end;
end;

procedure TFrmContribuicoes.btnObrigadoClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmContribuicoes.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caHide;
end;

procedure TFrmContribuicoes.UniFormCreate(Sender: TObject);
var
  LStyle: TUniDSAFormStyle;
begin
  DemoClass(flexDemoPage, 'demo-page demo-modal');
  AlignmentControl := uniAlignmentClient;
  Layout := 'fit';
  DemoPrepare(flexDemoPage);
  UniImage1.Proportional := True;
  LStyle := TUniDSAFormStyle.Create(Self);
  LStyle.Sizing.AutoHeight := False;
  LStyle.Sizing.MaxWidth := 560;
  LStyle.Sizing.MaxHeight := 720;
  LStyle.Sizing.ViewportMargin := 16;
end;

end.
