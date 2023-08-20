unit FrameConfirm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrameBase, uniGUIBaseClasses, uniGUIClasses, uniLabel, uniButton, uniEdit, uniPanel, uniGroupBox, UniDSAJQuery, UniDSABase,
  UniDSAConfirm;

type
  TFrConfirm = class(TFrBase)
    UniLabel2: TUniLabel;
    UniLabel1: TUniLabel;
    ugbMensagem: TUniGroupBox;
    UniContainerPanel20: TUniContainerPanel;
    UniContainerPanel23: TUniContainerPanel;
    UniLabel16: TUniLabel;
    edtTitulo: TUniEdit;
    UniContainerPanel21: TUniContainerPanel;
    UniLabel15: TUniLabel;
    edtMensagem: TUniEdit;
    UniContainerPanel22: TUniContainerPanel;
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
    Clear;
    ClearEvents;

    Title := edtTitulo.Text;
    BoxWidth := '30%';
    Draggable := False;
    &Type := Green;
    Icon := '';
    Content := edtMensagem.Text;
    Theme := Supervan;

    with Buttons.AddItem do begin
      Text := 'Sim';
      BtnClass := 'btn-green';
      OnClickRef :=
        procedure (Sender: TObject)
        begin
          //
        end;
    end;

    with Buttons.AddItem do begin
      Text := 'Ajuda';
      BtnClass := 'btn-orange';
      OnClickRef :=
        procedure (Sender: TObject)
        begin
          //
        end;
    end;

    with Buttons.AddItem do begin
      Text := 'Não';
      BtnClass := 'btn-red';
      OnClickRef :=
        procedure (Sender: TObject)
        begin
          //
        end;
    end;

    Show;
  end;
end;

end.
