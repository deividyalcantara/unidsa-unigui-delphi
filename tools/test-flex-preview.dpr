program TestFlexPreview;
{$APPTYPE CONSOLE}
uses System.SysUtils, System.Classes, System.JSON, System.IOUtils,
  Vcl.Forms, UniDSAFlexPanel;
type
  TPreviewPanel = class(TUniDSAFlexPanel)
    procedure Preview;
  end;
procedure TPreviewPanel.Preview;
begin SetDesigning(True, False); RefreshFlex; end;
var
  Cases: TJSONArray;
procedure RunCase(Direction: TUniDSAFlexDirection; Justify: TUniDSAFlexJustify;
  Wrap: TUniDSAFlexWrap; AlignContent, AlignItems: TUniDSAFlexAlign);
const
  Widths: array[0..2] of Integer = (80,100,60);
  Heights: array[0..2] of Integer = (50,70,40);
var
  Host: TForm;
  Panel: TPreviewPanel;
  Child: array[0..2] of TUniDSAFlexPanel;
  I, W, H: Integer;
  C, Item: TJSONObject;
  Items: TJSONArray;
begin
  Host := TForm.CreateNew(nil);
  Panel := TPreviewPanel.Create(Host);
  try
    Host.ClientWidth := 900; Host.ClientHeight := 900;
    Panel.Flex.Direction := Direction;
    Panel.Flex.Wrap := Wrap;
    Panel.Flex.JustifyContent := Justify;
    Panel.Flex.AlignItems := AlignItems;
    Panel.Flex.AlignContent := AlignContent;
    Panel.Flex.Padding := 10;
    Panel.Flex.RowGap := 18;
    Panel.Flex.ColumnGap := 14;
    W := 600; H := 600;
    if Wrap <> fwNoWrap then
      if Direction in [fdColumn, fdColumnReverse] then H := 160 else W := 220;
    Panel.SetBounds(0,0,W,H);
    for I := 0 to 2 do
    begin
      Child[I] := TUniDSAFlexPanel.Create(Panel);
      Child[I].Responsive.XS.Span := 0;
      Child[I].SetBounds(0,0,Widths[I],Heights[I]);
      Child[I].Parent := Panel;
    end;
    Child[0].FlexItem.Order := 1;
    Child[1].FlexItem.Order := -1;
    Panel.Parent := Host;
    Panel.Preview;
    C := TJSONObject.Create;
    Cases.AddElement(C);
    C.AddPair('direction',TJSONNumber.Create(Ord(Direction)));
    C.AddPair('justify',TJSONNumber.Create(Ord(Justify)));
    C.AddPair('wrap',TJSONNumber.Create(Ord(Wrap)));
    C.AddPair('alignContent',TJSONNumber.Create(Ord(AlignContent)));
    C.AddPair('alignItems',TJSONNumber.Create(Ord(AlignItems)));
    C.AddPair('width',TJSONNumber.Create(W));
    C.AddPair('height',TJSONNumber.Create(H));
    Items := TJSONArray.Create;
    C.AddPair('items',Items);
    for I := 0 to 2 do
    begin
      Item := TJSONObject.Create;
      Items.AddElement(Item);
      Item.AddPair('width',TJSONNumber.Create(Widths[I]));
      Item.AddPair('height',TJSONNumber.Create(Heights[I]));
      Item.AddPair('order',TJSONNumber.Create(Child[I].FlexItem.Order));
      Item.AddPair('x',TJSONNumber.Create(Child[I].Left));
      Item.AddPair('y',TJSONNumber.Create(Child[I].Top));
      Item.AddPair('actualWidth',TJSONNumber.Create(Child[I].Width));
      Item.AddPair('actualHeight',TJSONNumber.Create(Child[I].Height));
    end;
    Panel.RefreshFlex;
    for I := 0 to 2 do
      if (Child[I].Left <> Items.Items[I].GetValue<Integer>('x')) or
        (Child[I].Top <> Items.Items[I].GetValue<Integer>('y')) then
        raise Exception.Create('Preview must be stable when reapplied');
  finally Panel.Free; Host.Free; end;
end;
procedure Check(Value: Boolean; const Message: string);
begin if not Value then raise Exception.Create(Message); end;

procedure TestNestedAndSizing;
var
  Host: TForm;
  Root, Gray: TPreviewPanel;
  Lights: array[0..2] of TPreviewPanel;
  I: Integer;
begin
  Host := TForm.CreateNew(nil);
  Root := TPreviewPanel.Create(Host);
  try
    Host.ClientWidth := 900; Host.ClientHeight := 900;
    Root.SetBounds(0,0,624,701);
    Root.Flex.Direction := fdColumn;
    Root.Flex.JustifyContent := fjCenter;
    Root.Flex.AlignItems := faCenter;
    Root.Flex.AlignContent := faCenter;
    Gray := TPreviewPanel.Create(Root);
    Gray.SetBounds(0,0,297,574);
    Gray.Flex.Direction := fdColumn;
    Gray.Flex.JustifyContent := fjSpaceEvenly;
    Gray.Flex.AlignItems := faCenter;
    Gray.Parent := Root;
    for I := 0 to 2 do
    begin
      Lights[I] := TPreviewPanel.Create(Gray);
      Lights[I].SetBounds(0,0,100,100);
      Lights[I].Parent := Gray;
      Lights[I].Preview;
    end;
    Gray.Preview;
    Root.Parent := Host;
    Root.Preview;
    Check((Abs(Gray.Left-163.5)<=0.5) and (Abs(Gray.Top-63.5)<=0.5), 'Project5: gray panel centered');
    for I := 0 to 2 do
    begin
      Check(Abs(Lights[I].Left-98.5)<=0.5,'Project5: light horizontally centered');
      Check(Abs(Lights[I].Top-(62.5+174.5*I))<=0.5,'Project5: space-evenly includes edge spaces and gaps');
    end;
    Lights[1].Height := 140;
    Check(Abs(Lights[0].Top-52.5)<=0.5,'Resize child refreshes parent distribution');
    Gray.Flex.AutoHeight := True;
    Check(Gray.Height=364,'AutoHeight measures natural contents, not distributed space');
    Check(Abs(Gray.Top-(701-364)/2)<=0.5,'AutoHeight refreshes parent center');
    Gray.Flex.AutoWidth := True;
    Check(Gray.Width=100,'AutoWidth preserves intrinsic widths');
    Check(Gray.Left=262,'AutoWidth refreshes parent center');
    Gray.RefreshFlex;
    Check((Gray.Width=100) and (Gray.Height=364),'Auto size is stable');
  finally Root.Free; Host.Free; end;
end;

procedure TestResponsiveAndOverrides;
var
  Host: TForm;
  Panel: TPreviewPanel;
  Children: array[0..2] of TUniDSAFlexPanel;
  I: Integer;
begin
  Host := TForm.CreateNew(nil);
  Panel := TPreviewPanel.Create(Host);
  try
    Host.ClientWidth := 900; Host.ClientHeight := 900;
    Panel.SetBounds(0,0,400,300);
    Panel.Flex.Padding := 10;
    Panel.Flex.Gap := 20;
    Panel.Flex.AlignItems := faStart;
    Panel.Flex.AlignContent := faCenter;
    for I := 0 to 2 do
    begin
      Children[I] := TUniDSAFlexPanel.Create(Panel);
      Children[I].SetBounds(0,0,80,50);
      Children[I].Parent := Panel;
      Children[I].Responsive.XS.Span := 6;
    end;
    with Panel.FlexItems.Add do
    begin
      Control := Children[0]; Order := 2;
      Responsive.XS.Span := 12;
      Responsive.LG.Span := 6;
    end;
    Panel.Parent := Host;
    Panel.Preview;
    Check((Children[0].Width=380) and (Children[0].Top=160),'Responsive override wraps on second centered line');
    Check((Children[1].Width=180) and (Children[1].Left=10) and
      (Children[2].Left=210) and (Children[1].Top=90),'Grid width and gaps retained');
    Panel.DesignPreview := dpDesktop;
    Check(Children[0].Width=180,'DesignPreview updates responsive override');
    Panel.Flex.AutoHeight := True;
    Check(Panel.Height=140,'AutoHeight follows wrapped rows');
    Children[0].Visible := False;
    Panel.RefreshFlex;
    Check(Panel.Height=70,'Hidden child excluded from layout');
    Panel.Flex.AutoHeight := False;
    Panel.Height := 300;
    Panel.Flex.Wrap := fwNoWrap;
    Panel.FlexItems[0].Control := Children[1];
    Panel.FlexItems[0].AlignSelf := fasEnd;
    Panel.RefreshFlex;
    Check(Children[1].Top=240,'Collection AlignSelf overrides container AlignItems');
  finally Panel.Free; Host.Free; end;
end;

var
  Direction: TUniDSAFlexDirection;
  Justify: TUniDSAFlexJustify;
  Wrap: TUniDSAFlexWrap;
  AlignContent, AlignItems: TUniDSAFlexAlign;
begin
  try
    TestNestedAndSizing;
    TestResponsiveAndOverrides;
    Cases := TJSONArray.Create;
    try
      for Direction := Low(TUniDSAFlexDirection) to High(TUniDSAFlexDirection) do
        for Justify := Low(TUniDSAFlexJustify) to High(TUniDSAFlexJustify) do
          for Wrap := Low(TUniDSAFlexWrap) to High(TUniDSAFlexWrap) do
            for AlignContent := faStretch to faEnd do
              for AlignItems := faStretch to faEnd do
                RunCase(Direction, Justify, Wrap, AlignContent, AlignItems);
      TFile.WriteAllText(ExtractFilePath(ParamStr(0))+'preview-cases.json',Cases.ToJSON,TEncoding.UTF8);
      Writeln('PASS: ',Cases.Count,' design layouts exported and stable.');
    finally Cases.Free; end;
  except on E: Exception do begin Writeln(E.ClassName, ': ', E.Message); Halt(1); end; end;
end.
