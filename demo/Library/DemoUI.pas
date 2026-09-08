unit DemoUI;

interface

uses
  System.Classes, System.SysUtils, System.TypInfo, Vcl.Controls, Vcl.Graphics, Vcl.StdCtrls,
  uniGUIClasses, uniGUIFrame, uniLabel, uniEdit, uniComboBox, uniSpinEdit,
  uniButton, uniCheckBox, uniPageControl, uniMemo, UniDSAFlexPanel;

function DemoPanel(AOwner: TComponent; AParent: TWinControl;
  const AClassName: string; AColumn: Boolean = True): TUniDSAFlexPanel;
function DemoText(AOwner: TComponent; AParent: TWinControl;
  const ACaption, AClassName: string): TUniLabel;
procedure DemoClass(AControl: TUniControl; const AClassName: string);
procedure DemoPrepare(AParent: TWinControl);
procedure DemoProperties(AOwner: TComponent; AParent: TWinControl;
  ATarget: TObject; const ATitle: string; const AProperties: array of string);

implementation

uses
  uniGUITypes, System.NetEncoding;

type
  TUniControlAccess = class(TUniControl);

  TDemoPropertyBinding = class(TComponent)
  private
    FTarget: TObject;
    FProperty: PPropInfo;
    FEditor: TUniControl;
    FStatus: TUniLabel;
    FIsColor: Boolean;
    FPath: string;
    procedure ApplyClick(Sender: TObject);
  public
    procedure Build(AParent: TWinControl; ATarget: TObject;
      const APath: string);
  end;

procedure DemoClass(AControl: TUniControl; const AClassName: string);
begin
  TUniControlAccess(AControl).JSInterface.JSConfig('cls', [AClassName]);
end;

function DemoPanel(AOwner: TComponent; AParent: TWinControl;
  const AClassName: string; AColumn: Boolean): TUniDSAFlexPanel;
begin
  Result := TUniDSAFlexPanel.Create(AOwner);
  Result.Parent := AParent;
  Result.Flex.AutoHeight := True;
  Result.Flex.Gap := 12;
  Result.Flex.AlignContent := faStart;
  Result.FlexItem.Shrink := 0;
  Result.Responsive.XS.Span := 0;
  if AColumn then begin
    Result.Flex.Direction := fdColumn;
    Result.Flex.Wrap := fwNoWrap;
  end;
  DemoClass(Result, AClassName);
end;

function DemoText(AOwner: TComponent; AParent: TWinControl;
  const ACaption, AClassName: string): TUniLabel;
begin
  Result := TUniLabel.Create(AOwner);
  Result.Parent := AParent;
  Result.Caption := ACaption;
  Result.AutoSize := False;
  Result.Height := 24;
  Result.ParentFont := False;
  Result.Font.Name := 'Segoe UI';
  Result.Font.Size := 10;
  DemoClass(Result, AClassName);
end;

procedure DemoPrepare(AParent: TWinControl);
var
  I: Integer;
  LControl: TControl;
  LPanel: TUniDSAFlexPanel;
  LItem: TUniDSAFlexChildItem;
  LContainer: TUniContainer;
begin
  if AParent is TUniFrame then
    LContainer := TUniFrame(AParent).FormRegion
  else if AParent is TUniContainer then
    LContainer := TUniContainer(AParent)
  else Exit;
  for I := 0 to LContainer.ControlCount - 1 do begin
    LControl := LContainer.Controls[I];
    if LControl is TUniTabSheet then begin
      TUniTabSheet(LControl).ParentAlignmentControl := False;
      TUniTabSheet(LControl).AlignmentControl := uniAlignmentClient;
      TUniTabSheet(LControl).Layout := 'fit';
    end;
    if LControl is TUniDSAFlexPanel then begin
      LPanel := TUniDSAFlexPanel(LControl);
      case LPanel.Tag of
        100: DemoClass(LPanel, 'demo-card');
        101, 102, 110: begin
          if (LPanel.ControlCount = 1) and (LPanel.Controls[0] is TUniButton) then
            DemoClass(LPanel, 'demo-layout demo-action-field')
          else
            DemoClass(LPanel, 'demo-layout');
        end;
        120: DemoClass(LPanel, 'demo-page');
      end;
    end;
    if LControl is TUniLabel then begin
      TUniLabel(LControl).AutoSize := False;
      if TUniLabel(LControl).Font.Height >= 25 then
        DemoClass(TUniLabel(LControl), 'demo-title')
      else if LControl.Tag = 100 then
        DemoClass(TUniLabel(LControl), 'demo-section-title')
      else
        DemoClass(TUniLabel(LControl), 'demo-label');
    end;
    if LControl is TUniButton then begin
      LControl.Height := 42;
      if (LControl.Name = 'btnMostrar') or (LControl.Name = 'btnSalvarCadastro') or
         (LControl.Name = 'btnPesquisar') or (LControl.Name = 'btnLer') then
        DemoClass(TUniButton(LControl), 'demo-button')
      else
        DemoClass(TUniButton(LControl), 'demo-button demo-secondary');
    end
    else if (LControl is TUniCustomEdit) or (LControl is TUniComboBox) or
            (LControl is TUniSpinEdit) then begin
      LControl.Height := 42;
      DemoClass(TUniControl(LControl), 'demo-input');
    end;
    if LControl is TUniMemo then
      DemoClass(TUniControl(LControl), 'demo-input demo-memo');
    if (AParent is TUniDSAFlexPanel) and (LControl is TUniControl) then begin
      LControl.AlignWithMargins := False;
      LControl.Align := alNone;
      LPanel := TUniDSAFlexPanel(AParent);
      if (LPanel.Tag >= 100) or (LPanel.Flex.Direction = fdColumn) then begin
        LItem := LPanel.FlexItems.FindByControl(LControl);
        if not Assigned(LItem) then begin
          LItem := LPanel.FlexItems.Add;
          LItem.Control := TUniControl(LControl);
        end;
        if LItem.Grow = 0 then LItem.Shrink := 0;
        if (LPanel.Flex.Direction = fdRow) and not (LControl is TUniLabel) then begin
          LItem.Responsive.XS.Span := 12;
          LItem.Responsive.SM.Span := 6;
          LItem.Responsive.MD.Span := 4;
          if (LControl is TUniDSAFlexPanel) and
             (TUniDSAFlexPanel(LControl).ControlCount = 1) and
             (TUniDSAFlexPanel(LControl).Controls[0] is TUniLabel) then begin
            LItem.Responsive.SM.Span := 12;
            LItem.Responsive.MD.Span := 12;
          end;
        end
        else if LPanel.Flex.Direction = fdRow then
          LItem.Responsive.XS.Span := 12;
      end;
    end;
    if LControl is TWinControl then DemoPrepare(TWinControl(LControl));
  end;
end;

procedure TDemoPropertyBinding.Build(AParent: TWinControl; ATarget: TObject;
  const APath: string);
var
  LParts: TArray<string>;
  LPart: string;
  I: Integer;
  LField: TUniDSAFlexPanel;
  LCombo: TUniComboBox;
  LEdit: TUniEdit;
  LButton: TUniButton;
  LData: PTypeData;
begin
  FPath := APath;
  FTarget := ATarget;
  LParts := APath.Split(['.']);
  for I := 0 to High(LParts) - 1 do begin
    FProperty := GetPropInfo(FTarget, LParts[I]);
    if not Assigned(FProperty) then Exit;
    FTarget := GetObjectProp(FTarget, FProperty);
    if not Assigned(FTarget) then Exit;
  end;
  LPart := LParts[High(LParts)];
  FProperty := GetPropInfo(FTarget, LPart);
  if not Assigned(FProperty) or not Assigned(FProperty.SetProc) then Exit;
  LField := DemoPanel(Owner, AParent, 'demo-field');
  LField.Responsive.XS.Span := 12;
  LField.Responsive.SM.Span := 6;
  LField.Responsive.MD.Span := 4;
  DemoText(Owner, LField, APath, 'demo-label');
  FIsColor := SameText(string(FProperty.PropType^.Name), 'TColor');
  if FProperty.PropType^.Kind = tkEnumeration then begin
    LCombo := TUniComboBox.Create(Owner);
    LCombo.Parent := LField;
    LCombo.Style := csDropDownList;
    LData := GetTypeData(FProperty.PropType^);
    for I := LData.MinValue to LData.MaxValue do
      LCombo.Items.Add(GetEnumName(FProperty.PropType^, I));
    LCombo.ItemIndex := GetOrdProp(FTarget, FProperty) - LData.MinValue;
    FEditor := LCombo;
  end
  else begin
    LEdit := TUniEdit.Create(Owner);
    LEdit.Parent := LField;
    if FIsColor then
      LEdit.Text := ColorToString(TColor(GetOrdProp(FTarget, FProperty)))
    else
      LEdit.Text := GetPropValue(FTarget, LPart, True);
    FEditor := LEdit;
  end;
  FEditor.Height := 42;
  DemoClass(FEditor, 'demo-input');
  if FIsColor then
    DemoText(Owner, LField, 'Ex.: clWhite ou $00BBGGRR', 'demo-muted');
  LButton := TUniButton.Create(Owner);
  LButton.Parent := LField;
  LButton.Caption := 'Aplicar';
  LButton.Height := 38;
  LButton.OnClick := ApplyClick;
  DemoClass(LButton, 'demo-button demo-secondary');
  FStatus := DemoText(Owner, LField, '', 'demo-status');
  FStatus.Visible := False;
end;

procedure TDemoPropertyBinding.ApplyClick(Sender: TObject);
var
  LValue: string;
  LNumber: Integer;
  LColor: TColor;
begin
  if FEditor is TUniComboBox then
    LValue := TUniComboBox(FEditor).Text
  else
    LValue := TUniEdit(FEditor).Text;
  try
    if FIsColor then begin
      LColor := StringToColor(LValue);
      SetOrdProp(FTarget, FProperty, LColor);
    end
    else if FProperty.PropType^.Kind = tkInteger then begin
      if not TryStrToInt(LValue, LNumber) or (LNumber < -1) or (LNumber > 60000) then
        raise EConvertError.Create('Informe um inteiro entre -1 e 60000.');
      if (FPath = 'FPS') and ((LNumber < 1) or (LNumber > 30)) then
        raise EConvertError.Create('FPS deve estar entre 1 e 30.');
      if (FPath = 'QrBox') and ((LNumber < 80) or (LNumber > 220)) then
        raise EConvertError.Create('QrBox deve estar entre 80 e 220.');
      SetOrdProp(FTarget, FProperty, LNumber);
    end
    else
      SetPropValue(FTarget, string(FProperty.Name), LValue);
    if FIsColor then
      LValue := ColorToString(TColor(GetOrdProp(FTarget, FProperty)))
    else
      LValue := GetPropValue(FTarget, string(FProperty.Name), True);
    FStatus.Caption := TNetEncoding.HTML.Encode('Aplicado: ' + LValue);
  except
    on E: Exception do
      FStatus.Caption := TNetEncoding.HTML.Encode('Valor não aplicado. ' + E.Message);
  end;
  FStatus.Visible := True;
end;

procedure DemoProperties(AOwner: TComponent; AParent: TWinControl;
  ATarget: TObject; const ATitle: string; const AProperties: array of string);
var
  LCard, LFields: TUniDSAFlexPanel;
  LPath: string;
  LBinding: TDemoPropertyBinding;
begin
  LCard := DemoPanel(AOwner, AParent, 'demo-card');
  LCard.Flex.Padding := 20;
  DemoText(AOwner, LCard, ATitle, 'demo-section-title');
  DemoText(AOwner, LCard,
    'Altere o valor e use Aplicar para testar o componente.', 'demo-muted');
  LFields := DemoPanel(AOwner, LCard, 'demo-layout', False);
  for LPath in AProperties do begin
    LBinding := TDemoPropertyBinding.Create(AOwner);
    LBinding.Build(LFields, ATarget, LPath);
  end;
end;

initialization
  UniAddCSSLibrary('/files/demo/demo.css?v=8', True, [upoFolderUni, upoPlatformDesktop]);
  UniAddJSLibrary('/files/demo/demo.js?v=8', True, [upoFolderUni, upoPlatformDesktop]);

end.
