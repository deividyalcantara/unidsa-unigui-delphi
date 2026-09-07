unit UniDSAKanban;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils, Vcl.Graphics,
  uniGUIClasses, uniGUITypes, uniGUIApplication,
  UniDSABaseControl, UniDSASource, UniDSAWebUtils;

type
  TUniDSAKanban = class;

  TUniDSAKanbanColumn = class(TCollectionItem)
  private
    FID: string;
    FCaption: string;
    FDescription: string;
    FAccentColor: TColor;
    FWIPLimit: Integer;
    FAllowDrop: Boolean;
    FVisible: Boolean;
    procedure SetID(const Value: string);
    procedure SetCaption(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetAccentColor(const Value: TColor);
    procedure SetWIPLimit(const Value: Integer);
    procedure SetAllowDrop(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    function GetKanban: TUniDSAKanban;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property Kanban: TUniDSAKanban read GetKanban;
  published
    property ID: string read FID write SetID;
    property Caption: string read FCaption write SetCaption;
    property Description: string read FDescription write SetDescription;
    property AccentColor: TColor read FAccentColor write SetAccentColor default clNone;
    property WIPLimit: Integer read FWIPLimit write SetWIPLimit default 0;
    property AllowDrop: Boolean read FAllowDrop write SetAllowDrop default True;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TUniDSAKanbanCard = class(TCollectionItem)
  private
    FID: string;
    FColumnID: string;
    FCaption: string;
    FDescription: string;
    FTag: string;
    FBadge: string;
    FFooter: string;
    FSortOrder: Integer;
    FDraggable: Boolean;
    FEnabled: Boolean;
    FVisible: Boolean;
    FOnClick: TNotifyEvent;
    procedure SetID(const Value: string);
    procedure SetColumnID(const Value: string);
    procedure SetCaption(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetTag(const Value: string);
    procedure SetBadge(const Value: string);
    procedure SetFooter(const Value: string);
    procedure SetSortOrder(const Value: Integer);
    procedure SetDraggable(const Value: Boolean);
    procedure SetEnabled(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    function GetKanban: TUniDSAKanban;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property Kanban: TUniDSAKanban read GetKanban;
  published
    property ID: string read FID write SetID;
    property ColumnID: string read FColumnID write SetColumnID;
    property Caption: string read FCaption write SetCaption;
    property Description: string read FDescription write SetDescription;
    property Tag: string read FTag write SetTag;
    property Badge: string read FBadge write SetBadge;
    property Footer: string read FFooter write SetFooter;
    property SortOrder: Integer read FSortOrder write SetSortOrder default 0;
    property Draggable: Boolean read FDraggable write SetDraggable default True;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Visible: Boolean read FVisible write SetVisible default True;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TUniDSAKanbanColumns = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TUniDSAKanbanColumn;
    procedure SetItem(Index: Integer; const Value: TUniDSAKanbanColumn);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TUniDSAKanbanColumn;
    function FindByID(const AID: string): TUniDSAKanbanColumn;
    property Items[Index: Integer]: TUniDSAKanbanColumn read GetItem write SetItem; default;
  end;

  TUniDSAKanbanCards = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TUniDSAKanbanCard;
    procedure SetItem(Index: Integer; const Value: TUniDSAKanbanCard);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TUniDSAKanbanCard;
    function FindByID(const AID: string): TUniDSAKanbanCard;
    property Items[Index: Integer]: TUniDSAKanbanCard read GetItem write SetItem; default;
  end;

  TUniDSAKanbanCardEvent = procedure(Sender: TObject;
    ACard: TUniDSAKanbanCard) of object;
  TUniDSAKanbanCardMoveEvent = procedure(Sender: TObject;
    ACard: TUniDSAKanbanCard;
    ASourceColumn, ATargetColumn: TUniDSAKanbanColumn;
    AOldIndex, ANewIndex: Integer; var AAllow: Boolean) of object;

  TUniDSAKanban = class(TUniDSABaseControl)
  private
    FDestroying: Boolean;
    FColumns: TUniDSAKanbanColumns;
    FCards: TUniDSAKanbanCards;
    FReadOnly: Boolean;
    FAjaxSecurity: Boolean;
    FEmptyText: string;
    FWIPLimitMessage: string;
    FMoveDeniedMessage: string;
    FOnCardClick: TUniDSAKanbanCardEvent;
    FOnCardMove: TUniDSAKanbanCardMoveEvent;
    FOnCardMoved: TUniDSAKanbanCardEvent;
    procedure SetColumns(const Value: TUniDSAKanbanColumns);
    procedure SetCards(const Value: TUniDSAKanbanCards);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetEmptyText(const Value: string);
    function RootID: string;
    function SortedCards(const AColumnID: string): TList;
    function CountCards(const AColumnID: string;
      AExclude: TUniDSAKanbanCard = nil): Integer;
    procedure ApplyMove(ACard: TUniDSAKanbanCard;
      const ASourceID, ATargetID: string; ANewIndex: Integer);
    procedure RollbackMove(const ACardID, ASourceID: string;
      AOldIndex: Integer; const AMessage: string);
    procedure PrepareHtml;
    procedure PrepareJS;
  protected
    procedure JSEventHandler(AEventName: string; AParams: TUniStrings); override;
    procedure ConfigJSClasses(ALoading: Boolean); override;
    procedure LoadCompleted; override;
    procedure WebCreate; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshBoard;
  published
    property Align;
    property ClientEvents;
    property Anchors;
    property Height;
    property Width;
    property Visible;
    property Enabled;
    property Columns: TUniDSAKanbanColumns read FColumns write SetColumns;
    property Cards: TUniDSAKanbanCards read FCards write SetCards;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property AjaxSecurity: Boolean read FAjaxSecurity write FAjaxSecurity default True;
    property EmptyText: string read FEmptyText write SetEmptyText;
    property WIPLimitMessage: string read FWIPLimitMessage write FWIPLimitMessage;
    property MoveDeniedMessage: string read FMoveDeniedMessage write FMoveDeniedMessage;
    property OnCardClick: TUniDSAKanbanCardEvent read FOnCardClick write FOnCardClick;
    property OnCardMove: TUniDSAKanbanCardMoveEvent read FOnCardMove write FOnCardMove;
    property OnCardMoved: TUniDSAKanbanCardEvent read FOnCardMoved write FOnCardMoved;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAKanban]);
end;

function UniqueKanbanID(ACollection: TCollection;
  const APrefix: string): string;
var
  I: Integer;
  LNumber: Integer;
  LUsed: Boolean;
begin
  LNumber := ACollection.Count;
  repeat
    Result := APrefix + IntToStr(LNumber);
    LUsed := False;

    for I := 0 to ACollection.Count - 1 do
    begin
      if (ACollection.Items[I] is TUniDSAKanbanColumn) and
         SameText(TUniDSAKanbanColumn(ACollection.Items[I]).FID, Result) then
        LUsed := True
      else if (ACollection.Items[I] is TUniDSAKanbanCard) and
         SameText(TUniDSAKanbanCard(ACollection.Items[I]).FID, Result) then
        LUsed := True;

      if LUsed then
        Break;
    end;

    Inc(LNumber);
  until not LUsed;
end;

{ TUniDSAKanbanColumn }

procedure TUniDSAKanbanColumn.Assign(Source: TPersistent);
begin
  if Source is TUniDSAKanbanColumn then
  begin
    FID := TUniDSAKanbanColumn(Source).FID;
    FCaption := TUniDSAKanbanColumn(Source).FCaption;
    FDescription := TUniDSAKanbanColumn(Source).FDescription;
    FAccentColor := TUniDSAKanbanColumn(Source).FAccentColor;
    FWIPLimit := TUniDSAKanbanColumn(Source).FWIPLimit;
    FAllowDrop := TUniDSAKanbanColumn(Source).FAllowDrop;
    FVisible := TUniDSAKanbanColumn(Source).FVisible;
    Changed(False);
  end
  else
    inherited;
end;

constructor TUniDSAKanbanColumn.Create(Collection: TCollection);
begin
  inherited;
  FID := UniqueKanbanID(Collection, 'column_');
  FCaption := 'Coluna ' + IntToStr(Index + 1);
  FAccentColor := clNone;
  FWIPLimit := 0;
  FAllowDrop := True;
  FVisible := True;
end;

function TUniDSAKanbanColumn.GetDisplayName: string;
begin
  if FCaption <> '' then
    Result := FCaption
  else
    Result := inherited GetDisplayName;
end;

function TUniDSAKanbanColumn.GetKanban: TUniDSAKanban;
begin
  Result := nil;
  if Assigned(Collection) and (Collection is TOwnedCollection) and
     (TOwnedCollection(Collection).Owner is TUniDSAKanban) then
    Result := TUniDSAKanban(TOwnedCollection(Collection).Owner);
end;

procedure TUniDSAKanbanColumn.SetAccentColor(const Value: TColor);
begin
  if FAccentColor <> Value then
  begin
    FAccentColor := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanColumn.SetAllowDrop(const Value: Boolean);
begin
  if FAllowDrop <> Value then
  begin
    FAllowDrop := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanColumn.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanColumn.SetDescription(const Value: string);
begin
  if FDescription <> Value then
  begin
    FDescription := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanColumn.SetID(const Value: string);
var
  I: Integer;
  LOldID: string;
begin
  if Trim(Value) = '' then
    raise EConvertError.Create('O ID da coluna não pode ser vazio.');

  if Assigned(Collection) then
    for I := 0 to Collection.Count - 1 do
      if (Collection.Items[I] <> Self) and
         SameText(TUniDSAKanbanColumn(Collection.Items[I]).FID, Value) then
        raise EConvertError.CreateFmt('Já existe uma coluna Kanban com ID "%s".', [Value]);

  if FID <> Value then
  begin
    LOldID := FID;
    FID := Value;
    if Assigned(Kanban) then
      for I := 0 to Kanban.Cards.Count - 1 do
        if SameText(Kanban.Cards[I].FColumnID, LOldID) then
          Kanban.Cards[I].FColumnID := FID;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanColumn.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanColumn.SetWIPLimit(const Value: Integer);
begin
  if FWIPLimit <> Value then
  begin
    if Value < 0 then
      FWIPLimit := 0
    else
      FWIPLimit := Value;

    Changed(False);
  end;
end;

{ TUniDSAKanbanCard }

procedure TUniDSAKanbanCard.Assign(Source: TPersistent);
begin
  if Source is TUniDSAKanbanCard then
  begin
    FID := TUniDSAKanbanCard(Source).FID;
    FColumnID := TUniDSAKanbanCard(Source).FColumnID;
    FCaption := TUniDSAKanbanCard(Source).FCaption;
    FDescription := TUniDSAKanbanCard(Source).FDescription;
    FTag := TUniDSAKanbanCard(Source).FTag;
    FBadge := TUniDSAKanbanCard(Source).FBadge;
    FFooter := TUniDSAKanbanCard(Source).FFooter;
    FSortOrder := TUniDSAKanbanCard(Source).FSortOrder;
    FDraggable := TUniDSAKanbanCard(Source).FDraggable;
    FEnabled := TUniDSAKanbanCard(Source).FEnabled;
    FVisible := TUniDSAKanbanCard(Source).FVisible;
    FOnClick := TUniDSAKanbanCard(Source).FOnClick;
    Changed(False);
  end
  else
    inherited;
end;

constructor TUniDSAKanbanCard.Create(Collection: TCollection);
begin
  inherited;
  FID := UniqueKanbanID(Collection, 'card_');
  FCaption := 'Cartão ' + IntToStr(Index + 1);
  if Assigned(Kanban) and (Kanban.Columns.Count > 0) then
    FColumnID := Kanban.Columns[0].ID;
  FSortOrder := Index;
  FDraggable := True;
  FEnabled := True;
  FVisible := True;
end;

function TUniDSAKanbanCard.GetDisplayName: string;
begin
  if FCaption <> '' then
    Result := FCaption
  else
    Result := inherited GetDisplayName;
end;

function TUniDSAKanbanCard.GetKanban: TUniDSAKanban;
begin
  Result := nil;
  if Assigned(Collection) and (Collection is TOwnedCollection) and
     (TOwnedCollection(Collection).Owner is TUniDSAKanban) then
    Result := TUniDSAKanban(TOwnedCollection(Collection).Owner);
end;

procedure TUniDSAKanbanCard.SetBadge(const Value: string);
begin
  if FBadge <> Value then
  begin
    FBadge := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetColumnID(const Value: string);
begin
  if FColumnID <> Value then
  begin
    FColumnID := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetDescription(const Value: string);
begin
  if FDescription <> Value then
  begin
    FDescription := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetDraggable(const Value: Boolean);
begin
  if FDraggable <> Value then
  begin
    FDraggable := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetFooter(const Value: string);
begin
  if FFooter <> Value then
  begin
    FFooter := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetSortOrder(const Value: Integer);
begin
  if FSortOrder <> Value then
  begin
    FSortOrder := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetTag(const Value: string);
begin
  if FTag <> Value then
  begin
    FTag := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(False);
  end;
end;

procedure TUniDSAKanbanCard.SetID(const Value: string);
var
  I: Integer;
begin
  if Trim(Value) = '' then
    raise EConvertError.Create('O ID do cartão não pode ser vazio.');

  if Assigned(Collection) then
    for I := 0 to Collection.Count - 1 do
      if (Collection.Items[I] <> Self) and
         SameText(TUniDSAKanbanCard(Collection.Items[I]).FID, Value) then
        raise EConvertError.CreateFmt('Já existe um cartão Kanban com ID "%s".', [Value]);

  if FID <> Value then
  begin
    FID := Value;
    Changed(False);
  end;
end;

{ TUniDSAKanbanColumns }

constructor TUniDSAKanbanColumns.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TUniDSAKanbanColumn);
end;

function TUniDSAKanbanColumns.Add: TUniDSAKanbanColumn;
begin
  Result := TUniDSAKanbanColumn(inherited Add);
end;

function TUniDSAKanbanColumns.FindByID(const AID: string): TUniDSAKanbanColumn;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if SameText(Items[I].ID, AID) then
    begin
      Result := Items[I];
      Exit;
    end;
end;

function TUniDSAKanbanColumns.GetItem(Index: Integer): TUniDSAKanbanColumn;
begin
  Result := TUniDSAKanbanColumn(inherited Items[Index]);
end;

procedure TUniDSAKanbanColumns.SetItem(Index: Integer;
  const Value: TUniDSAKanbanColumn);
begin
  inherited Items[Index] := Value;
end;

procedure TUniDSAKanbanColumns.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner is TUniDSAKanban then
    TUniDSAKanban(Owner).RefreshBoard;
end;

{ TUniDSAKanbanCards }

constructor TUniDSAKanbanCards.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TUniDSAKanbanCard);
end;

function TUniDSAKanbanCards.Add: TUniDSAKanbanCard;
begin
  Result := TUniDSAKanbanCard(inherited Add);
end;

function TUniDSAKanbanCards.FindByID(const AID: string): TUniDSAKanbanCard;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if SameText(Items[I].ID, AID) then
    begin
      Result := Items[I];
      Exit;
    end;
end;

function TUniDSAKanbanCards.GetItem(Index: Integer): TUniDSAKanbanCard;
begin
  Result := TUniDSAKanbanCard(inherited Items[Index]);
end;

procedure TUniDSAKanbanCards.SetItem(Index: Integer;
  const Value: TUniDSAKanbanCard);
begin
  inherited Items[Index] := Value;
end;

procedure TUniDSAKanbanCards.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner is TUniDSAKanban then
    TUniDSAKanban(Owner).RefreshBoard;
end;

{ TUniDSAKanban }

constructor TUniDSAKanban.Create(AOwner: TComponent);
begin
  inherited;
  Width := 720;
  Height := 420;
  FColumns := TUniDSAKanbanColumns.Create(Self);
  FCards := TUniDSAKanbanCards.Create(Self);
  FReadOnly := False;
  FAjaxSecurity := True;
  FEmptyText := 'Nenhum cartão nesta coluna';
  FWIPLimitMessage := 'Limite da coluna atingido.';
  FMoveDeniedMessage := 'Movimentação não permitida.';
end;

destructor TUniDSAKanban.Destroy;
begin
  FDestroying := True;
  FreeAndNil(FCards);
  FreeAndNil(FColumns);
  inherited;
end;

procedure TUniDSAKanban.ConfigJSClasses(ALoading: Boolean);
begin
  inherited;
  JSObjects.DefaultJSClassName := 'Ext.form.Label';
end;

function TUniDSAKanban.CountCards(const AColumnID: string;
  AExclude: TUniDSAKanbanCard): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FCards.Count - 1 do
    if FCards[I].Visible and (FCards[I] <> AExclude) and
       SameText(FCards[I].ColumnID, AColumnID) then
      Inc(Result);
end;

function TUniDSAKanban.RootID: string;
begin
  Result := 'unidsa-kanban-' + JSName;
end;

procedure TUniDSAKanban.SetCards(const Value: TUniDSAKanbanCards);
begin
  if Assigned(Value) then
    FCards.Assign(Value);
end;

procedure TUniDSAKanban.SetColumns(const Value: TUniDSAKanbanColumns);
begin
  if Assigned(Value) then
    FColumns.Assign(Value);
end;

procedure TUniDSAKanban.SetEmptyText(const Value: string);
begin
  if FEmptyText <> Value then
  begin
    FEmptyText := Value;
    RefreshBoard;
  end;
end;

procedure TUniDSAKanban.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    RefreshBoard;
  end;
end;

function TUniDSAKanban.SortedCards(const AColumnID: string): TList;
var
  I: Integer;
  J: Integer;
  LCard: Pointer;
begin
  Result := TList.Create;

  for I := 0 to FCards.Count - 1 do
    if FCards[I].Visible and SameText(FCards[I].ColumnID, AColumnID) then
      Result.Add(FCards[I]);

  for I := 0 to Result.Count - 2 do
    for J := I + 1 to Result.Count - 1 do
      if (TUniDSAKanbanCard(Result[J]).SortOrder <
          TUniDSAKanbanCard(Result[I]).SortOrder) or
         ((TUniDSAKanbanCard(Result[J]).SortOrder =
           TUniDSAKanbanCard(Result[I]).SortOrder) and
          (TUniDSAKanbanCard(Result[J]).Index <
           TUniDSAKanbanCard(Result[I]).Index)) then
      begin
        LCard := Result[I];
        Result[I] := Result[J];
        Result[J] := LCard;
      end;
end;

procedure TUniDSAKanban.ApplyMove(ACard: TUniDSAKanbanCard;
  const ASourceID, ATargetID: string; ANewIndex: Integer);
var
  I: Integer;
  LCardIndex: Integer;
  LCards: TList;
begin
  if SameText(ASourceID, ATargetID) then
  begin
    LCards := SortedCards(ASourceID);
    try
      LCardIndex := LCards.IndexOf(ACard);
      if LCardIndex >= 0 then
        LCards.Delete(LCardIndex);

      ANewIndex := UniDSAClamp(ANewIndex, 0, LCards.Count);
      LCards.Insert(ANewIndex, ACard);

      for I := 0 to LCards.Count - 1 do
        TUniDSAKanbanCard(LCards[I]).FSortOrder := I;
    finally
      FreeAndNil(LCards);
    end;
  end
  else
  begin
    LCards := SortedCards(ASourceID);
    try
      LCardIndex := LCards.IndexOf(ACard);
      if LCardIndex >= 0 then
        LCards.Delete(LCardIndex);

      for I := 0 to LCards.Count - 1 do
        TUniDSAKanbanCard(LCards[I]).FSortOrder := I;
    finally
      FreeAndNil(LCards);
    end;

    ACard.FColumnID := ATargetID;

    LCards := SortedCards(ATargetID);
    try
      LCardIndex := LCards.IndexOf(ACard);
      if LCardIndex >= 0 then
        LCards.Delete(LCardIndex);

      ANewIndex := UniDSAClamp(ANewIndex, 0, LCards.Count);
      LCards.Insert(ANewIndex, ACard);

      for I := 0 to LCards.Count - 1 do
        TUniDSAKanbanCard(LCards[I]).FSortOrder := I;
    finally
      FreeAndNil(LCards);
    end;
  end;
end;

procedure TUniDSAKanban.RollbackMove(const ACardID, ASourceID: string;
  AOldIndex: Integer; const AMessage: string);
begin
  if WebMode then
    UniSession.AddJS(
      'if(window.UniDSAKanban){window.UniDSAKanban.rollback(' +
      UniDSAJSString(RootID) + ',' + UniDSAJSString(ACardID) + ',' +
      UniDSAJSString(ASourceID) + ',' + IntToStr(AOldIndex) + ',' +
      UniDSAJSString(AMessage) + ');}'
    );
end;

procedure TUniDSAKanban.JSEventHandler(AEventName: string; AParams: TUniStrings);
var
  LAllow: Boolean;
  LCard: TUniDSAKanbanCard;
  LNewIndex: Integer;
  LOldIndex: Integer;
  LSourceColumn: TUniDSAKanbanColumn;
  LSourceID: string;
  LTargetColumn: TUniDSAKanbanColumn;
  LTargetID: string;
begin
  inherited;

  if AEventName = 'UniDSAKanbanCardClick' then
  begin
    LCard := FCards.FindByID(AParams.Values['card']);
    if not Assigned(LCard) then
      Exit;

    if FAjaxSecurity and (not LCard.Enabled or not LCard.Visible) then
      Exit;

    if Assigned(LCard.OnClick) then
      LCard.OnClick(LCard);

    if Assigned(FOnCardClick) then
      FOnCardClick(Self, LCard);
  end
  else if AEventName = 'UniDSAKanbanCardMove' then
  begin
    LCard := FCards.FindByID(AParams.Values['card']);
    LSourceID := AParams.Values['source'];
    LTargetID := AParams.Values['target'];
    LSourceColumn := FColumns.FindByID(LSourceID);
    LTargetColumn := FColumns.FindByID(LTargetID);
    LOldIndex := StrToIntDef(AParams.Values['oldIndex'], 0);
    LNewIndex := StrToIntDef(AParams.Values['newIndex'], 0);

    LAllow := Assigned(LCard) and Assigned(LSourceColumn) and
      Assigned(LTargetColumn);

    if LAllow and FAjaxSecurity then
    begin
      LAllow := LCard.Enabled and LCard.Visible and LCard.Draggable and
        (not FReadOnly) and LSourceColumn.Visible and LTargetColumn.Visible and
        LTargetColumn.AllowDrop and SameText(LCard.ColumnID, LSourceID);

      if LAllow and (not SameText(LSourceID, LTargetID)) and
         (LTargetColumn.WIPLimit > 0) and
         (CountCards(LTargetID, LCard) >= LTargetColumn.WIPLimit) then
      begin
        RollbackMove(LCard.ID, LSourceID, LOldIndex, FWIPLimitMessage);
        Exit;
      end;
    end;

    if not LAllow then
    begin
      RollbackMove(AParams.Values['card'], LSourceID, LOldIndex,
        FMoveDeniedMessage);
      Exit;
    end;

    if Assigned(FOnCardMove) then
      FOnCardMove(Self, LCard, LSourceColumn, LTargetColumn, LOldIndex,
        LNewIndex, LAllow);

    if not LAllow then
    begin
      RollbackMove(LCard.ID, LSourceID, LOldIndex, FMoveDeniedMessage);
      Exit;
    end;

    ApplyMove(LCard, LSourceID, LTargetID, LNewIndex);

    if Assigned(FOnCardMoved) then
      FOnCardMoved(Self, LCard);
  end;
end;

procedure TUniDSAKanban.PrepareHtml;
const
  CDragIcon = '<svg viewBox="0 0 24 24" aria-hidden="true">' +
    '<circle cx="9" cy="7" r="1.5"/>' +
    '<circle cx="15" cy="7" r="1.5"/>' +
    '<circle cx="9" cy="12" r="1.5"/>' +
    '<circle cx="15" cy="12" r="1.5"/>' +
    '<circle cx="9" cy="17" r="1.5"/>' +
    '<circle cx="15" cy="17" r="1.5"/>' +
    '</svg>';
var
  I: Integer;
  J: Integer;
  LAccent: string;
  LCard: TUniDSAKanbanCard;
  LCards: TList;
  LClickable: string;
  LColumn: TUniDSAKanbanColumn;
  LDraggableAttribute: string;
  LHtml: TStringBuilder;
begin
  if not WebMode then
    Exit;

  LHtml := TStringBuilder.Create;
  try
    LHtml.Append('<div id="' + UniDSAHtmlEncode(RootID) +
      '" class="unidsa-kanban" role="region" aria-label="Quadro Kanban">');
    LHtml.Append('<div class="unidsa-kanban-board" role="list" tabindex="0" aria-label="Quadro Kanban - role horizontalmente para ver todas as etapas">');

    for I := 0 to FColumns.Count - 1 do
    begin
      LColumn := FColumns[I];
      if not LColumn.Visible then
        Continue;

      if LColumn.AccentColor = clNone then
        LAccent := '#2563eb'
      else
        LAccent := UniDSAColorToCSS(LColumn.AccentColor);

      LHtml.Append('<section class="unidsa-kanban-column' +
        IfThen(not LColumn.AllowDrop, ' is-drop-disabled', '') +
        '" role="listitem" data-column-id="' +
        UniDSAHtmlEncode(LColumn.ID) + '" data-wip-limit="' +
        IntToStr(LColumn.WIPLimit) + '" data-allow-drop="' +
        IfThen(LColumn.AllowDrop, '1', '0') +
        '" style="--dsa-column-accent:' + LAccent + '">');
      LHtml.Append('<header class="unidsa-kanban-column-header">' +
        '<div class="unidsa-kanban-column-heading">' +
        '<h3 class="unidsa-kanban-column-title">' +
        UniDSAHtmlEncode(LColumn.Caption) + '</h3>');

      if LColumn.Description <> '' then
        LHtml.Append('<p class="unidsa-kanban-column-subtitle">' +
          UniDSAHtmlEncode(LColumn.Description) + '</p>');

      LHtml.Append('</div><span class="unidsa-kanban-count" ' +
        'aria-label="Quantidade de cartões">0</span></header>');
      LHtml.Append('<div class="unidsa-kanban-card-list" role="list" ' +
        'aria-label="' + UniDSAHtmlEncode(LColumn.Caption) + '">');

      LCards := SortedCards(LColumn.ID);
      try
        for J := 0 to LCards.Count - 1 do
        begin
          LCard := TUniDSAKanbanCard(LCards[J]);

          if LCard.Draggable and LCard.Enabled and (not FReadOnly) then
            LDraggableAttribute := ' draggable="true"'
          else
            LDraggableAttribute := ' draggable="false"';

          if LCard.Enabled and
             (Assigned(LCard.OnClick) or Assigned(FOnCardClick)) then
            LClickable := '1'
          else
            LClickable := '0';

          LHtml.Append('<article class="unidsa-kanban-card' +
            IfThen(not LCard.Enabled, ' is-disabled', '') +
            '" role="listitem" tabindex="0" aria-disabled="' +
            IfThen(LCard.Enabled, 'false', 'true') + '" data-card-id="' +
            UniDSAHtmlEncode(LCard.ID) + '" data-draggable="' +
            IfThen(LCard.Draggable and LCard.Enabled, '1', '0') +
            '" data-clickable="' + LClickable + '"' +
            LDraggableAttribute + '>');
          LHtml.Append('<div class="unidsa-kanban-card-top">' +
            '<div class="unidsa-kanban-card-content">' +
            '<h4 class="unidsa-kanban-card-title">' +
            UniDSAHtmlEncode(LCard.Caption) + '</h4>');

          if LCard.Description <> '' then
            LHtml.Append('<p class="unidsa-kanban-card-description">' +
              UniDSAHtmlEncode(LCard.Description) + '</p>');

          LHtml.Append('</div>');

          if LCard.Draggable and LCard.Enabled and (not FReadOnly) then
            LHtml.Append('<button type="button" ' +
              'class="unidsa-kanban-drag-handle" tabindex="-1" ' +
              'aria-label="Mover cartão">' + CDragIcon + '</button>');

          LHtml.Append('</div>');

          if (LCard.Tag <> '') or (LCard.Badge <> '') then
          begin
            LHtml.Append('<div class="unidsa-kanban-card-meta">');

            if LCard.Tag <> '' then
              LHtml.Append('<span class="unidsa-kanban-tag">' +
                UniDSAHtmlEncode(LCard.Tag) + '</span>');

            if LCard.Badge <> '' then
              LHtml.Append('<span class="unidsa-kanban-badge">' +
                UniDSAHtmlEncode(LCard.Badge) + '</span>');

            LHtml.Append('</div>');
          end;

          if LCard.Footer <> '' then
            LHtml.Append('<div class="unidsa-kanban-card-footer">' +
              UniDSAHtmlEncode(LCard.Footer) + '</div>');

          LHtml.Append('</article>');
        end;
      finally
        FreeAndNil(LCards);
      end;

      LHtml.Append('<div class="unidsa-kanban-empty">' +
        UniDSAHtmlEncode(FEmptyText) + '</div></div></section>');
    end;

    LHtml.Append('</div><div class="unidsa-kanban-announcer" ' +
      'aria-live="polite" aria-atomic="true"></div></div>');
    Caption := LHtml.ToString;
  finally
    FreeAndNil(LHtml);
  end;
end;

procedure TUniDSAKanban.PrepareJS;
begin
  if not WebMode then
    Exit;

  UniSession.AddJS(
    'if(window.UniDSAKanban){window.UniDSAKanban.init(' +
    UniDSAJSString(RootID) + ',' + JSName + ',{readOnly:' +
    UniDSABoolJS(FReadOnly) + ',wipMessage:' +
    UniDSAJSString(FWIPLimitMessage) + '});}'
  );
end;

procedure TUniDSAKanban.LoadCompleted;
begin
  inherited;
  PrepareHtml;
  PrepareJS;
end;

procedure TUniDSAKanban.RefreshBoard;
begin
  if FDestroying or (csDestroying in ComponentState) or IsDesigning or
     IsLoading or (not WebMode) then
    Exit;

  PrepareHtml;
  PrepareJS;
end;

procedure TUniDSAKanban.WebCreate;
begin
  inherited;
  JSCls := 'x-unidsa-kanban';
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.Kanban);

end.
