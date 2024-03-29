unit UniDSABaseControl;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSAExecuteFunction, UniDSALibrary, uniGUITypes;

type
  TUniDSABaseControl = class(TUniControl)
  private
    FAbout: string;
    FVersion: string;
    FFontAwesome: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IIfVar(ACondicao: Boolean; AVerdadeiro: Variant; AFalso: Variant): Variant;
    procedure JS(AScript: string);

    procedure JQueryShow(AId: string);
    procedure JQueryHide(AId: string);
    procedure JQueryText(AId: string; AText: string);
    procedure JQueryVal(AId: string; AText: string);
    procedure JqueryWidth(AId: string; AWidth: Integer; ATipo: string = ''); overload;
    procedure JqueryWidth(AId: string; AWidth: string); overload;
    procedure JQueryMarginLeft(AId: string; AMargin: Integer; ATipo: string = '');
    procedure JQueryMarginRigth(AId: string; AMargin: Integer; ATipo: string = '');
    procedure JQueryMarginTop(AId: string; AMargin: Integer; ATipo: string = '');
    procedure JQueryMarginBottom(AId: string; AMargin: Integer; ATipo: string = '');
    procedure JQueryDisplayNone(AId: string);
    procedure JQueryDisplayFlex(AId: string);
    procedure JQueryAttr(AId: string; AValue: string; AAttribute: string);
    procedure JQuerySrc(AId: string; AUrl: string);
    procedure JQueryChecked(AId: string; AValue: Boolean);
    procedure JQueryFocus(AId: string);
    procedure JQueryDisabled(AId: string; AValue: Boolean);
  published
    property About: string read FAbout;
    property Version: string read FVersion;
    property FontAwesome: string read FFontAwesome;
  protected
    procedure InternalSetCaption(const Value: string); override;
    procedure ConfigJSClasses(ALoading: Boolean); override;
  end;

implementation

{ TUniDSABaseControl }

procedure TUniDSABaseControl.ConfigJSClasses(ALoading: Boolean);
begin
  inherited;
  JSObjects.DefaultJSClassName:='Ext.form.Label';
end;

constructor TUniDSABaseControl.Create(AOwner: TComponent);
begin
  inherited;
  FAbout := 'https://github.com/deividyalcantara?tab=repositories';
  FVersion := '1.1.0';
  FFontAwesome := '5.14.0';
end;

destructor TUniDSABaseControl.Destroy;
begin
  inherited;
end;

function TUniDSABaseControl.IIfVar(ACondicao: Boolean; AVerdadeiro, AFalso: Variant): Variant;
begin
  if ACondicao then
    Result := AVerdadeiro
  else
    Result := AFalso;
end;

procedure TUniDSABaseControl.JS(AScript: string);
begin
  if WebMode then
    JSCode(AScript);
end;

procedure TUniDSABaseControl.InternalSetCaption(const Value: string);
begin
  inherited;
  if not IsDesigning then begin
    InternalSetText(Value);

    if not IsLoading then
      JSProperty('html', [Caption, False], 'setText');
  end;
end;

procedure TUniDSABaseControl.JQueryAttr(AId, AValue: string; AAttribute: string);
begin
  JSCode('$("' + AId + '").attr("' + AAttribute + '", "' + AValue + '");');
end;

procedure TUniDSABaseControl.JQueryChecked(AId: string; AValue: Boolean);
begin
  if AValue then
    JSCode('$("' + AId + '").prop("checked", true);')
  else
    JSCode('$("' + AId + '").prop("checked", false);');
end;

procedure TUniDSABaseControl.JQueryDisabled(AId: string; AValue: Boolean);
begin
  if AValue then
    JSCode('$("' + AId + '").prop("disabled", true);')
  else
    JSCode('$("' + AId + '").prop("disabled", false);');
end;

procedure TUniDSABaseControl.JQueryDisplayFlex(AId: string);
begin
  JSCode('$("' + AId + '").css("display", "flex");');
end;

procedure TUniDSABaseControl.JQueryDisplayNone(AId: string);
begin
  JSCode('$("' + AId + '").css("display", "none");');
end;

procedure TUniDSABaseControl.JQueryFocus(AId: string);
begin
  JSCode('$("' + AId + '").focus();')
end;

procedure TUniDSABaseControl.JQueryHide(AId: string);
begin
  JSCode('$("' + AId + '").hide();')
end;

procedure TUniDSABaseControl.JQueryMarginBottom(AId: string; AMargin: Integer; ATipo: string = '');
begin
  JSCode('$("' + AId + '").css("margin-bottom", "' + IntToStr(AMargin) + '' + IIfStr(ATipo <> '', ATipo, 'px') + '");');
end;

procedure TUniDSABaseControl.JQueryMarginLeft(AId: string; AMargin: Integer; ATipo: string = '');
begin
  JSCode('$("' + AId + '").css("margin-left", "' + IntToStr(AMargin) + '' + IIfStr(ATipo <> '', ATipo, 'px') + '");');
end;

procedure TUniDSABaseControl.JQueryMarginRigth(AId: string; AMargin: Integer; ATipo: string = '');
begin
  JSCode('$("' + AId + '").css("margin-right", "' + IntToStr(AMargin) + '' + IIfStr(ATipo <> '', ATipo, 'px') + '");');
end;

procedure TUniDSABaseControl.JQueryMarginTop(AId: string; AMargin: Integer; ATipo: string = '');
begin
  JSCode('$("' + AId + '").css("margin-top", "' + IntToStr(AMargin) + '' + IIfStr(ATipo <> '', ATipo, 'px') + '");');
end;

procedure TUniDSABaseControl.JQueryShow(AId: string);
begin
  JSCode('$("' + AId + '").show();');
end;

procedure TUniDSABaseControl.JQuerySrc(AId, AUrl: string);
begin
  JQueryAttr(AId, AUrl, 'src');
end;

procedure TUniDSABaseControl.JQueryText(AId: string; AText: string);
begin
  JSCode('$("' + AId + '").text("' + AText + '");');
end;

procedure TUniDSABaseControl.JQueryVal(AId, AText: string);
begin
  JSCode('$("' + AId + '").val("' + AText + '");');
end;

procedure TUniDSABaseControl.JqueryWidth(AId, AWidth: string);
begin
  JSCode('$("' + AId + '").css("width", "' + AWidth + '");');
end;

procedure TUniDSABaseControl.JqueryWidth(AId: string; AWidth: Integer; ATipo: string = '');
begin
  JSCode('$("' + AId + '").css("width", "' + IntToStr(AWidth) + '' + IIfStr(ATipo <> '', ATipo, 'px') + '");');
end;

end.
