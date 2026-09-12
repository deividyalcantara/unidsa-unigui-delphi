program TestStyleModel;
{$APPTYPE CONSOLE}
uses System.SysUtils, System.Classes, System.JSON, Vcl.Graphics, UniDSAStyle, uniLabel;
procedure Check(Value: Boolean; const Message: string);
begin if not Value then raise Exception.Create(Message); end;
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
