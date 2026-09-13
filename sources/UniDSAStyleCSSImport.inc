{ CSS import is transactional: only typed properties reach the runtime/DFM. }
procedure CSSImportError(const Detail: string);
begin
  raise EArgumentException.Create('ImportCSS: ' + Detail);
end;

function CSSGroup(const M: TMatch; Index: Integer): string;
begin
  if Index < M.Groups.Count then Result := M.Groups[Index].Value else Result := '';
end;

function CSSNumber(const S: string): Double;
begin
  if not TRegEx.IsMatch(Trim(S), '^[+-]?(\d+(\.\d*)?|\.\d+)$') or
     not TryStrToFloat(Trim(S), Result, TFormatSettings.Invariant) then
    CSSImportError('numero nao suportado: ' + S);
end;

function CSSPixels(const S: string; Signed: Boolean = False): Integer;
var V: string; N: Double;
begin
  V := Trim(LowerCase(S));
  if EndsText('px', V) then Delete(V, Length(V)-1, 2)
  else if V <> '0' then CSSImportError('esperado valor inteiro em px: ' + S);
  N := CSSNumber(V);
  if (Abs(N) > MaxInt) or (N <> Trunc(N)) or ((N < 0) and not Signed) then
    CSSImportError('valor em px fora do intervalo: ' + S);
  Result := Trunc(N);
end;

function CSSChoice(const S, Choices: string): Integer;
var Values: TArray<string>; I: Integer;
begin
  Values := Choices.Split(['|']);
  for I := 0 to High(Values) do
    if SameText(Trim(S), Values[I]) then Exit(I+1);
  CSSImportError('valor nao suportado: ' + S);
  Result := 0;
end;

function CSSSplit(const S: string; Separator: Char): TArray<string>;
var I, Start, Depth: Integer; Quote, C: Char; Escaped, Delimiter: Boolean; Part: string;
begin
  SetLength(Result, 0); Start := 1; Depth := 0; Quote := #0; Escaped := False;
  for I := 1 to Length(S) do
  begin
    C := S[I];
    if Escaped then begin Escaped := False; Continue; end;
    if C = '\' then begin Escaped := True; Continue; end;
    if Quote <> #0 then begin if C = Quote then Quote := #0; Continue; end;
    if CharInSet(C, ['"', '''']) then begin Quote := C; Continue; end;
    if C = '(' then Inc(Depth);
    if C = ')' then Dec(Depth);
    if Depth < 0 then CSSImportError('parenteses desbalanceados');
    Delimiter := (C = Separator) or ((Separator = #0) and CharInSet(C, [#9,#10,#13,' ']));
    if Delimiter and (Depth = 0) then begin
      Part := Trim(Copy(S, Start, I-Start));
      if Part <> '' then begin SetLength(Result, Length(Result)+1); Result[High(Result)] := Part; end;
      Start := I+1;
    end;
  end;
  if (Depth <> 0) or (Quote <> #0) or Escaped then CSSImportError('valor CSS incompleto');
  Part := Trim(Copy(S, Start, MaxInt));
  if Part <> '' then begin SetLength(Result, Length(Result)+1); Result[High(Result)] := Part; end;
end;

function CSSNormalize(const Text: string): string;
var I: Integer; Quote: Char;
begin
  Result := ''; I := 1; Quote := #0;
  while I <= Length(Text) do begin
    if (Text[I] = '\') and (Quote <> #0) and (I < Length(Text)) then begin
      Result := Result + Text[I] + Text[I+1]; Inc(I,2); Continue;
    end;
    if Quote <> #0 then begin
      if Text[I] = Quote then Quote := #0;
    end else if CharInSet(Text[I], ['"','''']) then Quote := Text[I]
    else if (Text[I] = '/') and (I < Length(Text)) and (Text[I+1] = '*') then begin
      Inc(I,2);
      while (I < Length(Text)) and not ((Text[I] = '*') and (Text[I+1] = '/')) do Inc(I);
      if I >= Length(Text) then CSSImportError('comentario incompleto');
      Result := Result + ' '; Inc(I,2); Continue;
    end;
    Result := Result + Text[I]; Inc(I);
  end;
  Result := StringReplace(Result, '&#x20;', ' ', [rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '&#32;', ' ', [rfReplaceAll]);
  Result := StringReplace(Result, '&nbsp;', ' ', [rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, #$A0, ' ', [rfReplaceAll]);
  Result := Trim(Result);
end;

procedure CSSColor(const S: string; out Color: TColor; out Opacity: Integer);
var V, H: string; M: TMatch; Values: TArray<string>; I, N: Integer; Channels: array[0..2] of Integer; Alpha: Double;
begin
  V := LowerCase(Trim(S)); Opacity := 100;
  if V = 'transparent' then begin Color := clBlack; Opacity := 0; Exit; end;
  if TRegEx.IsMatch(V, '^#[0-9a-f]{3}$|^#[0-9a-f]{6}$') then begin
    H := Copy(V,2,MaxInt);
    if Length(H)=3 then H := H[1]+H[1]+H[2]+H[2]+H[3]+H[3];
    N := StrToInt('$'+H);
    Color := ((N shr 16) and $FF) or (N and $FF00) or ((N and $FF) shl 16); Exit;
  end;
  M := TRegEx.Match(V, '^(rgb|rgba)\((.*)\)$');
  if M.Success then begin
    Values := CSSSplit(CSSGroup(M,2), ',');
    if ((CSSGroup(M,1)='rgb') and (Length(Values)<>3)) or
       ((CSSGroup(M,1)='rgba') and (Length(Values)<>4)) then CSSImportError('cor invalida: '+S);
    for I := 0 to 2 do begin
      if not TryStrToInt(Values[I], Channels[I]) then CSSImportError('canal RGB invalido: '+S);
      if (Channels[I]<0) or (Channels[I]>255) then CSSImportError('canal RGB fora do intervalo: '+S);
    end;
    if Length(Values)=4 then begin
      Alpha := CSSNumber(Values[3]);
      if (Alpha<0) or (Alpha>1) then CSSImportError('alpha fora do intervalo: '+S);
      Opacity := Round(Alpha*100);
    end;
    Color := Channels[0] or (Channels[1] shl 8) or (Channels[2] shl 16); Exit;
  end;
  case CSSChoice(V,'black|white|red|green|blue|yellow|gray|grey|silver|navy|teal|purple|maroon|lime|aqua|fuchsia|orange') of
    1: Color:=clBlack; 2: Color:=clWhite; 3: Color:=clRed; 4: Color:=$008000;
    5: Color:=clBlue; 6: Color:=clYellow; 7,8: Color:=clGray; 9: Color:=clSilver;
    10: Color:=clNavy; 11: Color:=clTeal; 12: Color:=clPurple; 13: Color:=clMaroon;
    14: Color:=clLime; 15: Color:=clAqua; 16: Color:=clFuchsia; 17: Color:=$00A5FF;
  end;
end;

function CSSOpaqueColor(const S: string): TColor;
var Alpha: Integer;
begin
  CSSColor(S, Result, Alpha);
  if Alpha <> 100 then CSSImportError('transparencia suportada somente no fundo e sombra: '+S);
end;

procedure CSSLength(const S: string; Target: TUniDSAStyleLength; Signed: Boolean = False);
var M: TMatch; V: string; N: Double;
begin
  V := LowerCase(Trim(S));
  if MatchText(V,['auto','fit-content','min-content','max-content']) then begin
    Target.Units := TUniDSAStyleUnit(7+CSSChoice(V,'auto|fit-content|min-content|max-content')); Exit;
  end;
  M := TRegEx.Match(V, '^([+-]?(?:\d+(?:\.\d*)?|\.\d+))(px|%|em|rem|vw|vh|dvh)?$');
  if not M.Success then CSSImportError('dimensao nao suportada: '+S);
  N := CSSNumber(CSSGroup(M,1));
  if (N<0) and not Signed then CSSImportError('dimensao negativa: '+S);
  if CSSGroup(M,2)='' then begin
    if N<>0 then CSSImportError('dimensao sem unidade: '+S);
    Target.Units := suPx;
  end else Target.Units := TUniDSAStyleUnit(CSSChoice(CSSGroup(M,2),'px|%|em|rem|vw|vh|dvh'));
  Target.Value := N;
end;

procedure CSSGeometry(const S: string; Target: TUniDSAStyleGeometry);
var Matches: TMatchCollection; M: TMatch; Values: TArray<string>; Name, Rest: string; N: Double; Rank, LastRank: Integer;
begin
  Target.ScaleX:=1; Target.ScaleY:=1; Target.RotateZ:=0; Target.SkewX:=0; Target.SkewY:=0;
  if SameText(S,'none') then Exit;
  Matches := TRegEx.Matches(S,'([a-zA-Z]+)\(([^()]*)\)'); Rest := S; LastRank:=0;
  if Matches.Count=0 then CSSImportError('transform nao suportado: '+S);
  for M in Matches do begin
    Rest := StringReplace(Rest,M.Value,'',[]);
    Name := LowerCase(CSSGroup(M,1)); Values := CSSSplit(CSSGroup(M,2),',');
    if Length(Values)=0 then CSSImportError('transform vazio');
    if Name='scale' then begin
      Rank:=1;
      if Length(Values)>2 then CSSImportError('scale aceita um ou dois valores');
      Target.ScaleX:=CSSNumber(Values[0]); Target.ScaleY:=Target.ScaleX;
      if Length(Values)=2 then Target.ScaleY:=CSSNumber(Values[1]);
    end else begin
      if Length(Values)<>1 then CSSImportError('transform aceita um valor: '+Name);
      if (Name='scalex') or (Name='scaley') then CSSImportError('use scale(x, y)');
      if not EndsText('deg',Values[0]) then CSSImportError('use graus (deg): '+S);
      N:=CSSNumber(Copy(Values[0],1,Length(Values[0])-3));
      if (Name='rotate') or (Name='rotatez') then begin Rank:=2; Target.RotateZ:=N; end
      else if (Name='skewx') or (Name='skewy') then begin
        if (Abs(N)>=90) or (N<>Trunc(N)) then CSSImportError('skew requer graus inteiros entre -89 e 89');
        if Name='skewx' then begin Rank:=3; Target.SkewX:=Trunc(N); end
        else begin Rank:=4; Target.SkewY:=Trunc(N); end;
      end else begin CSSImportError('transform nao suportado: '+Name); Rank:=0; end;
    end;
    if Rank<=LastRank then CSSImportError('ordem suportada: scale, rotateZ, skewX, skewY (sem repeticao)');
    if (Target.ScaleX=-1000) or (Target.ScaleY=-1000) or (Target.RotateZ=-1000) then
      CSSImportError('-1000 e reservado para heranca em Transform');
    LastRank:=Rank;
  end;
  if Trim(Rest)<>'' then CSSImportError('transform nao suportado: '+Rest);
end;

procedure CSSDeclaration(A: TUniDSAStyleVisual; const Name, Value: string);
var V: string; Tokens: TArray<string>; Color: TColor; Alpha, I, N: Integer;
  Edges: TUniDSAStyleEdges; EdgeValues: array[0..3] of Integer; M: TMatch; D: Double;
begin
  V:=LowerCase(Trim(Value));
  if Name='width' then CSSLength(V,A.Sizing.Width)
  else if Name='height' then CSSLength(V,A.Sizing.Height)
  else if Name='min-width' then CSSLength(V,A.Sizing.MinWidth)
  else if Name='max-width' then CSSLength(V,A.Sizing.MaxWidth)
  else if Name='min-height' then CSSLength(V,A.Sizing.MinHeight)
  else if Name='max-height' then CSSLength(V,A.Sizing.MaxHeight)
  else if Name='box-sizing' then A.Sizing.BoxSizing:=TUniDSAStyleBoxSizing(CSSChoice(V,'border-box|content-box'))
  else if (Name='background') or (Name='background-color') then begin
    CSSColor(V,Color,Alpha); A.Background.Color:=Color; A.Background.Opacity:=Alpha;
    if Name='background' then begin A.Background.ImageURL:=''; A.Background.Gradient:=sgNone; A.Background.Pattern:=spNone; end;
  end
  else if Name='color' then A.Typography.Color:=CSSOpaqueColor(V)
  else if Name='border-color' then A.Border.Color:=CSSOpaqueColor(V)
  else if Name='border-width' then A.Border.Width:=CSSPixels(V)
  else if Name='border-style' then A.Border.Line:=TUniDSAStyleBorderLine(CSSChoice(V,'none|solid|dashed|dotted|double'))
  else if Name='border-radius' then begin
    A.Border.Radius:=CSSPixels(V); A.Border.TopLeftRadius:=-1; A.Border.TopRightRadius:=-1;
    A.Border.BottomLeftRadius:=-1; A.Border.BottomRightRadius:=-1;
  end
  else if Name='border' then begin
    Tokens:=CSSSplit(V,#0);
    if V='none' then begin A.Border.Width:=0; A.Border.Line:=blNone; end
    else begin
      if Length(Tokens)<>3 then CSSImportError('border: use largura tipo cor');
      A.Border.Width:=CSSPixels(Tokens[0]);
      A.Border.Line:=TUniDSAStyleBorderLine(CSSChoice(Tokens[1],'none|solid|dashed|dotted|double'));
      A.Border.Color:=CSSOpaqueColor(Tokens[2]);
    end;
    A.Border.Top.Width:=-1; A.Border.Top.Line:=blInherit; A.Border.Top.Color:=clNone;
    A.Border.Right.Assign(A.Border.Top); A.Border.Bottom.Assign(A.Border.Top); A.Border.Left.Assign(A.Border.Top);
  end
  else if Name='box-shadow' then begin
    if V='none' then begin A.Shadow.Enabled:=ssNo; Exit; end;
    Tokens:=CSSSplit(V,#0); N:=Length(Tokens); I:=0; A.Shadow.Inset:=ssNo;
    if (N>0) and (Tokens[0]='inset') then begin I:=1; A.Shadow.Inset:=ssYes; end;
    if (N-I<3) or (N-I>5) then CSSImportError('box-shadow: use x y [blur [spread]] cor, com inset opcional no inicio');
    A.Shadow.OffsetX:=CSSPixels(Tokens[I],True); A.Shadow.OffsetY:=CSSPixels(Tokens[I+1],True);
    A.Shadow.Blur:=0; A.Shadow.Spread:=0;
    if N-I>=4 then A.Shadow.Blur:=CSSPixels(Tokens[I+2]);
    if N-I=5 then A.Shadow.Spread:=CSSPixels(Tokens[I+3],True);
    if (A.Shadow.OffsetX=-1000) or (A.Shadow.OffsetY=-1000) or (A.Shadow.Spread=-1000) then
      CSSImportError('-1000 e reservado para heranca em Shadow');
    CSSColor(Tokens[N-1],Color,Alpha); A.Shadow.Color:=Color; A.Shadow.Opacity:=Alpha; A.Shadow.Enabled:=ssYes;
  end
  else if (Name='backdrop-filter') or (Name='-webkit-backdrop-filter') then begin
    if V='none' then A.Effects.BackdropBlur:=0 else begin
      M:=TRegEx.Match(V,'^blur\(([^()]*)\)$');
      if not M.Success then CSSImportError('backdrop-filter: somente blur(px)');
      A.Effects.BackdropBlur:=CSSPixels(CSSGroup(M,1));
    end;
  end
  else if Name='display' then A.Display:=TUniDSAStyleDisplay(CSSChoice(V,'none|block|inline|inline-block|flex|inline-flex|grid|inline-grid'))
  else if Name='align-items' then A.AlignItems:=TUniDSAStyleFlexAlign(CSSChoice(V,'stretch|flex-start|center|flex-end|baseline'))
  else if Name='justify-content' then A.JustifyContent:=TUniDSAStyleJustify(CSSChoice(V,'flex-start|center|flex-end|space-between|space-around|space-evenly'))
  else if Name='user-select' then A.Effects.UserSelect:=TUniDSAStyleUserSelect(CSSChoice(V,'auto|none|text|all'))
  else if Name='cursor' then A.Effects.Cursor:=TUniDSAStyleCursor(CSSChoice(V,'default|pointer|text|not-allowed|grab'))
  else if Name='text-align' then A.Typography.Alignment:=TUniDSAStyleAlign(CSSChoice(V,'left|center|right|justify'))
  else if Name='font-weight' then begin
    if V='400' then V:='normal' else if V='500' then V:='medium' else if V='600' then V:='semibold' else if V='700' then V:='bold';
    A.Typography.Weight:=TUniDSAStyleWeight(CSSChoice(V,'normal|medium|semibold|bold|bolder|lighter'));
  end
  else if Name='font-size' then begin
    N:=CSSPixels(V); if N<1 then CSSImportError('font-size requer pelo menos 1px'); A.Typography.Size:=N;
  end
  else if Name='font-style' then A.Typography.Italic:=TUniDSAStyleSwitch(CSSChoice(V,'normal|italic'))
  else if Name='white-space' then A.Typography.WhiteSpace:=TUniDSAStyleWhiteSpace(CSSChoice(V,'normal|nowrap|pre|pre-wrap|pre-line'))
  else if Name='text-transform' then A.Typography.Transform:=TUniDSAStyleTransform(CSSChoice(V,'none|uppercase|lowercase|capitalize'))
  else if Name='text-decoration' then A.Typography.Decoration:=TUniDSAStyleDecoration(CSSChoice(V,'none|underline|line-through'))
  else if Name='line-height' then begin D:=CSSNumber(V); if D<0.1 then CSSImportError('line-height requer multiplicador de pelo menos 0.1'); A.Typography.LineHeight:=D; end
  else if Name='letter-spacing' then begin
    N:=CSSPixels(V,True); if N=-1000 then CSSImportError('-1000 e reservado para heranca'); A.Typography.LetterSpacing:=N;
  end
  else if Name='opacity' then begin
    D:=CSSNumber(V); if (D<0) or (D>1) then CSSImportError('opacity entre 0 e 1'); A.Effects.Opacity:=Round(D*100);
  end
  else if (Name='transition') or (Name='transition-duration') then begin
    M:=TRegEx.Match(V,'^(?:all\s+)?(\d+(?:\.\d+)?|\.\d+)(ms|s)(?:\s+ease)?$');
    if not M.Success then CSSImportError('transition: use all <tempo> [ease]');
    D:=CSSNumber(CSSGroup(M,1)); if CSSGroup(M,2)='s' then D:=D*1000;
    if D>MaxInt then CSSImportError('transition fora do intervalo');
    A.Effects.TransitionMs:=Round(D); if Name='transition' then A.Effects.TransitionAll:=ssYes;
  end
  else if Name='transform' then CSSGeometry(V,A.Transform)
  else if (Name='padding') or (Name='margin') then begin
    Tokens:=CSSSplit(V,#0); if (Length(Tokens)<1) or (Length(Tokens)>4) then CSSImportError('espacamento: use 1 a 4 valores');
    for I:=0 to High(Tokens) do begin
      EdgeValues[I]:=CSSPixels(Tokens[I],Name='margin');
      if EdgeValues[I]=-1 then CSSImportError('-1px e reservado para heranca em Spacing');
    end;
    if Length(Tokens)=1 then EdgeValues[1]:=EdgeValues[0];
    if Length(Tokens)<3 then EdgeValues[2]:=EdgeValues[0];
    if Length(Tokens)<4 then EdgeValues[3]:=EdgeValues[1];
    if Name='padding' then Edges:=A.Spacing.Padding else Edges:=A.Spacing.Margin;
    Edges.All:=-1; Edges.Top:=EdgeValues[0]; Edges.Right:=EdgeValues[1]; Edges.Bottom:=EdgeValues[2]; Edges.Left:=EdgeValues[3];
  end
  else if Name='position' then A.Position.Mode:=TUniDSAStylePositionMode(CSSChoice(V,'static|relative|absolute|fixed|sticky'))
  else if Name='top' then CSSLength(V,A.Position.Top,True)
  else if Name='right' then CSSLength(V,A.Position.Right,True)
  else if Name='bottom' then CSSLength(V,A.Position.Bottom,True)
  else if Name='left' then CSSLength(V,A.Position.Left,True)
  else if Name='z-index' then begin if not TryStrToInt(V,N) or (N=-1000) then CSSImportError('z-index nao suportado'); A.Position.ZIndex:=N; end
  else if (Name='overflow') or (Name='overflow-x') or (Name='overflow-y') then begin
    N:=CSSChoice(V,'visible|hidden|auto|scroll');
    if Name<>'overflow-y' then A.Sizing.OverflowX:=TUniDSAStyleOverflow(N);
    if Name<>'overflow-x' then A.Sizing.OverflowY:=TUniDSAStyleOverflow(N);
  end
  else CSSImportError('propriedade nao suportada: '+Name);
end;

procedure CSSRemoveCustomDeclaration(A: TUniDSAStyleVisual; const Name: string);
var Declaration, Text: string; P: Integer;
begin
  Text := '';
  for Declaration in CSSSplit(CSSNormalize(A.CustomCSS.Text), ';') do begin
    P := Pos(':', Declaration);
    if ((Copy(Name,1,2)='--') and (Trim(Copy(Declaration,1,P-1))<>Name)) or
       ((Copy(Name,1,2)<>'--') and not SameText(Trim(Copy(Declaration,1,P-1)),Name)) then
      Text := Text + Declaration + ';' + sLineBreak;
  end;
  A.CustomCSS.Text := Text;
end;

procedure CSSDeclarations(A: TUniDSAStyleVisual; const Text: string);
var Declaration, Name, Value: string; P: Integer; Candidate: TUniDSAStyleVisual;
  Converted: Boolean;
begin
  for Declaration in CSSSplit(Text,';') do begin
    P:=Pos(':',Declaration);
    if P<=1 then CSSImportError('declaracao invalida: '+Declaration);
    Name:=Trim(Copy(Declaration,1,P-1));
    if Copy(Name,1,2)<>'--' then Name:=LowerCase(Name);
    Value:=Trim(Copy(Declaration,P+1,MaxInt));
    if Value='' then CSSImportError('valor vazio: '+Name);
    if not TRegEx.IsMatch(Name, '^(--[a-zA-Z0-9_-]+|[a-zA-Z-][a-zA-Z0-9-]*)$') then
      CSSImportError('nome de propriedade invalido: '+Name);
    Candidate := TUniDSAStyleVisual.Create(nil);
    try
      Candidate.Assign(A);
      CSSRemoveCustomDeclaration(Candidate, Name);
      Converted := True;
      try CSSDeclaration(Candidate,Name,Value);
      except on E: EArgumentException do Converted := False; end;
      if Converted then A.Assign(Candidate)
      else begin
        // Discard any partial conversion before preserving the original value.
        CSSRemoveCustomDeclaration(A, Name);
        A.CustomCSS.Add(Name + ': ' + Value + ';');
      end;
    finally Candidate.Free; end;
  end;
end;

function TUniDSAStyleRule.GetImportCSS: string;
begin Result := ''; end;

procedure TUniDSAStyleRule.Reset;
var Empty: TUniDSAStyleRule;
begin
  Empty := TUniDSAStyleRule.Create(nil);
  try Assign(Empty); finally Empty.Free; end;
end;

procedure TUniDSAStyleRule.SetImportCSS(const Value: string);
begin
  // Preserve the additive behavior of existing assignments in application code.
  LoadCSS(Value, False);
end;

procedure TUniDSAStyleRule.LoadCSS(const Value: string; ReplaceExisting: Boolean);
var Temp: TUniDSAStyleRule; Text, Selector, SelectorPart, Base: string; P, ClosePos: Integer;
  M: TMatch; A: TUniDSAStyleAppearance;
begin
  Text:=CSSNormalize(Value); if Text='' then Exit;
  Temp:=TUniDSAStyleRule.Create(nil);
  try
    if not ReplaceExisting then Temp.Assign(Self);
    Base:='';
    if Pos('{',Text)=0 then CSSDeclarations(Temp.Appearance,Text)
    else while Trim(Text)<>'' do begin
      P:=Pos('{',Text); ClosePos:=Pos('}',Text);
      if (P=0) or (ClosePos<P) or (Pos('{',Copy(Text,P+1,ClosePos-P-1))>0) then CSSImportError('blocos invalidos ou aninhados');
      // Every selector in a group addresses the same control, possibly another state.
      // Split without removing empty entries so malformed lists remain errors.
      for SelectorPart in Copy(Text,1,P-1).Split([',']) do begin
        Selector:=Trim(SelectorPart);
        if Selector='' then CSSImportError('seletor vazio na lista');
        M:=TRegEx.Match(Selector,'^([.#]?[a-zA-Z_][\w-]*)(?::(hover|active|focus|disabled))?$');
        if not M.Success then CSSImportError('seletor nao suportado: '+Selector);
        if Base='' then Base:=CSSGroup(M,1)
        else if Base<>CSSGroup(M,1) then CSSImportError('cole apenas um seletor base e seus estados: '+Selector);
        A:=Temp.Appearance;
        if CSSGroup(M,2)='hover' then A:=Temp.States.Hover
        else if CSSGroup(M,2)='active' then A:=Temp.States.Pressed
        else if CSSGroup(M,2)='focus' then A:=Temp.States.Focus
        else if CSSGroup(M,2)='disabled' then A:=Temp.States.Disabled;
        CSSDeclarations(A,Copy(Text,P+1,ClosePos-P-1));
      end;
      Delete(Text,1,ClosePos);
    end;
    Assign(Temp);
  finally Temp.Free; end;
end;
