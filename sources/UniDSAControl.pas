unit UniDSAControl;

interface

uses
  System.Classes, UniDSABaseControl;

type
  TUniDSAButton = class(TPersistent)
  private
    FParent: TUniDSABaseControl;
    FId: string;
    FVisible: Boolean;
    FCaption: string;
    FWidth: Integer;
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
    function GetCaption: string;
    procedure SetCaption(const Value: string);
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);
  public
    constructor Create(
      AParentMenu: TUniDSABaseControl;
      AId: string;
      ACaption: string;
      AVisible: Boolean;
      AWidth: Integer // -1 igual a auto
    );
    destructor Destroy; override;
    procedure Refresh;
  published
    property Visible: Boolean read GetVisible write SetVisible;
    property Caption: string read GetCaption write SetCaption;
    property Width: Integer read GetWidth write SetWidth;
    procedure SetFocus;
  end;

  TUniDSAButtonText = class(TPersistent)
  private
    FId: string;
    FCk: string;
    FVisible: Boolean;
    FCaption: string;
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
    function GetCaption: string;
    procedure SetCaption(const Value: string);
  public
    constructor Create(
      AParentMenu: TUniDSABaseControl;
      AId: string;
      ACk: string;
      ACaption: string;
      AVisible: Boolean
    );
    destructor Destroy; override;
    procedure Refresh;
  protected
    FParent: TUniDSABaseControl;
  published
    property Visible: Boolean read GetVisible write SetVisible;
    property Caption: string read GetCaption write SetCaption;
  end;

  TUniDSACheckBox = class(TUniDSAButtonText)
  private
    FChecked: Boolean;

    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
  public
    constructor Create(
      AParentMenu: TUniDSABaseControl;
      AId: string;
      ACk: string;
      ACaption: string;
      AVisible: Boolean
    );
    destructor Destroy; override;
  published
    procedure SetVarChecked(AValue: Boolean);
    property Checked: Boolean read GetChecked write SetChecked;
  end;

  TUniDSAInput = class(TPersistent)
  private
    FParent: TUniDSABaseControl;
    FId: string;
    FIdCaption: string;
    FValue: string;
    FCaption: string;
    FEnabled: Boolean;
    function GetCaption: string;
    procedure SetCaption(const Value: string);
    function GetValue: string;
    procedure SetValue(const Value: string);
    function GetEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
  public
    constructor Create(
      AParentMenu: TUniDSABaseControl;
      AId: string;
      AIdCaption: string;
      ACaption: string;
      AValue: string
    );
    destructor Destroy; override;
    procedure Refresh;
  published
    property Caption: string read GetCaption write SetCaption;
    property Value: string read GetValue write SetValue;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    procedure Clear;
    procedure SetFocus;
  end;

  TUniDSALoginImage = class(TPersistent)
  private
    FParent: TUniDSABaseControl;
    FImage: string;
    FMarginTop: Integer;
    FMarginLeft: Integer;
    FId: string;
    function GetImage: string;
    procedure SetImage(const Value: string);
    function GetMarginTop: Integer;
    procedure SetMarginTop(const Value: Integer);
    function GetMarginLeft: Integer;
    procedure SetMarginLeft(const Value: Integer);
  public
    constructor Create(
      AParentMenu: TUniDSABaseControl;
      AId: string;
      AImage: string;
      AMarginTop: Integer;
      AMarginLeft: Integer
    );
    destructor Destroy; override;
    procedure Refresh;
  published
    property Image: string read GetImage write SetImage;
    property MarginTop: Integer read GetMarginTop write SetMarginTop;
    property MarginLeft: Integer read GetMarginLeft write SetMarginLeft;
  end;

implementation

{ TUniDSAButton }

constructor TUniDSAButton.Create(
  AParentMenu: TUniDSABaseControl;
  AId: string;
  ACaption: string;
  AVisible: Boolean;
  AWidth: Integer // -1 igual a auto
);
begin
  FParent := AParentMenu;
  FId := AId;
  FVisible := AVisible;
  FWidth := AWidth;
  FCaption := ACaption;
end;

destructor TUniDSAButton.Destroy;
begin
  inherited;
end;

function TUniDSAButton.GetCaption: string;
begin
  Result := FCaption;
end;

function TUniDSAButton.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function TUniDSAButton.GetWidth: Integer;
begin
  Result := FWidth;
end;

procedure TUniDSAButton.Refresh;
begin
  Visible := Visible;
  Caption := Caption;
  Width := Width;
end;

procedure TUniDSAButton.SetCaption(const Value: string);
begin
  if Assigned(FParent) then
    FParent.JQueryText(FId, Value);

  FCaption := Value;
end;

procedure TUniDSAButton.SetFocus;
begin
  if Assigned(FParent) then
    FParent.JQueryFocus(FId);
end;

procedure TUniDSAButton.SetVisible(const Value: Boolean);
begin
  if Assigned(FParent) then begin
    if Value then
      FParent.JQueryShow(FId)
    else
      FParent.JQueryHide(FId);
  end;

  FVisible := Value;
end;

procedure TUniDSAButton.SetWidth(const Value: Integer);
begin
  if Assigned(FParent) then begin
    if Value = -1 then
      FParent.JqueryWidth(FId, 'auto')
    else
      FParent.JqueryWidth(FId, Value);
  end;

  FWidth := Value;
end;

{ TUniDSALoginButtonText }

constructor TUniDSAButtonText.Create(
  AParentMenu: TUniDSABaseControl;
  AId: string;
  ACk: string;
  ACaption: string;
  AVisible: Boolean
);
begin
  FParent := AParentMenu;
  FVisible := AVisible;
  FCaption := ACaption;
  FId := AId;
  FCk := ACk;
end;

destructor TUniDSAButtonText.Destroy;
begin
  inherited;
end;

function TUniDSAButtonText.GetCaption: string;
begin
  Result := FCaption;
end;

function TUniDSAButtonText.GetVisible: Boolean;
begin
  Result := FVisible;
end;

procedure TUniDSAButtonText.Refresh;
begin
  Visible := Visible;
  Caption := Caption;
end;

procedure TUniDSAButtonText.SetCaption(const Value: string);
begin
  if Assigned(FParent) then
    FParent.JQueryText(FId, Value);

  FCaption := Value;
end;

procedure TUniDSAButtonText.SetVisible(const Value: Boolean);
begin
  if Assigned(FParent) then begin
    if Value then begin
      FParent.JQueryShow(FId);

      if FCk <> '' then
        FParent.JQueryShow(FCk);
    end
    else begin
      FParent.JQueryHide(FId);

      if FCk <> '' then
        FParent.JQueryHide(FCk);
    end;
  end;

  FVisible := Value;
end;

{ TUniDSAInput }

procedure TUniDSAInput.Clear;
begin
  Value := '';
end;

constructor TUniDSAInput.Create(
  AParentMenu: TUniDSABaseControl;
  AId: string;
  AIdCaption: string;
  ACaption: string;
  AValue: string
);
begin
  FParent := AParentMenu;
  FId := AId;
  FIdCaption := AIdCaption;
  FCaption := ACaption;

end;

destructor TUniDSAInput.Destroy;
begin
  inherited;
end;

function TUniDSAInput.GetCaption: string;
begin
  Result := FCaption;
end;

function TUniDSAInput.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TUniDSAInput.GetValue: string;
begin
  Result := FValue;
end;

procedure TUniDSAInput.Refresh;
begin
  Caption := Caption;
  Value := Value;
end;

procedure TUniDSAInput.SetCaption(const Value: string);
begin
  if Assigned(FParent) then
    FParent.JQueryText(FIdCaption, Value);

  FCaption := Value;
end;

procedure TUniDSAInput.SetEnabled(const Value: Boolean);
begin
  if Assigned(FParent) then
    FParent.JQueryDisabled(FId, not Value);

  FEnabled := Value;
end;

procedure TUniDSAInput.SetFocus;
begin
  if Assigned(FParent) then
    FParent.JQueryFocus(FId);
end;

procedure TUniDSAInput.SetValue(const Value: string);
begin
  if Assigned(FParent) then
    FParent.JQueryVal(FId, Value);

  FValue := Value;
end;

{ TUniDSALoginImage }

constructor TUniDSALoginImage.Create(
  AParentMenu: TUniDSABaseControl;
  AId: string;
  AImage: string;
  AMarginTop: Integer;
  AMarginLeft: Integer
);
begin
  FParent := AParentMenu;
  FId := AId;
  FImage := AImage;
  FMarginTop := AMarginTop;
  FMarginLeft := AMarginLeft;
end;

destructor TUniDSALoginImage.Destroy;
begin
  inherited;
end;

function TUniDSALoginImage.GetImage: string;
begin
  Result := FImage;
end;

function TUniDSALoginImage.GetMarginLeft: Integer;
begin
  Result := FMarginLeft;
end;

function TUniDSALoginImage.GetMarginTop: Integer;
begin
  Result := FMarginTop;
end;

procedure TUniDSALoginImage.Refresh;
begin
  Image := Image;
  MarginTop := MarginTop;
  MarginLeft := MarginLeft;
end;

procedure TUniDSALoginImage.SetImage(const Value: string);
begin
  if Assigned(FParent) then
    FParent.JQuerySrc(FId, Value);

  FImage := Value;
end;

procedure TUniDSALoginImage.SetMarginLeft(const Value: Integer);
begin
  if Assigned(FParent) then
    FParent.JQueryMarginLeft(FId, Value);

  FMarginLeft:= Value;
end;

procedure TUniDSALoginImage.SetMarginTop(const Value: Integer);
begin
  if Assigned(FParent) then
    FParent.JQueryMarginTop(FId, Value);

  FMarginTop := Value;
end;


{ TUniDSACheckBox }

constructor TUniDSACheckBox.Create(AParentMenu: TUniDSABaseControl; AId, ACk, ACaption: string; AVisible: Boolean);
begin
  inherited Create(AParentMenu, AId, ACk, ACaption, AVisible);
  FChecked := False;
end;

destructor TUniDSACheckBox.Destroy;
begin
  inherited;
end;

function TUniDSACheckBox.GetChecked: Boolean;
begin
  Result := FChecked;
end;

procedure TUniDSACheckBox.SetChecked(const Value: Boolean);
begin
  if Assigned(FParent) then
    FParent.JQueryChecked(FCk, Value);

  FChecked := Value;
end;

procedure TUniDSACheckBox.SetVarChecked(AValue: Boolean);
begin
  FChecked := AValue;
end;

end.
