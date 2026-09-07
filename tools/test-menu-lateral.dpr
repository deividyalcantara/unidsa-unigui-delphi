program TestMenuLateral;

{$APPTYPE CONSOLE}

uses
  System.SysUtils, System.Classes, UniDSAMenuLateral;

type
  TMenuFixture = class(TComponent)
  private
    FMenu: TUniDSAMenuLateralMenu;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Menu: TUniDSAMenuLateralMenu read FMenu write FMenu;
  end;

constructor TMenuFixture.Create(AOwner: TComponent);
begin
  inherited;
  FMenu := TUniDSAMenuLateralMenu.Create(Self, TUniDSAMenuLateralMenuItem);
end;

destructor TMenuFixture.Destroy;
begin
  FMenu.Free;
  inherited;
end;

procedure Check(Condition: Boolean; const Message: string);
begin
  if not Condition then raise Exception.Create(Message);
end;

var
  Source, Target: TMenuFixture;
  Group, Child, Leaf: TUniDSAMenuLateralMenuItem;
  Stream: TMemoryStream;
  ClickCount: Integer;
begin
  try
    RegisterClass(TMenuFixture);
    Source := TMenuFixture.Create(nil);
    Target := TMenuFixture.Create(nil);
    Stream := TMemoryStream.Create;
    try
      Source.Name := 'MenuFixture';
      Group := Source.Menu.AddItem;
      Group.Caption := 'Vendas';
      Group.Expanded := True;
      Child := Group.SubItems.AddItem;
      Child.Caption := 'Faturamento';
      Leaf := Child.SubItems.AddItem;
      Leaf.Caption := 'Boletos';
      Leaf.NotificationCount := 3;
      Leaf.Hidden := True;
      Check(Leaf.ParentItem = Child, 'ParentItem must resolve the direct parent');
      Check(Group.ParentItem = nil, 'Root must have no parent item');
      Check(Source.Menu.IndexOf('Boletos') = Leaf, 'Lookup must find third-level items');
      Check(Source.Menu.IndexOf('Missing') = nil, 'Missing lookup must return nil');
      ClickCount := 0;
      Leaf.OnClickRef := procedure(Sender: TObject)
        begin
          Inc(ClickCount);
        end;
      Target.Menu.Assign(Source.Menu);
      Check(Target.Menu.IndexOf('Boletos') <> Leaf, 'Assign must deep-copy children');
      Target.Menu.IndexOf('Boletos').OnClickRef(nil);
      Check(ClickCount = 1, 'Assign must preserve anonymous callbacks');
      Target.Menu.IndexOf('Boletos').Caption := 'Copied';
      Check(Leaf.Caption = 'Boletos', 'Assigned children must be independent');
      Target.Menu.Clear;
      Stream.WriteComponent(Source);
      Stream.Position := 0;
      Stream.ReadComponent(Target);
      Check(Target.Menu.Count = 1, 'DFM round-trip must preserve root collection');
      Check(Target.Menu.IndexOf('Vendas').Expanded, 'DFM must preserve Expanded');
      Leaf := Target.Menu.IndexOf('Boletos');
      Check(Assigned(Leaf), 'DFM must preserve nested collections');
      Check(Leaf.Hidden and (Leaf.NotificationCount = 3), 'DFM must preserve child state');
      Leaf.ClearNotification;
      Leaf.DecNotification;
      Check(Leaf.NotificationCount = 0, 'Notifications must not decrement below zero');
      Target.Menu.Clear;
      Check(Target.Menu.IndexOf('Boletos') = nil, 'Clear must remove the whole tree');
      Writeln('PASS: nested lookup, ownership, deep assignment, callbacks, DFM streaming and clear');
    finally
      Stream.Free;
      Target.Free;
      Source.Free;
    end;
  except
    on E: Exception do begin
      Writeln(E.ClassName + ': ' + E.Message);
      Halt(1);
    end;
  end;
end.
