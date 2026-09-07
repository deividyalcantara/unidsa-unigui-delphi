unit UniDSAFlexPanelDesign;

interface

uses
  System.Classes, System.SysUtils, System.Math, DesignIntf, DesignEditors,
  TreeIntf, UniDSAFlexPanel;

type
  // FlexItems is configured through the Object Inspector.  Representing it in
  // the Structure View makes it look like a visual child of the FlexPanel, so
  // use an empty transient sprig to keep that design-time tree clean.
  TUniDSAFlexItemsSprig = class(TCollectionSprig)
  public
    function Transient: Boolean; override;
    procedure FigureChildren; override;
  end;

  TUniDSAFlexPanelComponentEditor = class(TComponentEditor)
  private
    function FlexPanel: TUniDSAFlexPanel;
    procedure AddColumns(ACount: Integer);
    procedure SetPreview(AValue: TUniDSADesignPreview);
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

procedure Register;

implementation

procedure TUniDSAFlexItemsSprig.FigureChildren;
begin
  // Intentionally empty. FlexItems remains available in the Object Inspector.
end;

function TUniDSAFlexItemsSprig.Transient: Boolean;
begin
  Result := True;
end;

function TUniDSAFlexPanelComponentEditor.FlexPanel: TUniDSAFlexPanel;
begin
  Result := Component as TUniDSAFlexPanel;
end;

procedure TUniDSAFlexPanelComponentEditor.AddColumns(ACount: Integer);
var
  I, LGap, LWidth, LHeight, LSpan: Integer;
  LChild: TUniDSAFlexPanel;
begin
  if not Assigned(Designer) or (ACount < 1) then
    Exit;

  LGap := FlexPanel.Flex.EffectiveColumnGap;
  LWidth := Max(1, (FlexPanel.Width - (FlexPanel.Flex.Padding * 2) -
    (LGap * (ACount - 1))) div ACount);
  LHeight := Max(1, FlexPanel.Height - (FlexPanel.Flex.Padding * 2));
  LSpan := Max(1, FlexPanel.Flex.Columns div ACount);

  for I := 0 to ACount - 1 do
  begin
    LChild := Designer.CreateComponent(TUniDSAFlexPanel, FlexPanel,
      FlexPanel.Flex.Padding + (I * (LWidth + LGap)), FlexPanel.Flex.Padding,
      LWidth, LHeight) as TUniDSAFlexPanel;
    LChild.Responsive.XS.Span := FlexPanel.Flex.Columns;
    LChild.Responsive.SM.Span := FlexPanel.Flex.Columns;
    LChild.Responsive.MD.Span := LSpan;
    LChild.Flex.Direction := fdColumn;
    LChild.Flex.Wrap := fwNoWrap;
  end;

  Designer.Modified;
end;

procedure TUniDSAFlexPanelComponentEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: AddColumns(1);
    1: AddColumns(2);
    2: AddColumns(3);
    3: AddColumns(4);
    4: SetPreview(dpPhone);
    5: SetPreview(dpTablet);
    6: SetPreview(dpDesktop);
    7: SetPreview(dpWide);
    8: SetPreview(dpAuto);
  end;
end;

function TUniDSAFlexPanelComponentEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Adicionar FlexPanel filho';
    1: Result := 'Criar 2 colunas responsivas';
    2: Result := 'Criar 3 colunas responsivas';
    3: Result := 'Criar 4 colunas responsivas';
    4: Result := 'Preview: celular';
    5: Result := 'Preview: tablet';
    6: Result := 'Preview: desktop';
    7: Result := 'Preview: tela ampla';
    8: Result := 'Preview: autom' + #$00E1 + 'tico';
  else
    Result := '';
  end;
end;

function TUniDSAFlexPanelComponentEditor.GetVerbCount: Integer;
begin
  Result := 9;
end;

procedure TUniDSAFlexPanelComponentEditor.SetPreview(AValue: TUniDSADesignPreview);
begin
  FlexPanel.DesignPreview := AValue;
  if Assigned(Designer) then
    Designer.Modified;
end;

procedure Register;
begin
  RegisterSprigType(TUniDSAFlexChildItems, TUniDSAFlexItemsSprig);
  RegisterComponentEditor(TUniDSAFlexPanel, TUniDSAFlexPanelComponentEditor);
end;

end.
