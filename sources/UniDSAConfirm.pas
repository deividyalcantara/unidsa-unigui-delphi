unit UniDSAConfirm;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSABase, UniDSAJQuery, UniDSAColor,
 uniGUITypes, System.TypInfo, UniDSALibrary, System.Variants, Vcl.Graphics, UniDSASource,
 UniDSABrowser;

type
  TUniDSAConfirmTypeTheme = (Bootstrap, Dark, Light, Modern, Material, Supervan);
  TUniDSAConfirmTypeConfirm = (Alert, Confirm, Dialog, Prompt);
  TUniDSAConfirmTypeBgDismiss = (Shake, Glow);
  TUniDSAConfirmTypeType = (Blue, DarkColor, Green, None, Orange, Purple, Red);
  TUniDSAConfirmPromptInput = (
    Button,
    Checkbox,
    Color,
    Date,
    DatetimeLocal,
    Email,
    &File,
    Hidden,
    Image,
    Month,
    Number,
    Password,
    Radio,
    Range,
    Reset,
    Search,
    Submit,
    Tel,
    Text,
    Time,
    Url,
    Week
  );

  TConfirmPromptOnClick = procedure(ButtonText: string; Result: string) of object;

  TUniDSAConfirmButtonItem = class(TCollectionItem)
  private
    FName: string; 
    FText: string;
    FBtnClass: string;
    FOnClick: TNotifyEvent;
    FKeys: string;  
    FIsHidden: Boolean;
    FisDisabled: Boolean;
    FAutoClose: Integer;
    FScapeKey: Boolean;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure SetName;
  published
    property Text: string read FText write FText;
    property BtnClass: string read FBtnClass write FBtnClass;
    property Keys: string read FKeys write FKeys;
    property IsHidden: Boolean read FIsHidden write FIsHidden;
    property isDisabled: Boolean read FisDisabled write FisDisabled;
    property AutoClose: Integer read FAutoClose write FAutoClose;
    property ScapeKey: Boolean read FScapeKey write FScapeKey;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TUniDSAConfirmButton = class(TOwnedCollection)
  public
    destructor Destroy; override;
  end;

  TUniDSAConfirmClose = class(TPersistent)
  private
    FCloseIcon: Boolean;
    FCloseIconClass: string; 
  public
    constructor Create;
    destructor Destroy; override;
  published
    property CloseIcon: Boolean read FCloseIcon write FCloseIcon;
    property CloseIconClass: string read FCloseIconClass write FCloseIconClass;
  end;

  TUniDSAConfirmBgDismiss = class(TPersistent)
  private
    FBackgroundDismiss: Boolean;
    FBackgroundDismissAnimation: TUniDSAConfirmTypeBgDismiss;
  public
    constructor Create;
    destructor Destroy; override; 
  published
    property BackgroundDismiss: Boolean read FBackgroundDismiss write FBackgroundDismiss;
    property BackgroundDismissAnimation: TUniDSAConfirmTypeBgDismiss read FBackgroundDismissAnimation write FBackgroundDismissAnimation;
  end;

  TUniDSAConfirmAnimation = class(TPersistent)
  private
    FAnimation: string;
    FCloseAnimation: string;
    FAnimationSpeed: Integer;
    FAnimationBounce: Integer;
    FEnabled: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property Animation: string read FAnimation write FAnimation;
    property CloseAnimation: string read FCloseAnimation write FCloseAnimation;
    property AnimationSpeed: Integer read FAnimationSpeed write FAnimationSpeed;
    property AnimationBounce: Integer read FAnimationBounce write FAnimationBounce;
  end;

  TUniDSAConfirmPrompt = class(TPersistent)
  private
    FContentCustom: string;
    FClassForm: string;
    FClassLabel: string;
    FClassInput: string;
    FPlaceHolder: string;
    FClassGroup: string;
    FInputType: TUniDSAConfirmPromptInput;
  public
    constructor Create;
    destructor Destroy; override;
    function GetInputType: string;
  published
    property ContentCustom: string read FContentCustom write FContentCustom;
    property ClassForm: string read FClassForm write FClassForm;
    property ClassGroup: string read FClassGroup write FClassGroup;
    property ClassLabel: string read FClassLabel write FClassLabel;
    property ClassInput: string read FClassInput write FClassInput;
    property PlaceHolder: string read FPlaceHolder write FPlaceHolder;
    property InputType: TUniDSAConfirmPromptInput read FInputType write FInputType;
  end;

  TUniDSAConfirm = class(TUniDSABaseComponent)
  private
    FConfirm: TJQuery;
    FDraggable: Boolean;
    FTitle: string;
    FContent: string;
    FDragWindowsBorder: Boolean;
    FDragWindowsGap: Integer;
    FContentFile: string;
    FButtons: TUniDSAConfirmButton;
    FTheme: TUniDSAConfirmTypeTheme;
    FClose: TUniDSAConfirmClose;
    FTypeConfirm: TUniDSAConfirmTypeConfirm;
    FIcon: string;
    FOnDestroy: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FOnOpen: TNotifyEvent;
    FOnOpenBefore: TNotifyEvent;
    FTypes: TUniDSAColor;
    FTypeAnimated: Boolean;
    FContainerFluid: Boolean;
    FColumnClass: string;
    FBoxWidth: string;
    FUseBootstrap: Boolean;
    FDismiss: TUniDSAConfirmBgDismiss;
    FTitleClass: string;
    FAnimateFromElement: Boolean;
    FSmoothContent: Boolean;
    FLazyOpen: Boolean;
    FBgOpacity: string;
    FAnimation: TUniDSAConfirmAnimation;
    FRTL: Boolean;
    FContainer: string;
    FWatchInterval: Integer;
    FScrollToPreviousElement: Boolean;
    FScrollToPreviousElementAnimate: Boolean;
    FOffsetTop: Integer;
    FOffsetBottom: Integer;
    FType: TUniDSAConfirmTypeType;
    FPromptCustom: TUniDSAConfirmPrompt;
    FOnButtonClick: TConfirmPromptOnClick;
    FResponse: string;
    FonContentReady: TNotifyEvent;
    FOnAction: TNotifyEvent;
    FEscapeKey: Boolean;
  protected
    procedure AJAXEvent(var EventName: string; var Params: TUniStrings); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Show;
    procedure Alert;
    procedure Dialog;
    procedure Prompt;
    procedure Confirm;
    procedure Prepare;
  published
    property Title: string read FTitle write FTitle;
    property TitleClass: string read FTitleClass write FTitleClass;
    property Content: string read FContent write FContent;
    property Draggable: Boolean read FDraggable write FDraggable;
    property DrawWindowsBorder: Boolean read FDragWindowsBorder write FDragWindowsBorder;
    property DrawWindowsGap: Integer read FDragWindowsGap write FDragWindowsGap;
    property ContentFile: string read FContentFile write FContentFile;
    property Buttons: TUniDSAConfirmButton read FButtons write FButtons;
    property Theme: TUniDSAConfirmTypeTheme read FTheme write FTheme;
    property Icon: string read FIcon write FIcon;
    property Types: TUniDSAColor read FTypes write FTypes;
    property TypeAnimated: Boolean read FTypeAnimated write FTypeAnimated;
    property ContainerFluid: Boolean read FContainerFluid write FContainerFluid;
    property ColumnClass: string read FColumnClass write FColumnClass;
    property BoxWidth: string read FBoxWidth write FBoxWidth;
    property UseBootstrap: Boolean read FUseBootstrap write FUseBootstrap;
    property Dismiss: TUniDSAConfirmBgDismiss read FDismiss write FDismiss;
    property AnimateFromElement: Boolean read FAnimateFromElement write FAnimateFromElement;
    property SmoothContent: Boolean read FSmoothContent write FSmoothContent;
    property LazyOpen: Boolean read FLazyOpen write FLazyOpen;
    property BgOpacity: string read FBgOpacity write FBgOpacity;
    property Animation: TUniDSAConfirmAnimation read FAnimation write FAnimation;
    property RTL: Boolean read FRTL write FRTL;
    property Container: string read FContainer write FContainer;
    property WatchInterval: Integer read FWatchInterval write FWatchInterval;
    property ScrollToPreviousElement: Boolean read FScrollToPreviousElement write FScrollToPreviousElement;
    property ScrollToPreviousElementAnimate: Boolean read FScrollToPreviousElementAnimate write FScrollToPreviousElementAnimate;
    property OffsetTop: Integer read FOffsetTop write FOffsetTop;
    property OffsetBottom: Integer read FOffsetBottom write FOffsetBottom;
    property PromptCustom: TUniDSAConfirmPrompt read FPromptCustom write FPromptCustom;
    property Response: string read FResponse write FResponse;
    property EscapeKey: Boolean read FEscapeKey write FEscapeKey;
    property ConfirmProperty: TJQuery read FConfirm write FConfirm;

    property Close: TUniDSAConfirmClose read FClose write FClose;
    property TypeConfirm: TUniDSAConfirmTypeConfirm read FTypeConfirm write FTypeConfirm;
    property &Type: TUniDSAConfirmTypeType read FType write FType;

    property onContentReady: TNotifyEvent read FonContentReady write FonContentReady;
    property OnOpenBefore: TNotifyEvent read FOnOpenBefore write FOnOpenBefore;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnAction: TNotifyEvent read FOnAction write FOnAction;
    property OnButtonClick: TConfirmPromptOnClick read FOnButtonClick write FOnButtonClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAConfirm]);
end;

{ TUniDSAConfirm }

procedure TUniDSAConfirm.AJAXEvent(var EventName: string; var Params: TUniStrings);
var
  button_item: TUniDSAConfirmButtonItem;

  function SearchButton(ButtonName: string): TUniDSAConfirmButtonItem;
  var
    k: Integer;
  begin
    Result := nil;

    for k := 0 to FButtons.Count - 1 do begin
      if TUniDSAConfirmButtonItem(FButtons.Items[k]).FName <> ButtonName then
        Continue;

      Result := TUniDSAConfirmButtonItem(FButtons.Items[k]);
      Break;
    end;
  end;
begin
  inherited;
  FResponse := Params.Values['Response'];

  if EventName = 'UniDSAToastButtons' then begin
    button_item := SearchButton(Params.Values['ButtonName']);

    if Assigned(FOnButtonClick) then
      FOnButtonClick(button_item.FText, response);

    if Assigned(button_item.OnClick) then
      button_item.OnClick(Self);
  end
  else if EventName = 'UniDSAToastOnContentReady' then begin
    if Assigned(FOnContentReady) then
      FOnContentReady(Self);
  end
  else if EventName = 'UniDSAToastOnOpenBefore' then begin
    if Assigned(FOnOpenBefore) then
      FOnOpenBefore(Self);
  end
  else if EventName = 'UniDSAToastOnOpen' then begin
    if Assigned(FOnOpen) then
      FOnOpen(Self);
  end
  else if EventName = 'UniDSAToastOnClose' then begin
    if Assigned(FOnClose) then
      FOnClose(Self);
  end
  else if EventName = 'UniDSAToastOnDestroy' then begin
    if Assigned(FOnDestroy) then
      FOnDestroy(Self);
  end
  else if EventName = 'UniDSAToastOnAction' then begin
    if Assigned(FOnAction) then
      FOnAction(Self);
  end
end;

procedure TUniDSAConfirm.Alert;
begin
  FTypeConfirm := TUniDSAConfirmTypeConfirm.Alert;
  Prepare;
  FConfirm.FunctionName('alert');
  FConfirm.Execute;
end;

procedure TUniDSAConfirm.Clear;
begin
  FTitle := '';
  FTitleClass := '';

  FTypes.Enabled := True;
  FTypes.Color := clBlue;

  FTypeAnimated := False;
  FType := TUniDSAConfirmTypeType.Blue;
  FDraggable := True;
  FDragWindowsGap := 15;
  FDragWindowsBorder := True;
  FAnimateFromElement := True;
  FSmoothContent := True;
  FContent := '';

  FButtons.Clear;

  FIcon := '';
  FLazyOpen := False;
  FBgOpacity := '1';
  FTheme := TUniDSAConfirmTypeTheme.Light;

  FAnimation.FEnabled := True;
  FAnimation.FAnimation := 'scale';
  FAnimation.FCloseAnimation := 'scale';
  FAnimation.FAnimationSpeed := 400;
  FAnimation.FAnimationBounce := 1;
  
  FRTL := false;
  FContainer := 'body';
  FContainerFluid := False;

  EscapeKey := False;
  
  FDismiss.FBackgroundDismiss := False;
  FDismiss.FBackgroundDismissAnimation := TUniDSAConfirmTypeBgDismiss.Shake;
  
  FClose.FCloseIcon := False;
  FClose.FCloseIconClass := '';
  
  FWatchInterval := 100;
  FColumnClass := 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1';
  FBoxWidth := '35%';
  ScrollToPreviousElement := True;
  ScrollToPreviousElementAnimate := True;
  UseBootstrap := False;
  OffsetTop := 40;
  OffsetBottom := 40;
end;

procedure TUniDSAConfirm.Confirm;
begin
  Show;
end;

constructor TUniDSAConfirm.Create(AOwner: TComponent);
begin
  inherited;
  FClose := TUniDSAConfirmClose.Create;
  FTypes := TUniDSAColor.Create;
  FPromptCustom := TUniDSAConfirmPrompt.Create;
  FButtons := TUniDSAConfirmButton.Create(Self, TUniDSAConfirmButtonItem);
  FConfirm := TJQuery.Create('confirm');
  FDismiss := TUniDSAConfirmBgDismiss.Create;
  FAnimation := TUniDSAConfirmAnimation.Create;

  Clear;
end;

destructor TUniDSAConfirm.Destroy;
begin
  inherited;
  FreeAndNil(FClose);
  FreeAndNil(FTypes);
  FreeAndNil(FDismiss);
  FreeAndNil(FPromptCustom);
  FreeAndNil(FButtons);
  FreeAndNil(FAnimation);
  FreeAndNil(FConfirm);
end;

procedure TUniDSAConfirm.Dialog;
begin
  FTypeConfirm := TUniDSAConfirmTypeConfirm.Dialog;
  Prepare;
  FConfirm.FunctionName('dialog');
  FConfirm.Execute;
end;

procedure TUniDSAConfirm.Prepare;
var
  auto_close: string;
  escape_key: string;

  function PrepareButtons: string;
  var
    i: Integer;
  begin
    Result := Result + ' { ';

    for i := 0 to FButtons.Count - 1 do begin
      if i <> 0 then
        Result := Result + ', ';

      Result := Result +
           TUniDSAConfirmButtonItem(FButtons.Items[i]).FName + ': { ' +
           '  text: "' + TUniDSAConfirmButtonItem(FButtons.Items[i]).Text + '" ' +
           ', btnClass: "' + TUniDSAConfirmButtonItem(FButtons.Items[i]).BtnClass + '" ' +
           IIfStr(
             TUniDSAConfirmButtonItem(FButtons.Items[i]).Keys <> '',
             ', keys: ' +
             IIfStr(Copy(TUniDSAConfirmButtonItem(FButtons.Items[i]).Keys, 1, 1) = '[', '', '[') + ' ' +
             TUniDSAConfirmButtonItem(FButtons.Items[i]).Keys + ' ' +
             IIfStr(Copy(TUniDSAConfirmButtonItem(FButtons.Items[i]).Keys, 1, 1) = '[', '', ']') + ' ',
             ' '
           ) +
           ', isHidden: ' + IIfStr(TUniDSAConfirmButtonItem(FButtons.Items[i]).IsHidden, 'true', 'false') + ' ' +
           ', IsDisabled: ' + IIfStr(TUniDSAConfirmButtonItem(FButtons.Items[i]).IsDisabled, 'true', 'false') + ' ' +
           ', action: function() { ' +
           ' var name = this.$content.find(".name").val(); ' +
           ' ajaxRequest(' +  IIfStr(Self.JSName = '', 'body', Self.JSName) + ', "UniDSAToastButtons", ' +
             '["ButtonName=" + "' + TUniDSAConfirmButtonItem(FButtons.Items[i]).FName + '", "Response=" + name]); ' +
           '} ' +
        '}'
    end;

    Result := Result + '} ';
  end;

  function ButtonAutoClose: string;
  var
    k: Integer;
  begin
    Result := '';

    for k := 0 to FButtons.Count - 1 do begin
      with TUniDSAConfirmButtonItem(FButtons.Items[k]) do begin
        if AutoClose <> 0 then begin
          Result := FName + '|' + IntToStr(AutoClose);
          Break;
        end;
      end;
    end;
  end;

  function GetEscapeKey: string;
  var
    k: Integer;
  begin
    Result := '';

    for k := 0 to FButtons.Count - 1 do begin
      with TUniDSAConfirmButtonItem(FButtons.Items[k]) do begin
        if ScapeKey = True then begin
          Result := FName;
          Break;
        end;
      end;
    end;
  end;
begin
  with FConfirm do begin
    Clear;

    auto_close := ButtonAutoClose;
    escape_key := GetEscapeKey;

    Add('title', FTitle, FTitle <> '');
    Add('titleClass', FTitleClass, FTitleClass <> '');

    Add(
      'type',
       IIfStr(
         FType = TUniDSAConfirmTypeType.DarkColor, 'dark',
         AnsiLowerCase(GetEnumName(TypeInfo(TUniDSAConfirmTypeType), Integer(FType)))
       ),
       FType <> TUniDSAConfirmTypeType.None
    );

    Add('typeAnimated', FTypeAnimated, not FTypeAnimated);
    Add('draggable', FDraggable, not FDraggable);
    Add('dragWindowGap', FDragWindowsGap, FDragWindowsGap <> 15);
    Add('dragWindowBorder', FDragWindowsBorder, not FDragWindowsBorder);
    Add('animateFromElement', FAnimateFromElement, not FAnimateFromElement);
    Add('smoothContent', FSmoothContent, not FSmoothContent);
    
    if FTypeConfirm = TUniDSAConfirmTypeConfirm.Prompt then begin
      Add(
        'content',
        IIfStr(
          FPromptCustom.FContentCustom = '',
          '<form action="" class="' + FPromptCustom.FClassForm + '">' +
          '  <div class="' + FPromptCustom.FClassGroup +'">' +
          '    <label class="' + FPromptCustom.FClassLabel + '" >' + FContent + '</label>' +
          '    <input type="' + FPromptCustom.GetInputType + '" placeholder="' + FPromptCustom.FPlaceHolder + '" class="' + FPromptCustom.FClassInput + '" required />' +
          '  </div>' +
          '</form>',
          FPromptCustom.FContentCustom
        ),
        True,
        True,
        False
      );
    end
    else begin
      Add('content', 'url:' + FContentFile, FContentFile <> '');
      Add('content', FContent, FContent <> '');
    end;

    Add('autoClose', auto_close, auto_close <> '');
    Add('escapeKey', escape_key, escape_key <> '');
    Add('escapeKey', FEscapeKey, (escape_key = '') and (EscapeKey));
    Add('icon', FIcon, FIcon <> '');
    Add('lazyOpen', FLazyOpen, FLazyOpen);
    Add('bgOpacity', BgOpacity, BgOpacity <> '1', False);
    Add('theme', AnsiLowerCase(GetEnumName(TypeInfo(TUniDSAConfirmTypeTheme), Integer(FTheme))));
    Add('buttons', PrepareButtons, FButtons.Count - 1 > -1, False);
    Add('animation', FAnimation.Animation, FAnimation.Enabled);
    Add('closeAnimation', FAnimation.CloseAnimation, FAnimation.Enabled);
    Add('animationSpeed', FAnimation.AnimationSpeed, FAnimation.Enabled);
    Add('animationBounce', FAnimation.AnimationBounce, FAnimation.Enabled);  
    Add('rtl', FRTL, FRTL);
    Add('container', FContainer, FContainer <> 'body');
    Add('containerFluid', containerFluid, FContainerFluid); 
    Add('backgroundDismiss', FDismiss.BackgroundDismiss, FDismiss.BackgroundDismiss);
    Add('backgroundDismissAnimation', AnsiLowerCase(GetEnumName(TypeInfo(TUniDSAConfirmTypeBgDismiss), Integer(FDismiss.BackgroundDismissAnimation))), FDismiss.BackgroundDismiss);
    Add('closeIcon', FClose.CloseIcon, FClose.CloseIcon);  
    Add('closeIconClass', FClose.CloseIconClass, FClose.CloseIconClass <> '');  
    Add('watchInterval', FWatchInterval, FWatchInterval <> 100);
    Add('columnClass', FColumnClass, FColumnClass <> 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1'); 
    Add('boxWidth', FBoxWidth, FBoxWidth <> '35%');
    Add('scrollToPreviousElement', FScrollToPreviousElement, not FScrollToPreviousElement);
    Add('scrollToPreviousElementAnimate', FScrollToPreviousElementAnimate, not FScrollToPreviousElementAnimate);
    Add('useBootstrap', FUseBootstrap, not FUseBootstrap);
    Add('offsetTop', FOffsetTop, FOffsetTop <> 40);    
    Add('offsetBottom', FOffsetBottom, FOffsetBottom <> 40);
    Add(
      'onContentReady',
      AjaxRequest('UniDSAConfirmOnContentReady'),
      Assigned(FOnContentReady),
      False
    );
    Add(
      'onOpenBefore',
      AjaxRequest('UniDSAConfirmOnOpenBefore'),
      Assigned(FOnOpenBefore),
      False
    );
    Add(
      'onOpen',
      AjaxRequest('UniDSAConfirmOnOpen'),
      Assigned(FOnOpen),
      False
    );
    Add(
      'onClose',
      AjaxRequest('UniDSAConfirmOnClose'),
      Assigned(FOnClose),
      False
    );
    Add(
      'onDestroy',
      AjaxRequest('UniDSAConfirmOnDestroy'),
      Assigned(FOnDestroy),
      False
    );
    Add(
      'onAction',
      AjaxRequest('UniDSAConfirmOnAction'),
      Assigned(FOnAction),
      False
    );
  end;
end;

procedure TUniDSAConfirm.Prompt;
begin
  FTypeConfirm := TUniDSAConfirmTypeConfirm.Prompt;
  Prepare;
  FConfirm.FunctionName('confirm');
  FConfirm.Execute;
end;

procedure TUniDSAConfirm.Show;
begin
  FTypeConfirm := TUniDSAConfirmTypeConfirm.Confirm;
  Prepare;
  FConfirm.FunctionName('confirm');
  FConfirm.Execute;
end;

{ TUniDSAConfirmButtonItem }

constructor TUniDSAConfirmButtonItem.Create(Collection: TCollection);
begin
  inherited;
  FText := '';
  FBtnClass := '';
  FKeys := '';  
  FIsHidden := False;
  FisDisabled := False;
  FAutoClose := 0;
  FScapeKey := False;
  SetName;
end;

destructor TUniDSAConfirmButtonItem.Destroy;
begin
  inherited;
end;

procedure TUniDSAConfirmButtonItem.SetName;
var
  name_invalid: Boolean;
  generated_name: string;
    
  function ExistingButton(name: string): Boolean;
  var
    i: Integer;

  begin
    Result := False;
    
    for i := 0 to Collection.Count - 1 do begin
      if TUniDSAConfirmButtonItem(Collection.Items[i]).FName = name then begin
        Result := True;
        Break;
      end;       
    end;
  end;
begin
  name_invalid := True;
  repeat
    generated_name := SortName;
  until name_invalid;

  FName := generated_name;  
end;

{ TUniDSAConfirmAnimation }

constructor TUniDSAConfirmAnimation.Create;
begin
  FEnabled := True;
  FAnimation := 'scale';
  FCloseAnimation := 'scale';
  FAnimationSpeed := 400;
  FAnimationBounce := 1;
end;

destructor TUniDSAConfirmAnimation.Destroy;
begin
  inherited;
end;

{ TUniDSAConfirmBgDismiss }

constructor TUniDSAConfirmBgDismiss.Create;
begin
  FBackgroundDismiss := False;
  FBackgroundDismissAnimation := TUniDSAConfirmTypeBgDismiss.Shake;
end;

destructor TUniDSAConfirmBgDismiss.Destroy;
begin
  inherited;
end;

{ TUniDSAConfirmClose }

constructor TUniDSAConfirmClose.Create;
begin
  FCloseIcon := False;
  FCloseIconClass := '';
end;

destructor TUniDSAConfirmClose.Destroy;
begin
  inherited;
end;

{ TUniDSAConfirmPrompt }

constructor TUniDSAConfirmPrompt.Create;
begin
  FContentCustom := '';
  FClassForm := 'formName';
  FClassGroup := 'form-group';
  FClassLabel := '';
  FClassInput := 'name form-control';
  FPlaceHolder := 'Digite...';
  FInputType := TUniDSAConfirmPromptInput.Text;
end;

destructor TUniDSAConfirmPrompt.Destroy;
begin

  inherited;
end;

function TUniDSAConfirmPrompt.GetInputType: string;
begin
  if FInputType = TUniDSAConfirmPromptInput.File then
    Result := 'file'
  else if FInputType = TUniDSAConfirmPromptInput.DatetimeLocal then
    Result := 'datetime-local'
  else
    Result := AnsiLowerCase(GetEnumName(TypeInfo(TUniDSAConfirmPromptInput), Integer(FInputType)));
end;

{ TUniDSAConfirmButton }

destructor TUniDSAConfirmButton.Destroy;
begin
  inherited;
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.Confirm);
  
end.
