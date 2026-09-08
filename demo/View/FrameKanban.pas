unit FrameKanban;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIFrame,
  uniGUIBaseClasses, uniGUIClasses, uniLabel, uniPanel, uniEdit, uniButton,
  UniDSABaseControl, UniDSAKanban, DemoUI, UniDSAFlexPanel;

type
  TFrKanban = class(TUniFrame)
    flexDemoPage: TUniDSAFlexPanel;
    flexFieldedtNovoCartaoID: TUniDSAFlexPanel;
    flexFieldedtNovoCartao: TUniDSAFlexPanel;
    flexFieldbtnNovoCartao: TUniDSAFlexPanel;
    lblFieldedtNovoCartaoID: TUniLabel;
    lblFieldedtNovoCartao: TUniLabel;

    lblTitulo: TUniLabel;
    lblDescricao: TUniLabel;
    lblStatus: TUniLabel;
    pnlNovoCartao: TUniDSAFlexPanel;
    edtNovoCartaoID: TUniEdit;
    edtNovoCartao: TUniEdit;
    btnNovoCartao: TUniButton;
    Kanban: TUniDSAKanban;
    procedure btnNovoCartaoClick(Sender: TObject);
    procedure KanbanCardClick(Sender: TObject; ACard: TUniDSAKanbanCard);
    procedure KanbanCardMove(
      Sender: TObject;
      ACard: TUniDSAKanbanCard;
      ASourceColumn, ATargetColumn:
      TUniDSAKanbanColumn; AOldIndex,
      ANewIndex: Integer;
      var AAllow: Boolean
    );
    procedure KanbanCardMoved(Sender: TObject; ACard: TUniDSAKanbanCard);
  private
    FUltimoCardId: string;
  end;

implementation

{$R *.dfm}

procedure TFrKanban.btnNovoCartaoClick(Sender: TObject);
var
  LCard: TUniDSAKanbanCard;
  LID: string;
  LTitulo: string;
begin
  LID := Trim(edtNovoCartaoID.Text);
  LTitulo := Trim(edtNovoCartao.Text);

  if LID = '' then begin
    ShowMessage('Informe o ID do novo cartão.');
    edtNovoCartaoID.SetFocus;
    Exit;
  end;

  if Assigned(Kanban.Cards.FindByID(LID)) then begin
    ShowMessage(Format('Já existe um cartão com o ID "%s".', [LID]));
    edtNovoCartaoID.SetFocus;
    Exit;
  end;

  if LTitulo = '' then begin
    ShowMessage('Informe o título do novo cartão.');
    edtNovoCartao.SetFocus;
    Exit;
  end;

  if SameText(LTitulo, 'Cartão XX') then begin
    ShowMessage('O cartão "Cartão XX" não pode ser criado.');
    lblStatus.Caption := 'Criação bloqueada pela validação do título.';
    edtNovoCartao.SetFocus;
    Exit;
  end;

  Kanban.Cards.BeginUpdate;
  try
    LCard := Kanban.Cards.Add;
    LCard.ID := LID;
    LCard.ColumnID := 'a_fazer';
    LCard.Caption := LTitulo;
    LCard.Description := 'Cartão criado em runtime pela demonstração.';
    LCard.Tag := 'Novo';
    LCard.Badge := 'Pendente';
    LCard.Footer := 'Criado agora';
    LCard.SortOrder := Kanban.Cards.Count - 1;
  finally
    Kanban.Cards.EndUpdate;
  end;

  FUltimoCardId := LCard.ID;
  edtNovoCartaoID.Clear;
  edtNovoCartao.Clear;

  lblStatus.Caption := Format(
    'Novo cartão criado: "%s". ID salvo: %s.',
    [LCard.Caption, LCard.ID]
  );

  edtNovoCartaoID.SetFocus;
end;

procedure TFrKanban.KanbanCardClick(Sender: TObject; ACard: TUniDSAKanbanCard);
begin
  lblStatus.Caption := Format('Cartão selecionado: %s', [ACard.Caption]);
end;

procedure TFrKanban.KanbanCardMove(
  Sender: TObject;
  ACard: TUniDSAKanbanCard;
  ASourceColumn, ATargetColumn: TUniDSAKanbanColumn;
  AOldIndex,ANewIndex: Integer;
  var AAllow: Boolean
);
begin
  if SameText(ASourceColumn.ID, ATargetColumn.ID) then begin
    lblStatus.Caption := Format(
      'Reordenando "%s" na coluna %s: posição %d para %d.',
      [ACard.Caption, ASourceColumn.Caption, AOldIndex + 1, ANewIndex + 1]
    )
  end
  else begin
    lblStatus.Caption := Format(
      'Movendo "%s" de %s para %s.',
      [ACard.Caption, ASourceColumn.Caption, ATargetColumn.Caption]
    );
  end;
end;

procedure TFrKanban.KanbanCardMoved(Sender: TObject;
  ACard: TUniDSAKanbanCard);
var
  LColumn: TUniDSAKanbanColumn;
begin
  LColumn := Kanban.Columns.FindByID(ACard.ColumnID);

  if Assigned(LColumn) then begin
    if SameText(ACard.ID, FUltimoCardId) then begin
      lblStatus.Caption := Format(
        'O cartão criado manualmente "%s" (ID: %s) foi movido para %s.',
        [ACard.Caption, ACard.ID, LColumn.Caption]
      )
    end
    else begin
      lblStatus.Caption := Format(
        'Movimentação concluída: "%s" agora está em %s.',
        [ACard.Caption, LColumn.Caption]
      );
    end;
  end;
end;

end.
