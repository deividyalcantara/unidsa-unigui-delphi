procedure TestCSSImport;
var Source, Target: TUniDSAStyle; Item: TUniDSANamedStyle; R: TUniDSAStyleRule;
  Binary, TextDFM: TMemoryStream; JSON: TJSONObject; Probe: TChangeProbe;
  CSS, Snapshot, Bad: string; Raised: Boolean;
  function RuleJSON(Rule: TUniDSAStyleRule): string;
  var J: TJSONObject;
  begin J:=Rule.ToJSON; try Result:=J.ToJSON; finally J.Free; end; end;
begin
  Source:=TUniDSAStyle.Create(nil); Target:=TUniDSAStyle.Create(nil);
  Probe:=TChangeProbe.Create; R:=TUniDSAStyleRule.Create(Probe.Changed);
  Binary:=TMemoryStream.Create; TextDFM:=TMemoryStream.Create;
  try
    CSS:=TFile.ReadAllText(ExpandFileName(ExtractFilePath(ParamStr(0))+'..\..\tools\fixtures\style-card.css'),TEncoding.UTF8);
    Source.Name:='ImportedCard'; Item:=Source.Styles.Add; Item.Name:='Card';
    Item.ImportCSS:=CSS;
    with Item do begin
      Check(Appearance.Sizing.Width.Value=190,'CSS width');
      Check(Appearance.Sizing.Height.Value=254,'CSS height');
      Check(Appearance.Sizing.BoxSizing=bsBorderBox,'CSS box-sizing');
      Check(Appearance.Background.Color=$D9D9D9,'CSS background RGB');
      Check(Appearance.Background.Opacity=58,'CSS background alpha');
      Check(Appearance.Border.Color=clWhite,'CSS border white');
      Check(Appearance.Border.Width=1,'CSS border width');
      Check(Appearance.Border.Radius=17,'CSS radius');
      Check(Appearance.Shadow.OffsetX=12,'CSS shadow X');
      Check(Appearance.Shadow.OffsetY=17,'CSS shadow Y');
      Check(Appearance.Shadow.Blur=51,'CSS shadow blur');
      Check(Appearance.Shadow.Opacity=22,'CSS shadow alpha');
      Check(Appearance.Effects.BackdropBlur=6,'CSS backdrop blur');
      Check(Appearance.Effects.TransitionMs=500,'CSS transition seconds');
      Check(Appearance.Effects.TransitionAll=ssYes,'CSS transition all');
      Check(Appearance.Effects.UserSelect=susNone,'CSS user-select');
      Check(Appearance.Typography.Weight=swBolder,'CSS relative font weight');
      Check(Appearance.Typography.Alignment=saCenter,'CSS text align');
      Check(Appearance.Display=sdFlex,'CSS flex');
      Check(Appearance.AlignItems=sfaCenter,'CSS align items');
      Check(Appearance.JustifyContent=sjCenter,'CSS justify content');
      Check(States.Hover.Border.Color=clBlack,'CSS hover');
      Check(Abs(States.Hover.Transform.ScaleX-1.05)<0.000001,'CSS hover scale');
      Check(Abs(States.Pressed.Transform.ScaleY-0.95)<0.000001,'CSS active scale');
      Check(Abs(States.Pressed.Transform.RotateZ-1.7)<0.000001,'CSS active rotation');
    end;
    JSON:=Item.Rule.ToJSON;
    try TFile.WriteAllText(ExtractFilePath(ParamStr(0))+'imported-card.json',JSON.ToJSON,TEncoding.UTF8);
    finally JSON.Free; end;
    R.ImportCSS:=CSS; Check(Probe.Count=1,'CSS import single notification');
    Snapshot:=RuleJSON(R); Probe.Count:=0;
    for Bad in ['.a {color: red;} .b {color: blue;}',
      '.a:hover:active {color: red;}', '@media (max-width:600px) {.a {width:10px;}}',
      'width: 10px; /* unclosed', 'width: 10px; color: rgb(1,2,3;',
      'color:;', 'width:10px; no-colon', '.a {width:10px;} trailing',
      'bad property: red;'] do begin
      Raised:=False;
      try R.ImportCSS:=Bad; except on E: EArgumentException do Raised:=True; end;
      Check(Raised,'Unsupported CSS must fail: '+Bad);
      Check(RuleJSON(R)=Snapshot,'Failed CSS must preserve all properties: '+Bad);
    end;
    Check(Probe.Count=0,'Failed import must not notify');
    Item.Appearance.Border.Radius:=23;
    Binary.WriteComponent(Source); Binary.Position:=0; ObjectBinaryToText(Binary,TextDFM);
    // Inspect the serialized text as bytes; the command must never be replayed on load.
    TextDFM.Position:=0;
    with TStringStream.Create('',TEncoding.UTF8) do try
      CopyFrom(TextDFM,0); Check(Pos('ImportCSS',DataString)=0,'Import command must not persist');
    finally Free; end;
    Binary.Position:=0; Binary.ReadComponent(Target);
    Check(RuleJSON(Target.Styles[0].Rule)=RuleJSON(Item.Rule),'Imported properties round-trip DFM');
    Check(Target.Styles[0].Appearance.Border.Radius=23,'Manual edits after import must persist');
    Target.Styles.Assign(Source.Styles);
    Target.Styles[0].States.Hover.Transform.ScaleX:=2;
    Check(Abs(Item.States.Hover.Transform.ScaleX-1.05)<0.000001,'Imported scale deep Assign');
    R.Appearance.Scrollbar.Size:=9;
    R.ImportCSS:='/* comment */ width: 50%; padding: 1px 2px 3px 4px; background: #abc; transition: all 120ms;';
    Check(R.Appearance.Scrollbar.Size=9,'Import preserves unrelated settings');
    Check(R.Appearance.Background.Color=$CCBBAA,'CSS short hex channels');
    Check(R.Appearance.Sizing.Width.Units=suPercent,'CSS percentage');
    Check(R.Appearance.Spacing.Padding.Left=4,'CSS padding shorthand');
    Check(R.Appearance.Effects.TransitionMs=120,'CSS milliseconds');
    R.ImportCSS:='.x:focus {color: blue;} .x:disabled {opacity: 0.5;} .x:hover {transform: none;}';
    Check(R.States.Focus.Typography.Color=clBlue,'CSS focus');
    Check(R.States.Disabled.Effects.Opacity=50,'CSS disabled');
    Check(R.States.Hover.Transform.ScaleX=1,'CSS transform reset');
    Item.ImportCSS:='backdrop-filter: none; transform: scale(0) rotateZ(0deg);';
    Binary.Clear; Binary.WriteComponent(Source); Binary.Position:=0; Binary.ReadComponent(Target);
    Check(Target.Styles[0].Appearance.Effects.BackdropBlur=0,'Zero blur reset must persist');
    Check(Target.Styles[0].Appearance.Transform.ScaleX=0,'Zero scale must persist');
    Check(Target.Styles[0].Appearance.Transform.RotateZ=0,'Zero rotation must persist');
    Source.Defaults.ImportCSS:='color: #ff0000;';
    Check(Source.Defaults.Appearance.Typography.Color=clRed,'Defaults import');
    Source.StyleItems.Add.ImportCSS:='color: #0000ff;';
    Check(Source.StyleItems[0].Appearance.Typography.Color=clBlue,'StyleItems import');
    Writeln('PASS: CSS card import, states, atomic errors, DFM, manual edits, Assign and notifications.');
  finally TextDFM.Free; Binary.Free; R.Free; Probe.Free; Target.Free; Source.Free; end;
end;
procedure TestCustomCSS;
var Source, Target: TUniDSAStyle; Rule, Plain: TUniDSAStyleRule;
  Stream: TMemoryStream; JSON: TJSONObject; Probe: TChangeProbe;
  CSS, Declarations, Before: string; Raised: Boolean;
  function AsJSON(R: TUniDSAStyleRule): string;
  var J: TJSONObject;
  begin J:=R.ToJSON; try Result:=J.ToJSON; finally J.Free; end; end;
begin
  Source:=TUniDSAStyle.Create(nil); Target:=TUniDSAStyle.Create(nil);
  Stream:=TMemoryStream.Create; Probe:=TChangeProbe.Create;
  Plain:=TUniDSAStyleRule.Create(Probe.Changed);
  try
    Source.Name:='CustomCSSFixture'; Rule:=Source.Styles.Add.Rule;
    CSS:=TFile.ReadAllText(ExpandFileName(ExtractFilePath(ParamStr(0))+'..\..\tools\fixtures\style-box.css'),TEncoding.UTF8);
    Declarations:=Copy(CSS,Pos('{',CSS)+1,Pos('}',CSS)-Pos('{',CSS)-1);
    Rule.ImportCSS:=CSS; Plain.ImportCSS:=Declarations;
    Check(AsJSON(Rule)=AsJSON(Plain),'Selector and declaration-only imports must match');
    Check(Probe.Count=1,'Fallback import must notify once');
    Check(Rule.Appearance.Border.Radius=46,'Radius must still map to typed property');
    Check(Rule.Appearance.Background.Color=$E0E0E0,'Background must still map to typed property');
    Check(Pos('box-shadow:',Rule.Appearance.CustomCSS.Text)>0,'Multiple shadows preserved in CustomCSS');
    Check(Pos('-34px -34px 68px #ffffff',Rule.Appearance.CustomCSS.Text)>0,'Second shadow preserved');
    Check(Pos('&#x20;',Rule.Appearance.CustomCSS.Text)=0,'HTML space entities normalized');
    Check(Rule.Appearance.Shadow.Enabled=ssInherit,'Failed conversion must not leave partial shadow parameters');
    Probe.Count:=0; Plain.Appearance.CustomCSS.Add('filter: brightness(0.9);');
    Check(Probe.Count=1,'Editing CustomCSS must notify');
    Rule.ImportCSS:='.box:hover {box-shadow: inset 0 0 5px red, 1px 1px 3px rgba(0,0,0,0.2);}';
    Check(Pos('rgba(0,0,0,0.2)',Rule.States.Hover.CustomCSS.Text)>0,'Hover fallback retains function commas');
    Stream.WriteComponent(Source); Stream.Position:=0; Stream.ReadComponent(Target);
    Check(AsJSON(Target.Styles[0].Rule)=AsJSON(Rule),'CustomCSS must persist in DFM, including states');
    JSON:=Target.Styles[0].Rule.ToJSON;
    try TFile.WriteAllText(ExtractFilePath(ParamStr(0))+'imported-box.json',JSON.ToJSON,TEncoding.UTF8);
    finally JSON.Free; end;
    Target.Styles.Assign(Source.Styles); Target.Styles[0].Appearance.CustomCSS.Clear;
    Check(Rule.Appearance.CustomCSS.Count>0,'CustomCSS must deep-copy on Assign');
    Before:=AsJSON(Rule); Raised:=False;
    try Rule.ImportCSS:='width: 200px; filter: brightness(0.8); invalid';
    except on E: EArgumentException do Raised:=True; end;
    Check(Raised and (AsJSON(Rule)=Before),'Malformed imports must still be atomic');
    Rule.ImportCSS:='box-shadow: 0 0 3px red;';
    Check(Pos('box-shadow:',Rule.Appearance.CustomCSS.Text)=0,'Supported reimport removes stale fallback');
    Check(Rule.Appearance.Shadow.Color=clRed,'Reimport converts supported shadow');
    Plain.ImportCSS:='--Accent: red; --accent: blue; color: var(--Accent); width: calc(100% - 2px);';
    Check(Pos('--Accent: red;',Plain.Appearance.CustomCSS.Text)>0,'Custom properties retain case');
    Check(Pos('--accent: blue;',Plain.Appearance.CustomCSS.Text)>0,'Custom properties are case sensitive');
    Check(Pos('color: var(--Accent);',Plain.Appearance.CustomCSS.Text)>0,'CSS values retain case');
    Rule.ImportCSS:='border: 5px solid rgba(0,0,0,0.4);';
    Check(Rule.Appearance.Border.Width=-1,'Partial shorthand parsing must not change typed width');
    Check(Pos('border: 5px solid rgba',Rule.Appearance.CustomCSS.Text)>0,'Unsupported shorthand preserved whole');
    Writeln('PASS: CustomCSS fallback, both box formats, DFM, states, notifications, deep Assign and reimport.');
  finally Plain.Free; Probe.Free; Stream.Free; Target.Free; Source.Free; end;
end;
procedure TestCSSReplace;
var Manager: TUniDSAStyle; Item: TUniDSAStyleItem; Probe: TChangeProbe;
  Rule, Expected: TUniDSAStyleRule; Control: TUniLabel;
  CSS, BoxCSS, Snapshot, DefaultsSnapshot, SharedSnapshot: string;
  Raised: Boolean; Binary: TMemoryStream; CopyManager: TUniDSAStyle;
  function JSONText(R: TUniDSAStyleRule): string;
  var J: TJSONObject;
  begin J:=R.ToJSON; try Result:=J.ToJSON; finally J.Free; end; end;
  procedure Seed(R: TUniDSAStyleRule);
  begin
    R.LoadCSS(CSS);
    R.Appearance.CustomCSS.Add('filter: brightness(0.8);');
    R.Appearance.Content.CustomCSS.Add('letter-spacing: 3px;');
    R.Appearance.Before.Enabled:=ssYes; R.Appearance.Before.Text:='old';
    R.Appearance.After.Enabled:=ssYes; R.Appearance.After.Text:='after';
    R.States.Focus.CustomCSS.Add('outline: 4px solid red;');
    R.States.Disabled.Effects.Opacity:=40;
    R.States.Selected.Typography.Color:=clRed;
    with R.Responsive.Add do begin
      MaxWidth:=1200; Appearance.Sizing.Width.Units:=suPx; Appearance.Sizing.Width.Value:=500;
      States.Hover.CustomCSS.Add('filter: grayscale(1);');
    end;
  end;
begin
  Manager:=TUniDSAStyle.Create(nil); CopyManager:=TUniDSAStyle.Create(nil);
  Probe:=TChangeProbe.Create; Rule:=TUniDSAStyleRule.Create(Probe.Changed);
  Expected:=TUniDSAStyleRule.Create(nil); Binary:=TMemoryStream.Create;
  try
    CSS:=TFile.ReadAllText(ExpandFileName(ExtractFilePath(ParamStr(0))+'..\..\tools\fixtures\style-card.css'),TEncoding.UTF8);
    BoxCSS:=TFile.ReadAllText(ExpandFileName(ExtractFilePath(ParamStr(0))+'..\..\tools\fixtures\style-box.css'),TEncoding.UTF8);
    Seed(Rule); Snapshot:=JSONText(Rule); Probe.Count:=0;
    for CSS in ['width: 40px; broken', '.x {width:40px;} .y {color:red;}'] do begin
      Raised:=False;
      try Rule.LoadCSS(CSS); except on E: EArgumentException do Raised:=True; end;
      Check(Raised and (JSONText(Rule)=Snapshot),'Replace errors must preserve the complete previous style');
    end;
    Rule.LoadCSS(' /* only comment */ ');
    Check(JSONText(Rule)=Snapshot,'Empty replacement must not silently erase the style');
    Check(Probe.Count=0,'Failed/empty replacement must not notify');
    TFile.WriteAllText(ExtractFilePath(ParamStr(0))+'replace-style-before.json',JSONText(Rule),TEncoding.UTF8);
    Rule.LoadCSS(BoxCSS);
    Expected.ImportCSS:=BoxCSS;
    Check(JSONText(Rule)=JSONText(Expected),'Replacement must equal a fresh import, including states, parts and responsive');
    Check(Probe.Count=1,'Replacement must notify once');
    TFile.WriteAllText(ExtractFilePath(ParamStr(0))+'replace-style-after.json',JSONText(Rule),TEncoding.UTF8);
    Rule.LoadCSS('color: blue;',False);
    Check((Rule.Appearance.Border.Radius=46) and (Rule.Appearance.CustomCSS.Count>0),'Merge mode must retain existing properties and fallback');
    Rule.ImportCSS:='font-size: 18px;';
    Check(Rule.Appearance.Border.Radius=46,'Property setter remains additive for existing code');
    Manager.Name:='ReplaceFixture'; Manager.Defaults.ImportCSS:='color:green;';
    with Manager.Styles.Add do begin Name:='Shared'; ImportCSS:='border-radius:9px;'; end;
    Item:=Manager.StyleItems.Add; Item.Name:='Target'; Item.StyleName:='Shared';
    Control:=TUniLabel.Create(Manager); Control.Name:='TargetLabel'; Item.Control:=Control;
    Item.Selected:=True; Item.Enabled:=False;
    Item.Rule.Assign(Rule); DefaultsSnapshot:=JSONText(Manager.Defaults); SharedSnapshot:=JSONText(Manager.Styles[0].Rule);
    Item.LoadCSS(BoxCSS);
    Check(JSONText(Item.Rule)=JSONText(Expected),'Named item helper must replace the local rule');
    Check((Item.Name='Target') and (Item.StyleName='Shared') and (Item.Control=Control),'Replacement must retain the name and control/style associations');
    Check(Item.Selected and not Item.Enabled,'Replacement must retain association flags');
    Check((JSONText(Manager.Defaults)=DefaultsSnapshot) and (JSONText(Manager.Styles[0].Rule)=SharedSnapshot),'Replacement must not clear defaults or another shared style');
    Binary.WriteComponent(Manager); Binary.Position:=0; Binary.ReadComponent(CopyManager);
    Check(JSONText(CopyManager.StyleItems[0].Rule)=JSONText(Expected),'Replacement must persist as only the new rule in DFM');
    Probe.Count:=0; Rule.Reset; Expected.Reset;
    Check(JSONText(Rule)=JSONText(Expected),'Reset clears the entire rule');
    Check(Probe.Count=1,'Reset must notify once');
    Item.Reset;
    Check((JSONText(Item.Rule)=JSONText(Expected)) and (Item.Control=Control) and (Item.StyleName='Shared'),'Reset must preserve item associations');
    Writeln('PASS: replace/merge/reset, atomic errors, complete state cleanup, DFM, notifications and retained associations.');
  finally Binary.Free; Expected.Free; Rule.Free; Probe.Free; CopyManager.Free; Manager.Free; end;
end;
procedure TestCSSSelectorGroups;
var Manager, CopyManager: TUniDSAStyle; Rule, Separate: TUniDSAStyleRule;
  Probe: TChangeProbe; Binary: TMemoryStream; CSS, Snapshot, Bad: string;
  Raised: Boolean; J: TJSONObject;
  function JSONText(R: TUniDSAStyleRule): string;
  var Value: TJSONObject;
  begin Value:=R.ToJSON; try Result:=Value.ToJSON; finally Value.Free; end; end;
begin
  Manager:=TUniDSAStyle.Create(nil); CopyManager:=TUniDSAStyle.Create(nil);
  Probe:=TChangeProbe.Create; Rule:=TUniDSAStyleRule.Create(Probe.Changed);
  Separate:=TUniDSAStyleRule.Create(nil); Binary:=TMemoryStream.Create;
  try
    CSS:=TFile.ReadAllText(ExpandFileName(ExtractFilePath(ParamStr(0))+'..\..\tools\fixtures\style-button-grouped.css'),TEncoding.UTF8);
    Rule.LoadCSS(CSS);
    Check(Probe.Count=1,'Grouped import must notify once');
    Check(Rule.Appearance.Background.Color=$894CEA,'Grouped button base background');
    Check(Rule.States.Hover.Background.Color=$AC82F0,'Grouped hover background');
    Check(Rule.States.Focus.Background.Color=$AC82F0,'Grouped focus background');
    Check(Pos('"Helvetica Neue", Helvetica, Arial, sans-serif',Rule.Appearance.CustomCSS.Text)>0,'Font-family commas preserved');
    Check(Pos('transition: color 100ms;',Rule.Appearance.CustomCSS.Text)>0,'Transition fallback preserved');
    Check(Pos('line-height: 20px;',Rule.Appearance.CustomCSS.Text)>0,'Line-height fallback preserved');
    Separate.LoadCSS(Copy(CSS,1,Pos('.button-1:hover',CSS)-1)+
      '.button-1:hover { background-color: #F082AC; } .button-1:focus { background-color: #F082AC; }');
    Check(JSONText(Rule)=JSONText(Separate),'Grouped selectors must equal separate rules');
    Manager.Name:='GroupedButton'; Manager.Styles.Add.Name:='Button'; Manager.Styles[0].Rule.Assign(Rule);
    Binary.WriteComponent(Manager); Binary.Position:=0; Binary.ReadComponent(CopyManager);
    Check(JSONText(CopyManager.Styles[0].Rule)=JSONText(Rule),'Grouped states must persist in DFM');
    J:=CopyManager.Styles[0].Rule.ToJSON;
    try TFile.WriteAllText(ExtractFilePath(ParamStr(0))+'grouped-button.json',J.ToJSON,TEncoding.UTF8);
    finally J.Free; end;
    Snapshot:=JSONText(Rule); Probe.Count:=0;
    for Bad in ['.button-1:hover, {color:red;}', ',.button-1 {color:red;}',
      '.button-1:hover,,.button-1:focus {color:red;}',
      '.button-1:hover, .other:focus {color:red;}',
      '.button-1:hover, .button-1:unknown {color:red;}',
      '.button-1:hover, .button-1:focus {width:10px; broken}'] do begin
      Raised:=False;
      try Rule.LoadCSS(Bad); except on E: EArgumentException do Raised:=True; end;
      Check(Raised and (JSONText(Rule)=Snapshot),'Invalid group must preserve previous style: '+Bad);
    end;
    Check(Probe.Count=0,'Invalid grouped import must not notify');
    Rule.ImportCSS:='.button-1:hover, /* comment */ .button-1:focus {filter: brightness(0.8); color: red;}' +
      '.button-1:hover {color: blue;}';
    Check(Rule.States.Hover.Typography.Color=clBlue,'Later hover rule must override grouped hover');
    Check(Rule.States.Focus.Typography.Color=clRed,'Later hover rule must preserve grouped focus');
    Check(Rule.States.Hover.CustomCSS.Text=Rule.States.Focus.CustomCSS.Text,'Grouped fallback applied to both states');
    Rule.States.Hover.CustomCSS.Clear;
    Check(Rule.States.Focus.CustomCSS.Count>0,'Grouped states must remain independently editable');
    Rule.LoadCSS('.x, .x:hover, .x:focus, .x:active, .x:disabled {background: blue;}');
    Check((Rule.Appearance.Background.Color=clBlue) and (Rule.States.Pressed.Background.Color=clBlue) and
      (Rule.States.Disabled.Background.Color=clBlue),'Group may include base and all supported states');
    Writeln('PASS: grouped selectors, full button CSS, independent states, fallback commas, DFM and atomic failures.');
  finally Binary.Free; Separate.Free; Rule.Free; Probe.Free; CopyManager.Free; Manager.Free; end;
end;
