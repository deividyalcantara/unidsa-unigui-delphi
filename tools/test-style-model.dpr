program TestStyleModel;
{$APPTYPE CONSOLE}
uses System.SysUtils, System.Classes, System.JSON, System.IOUtils, Vcl.Graphics, UniDSAStyle, uniLabel;
procedure Check(Value: Boolean; const Message: string);
begin if not Value then raise Exception.Create(Message); end;
type
  TChangeProbe = class
    Count: Integer;
    procedure Changed(Sender: TObject);
  end;
procedure TChangeProbe.Changed(Sender: TObject);
begin Inc(Count); end;

procedure TestEffects;
var
  Fixture, CopyStyle: TUniDSAStyle;
  Input: TFileStream;
  Binary: TMemoryStream;
  A: TUniDSAStyleAppearance;
  Probe: TChangeProbe;
  JSON: TJSONObject;
begin
  Fixture := TUniDSAStyle.Create(nil);
  CopyStyle := TUniDSAStyle.Create(nil);
  Binary := TMemoryStream.Create;
  Probe := TChangeProbe.Create;
  A := TUniDSAStyleAppearance.Create(Probe.Changed);
  try
    Input := TFileStream.Create(ExpandFileName(ExtractFilePath(ParamStr(0)) + '..\..\tools\fixtures\style-skew-button.dfm'), fmOpenRead);
    try ObjectTextToBinary(Input, Binary); finally Input.Free; end;
    Binary.Position := 0;
    Binary.ReadComponent(Fixture);
    Binary.Clear;
    Binary.WriteComponent(Fixture);
    Binary.Position := 0;
    Binary.ReadComponent(CopyStyle);
    with CopyStyle.Styles[0] do begin
      Check(Appearance.Display = sdInlineBlock, 'Display DFM');
      Check(Appearance.Transform.SkewX = -21, 'Negative skew DFM');
      Check(Appearance.Transform.SkewY = -1000, 'Unset skew DFM');
      Check(Appearance.Content.Display = sdInlineBlock, 'Content display DFM');
      Check(Appearance.Content.Transform.SkewX = 21, 'Content skew DFM');
      Check(Appearance.Before.Enabled = ssYes, 'Before enabled DFM');
      Check(Appearance.Before.Text = '', 'Empty pseudo content DFM');
      Check(Appearance.Before.Position.ZIndex = -1, 'Negative z-index DFM');
      Check(Appearance.Before.Position.Right.Units = suPercent, 'Percentage inset DFM');
      Check(Appearance.Before.Position.Right.Value = 100, 'Percentage value DFM');
      Check(Appearance.Before.Effects.TransitionAll = ssYes, 'Transition all DFM');
      Check(Appearance.Before.Effects.TransitionMs = 500, 'Transition duration DFM');
      Check(States.Hover.Before.Position.Right.Value = 0, 'Explicit hover zero DFM');
      Check(States.Hover.Before.Effects.Opacity = 100, 'Pseudo hover DFM');
    end;
    JSON := CopyStyle.Styles[0].Rule.ToJSON;
    try TFile.WriteAllText(ExtractFilePath(ParamStr(0)) + 'skew-button.json', JSON.ToJSON, TEncoding.UTF8);
    finally JSON.Free; end;
    CopyStyle.Styles.Assign(Fixture.Styles);
    CopyStyle.Styles[0].Appearance.Content.Transform.SkewX := 0;
    CopyStyle.Styles[0].Appearance.Before.Position.Right.Value := -25;
    CopyStyle.Styles[0].States.Hover.Before.Effects.Opacity := 50;
    Check(Fixture.Styles[0].Appearance.Content.Transform.SkewX = 21, 'Content deep Assign');
    Check(Fixture.Styles[0].Appearance.Before.Position.Right.Value = 100, 'Pseudo offset deep Assign');
    Check(Fixture.Styles[0].States.Hover.Before.Effects.Opacity = 100, 'Pseudo states deep Assign');
    A.BeginUpdate;
    try
      A.Display := sdInlineBlock;
      A.Transform.SkewX := -21;
      A.Content.Transform.SkewX := 21;
      A.Before.Enabled := ssYes;
      A.Before.Position.Right.Units := suPercent;
      A.Before.Effects.TransitionAll := ssYes;
      A.After.Enabled := ssYes;
      A.After.Text := 'After';
    finally A.EndUpdate; end;
    Check(Probe.Count = 1, 'New child changes must batch into one notification');
    Probe.Count := 0;
    A.Assign(Fixture.Styles[0].Appearance);
    Check(Probe.Count = 1, 'Assign must emit a single notification');
    A.After.Enabled := ssNo;
    A.Transform.SkewX := 0;
    A.Position.Left.Units := suPercent;
    A.Position.Left.Value := -10;
    CopyStyle.Styles[0].Appearance.Assign(A);
    Binary.Clear;
    Binary.WriteComponent(CopyStyle);
    Binary.Position := 0;
    Binary.ReadComponent(Fixture);
    Check(Fixture.Styles[0].Appearance.After.Enabled = ssNo, 'Explicit pseudo disable DFM');
    Check(Fixture.Styles[0].Appearance.Transform.SkewX = 0, 'Explicit zero skew DFM');
    Check(Fixture.Styles[0].Appearance.Position.Left.Value = -10, 'Negative percentage DFM');
    Writeln('PASS: effects DFM fixture, nested Assign, notifications, negative offsets and explicit resets.');
  finally
    A.Free; Probe.Free; Binary.Free; CopyStyle.Free; Fixture.Free;
  end;
end;
var
  Source, Target: TUniDSAStyle;
  Named: TUniDSANamedStyle;
  Item: TUniDSAStyleItem;
  LabelControl: TUniLabel;
  Stream: TMemoryStream;
  JSON: TJSONObject;
  Raised: Boolean;
begin
  try
    RegisterClass(TUniDSAStyle);
    TestEffects;
    Source := TUniDSAStyle.Create(nil);
    Target := TUniDSAStyle.Create(nil);
    Stream := TMemoryStream.Create;
    LabelControl := nil;
    try
      Source.Name := 'StyleFixture';
      Source.BeginUpdate;
      try
        Named := Source.Styles.Add;
        Named.Name := 'Primary';
        Named.Appearance.Background.Color := clGreen;
        Named.Appearance.Border.Width := 0;
        Named.Appearance.Sizing.MaxWidth.Units := suPx;
        Named.Appearance.Sizing.MaxWidth.Value := 620;
        Named.Appearance.Scrollbar.Visible := ssYes;
        Named.Appearance.Scrollbar.Size := 8;
        Named.Appearance.Scrollbar.TrackColor := clWhite;
        Named.Appearance.Scrollbar.ThumbColor := clGreen;
        Named.Appearance.Scrollbar.ThumbHoverColor := clBlue;
        Named.Appearance.Scrollbar.Radius := 999;
        Named.States.Hover.Background.Color := clBlue;
        Named.States.Hover.Shadow.Enabled := ssYes;
        with Named.Responsive.Add do begin
          MaxWidth := 700;
          Appearance.Sizing.MaxWidthPercent := 92;
        end;
        Item := Source.StyleItems.Add;
        Item.Name := 'Send';
        Item.StyleName := 'Primary';
        Item.Selected := True;
        Item.Appearance.Typography.Size := 15;
      finally Source.EndUpdate; end;
      Source.Validate;
      Named.Name := 'PrimaryRenamed';
      Check(Item.StyleName = 'PrimaryRenamed', 'Renaming must preserve item references');
      Stream.WriteComponent(Source);
      Stream.Position := 0;
      Stream.ReadComponent(Target);
      Target.Validate;
      Check(Target.Styles.Count = 1, 'DFM style count');
      Check(Target.StyleItems.Count = 1, 'DFM item count');
      Check(Target.Styles[0].States.Hover.Background.Color = clBlue, 'DFM hover color');
      Check(Target.Styles[0].Appearance.Border.Width = 0, 'Explicit zero must persist');
      Check(Target.Styles[0].Appearance.Sizing.MaxWidth.Value = 620, 'Dimension value must persist');
      Check(Target.Styles[0].Appearance.Sizing.MaxWidth.Units = suPx, 'Dimension units must persist');
      Check(Target.Styles[0].Appearance.Scrollbar.Visible = ssYes, 'Scrollbar visibility must persist');
      Check(Target.Styles[0].Appearance.Scrollbar.Size = 8, 'Scrollbar size must persist');
      Check(Target.Styles[0].Appearance.Scrollbar.ThumbHoverColor = clBlue, 'Scrollbar hover color must persist');
      Check(Target.Styles[0].Appearance.Scrollbar.Radius = 999, 'Scrollbar radius must persist');
      Check(Target.Styles[0].Responsive[0].Appearance.Sizing.MaxWidthPercent = 92, 'Responsive rule must persist');
      Check(Target.StyleItems[0].Selected, 'Selected must persist');
      JSON := Target.Styles[0].Rule.ToJSON;
      try
        Check(Pos('Hover', JSON.ToJSON) > 0, 'Hover JSON');
        Check(Pos('"Width":0', JSON.ToJSON) > 0, 'Zero JSON');
        Check(Pos('"Scrollbar"', JSON.ToJSON) > 0, 'Scrollbar JSON');
      finally JSON.Free; end;
      Target.Styles.Assign(Source.Styles);
      Target.Styles[0].Appearance.Typography.Size := 30;
      Check(Source.Styles[0].Appearance.Typography.Size = -1, 'Assign must deep-copy');
      if LabelControl = nil then LabelControl := TUniLabel.Create(Source);
      Item.Control := LabelControl;
      Source.TargetContainer := LabelControl;
      Item.Control := nil;
      if LabelControl = nil then LabelControl := TUniLabel.Create(Source);
      Item.Control := LabelControl;
      LabelControl.Free;
      LabelControl := nil;
      Check(Item.Control = nil, 'Destroyed control must clear item reference');
      Check(Source.TargetContainer = nil, 'Destroyed scope must clear reference');
      Source.Styles.Add.Name := 'Secondary';
      Raised := False;
      try Source.Styles[1].Name := 'PrimaryRenamed'; except on E: EArgumentException do Raised := True; end;
      Check(Raised, 'Duplicate style names must be rejected');
      Item.StyleName := 'Missing';
      Raised := False;
      try Source.Validate; except on E: EArgumentException do Raised := True; end;
      Check(Raised, 'Missing named style must be diagnosed');
      Writeln('PASS: DFM, hover, scrollbar, explicit zero, units, responsive, Assign, renaming, notifications and validation.');
    finally
      LabelControl.Free; Stream.Free; Target.Free; Source.Free;
    end;
  except
    on E: Exception do begin Writeln(E.ClassName + ': ' + E.Message); Halt(1); end;
  end;
end.
