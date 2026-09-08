unit FrameConfirm;

interface

uses
  Windows, Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uniGUIBaseClasses, uniGUIClasses,
  uniLabel, uniButton, uniEdit, uniPanel, UniDSABase,
  UniDSAConfirm, UniDSAExecuteFunction, uniGUIFrame, DemoUI, UniDSAFlexPanel;

type
  TFrConfirm = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;
    lblSectionugbMensagem: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel1: TUniLabel;
    ugbMensagem: TUniDSAFlexPanel;
    UniContainerPanel20: TUniDSAFlexPanel;
    UniContainerPanel23: TUniDSAFlexPanel;
    UniLabel16: TUniLabel;
    edtTitulo: TUniEdit;
    UniContainerPanel21: TUniDSAFlexPanel;
    UniLabel15: TUniLabel;
    edtMensagem: TUniEdit;
    UniContainerPanel22: TUniDSAFlexPanel;
    btnMostrar: TUniButton;
    UniLabel3: TUniLabel;
    Confirm: TUniDSAConfirm;
    procedure btnMostrarClick(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TFrConfirm.btnMostrarClick(Sender: TObject);
begin
  inherited;
  with Confirm do begin
    Buttons.Clear;

    Title := edtTitulo.Text;
    Content := edtMensagem.Text;

    with Buttons.AddItem do begin
      Text := 'Sim';
      BtnClass := 'btn-green';
      OnClickRef :=
        procedure (Sender: TObject)
        begin
          UniLabel3.Caption := 'Confirmado: o evento OnClickRef do botão Sim foi executado.';
        end;
    end;

    with Buttons.AddItem do begin
      Text := 'Ajuda';
      BtnClass := 'btn-orange';
      OnClickRef :=
        procedure (Sender: TObject)
        begin
          UniLabel3.Caption := 'Ajuda: cada botão pode executar um evento independente.';
        end;
    end;

    with Buttons.AddItem do begin
      Text := 'Não';
      BtnClass := 'btn-red';
      OnClickRef :=
        procedure (Sender: TObject)
        begin
          UniLabel3.Caption := 'Cancelado: nenhuma operação foi executada.';
        end;
    end;

    Show;
  end;
end;

end.
