unit UniDSAMenuLateral;

interface

uses
 System.SysUtils, System.Classes, uniGUIClasses, UniDSABaseControl, UniDSAJQuery, uniGUITypes,
 System.TypInfo, UniDSALibrary, System.Variants, Vcl.Graphics, UniDSASource, UniDSABrowser, Vcl.Controls, 
 System.Types;

type
  TUniDSAMenuLateral = class;
  TUniDSAMenuLateralMenuItem = class;

  TUniDSAMenuLateralSender = reference to procedure(Sender: TObject);
  TMenuLateralOnSearchEnter = procedure(Text: string) of object;

  TMenuLateralMenuState = (mlmMinimize, mlmMaximize);
  TUniDSAMenuLateralTypeTheme = (mltThemeLeft, mltThemeRight);
  TUniDSAMenuLateralStyleTheme = (
    mltClaro,
    mltEscuro,
    mltUniClassic,
    mltUniGray,
    mltUniCrisp,
    mltUniNeptune,
    mltUniTriton,
    mltUniAria,
    mltUniGraphite,
    mltUniMaterial,
    mltUniAqua,
    mltUniCarbon,
    mltUniClassic2,
    mltUniEmerald,
    mltUniFlatBlack,
    mltUniKde,
    mltUniMac,
    mltUniSencha,
    mltNatureSerenity,
    mltMidnightGalaxy,
    mltGoldenElegance,
    mltVibratCitrus,
    mltPinterestInspired,
    mltWhatsAppInspired,
    mltLinkedInInspired,
    mltSnapchatInspired,
    mltFacebookInspired,
    mltCoastalBlues,
    mltSereneSky,
    mltPink,
    mltAzureDream,
    mltSoothingSky,
    mltSapphireMajesty,
    mltTwitterInspired,
    mltTwitterDarkMode,
    mltCherryBlossom,
    mltRubyRadiance,
    mltCrimsonGold,
    mltPastelParadise,
    mltBlue,
    mltOceanBreeze,
    mltOrange,
    mltGray,
    mltCitrusPunch,
    mltDesertDream,
    mltVintageRose,
    mltMidnightForest,
    mltTropicalParadise,
    mltSenchaFresh,
    mltElectricVibes,
    mltAeroGlass,
    mltModernMetro,
    mltFluentDesign,
    mltClassicBliss,
    mltLinuxMint,
    mltSunsetWarmth,
    mltLilacGlow,
    mltMysticMoonlight,
    mltFreshBreeze,
    mltVibrantViolet,
    mltCandyCrush,
    mltMintyFresh,
    mltChocoDelight,
    mltPastelPalette,
    mltFloralElegance,
    mltRoyalRegency,
    mltAutumnLeaves,
    mltAzureHorizon,
    mltGoldenHarvest,
    mltFrostyMorning,
    mltPumpkinSpice,
    mltMoonlitMeadow,
    mltIcyElegance,
    mltHarvestHues,
    mltRoyalVelvet,
    mltSummerSolstice,
    mltAutumnColors,
    mltWinterWonderland,
    mltNeonNightlife,
    mltPastelDreams,
    mltSeasideCottage,
    mltMountainMajesty,
    mltRainyDay
  );

  TUniDSAMenuLateralLogo = class(TPersistent)
  private
    FParentMenu: TUniDSAMenuLateral;
    FUrlImage: string;
    FCompanyName: string;
    FVisible: Boolean;
    procedure SetUrlImage(const Value: string);
    procedure SetCompanyName(const Value: string);
    procedure SetVisible(const Value: Boolean);
  public
    constructor Create(AParentMenu: TUniDSAMenuLateral);
    destructor Destroy; override;
  published
    property UrlImage: string read FUrlImage write SetUrlImage;
    property CompanyName: string read FCompanyName write SetCompanyName;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TUniDSAMenuLateralSearch = class(TPersistent)
  private
    FParentMenu: TUniDSAMenuLateral;
    FIcon: string;
    FTextPrompt: string;
    FAutoComplete: Boolean;
    FVisible: Boolean;
    FSearchText: string;
    procedure SetTextPrompt(const Value: string);
    procedure SetIcon(const Value: string);
    procedure SetAutoComplete(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    property SearchText: string read FSearchText write FSearchText;
  public
    constructor Create(AParentMenu: TUniDSAMenuLateral);
    destructor Destroy; override;
  published
    procedure SetFocus;
    function Text: string;
    property Icon: string read FIcon write SetIcon;
    property TextPrompt: string read FTextPrompt write SetTextPrompt;
    property AutoComplete: Boolean read FAutoComplete write SetAutoComplete;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TUniDSAMenuLateralTheme = class(TPersistent)
  private
    FParentMenu: TUniDSAMenuLateral;
    FTitleLeft: string;
    FTitleRight: string;
    FVisible: Boolean;
    FStyleLeft: TUniDSAMenuLateralStyleTheme;
    FStyleRight: TUniDSAMenuLateralStyleTheme;

    function GetTitleLeft: string;
    procedure SetTitleLeft(const Value: string);
    function GetTitleRight: string;
    procedure SetTitleRight(const Value: string);
    procedure SetVisible(const Value: Boolean);
    procedure SetStyleLeft(const Value: TUniDSAMenuLateralStyleTheme);
    procedure SetStyleRight(const Value: TUniDSAMenuLateralStyleTheme);
  public
    constructor Create(AParentMenu: TUniDSAMenuLateral);
    destructor Destroy; override;
  published
    property StyleLeft: TUniDSAMenuLateralStyleTheme read FStyleLeft write SetStyleLeft;
    property StyleRight: TUniDSAMenuLateralStyleTheme read FStyleRight write SetStyleRight;
    property TitleLeft: string read GetTitleLeft write SetTitleLeft;
    property TitleRight: string read GetTitleRight write SetTitleRight;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TUniDSAMenuLateralMenuStyle = class(TPersistent)
  private
    FParentMenu: TUniDSAMenuLateral;
    FPaddingTop: Integer;
    FPaddingLeft: Integer;
    FPaddingRight: Integer;
    FPaddingBottom: Integer;
    FBorderRadiusTopLeft: Integer;
    FBorderRadiusTopRight: Integer;
    FBorderRadiusBottomLeft: Integer;
    FBorderRadiusBottomRight: Integer;
    FBorderTop: Integer;
    FBorderLeft: Integer;
    FBorderRight: Integer;
    FBorderBottom: Integer;
    procedure SetPaddingTop(const Value: Integer);
    procedure SetPaddingLeft(const Value: Integer);
    procedure SetPaddingRight(const Value: Integer);
    procedure SetPaddingBottom(const Value: Integer);
    procedure SetBorderRadiusTopLeft(const Value: Integer);
    procedure SetBorderRadiusTopRight(const Value: Integer);
    procedure SetBorderRadiusBottomLeft(const Value: Integer);
    procedure SetBorderRadiusBottomRight(const Value: Integer);
    procedure SetBorderTop(const Value: Integer);
    procedure SetBorderLeft(const Value: Integer);
    procedure SetBorderRight(const Value: Integer);
    procedure SetBorderBottom(const Value: Integer);
  public
    constructor Create(AParentMenu: TUniDSAMenuLateral);
    destructor Destroy; override;
  published
    property PaddingTop: Integer read FPaddingTop write SetPaddingTop;
    property PaddingLeft: Integer read FPaddingLeft write SetPaddingLeft;
    property PaddingRight: Integer read FPaddingRight write SetPaddingRight;
    property PaddingBottom: Integer read FPaddingBottom write SetPaddingBottom;
    property BorderTop: Integer read FBorderTop write SetBorderTop;
    property BorderLeft: Integer read FBorderLeft write SetBorderLeft;
    property BorderRight: Integer read FBorderRight write SetBorderRight;
    property BorderBottom: Integer read FBorderBottom write SetBorderBottom;
    property BorderRadiusTopLeft: Integer read FBorderRadiusTopLeft write SetBorderRadiusTopLeft;
    property BorderRadiusTopRight: Integer read FBorderRadiusTopRight write SetBorderRadiusTopRight;
    property BorderRadiusBottomLeft: Integer read FBorderRadiusBottomLeft write SetBorderRadiusBottomLeft;
    property BorderRadiusBottomRight: Integer read FBorderRadiusBottomRight write SetBorderRadiusBottomRight;
  end;

  TUniDSAMenuLateralProfile = class(TPersistent)
  private
    FParentMenu: TUniDSAMenuLateral;
    FName: string;
    FEmail: string;
    FImageURL: string;
    FVisible: Boolean;

    function GetName: string;
    procedure SetName(const Value: string);
    function GetEmail: string;
    procedure SetEmail(const Value: string);
    function GetImageURL: string;
    procedure SetImageURL(const Value: string);
    procedure SetVisible(const Value: Boolean);
  public
    constructor Create(AParentMenu: TUniDSAMenuLateral);
    destructor Destroy; override;
  published
    property Name: string read GetName write SetName;
    property Email: string read GetEmail write SetEmail;
    property ImageURL: string read GetImageURL write SetImageURL;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TUniDSAMenuLateralMenuItem = class(TCollectionItem)
  private
    FName: string;
    FNotificationCount: Integer;
    FIcon: string;
    FCaption: string;
    FVisible: Boolean;
    FEnabled: Boolean;
    FSeparator: Boolean;
    FHidden: Boolean;
    FHint: string;
    FOnClick: TNotifyEvent;
    FOnClickNotification: TNotifyEvent;
    FOnClickRef: TUniDSAMenuLateralSender;
    FOnClickNotificationRef: TUniDSAMenuLateralSender;
    function GetIcon: string;
    procedure SetIcon(const Value: string);
    function GetCaption: string;
    procedure SetCaption(const Value: string);
    function GetNotificationCount: Integer;
    procedure SetNotificationCount(const Value: Integer);
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
    function GetEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
    function GetSeparator: Boolean;
    procedure SetSeparator(const Value: Boolean);
    function GetHint: string;
    procedure SetHint(const Value: string);
    function GetHidden: Boolean;
    procedure SetHidden(const Value: Boolean);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure SetName;
    property OnClickRef: TUniDSAMenuLateralSender read FOnClickRef write FOnClickRef;
    property OnClickNotificationRef: TUniDSAMenuLateralSender read FOnClickNotificationRef write FOnClickNotificationRef;
  published
    procedure IncNotification;
    procedure DecNotification;
    procedure ClearNotification;
    property Icon: string read GetIcon write SetIcon;
    property Caption: string read GetCaption write SetCaption;
    property NotificationCount: Integer read GetNotificationCount write SetNotificationCount;
    property Visible: Boolean read GetVisible write SetVisible;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Hidden: Boolean read GetHidden write SetHidden;
    property Separator: Boolean read GetSeparator write SetSeparator;
    property Hint: string read GetHint write SetHint;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnClickNotification: TNotifyEvent read FOnClickNotification write FOnClickNotification;
  end;

  TUniDSAMenuLateralMenu = class(TOwnedCollection)
  private
    FIMenuParent: TUniDSAMenuLateral;
    procedure SetIMenuParent(const Value: TUniDSAMenuLateral);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass); overload;
    destructor Destroy; override;
  published
    function IndexOf(ACaptionItem: string): TUniDSAMenuLateralMenuItem;
    function AddItem: TUniDSAMenuLateralMenuItem;
    property IMenuParent: TUniDSAMenuLateral read FIMenuParent write SetIMenuParent;
  end;

  TUniDSAMenuLateral = class(TUniDSABaseControl)
  private
    FMenuLateral: TJQuery;
    FLogo: TUniDSAMenuLateralLogo;
    FSearch: TUniDSAMenuLateralSearch;
    FTheme: TUniDSAMenuLateralTheme;
    FMenu: TUniDSAMenuLateralMenu;
    FMenuState: TMenuLateralMenuState;
    FStyle: TUniDSAMenuLateralMenuStyle;
    FProfile: TUniDSAMenuLateralProfile;
    FOnClickLogo: TNotifyEvent;
    FOnClickMenu: TNotifyEvent;
    FOnClickNotificationMenu: TNotifyEvent;
    FOnAfterSelectTheme: TNotifyEvent;
    FOnClickProfile: TNotifyEvent;
    FOnClickLogoff: TNotifyEvent;
    FOnSearchEnter: TMenuLateralOnSearchEnter;
    FSelectedDiretionTheme: TUniDSAMenuLateralTypeTheme;
    FOnClickIconSearch: TNotifyEvent;
    FSelectedTheme: TUniDSAMenuLateralStyleTheme;
    FSelectedMenu: TUniDSAMenuLateralMenuItem;
    FAjaxSecurity: Boolean;
    procedure PrepareHtml;
    procedure PrepareJS;
    procedure NovoCaption(const Value: string);
    procedure SetSearch(const Value: TUniDSAMenuLateralSearch);
    procedure SetMenu(const Value: TUniDSAMenuLateralMenu);
    function GetMenuState: TMenuLateralMenuState;
    procedure SetMenuState(const Value: TMenuLateralMenuState);
    procedure SetSelectedDiretionTheme(const Value: TUniDSAMenuLateralTypeTheme);
  protected
    procedure JSEventHandler(AEventName: string; AParams: TUniStrings); override;
    procedure ConfigJSClasses(ALoading: Boolean); override;
    procedure InternalSetCaption(const Value: string); override;
    procedure LoadCompleted; override;
    procedure WebCreate; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    procedure MinimizeMaximize;
    procedure HideMenu;
    procedure ShowMenu;
    procedure SetTheme(ATheme: TUniDSAMenuLateralStyleTheme);
    property Height;
    property Width;
    property Visible;
    property Logo: TUniDSAMenuLateralLogo read FLogo write FLogo;
    property Search: TUniDSAMenuLateralSearch read FSearch write SetSearch;
    property Theme: TUniDSAMenuLateralTheme read FTheme write FTheme;
    property Profile: TUniDSAMenuLateralProfile read FProfile write FProfile;
    property Menu: TUniDSAMenuLateralMenu read FMenu write SetMenu;
    property MenuState: TMenuLateralMenuState read GetMenuState write SetMenuState;
    property Style: TUniDSAMenuLateralMenuStyle read FStyle write FStyle;
    property SelectedDiretionTheme: TUniDSAMenuLateralTypeTheme read FSelectedDiretionTheme write SetSelectedDiretionTheme;
    property SelectedTheme: TUniDSAMenuLateralStyleTheme read FSelectedTheme write FSelectedTheme;
    property SelectedMenu: TUniDSAMenuLateralMenuItem read FSelectedMenu write FSelectedMenu;
    property OnClickLogo: TNotifyEvent read FOnClickLogo write FOnClickLogo;
    property OnClickMenu: TNotifyEvent read FOnClickMenu write FOnClickMenu;
    property OnClickNotificationMenu: TNotifyEvent read FOnClickNotificationMenu write FOnClickNotificationMenu;
    property OnAfterSelectTheme: TNotifyEvent read FOnAfterSelectTheme write FOnAfterSelectTheme;
    property OnClickProfile: TNotifyEvent read FOnClickProfile write FOnClickProfile;
    property OnClickLogoff: TNotifyEvent read FOnClickLogoff write FOnClickLogoff;
    property OnSearchEnter: TMenuLateralOnSearchEnter read FOnSearchEnter write FOnSearchEnter;
    property OnClickIconSearch: TNotifyEvent read FOnClickIconSearch write FOnClickIconSearch;
    property AjaxSecurity: Boolean read FAjaxSecurity write FAjaxSecurity;
  end;

function GetMenuLateralStyleTheme(ATheme: TUniDSAMenuLateralStyleTheme): string;

procedure Register;

implementation

{ TUniDSAMenuLateral }

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAMenuLateral]);
end;

procedure TUniDSAMenuLateral.JSEventHandler(AEventName: string; AParams: TUniStrings);
var
  LMenu: TUniDSAMenuLateralMenuItem;
  LMenuIndex: Integer;
  LMenuCaption: string;

  procedure SearchMenu(LName: string);
  var
    I: Integer;
  begin
    LMenu := nil;
    LMenuIndex := -1;
    LMenuCaption := '';

    for I := 0 to Menu.Count - 1 do begin
      if AParams.Values['menu'] <> TUniDSAMenuLateralMenuItem(Menu.Items[I]).FName then
        Continue;

      LMenuIndex := I;
      LMenuCaption := TUniDSAMenuLateralMenuItem(Menu.Items[I]).Caption;
      LMenu := TUniDSAMenuLateralMenuItem(Menu.Items[I]);
      Break;
    end;
  end;
begin
  inherited;
  if AEventName = 'UniDSAMenuLateralOnClickLogo' then begin
    if Assigned(FOnClickLogo) then
      FOnClickLogo(Self);
  end
  else if AEventName = 'UniDSAMenuLateralOnClickMenu' then begin
    SearchMenu(AParams.Values['menu']);

    if LMenu = nil then
      Exit;

    if
      (AjaxSecurity) and
      (
        (LMenu.Visible = False) or
        (LMenu.Hidden = True) or
        (LMenu.Enabled = False)
      )
    then
      Exit;

    SelectedMenu := LMenu;

    if Assigned(FOnClickMenu) then
      FOnClickMenu(LMenu);

    if Assigned(LMenu.OnClick) then
      LMenu.OnClick(LMenu);

    if Assigned(LMenu.OnClickRef) then
      LMenu.OnClickRef(LMenu);
  end
  else if AEventName = 'UniDSAMenuLateralOnClickNotificationMenu' then begin
    SearchMenu(AParams.Values['menu']);

    if LMenu = nil then
      Exit;

    if
      (AjaxSecurity) and
      (
        (LMenu.Visible = False) or
        (LMenu.Hidden = True) or
        (LMenu.Enabled = False)
      )
    then
      Exit;

    if Assigned(OnClickNotificationMenu) then
      OnClickNotificationMenu(LMenu);

    if Assigned(LMenu.OnClickNotification) then
      LMenu.OnClickNotification(LMenu);

    if Assigned(LMenu.OnClickNotificationRef) then
      LMenu.OnClickNotificationRef(LMenu);
  end
  else if AEventName = 'UniDSAMenuLateralOnAfterSelectTheme' then begin
    if Assigned(FOnAfterSelectTheme) then
      FOnAfterSelectTheme(Self);
  end
  else if AEventName = 'UniDSAMenuLateralOnClickProfile' then begin
    if Assigned(FOnClickProfile) then
      FOnClickProfile(Self);
  end
  else if AEventName = 'UniDSAMenuLateralOnClickLogoff' then begin
    if Assigned(FOnClickLogoff) then
      FOnClickLogoff(Self);
  end
  else if AEventName = 'UniDSAMenuLateralOnSearchEnter' then begin
    if Assigned(FOnSearchEnter) then
      FOnSearchEnter(AParams.Values['texto']);
  end
  else if AEventName = 'UniDSAMenuLateralOnClickIconSearch' then begin
    if Assigned(FOnClickIconSearch) then
      FOnClickIconSearch(Self);
  end;

  if AEventName = 'UniDSAMenuLateralGetSearchValue' then
    Self.Search.SearchText := AParams.Values['texto'];
end;

procedure TUniDSAMenuLateral.LoadCompleted;
begin
  inherited;
  PrepareHTML;
  PrepareJS;
end;

procedure TUniDSAMenuLateral.MinimizeMaximize;
begin
  MenuState := IIf(MenuState = mlmMaximize, mlmMinimize, mlmMaximize);
end;

procedure TUniDSAMenuLateral.NovoCaption(const Value: string);
begin
  JSProperty('html', [Caption, False], 'setText');
end;

procedure TUniDSAMenuLateral.ConfigJSClasses(ALoading: Boolean);
begin
  inherited;
  JSObjects.DefaultJSClassName:='Ext.form.Label';
end;

constructor TUniDSAMenuLateral.Create(AOwner: TComponent);
begin
  inherited;
  Self.Height := 100;
  Self.Width := 300;
  SetAlign(alLeft);
  AjaxSecurity := True;

  FMenuLateral := TJQuery.Create('qrCodeReader');

  Logo := TUniDSAMenuLateralLogo.Create(Self);
  Search := TUniDSAMenuLateralSearch.Create(Self);
  Theme := TUniDSAMenuLateralTheme.Create(Self);
  Profile := TUniDSAMenuLateralProfile.Create(Self);
  FMenu := TUniDSAMenuLateralMenu.Create(Self, TUniDSAMenuLateralMenuItem);
  FMenu.FIMenuParent := Self;
  MenuState := mlmMaximize;
  Style := TUniDSAMenuLateralMenuStyle.Create(Self);

  Visible := True;
end;

destructor TUniDSAMenuLateral.Destroy;
begin
  Menu.Clear;
  inherited;
  FreeAndNil(Logo);
  FreeAndNil(Search);
  FreeAndNil(Theme);
  FreeAndNil(Profile);
  FreeAndNil(Style);
  FreeAndNil(Menu);
  FreeAndNil(FMenuLateral);
end;

function TUniDSAMenuLateral.GetMenuState: TMenuLateralMenuState;
begin
  Result := FMenuState;
end;

procedure TUniDSAMenuLateral.HideMenu;
begin
  Visible := False;
end;

procedure TUniDSAMenuLateral.InternalSetCaption(const Value: string);
begin
  inherited;
  if not IsDesigning then
  begin
    InternalSetText(Value);

    if not IsLoading then
      NovoCaption(Value);
  end;
end;

procedure TUniDSAMenuLateral.PrepareHtml;
var
  LHTML: TStringBuilder;
  I: Integer;

  LMenuName: string;
  LMenuHint: string;
  LMenuIcon: string;
  LMenuCaption: string;
  LMenuNotification: string;
  LMenuIndex: string;
begin
  if WebMode then begin
    LHTML := TStringBuilder.Create;

    try
      with LHTML do begin

        Append('<!DOCTYPE html>');
        Append('<html lang="en">');
        Append('<head>');
        Append('  <meta charset="UTF-8">');
        Append('  <meta name="viewport" content="width=device-width, initial-scale=1.0">');
        Append('  <style></style>');
        Append('  <title>UniDSA - Menu Lateral</title>');
        Append('</head>');

        Append('<body>');
        Append('  <div class="uni-ml">');

        // Bloco logo
        Append('    <div class="uni-ml-logo" onclick="UniDSAMenuLateralOnClickLogo(' + JSName + ')">');
        Append('      <img id="uni-ml-logo-imagem-empresa" src="' + Logo.UrlImage + '" alt="' + Logo.CompanyName + '">');
        Append('      <span id="uni-ml-logo-nome-empresa">' + Logo.CompanyName + '</span>');
        Append('    </div>');

        // Bloco pesquisa
        Append('    <div class="uni-ml-pesquisa">');
        Append('      <div class="uni-ml-item-icone">');
        Append('        <i id="uni-ml-item-search-icon" class="' + Search.Icon + '" onclick="UniDSAMenuLateralOnClickIconSearch(' + JSName + ')"></i> ');
        Append('      </div>');
        Append('      <input type="search" id="uni-ml-pesquisar" autocomplete="' + IIfStr(Search.AutoComplete, 'on', 'off') + '" placeholder="' + Search.TextPrompt + '" onkeydown="UniDSAMenuLateralOnKeyDownSearch(' + JSName + ', event)" >');
        Append('    </div>  ');

        // Bloco menu e grupo
        Append('    <div class="uni-ml-scroll-menu">');

        if Menu.Count > 0 then begin
          Append('      <span class="uni-ml-titulo-menu">Menu</span>');
          Append('      <ul class="uni-ml-menu-lista">');

          for I := 0 to Menu.Count - 1 do begin
            LMenuName := TUniDSAMenuLateralMenuItem(Menu.Items[I]).FName;
            LMenuHint := TUniDSAMenuLateralMenuItem(Menu.Items[I]).Hint;
            LMenuIcon := TUniDSAMenuLateralMenuItem(Menu.Items[I]).Icon;
            LMenuCaption := TUniDSAMenuLateralMenuItem(Menu.Items[I]).Caption;
            LMenuNotification := IntToStr(TUniDSAMenuLateralMenuItem(Menu.Items[I]).NotificationCount);
            LMenuIndex := IntToStr(TUniDSAMenuLateralMenuItem(Menu.Items[I]).Index);

            if not TUniDSAMenuLateralMenuItem(Menu.Items[I]).Separator then begin
              Append(
                '<li id="uni-ml-item-menu-' + LMenuName + '" onclick="UniDSAMenuLateralOnClickMenu(' + JSName + ', ''' + LMenuName + ''')" style="order: ' + LMenuIndex + ';"> ' +
                '  <a id="uni-ml-item-menu-link" title="' + LMenuHint + '"> ' +
                '    <div class="uni-ml-item-icone"> ' +
                '      <i id="uni-ml-item-icon-' + LMenuName + '" class="' + LMenuIcon + '"></i> ' +
                '    </div> ' +
                '    <span id="uni-ml-item-texto-' + LMenuName + '">' + LMenuCaption + '</span> ' +
                '    <div class="uni-ml-item-menu-notif" id="uni-ml-item-menu-notif-' + LMenuName + '" onclick="UniDSAMenuLateralOnClickNotificationMenu(' + JSName + ', ''' + LMenuName + ''', event)">' + LMenuNotification + '</div> ' +
                '  </a> ' +
                '</li> '
              );
            end
            else
              Append('<div id="uni-ml-item-menu-' + LMenuName + '" class="uni-ml-item-menu-divisor" style="order: ' + LMenuIndex + ';"></div>');
          end;

          Append('      </ul>');
        end;

        Append('    </div>');

        // Bloco tema
        Append('    <div class="uni-ml-config-usuario">');
        Append('      <div class="uni-ml-config-usuario-tema">');
        Append('        <div class="uni-ml-config-usuario-tema-1" option="T1" onClick="UniDSAMenuLateralOnAfterSelectTheme(' + JSName + ', event)">');
        Append('          <i class="far fa-sun"></i>');
        Append('          <span id="uni-ml-tema-esquerda">' + Theme.TitleLeft + '</span>');
        Append('        </div>');
        Append('        <div class="uni-ml-config-usuario-tema-2" option="T2" onClick="UniDSAMenuLateralOnAfterSelectTheme(' + JSName + ', event)">');
        Append('          <i class="far fa-moon"></i>');
        Append('          <span id="uni-ml-tema-direita">' + Theme.TitleRight + '</span>');
        Append('        </div>');
        Append('      </div>');

        // Bloco perfil
        Append('      <div class="uni-ml-perfil">');
        Append('        <img id="uni-ml-perfil-imagem" src="' + Profile.ImageURL  + '" onClick="UniDSAMenuLateralOnClickProfile(' + JSName + ')"/>');
        Append('        <div class="uni-ml-perfil-desc" onClick="UniDSAMenuLateralOnClickProfile(' + JSName + ')">');
        Append('          <span id="uni-ml-perfil-nome">' + Profile.Name  + '</span>');
        Append('          <span id="uni-ml-perfil-email">' + Profile.Email  + '</span>');
        Append('        </div>');
        Append('        <i class="fas fa-sign-out-alt" onClick="UniDSAMenuLateralOnClickLogoff(' + JSName + ')"></i>');
        Append('      </div>');
        Append('    </div> ');
        Append('  </div>');
        Append('</body>');

        Append('</html>');

        Caption := LHTML.ToString;
      end;
    finally
      FreeAndNil(LHTML);
    end;
  end;
end;

procedure TUniDSAMenuLateral.PrepareJS;
var
  I: Integer;
begin
  for I := 0 to Menu.Count - 1 do begin
    TUniDSAMenuLateralMenuItem(Menu.Items[I]).NotificationCount := TUniDSAMenuLateralMenuItem(Menu.Items[I]).NotificationCount;
    TUniDSAMenuLateralMenuItem(Menu.Items[I]).Enabled := TUniDSAMenuLateralMenuItem(Menu.Items[I]).Enabled;
    TUniDSAMenuLateralMenuItem(Menu.Items[I]).Hidden := TUniDSAMenuLateralMenuItem(Menu.Items[I]).Hidden;
    TUniDSAMenuLateralMenuItem(Menu.Items[I]).Visible := TUniDSAMenuLateralMenuItem(Menu.Items[I]).Visible;
  end;

  MenuState := MenuState;

  Logo.Visible := Logo.Visible;

  Search.Visible := Search.Visible;

  Theme.Visible := Theme.Visible;
  Theme.StyleLeft := Theme.StyleLeft;
  Theme.StyleRight := Theme.StyleRight;

  Profile.Visible := Profile.Visible; 

  Style.PaddingTop := Style.PaddingTop;
  Style.PaddingLeft := Style.PaddingLeft;
  Style.PaddingRight := Style.PaddingRight;
  Style.PaddingBottom := Style.PaddingBottom;
  
  Style.BorderRadiusTopLeft := Style.BorderRadiusTopLeft;
  Style.BorderRadiusTopRight := Style.BorderRadiusTopRight;
  Style.BorderRadiusBottomLeft := Style.BorderRadiusBottomLeft;
  Style.BorderRadiusBottomRight := Style.BorderRadiusBottomRight;
  
  Style.BorderTop := Style.BorderTop;
  Style.BorderLeft := Style.BorderLeft;
  Style.BorderRight := Style.BorderRight;
  Style.BorderBottom := Style.BorderBottom;

  SelectedDiretionTheme := SelectedDiretionTheme;
end;

procedure TUniDSAMenuLateral.SetMenu(const Value: TUniDSAMenuLateralMenu);
begin
  FMenu := Value;
end;

procedure TUniDSAMenuLateral.SetMenuState(const Value: TMenuLateralMenuState);
begin
  if Value = mlmMaximize then begin
    JS('MenuLateralMaximizado();');
    Width := 300;
  end
  else begin
    Width := 80;
    JS('MenuLateralMinimizado();');
  end;

  FMenuState := Value;
end;

procedure TUniDSAMenuLateral.SetSearch(const Value: TUniDSAMenuLateralSearch);
begin
  FSearch := Value;
end;

procedure TUniDSAMenuLateral.SetSelectedDiretionTheme(const Value: TUniDSAMenuLateralTypeTheme);
begin
  if Value = TUniDSAMenuLateralTypeTheme.mltThemeLeft then
    JS('Tema1();')
  else
    JS('Tema2();');

  FSelectedDiretionTheme := Value;
end;

procedure TUniDSAMenuLateral.SetTheme(ATheme: TUniDSAMenuLateralStyleTheme);
begin
  JS('DefinirCorTema(' + GetMenuLateralStyleTheme(ATheme) + ');');

  SelectedTheme := ATheme;
end;

procedure TUniDSAMenuLateral.ShowMenu;
begin
  Visible := True;
end;

procedure TUniDSAMenuLateral.WebCreate;
begin
  inherited;
  JSCls := 'x-uni-dsa-menu-lateral';
end;

{ TUniDSAMenuLateralSearch }

constructor TUniDSAMenuLateralSearch.Create(AParentMenu: TUniDSAMenuLateral);
begin
  FParentMenu := AParentMenu;
  Icon := 'fas fa-search';
  TextPrompt := 'Pesquisa...';
  AutoComplete := True;
  Visible := True;
end;

destructor TUniDSAMenuLateralSearch.Destroy;
begin
  inherited;
end;

procedure TUniDSAMenuLateralSearch.SetAutoComplete(const Value: Boolean);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$("#uni-ml-pesquisar").attr("autocomplete","' + IIfStr(Value, 'on', 'off') + '");');

  FAutoComplete := Value;
end;

procedure TUniDSAMenuLateralSearch.SetFocus;
begin
  FParentMenu.JS('$("#uni-ml-pesquisar").focus();');
end;

procedure TUniDSAMenuLateralSearch.SetIcon(const Value: string);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$("#uni-ml-item-search-icon").removeClass().addClass("' + RemoverTagFontAwesome(Value) + '");');

  FIcon := RemoverTagFontAwesome(Value);
end;

procedure TUniDSAMenuLateralSearch.SetTextPrompt(const Value: string);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$("#uni-ml-pesquisar").attr("placeholder","' + Value + '");');

  FTextPrompt := Value;
end;

procedure TUniDSAMenuLateralSearch.SetVisible(const Value: Boolean);
begin
  if Assigned(FParentMenu) then begin
    if Value then
      FParentMenu.JS('$(".uni-ml-pesquisa").show();')
    else
      FParentMenu.JS('$(".uni-ml-pesquisa").hide();');
  end;

  FVisible := Value;
end;


function TUniDSAMenuLateralSearch.Text: string;
begin
  Result := FSearchText;
end;

{ TUniDSAMenuLateralLogo }

constructor TUniDSAMenuLateralLogo.Create(AParentMenu: TUniDSAMenuLateral);
begin
  FParentMenu := AParentMenu;
  UrlImage := 'https://i.ibb.co/yhLx7mc/Logo.jpg';
  CompanyName := 'UniDSA - UniGUI';
  Visible := True;
end;

destructor TUniDSAMenuLateralLogo.Destroy;
begin
  inherited;
end;

procedure TUniDSAMenuLateralLogo.SetCompanyName(const Value: string);
begin
  if Assigned(FParentMenu) then begin
    FParentMenu.JS('$("#uni-ml-logo-nome-empresa").text("' + Value + '");');
  end;

  FCompanyName := Value;
end;

procedure TUniDSAMenuLateralLogo.SetUrlImage(const Value: string);
begin
  if Assigned(FParentMenu) then begin
    FParentMenu.JS('$("#uni-ml-logo-imagem-empresa").attr("src","' + Value + '");');
  end;

  FUrlImage := Value;
end;

procedure TUniDSAMenuLateralLogo.SetVisible(const Value: Boolean);
begin
  if Assigned(FParentMenu) then begin
    if Value then
      FParentMenu.JS('$(".uni-ml-logo").show();')
    else
      FParentMenu.JS('$(".uni-ml-logo").hide();');
  end;

  FVisible := Value;
end;

{ TUniDSAMenuLateralTheme }

constructor TUniDSAMenuLateralTheme.Create(AParentMenu: TUniDSAMenuLateral);
begin
  FParentMenu := AParentMenu;
  TitleLeft := 'Claro';
  TitleRight := 'Escuro';
  Visible := True;
  StyleLeft := TUniDSAMenuLateralStyleTheme.mltClaro;
  StyleRight := TUniDSAMenuLateralStyleTheme.mltEscuro;
end;

destructor TUniDSAMenuLateralTheme.Destroy;
begin
  inherited;
end;

function TUniDSAMenuLateralTheme.GetTitleLeft: string;
begin
  Result := FTitleLeft;
end;

function TUniDSAMenuLateralTheme.GetTitleRight: string;
begin
  Result := FTitleRight;
end;

procedure TUniDSAMenuLateralTheme.SetStyleLeft(const Value: TUniDSAMenuLateralStyleTheme);
begin
  if Assigned(FParentMenu) then begin
    FParentMenu.JS('ConfigurarCorTema("T1",' + GetMenuLateralStyleTheme(Value) + ');');
    FParentMenu.SelectedTheme := Value;
  end;

  FStyleLeft := Value;
end;

procedure TUniDSAMenuLateralTheme.SetStyleRight(const Value: TUniDSAMenuLateralStyleTheme);
begin
  if Assigned(FParentMenu) then begin
    FParentMenu.JS('ConfigurarCorTema("T2",' + GetMenuLateralStyleTheme(Value) + ');');
    FParentMenu.SelectedTheme := Value;
  end;

  FStyleRight := Value;
end;

procedure TUniDSAMenuLateralTheme.SetTitleLeft(const Value: string);
begin
  if Assigned(FParentMenu) then begin
    with FParentMenu do begin
      JS('$("#uni-ml-tema-esquerda").text("' + Value + '");');
    end;
  end;

  FTitleLeft := Value;
end;

procedure TUniDSAMenuLateralTheme.SetTitleRight(const Value: string);
begin
  if Assigned(FParentMenu) then begin
    with FParentMenu do begin
      JS('$("#uni-ml-tema-direita").text("' + Value + '");');
    end;
  end;

  FTitleRight := Value;
end;

procedure TUniDSAMenuLateralTheme.SetVisible(const Value: Boolean);
begin
  if Assigned(FParentMenu) then begin
    if Value then
      FParentMenu.JS('$(".uni-ml-config-usuario-tema").show();')
    else
      FParentMenu.JS('$(".uni-ml-config-usuario-tema").hide();');
  end;

  FVisible := Value;
end;

{ TUniDSAMenuLateralProfile }

constructor TUniDSAMenuLateralProfile.Create(AParentMenu: TUniDSAMenuLateral);
begin
  FParentMenu := AParentMenu;
  FName := 'Nome Sobrenome';
  FEmail := 'nome@dominio.com';
  FImageURL := 'https://s11.gifyu.com/images/SchAL.png';
  Visible := True;
end;

destructor TUniDSAMenuLateralProfile.Destroy;
begin
  inherited;
end;

function TUniDSAMenuLateralProfile.GetEmail: string;
begin
  Result := FEmail;
end;

function TUniDSAMenuLateralProfile.GetImageURL: string;
begin
  Result := FImageURL;
end;

function TUniDSAMenuLateralProfile.GetName: string;
begin
  Result := FName;
end;

procedure TUniDSAMenuLateralProfile.SetEmail(const Value: string);
begin
  FEmail := Value;

  if Assigned(FParentMenu) then begin
    with FParentMenu do begin
      JS('$("#uni-ml-perfil-email").text("' + Value + '");');
    end;
  end;
end;

procedure TUniDSAMenuLateralProfile.SetImageURL(const Value: string);
begin
  FImageURL := Value;

  if Assigned(FParentMenu) then begin
    with FParentMenu do begin
      JS('$("#uni-ml-perfil-imagem").attr("src", "' + Value + '");');
    end;
  end;
end;

procedure TUniDSAMenuLateralProfile.SetName(const Value: string);
begin
  FName := Value;

  if Assigned(FParentMenu) then begin
    with FParentMenu do begin
      JS('$("#uni-ml-perfil-nome").text("' + Value + '");');
    end;
  end;
end;

procedure TUniDSAMenuLateralProfile.SetVisible(const Value: Boolean);
begin
  if Assigned(FParentMenu) then begin
    if Value then
      FParentMenu.JS('$(".uni-ml-perfil").show();')
    else
      FParentMenu.JS('$(".uni-ml-perfil").hide();');
  end;

  FVisible := Value;
end;

{ TUniDSAMenuLateralMenuitem }

procedure TUniDSAMenuLateralMenuItem.ClearNotification;
begin
  try
    NotificationCount := 0;
  except
  end;
end;

constructor TUniDSAMenuLateralMenuitem.Create(Collection: TCollection);
var
  LMenuHTML: string;
  LJSName: string;
begin
  inherited;
  Icon := 'fas fa-bars';
  Caption := 'Menu ' + IntToStr(Self.Index + 1);
  NotificationCount := 0;
  Visible := True;
  Enabled := True;
  Separator := False;
  FHidden := False;
  Hint := '';
  SetName;

  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    LJSName := TUniDSAMenuLateralMenu(Collection).FIMenuParent.JSName;

    LMenuHTML :=
      '<li id="uni-ml-item-menu-' + FName + '" onclick="UniDSAMenuLateralOnClickMenu(' + LJSName + ', ''' + Trim(FName) + ''')" style="order: ' + IntToStr(Self.Index) + ';"> ' +
      '  <a id="uni-ml-item-menu-link" title="' + Hint + '"> ' +
      '    <div class="uni-ml-item-icone"> ' +
      '      <i id="uni-ml-item-icon-' + FName + '" class="' + Icon + '"></i> ' +
      '    </div> ' +
      '    <span id="uni-ml-item-texto-' + FName + '">' + FCaption + '</span> ' +
      '    <div class="uni-ml-item-menu-notif" id="uni-ml-item-menu-notif-' + FName + '" onclick="UniDSAMenuLateralOnClickNotificationMenu(' + LJSName + ', ''' + FName + ''', event)">' + IntToStr(FNotificationCount) + '</div> ' +
      '  </a> ' +
      '</li> ';

    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do begin
      JS('$(".uni-ml-menu-lista").append($(`' + LMenuHTML + '`));');
      JS('$("#uni-ml-item-menu-notif-' + FName + '").hide();');
    end;
  end;
end;

procedure TUniDSAMenuLateralMenuItem.DecNotification;
begin
  try
    NotificationCount := NotificationCount - 1;
  except
  end;
end;

destructor TUniDSAMenuLateralMenuitem.Destroy;
begin
  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do
      JS('$("#uni-ml-item-menu-' + FName + '").remove();');
  end;

  inherited;
end;

function TUniDSAMenuLateralMenuitem.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TUniDSAMenuLateralMenuItem.GetHidden: Boolean;
begin
  Result := FHidden;
end;

function TUniDSAMenuLateralMenuitem.GetHint: string;
begin
  Result := FHint;
end;

function TUniDSAMenuLateralMenuitem.GetIcon: string;
begin
  Result := FIcon;
end;

function TUniDSAMenuLateralMenuitem.GetNotificationCount: Integer;
begin
  Result := FNotificationCount;
end;

function TUniDSAMenuLateralMenuitem.GetSeparator: Boolean;
begin
  Result := FSeparator;
end;

function TUniDSAMenuLateralMenuitem.GetCaption: string;
begin
  Result := FCaption;
end;

function TUniDSAMenuLateralMenuitem.GetVisible: Boolean;
begin
  Result := FVisible;
end;

procedure TUniDSAMenuLateralMenuItem.IncNotification;
begin
  try
    NotificationCount := NotificationCount + 1;
  except
  end;
end;

procedure TUniDSAMenuLateralMenuitem.SetEnabled(const Value: Boolean);
begin
  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do begin
      if Value then
        JS('$("#uni-ml-item-menu-' + FName + '").removeClass("uni-ml-desativado");')
      else
        JS('$("#uni-ml-item-menu-' + FName + '").addClass("uni-ml-desativado");');
    end;
  end;

  FEnabled := Value;
end;

procedure TUniDSAMenuLateralMenuItem.SetHidden(const Value: Boolean);
begin
  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do begin
      if Value then
        JS('$("#uni-ml-item-menu-' + FName + '").css("visibility","hidden");')
      else
        JS('$("#uni-ml-item-menu-' + FName + '").css("visibility","visible");');
    end;
  end;

  FHidden := Value;
end;

procedure TUniDSAMenuLateralMenuitem.SetHint(const Value: string);
begin
  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do
      JS('$("#uni-ml-item-menu-link-' + FName + '").attr("title","' + Value + '");');
  end;

  FHint := Value;
end;

procedure TUniDSAMenuLateralMenuitem.SetIcon(const Value: string);
begin
  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do begin
      JS('$("#uni-ml-item-icon-' + FName + '").removeClass().addClass("' + RemoverTagFontAwesome(Value) + '");');
    end;
  end;

  FIcon := RemoverTagFontAwesome(Value);
end;

procedure TUniDSAMenuLateralMenuitem.SetName;
var
  LNameInvalid: Boolean;
  LGeneratedName: string;

  function ExistingButton(name: string): Boolean;
  var
    i: Integer;

  begin
    Result := False;

    for i := 0 to Collection.Count - 1 do begin
      if TUniDSAMenuLateralMenuitem(Collection.Items[i]).FName = name then begin
        Result := True;
        Break;
      end;
    end;
  end;
begin
  LNameInvalid := True;
  repeat
    LGeneratedName := SortName;
  until LNameInvalid;

  FName := LGeneratedName;
end;

procedure TUniDSAMenuLateralMenuitem.SetNotificationCount(const Value: Integer);
begin
  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do begin
      if Value > 99 then begin
        JS('$("#uni-ml-item-menu-notif-' + FName + '").text("+99");');
        JS('$("#uni-ml-item-menu-notif-' + FName + '").show();');
      end
      else if Value > 0 then begin
        JS('$("#uni-ml-item-menu-notif-' + FName + '").text("' + IntToStr(Value) + '");');
        JS('$("#uni-ml-item-menu-notif-' + FName + '").show();');
      end
      else begin
        JS('$("#uni-ml-item-menu-notif-' + FName + '").text("");');
        JS('$("#uni-ml-item-menu-notif-' + FName + '").hide();');
      end;
    end;
  end;

  FNotificationCount := Value;
end;

procedure TUniDSAMenuLateralMenuitem.SetSeparator(const Value: Boolean);
var
  LMenuHTML: string;
begin
  if Value <> FSeparator then begin
    if Value then begin
      if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
        with TUniDSAMenuLateralMenu(Collection).FIMenuParent do begin
          JS('$("#uni-ml-item-menu-' + FName + '").remove();');
          LMenuHTML := '<div id="uni-ml-item-menu-' + FName + '" class="uni-ml-item-menu-divisor" style="order: ' + IntToStr(Self.Index) + ';"></div>';
          JS('$(".uni-ml-menu-lista").append($(`' + LMenuHTML + '`));');
        end;
      end;
    end
    else begin
      if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
        with TUniDSAMenuLateralMenu(Collection).FIMenuParent do begin
          JS('$("#uni-ml-item-menu-' + FName + '").remove();');

          LMenuHTML :=
            '<li id="uni-ml-item-menu-' + FName + '" onclick="UniDSAMenuLateralOnClickMenu(' + JSName + ', ''' + Trim(FName) + ''')" style="order: ' + IntToStr(Self.Index) + ';"> ' +
            '  <a id="uni-ml-item-menu-link" title="' + Hint + '"> ' +
            '    <div class="uni-ml-item-icone"> ' +
            '      <i id="uni-ml-item-icon-x" class="' + Icon + '"></i> ' +
            '    </div> ' +
            '    <span id="uni-ml-item-texto-' + FName + '">' + FCaption + '</span> ' +
            '    <div class="uni-ml-item-menu-notif" id="uni-ml-item-menu-notif-' + FName + '" onclick="UniDSAMenuLateralOnClickNotificationMenu(' + JSName + ', ''' + FName + ''', event)">' + IntToStr(FNotificationCount) + '</div> ' +
            '  </a> ' +
            '</li> ';

          JS('$(".uni-ml-menu-lista").append($(`' + LMenuHTML + '`));');

          if NotificationCount <= 0 then
            JS('$("#uni-ml-item-menu-notif-' + FName + '").hide();');
        end;
      end;
    end;
  end;

  FSeparator := Value;
end;

procedure TUniDSAMenuLateralMenuitem.SetCaption(const Value: string);
begin
  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do
      JS('$("#uni-ml-item-texto-' + FName + '").text("' + Value + '");');
  end;

  FCaption := Value;
end;

procedure TUniDSAMenuLateralMenuitem.SetVisible(const Value: Boolean);
begin
  if Assigned(TUniDSAMenuLateralMenu(Collection).FIMenuParent) then begin
    with TUniDSAMenuLateralMenu(Collection).FIMenuParent do begin
      if Value then
        JS('$("#uni-ml-item-menu-' + FName + '").show();')
      else
        JS('$("#uni-ml-item-menu-' + FName + '").hide();');
    end;
  end;

  FVisible := Value;
end;

{ TUniDSAMenuLateralMenu }

function TUniDSAMenuLateralMenu.AddItem: TUniDSAMenuLateralMenuItem;
begin
  Result := TUniDSAMenuLateralMenuItem(Add);
end;

constructor TUniDSAMenuLateralMenu.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  inherited;
end;

destructor TUniDSAMenuLateralMenu.Destroy;
begin
  inherited;
end;

function TUniDSAMenuLateralMenu.IndexOf(ACaptionItem: string): TUniDSAMenuLateralMenuItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Self.Count - 1 do begin
    if TUniDSAMenuLateralMenuItem(Self.Items[I]).Caption <> ACaptionItem then
      Continue;

    Result := TUniDSAMenuLateralMenuItem(Self.Items[I]);
    Break;
  end;
end;

procedure TUniDSAMenuLateralMenu.SetIMenuParent(const Value: TUniDSAMenuLateral);
begin
  FIMenuParent := Value;
end;

{ TUniDSAMenuStyle }

constructor TUniDSAMenuLateralMenuStyle.Create(AParentMenu: TUniDSAMenuLateral);
begin
  FParentMenu := AParentMenu;

  FPaddingTop := 20;
  FPaddingLeft := 20;
  FPaddingRight := 20;
  FPaddingBottom := 20;

  FBorderRadiusTopLeft := 0;
  FBorderRadiusTopRight := 15;
  FBorderRadiusBottomLeft := 0;
  FBorderRadiusBottomRight := 15;

  FBorderTop := 0;
  FBorderLeft := 0;
  FBorderRight := 2;
  FBorderBottom := 0;  
end;

destructor TUniDSAMenuLateralMenuStyle.Destroy;
begin
  inherited;
end;

procedure TUniDSAMenuLateralMenuStyle.SetBorderBottom(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("border-bottom","' + px(Value) +' solid var(--var-uni-ml-cor-borda)");');
    
  FBorderBottom := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetBorderLeft(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("border-left","' + px(Value) +' solid var(--var-uni-ml-cor-borda)");');
    
  FBorderLeft := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetBorderRadiusBottomLeft(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("border-bottom-left-radius","' + px(Value) +'");');

  FBorderRadiusBottomLeft := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetBorderRadiusBottomRight(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("border-bottom-right-radius","' + px(Value) +'");');

  FBorderRadiusBottomRight := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetBorderRadiusTopLeft(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("border-top-left-radius","' + px(Value) +'");');

  FBorderRadiusTopLeft := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetBorderRadiusTopRight(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("border-top-right-radius","' + px(Value) +'");');

  FBorderRadiusTopRight := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetBorderRight(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("border-right","' + px(Value) +' solid var(--var-uni-ml-cor-borda)");');
    
  FBorderRight := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetBorderTop(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("border-top","' + px(Value) +' solid var(--var-uni-ml-cor-borda)");');
  
  FBorderTop := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetPaddingBottom(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("padding-bottom","' + px(Value) + '");');

  FPaddingBottom := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetPaddingLeft(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("padding-left","' + px(Value) + '");');

  FPaddingLeft := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetPaddingRight(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("padding-right","' + px(Value) + '");');

  FPaddingRight := Value;
end;

procedure TUniDSAMenuLateralMenuStyle.SetPaddingTop(const Value: Integer);
begin
  if Assigned(FParentMenu) then
    FParentMenu.JS('$(".uni-ml").css("padding-top","' + px(Value) + '");');

  FPaddingTop := Value;
end;

function GetMenuLateralStyleTheme(ATheme: TUniDSAMenuLateralStyleTheme): string;
begin
  // Cor do fundo
  // Cor borda do fundo
  // Cor icones
  // Cor itens fundo
  // Cor itens
  // Cor texto
  // Cor tema texto selecionado
  // Cor icone hover sair
  // Cor fundo notificações

  if ATheme = mltClaro then
    Result := '"#FFF", "#edeeef", "#141414", "#00000009", "#141414", "#141414", "#141414", "#f42e2e", "#cddff0"'
  else if ATheme = mltEscuro then
    Result := '"#1C1C1C", "#2D2D2D", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#333333", "#f42e2e"'
  else if ATheme = mltUniClassic then
    Result := '"#FFF", "#cddff0", "#333333", "#c4dafb28", "#333333", "#333333", "#333333", "#4f78af", "#4f78af"'
  else if ATheme = mltUniGray then
    Result := '"#ffffff", "#bbbbbb", "#848484", "#84848413", "#848484", "#848484", "#848484", "#bbbbbb", "#707070"'
  else if ATheme in [mltUniCrisp, mltUniNeptune] then
    Result := '"#3892d4", "#3487c3", "#FFFFFF", "#3487c3", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#3487c3", "#3487c3"'
  else if ATheme = mltUniTriton then
    Result := '"#ffffff", "#5fa2dd", "#404040", "#5fa2dd2c", "#404040", "#404040", "#404040", "#5fa2dd", "#5fa2dd"'
  else if ATheme = mltUniGraphite then
    Result := '"#1b1b1b", "#6d6d6d", "#ffffff", "#4242422a", "#ffffff", "#ffffff", "#ffffff", "#6d6d6d", "#4242422a"'
  else if ATheme = mltUniMaterial then
    Result := '"#ffffff", "#2196f3", "#2196f3", "#ededed", "#2196f3", "#2196f3", "#2196f3", "#2196f3", "#2196f3"'
  else if ATheme = mltUniAqua then
    Result := '"#edf4f7", "#b5bdcb", "#333333", "#33333309", "#333333", "#333333", "#333333", "#2572d0", "#2572d0"'
  else if ATheme = mltUniCarbon then
    Result := '"#383737", "#4e4e4e", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#222222", "#222222"'
  else if ATheme = mltUniClassic2 then
    Result := '"#d4d0c8", "#111419", "#333333", "#33333309", "#333333", "#333333", "#333333", "#ffffff", "#333333"'
  else if ATheme = mltUniEmerald then
    Result := '"#ffffff", "#e5e5e5", "#000000", "#00000009", "#000000", "#000000", "#000000", "#18bc9c", "#18bc9c"'
  else if ATheme = mltUniFlatBlack then
    Result := '"#efefef", "#222222", "#333333", "#33333309", "#333333", "#333333", "#333333", "#0069d5", "#0069d5"'
  else if ATheme = mltUniKde then
    Result := '"#ccc6c4", "#7f8182", "#333333", "#33333309", "#333333", "#333333", "#333333", "#76787a", "#76787a"'
  else if ATheme = mltUniMac then
    Result := '"#F0F0F0", "#B3B3B3", "#333333", "#33333309", "#333333", "#333333", "#333333", "#333333", "#333333"'
  else if ATheme = mltUniSencha then
    Result := '"#0f5a8a", "#4fb6f7", "#FFF", "#00000009", "#FFF", "#FFF", "#FFF", "#8fc515", "#8fc515"'
  else if ATheme = mltUniAria then
    Result := '"#232d38", "#e68d00", "#e68d00", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#e68d00", "#e68d00"'
  else if ATheme = mltNatureSerenity then
    Result := '"#E6F2FF", "#B0E0E6", "#228B22", "#228B2209", "#228B22", "#228B22", "#228B22", "#104610", "#228B22"'
  else if ATheme = mltMidnightGalaxy then
    Result := '"#0D0221", "#2E1A47", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#4d03be", "#4d03be"'
  else if ATheme = mltGoldenElegance then
    Result := '"#FDF5E6", "#FFD700", "#4B0082", "#4B008209", "#4B0082", "#4B0082", "#4B0082", "#ab9000", "#ab9000"'
  else if ATheme = mltVibratCitrus then
    Result := '"#FFF8DC", "#FFA500", "#008B8B", "#008B8B09", "#008B8B", "#008B8B", "#008B8B", "#FFA500", "#FFA500"'
  else if ATheme = mltPinterestInspired then
    Result := '"#FFFFFF", "#E60023", "#E60023", "#E6002309", "#E60023", "#E60023", "#E60023", "#E60023", "#E60023"'
  else if ATheme = mltWhatsAppInspired then
    Result := '"#FFFFFF", "#25D366", "#25D366", "#25D36609", "#25D366", "#25D366", "#25D366", "#25D366", "#25D366"'
  else if ATheme = mltLinkedInInspired then
    Result := '"#0077B5", "#FFFFFF", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF"'
  else if ATheme = mltSnapchatInspired then
    Result := '"#FFFC00", "#3D3D3D", "#3D3D3D", "#3D3D3D09", "#3D3D3D", "#3D3D3D", "#3D3D3D", "#000", "#000"'
  else if ATheme = mltPink then
    Result := '"#E1306C", "#FFFFFF", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#910635", "#910635"'
  else if ATheme = mltAzureDream then
    Result := '"#F0F8FF", "#B0C4DE", "#4682B4", "#4682B409", "#4682B4", "#4682B4", "#4682B4", "#4682B4", "#4682B4"'
  else if ATheme = mltSoothingSky then
    Result := '"#87CEEB", "#B0E0E6", "#2F4F4F", "#2F4F4F09", "#2F4F4F", "#2F4F4F", "#2F4F4F", "#2F4F4F", "#2F4F4F"'
  else if ATheme = mltSapphireMajesty then
    Result := '"#F0F8FF", "#B0C4DE", "#483D8B", "#483D8B09", "#483D8B", "#483D8B", "#483D8B", "#483D8B", "#483D8B"'
  else if ATheme = mltTwitterInspired then
    Result := '"#FFFFFF", "#1DA1F2", "#1DA1F2", "#1DA1F209", "#1DA1F2", "#1DA1F2", "#1DA1F2", "#1DA1F2", "#1DA1F2"'
  else if ATheme = mltTwitterDarkMode then
    Result := '"#15202B", "#1DA1F2", "#1DA1F2", "#1DA1F209", "#1DA1F2", "#1DA1F2", "#1DA1F2", "#1DA1F2", "#1DA1F2"'
  else if ATheme = mltFacebookInspired then
    Result := '"#1877F2", "#FFFFFF", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#616771", "#616771"'
  else if ATheme = mltCoastalBlues then
    Result := '"#E6F2FF", "#4682B4", "#4682B4", "#4682B409", "#4682B4", "#4682B4", "#4682B4", "#4682B4", "#4682B4"'
  else if ATheme = mltSereneSky then
    Result := '"#87CEEB", "#2F4F4F", "#2F4F4F", "#2F4F4F09", "#2F4F4F", "#2F4F4F", "#2F4F4F", "#2F4F4F", "#2F4F4F"'
  else if ATheme = mltCherryBlossom then
    Result := '"#FFC0CB", "#800000", "#800000", "#80000009", "#800000", "#800000", "#800000", "#800000", "#800000"'
  else if ATheme = mltRubyRadiance then
    Result := '"#E74C3C", "#FFFFFF", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#941414", "#941414"'
  else if ATheme = mltCrimsonGold then
    Result := '"#8B0000", "#FFD700", "#FFD700", "#FFD70009", "#FFD700", "#FFD700", "#FFD700", "#e74c3c", "#e74c3c"'
  else if ATheme = mltPastelParadise then
    Result := '"#FAD2E7", "#F5B8C4", "#5B4D61", "#5B4D6109", "#5B4D61", "#5B4D61", "#5B4D61", "#ae648b", "#ae648b"'
  else if ATheme = mltBlue then
    Result := '"#0000FF", "#0000A0", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#609cff", "#609cff"'
  else if ATheme = mltOceanBreeze then
    Result := '"#EAF6FF", "#B0D9F1", "#1A3B5F", "#1A3B5F09", "#1A3B5F", "#1A3B5F", "#1A3B5F", "#1A3B5F", "#1A3B5F"'
  else if ATheme = mltOrange then
    Result := '"#FF7F00", "#A05000", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#be6710", "#be6710"'
  else if ATheme = mltGray then
    Result := '"#808080", "#A0A0A0", "#FFFFFF", "#FFFFFF09", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#636363", "#636363"'
  else if ATheme = mltCitrusPunch then
    Result := '"#FDF3E8", "#F7D1AA", "#FF7100", "#FF710009", "#FF7100", "#FF7100", "#FF7100", "#FF7100", "#FF7100"'
  else if ATheme = mltDesertDream then
    Result := '"#FFE5C2", "#FFD1A0", "#C28B54", "#C28B5409", "#C28B54", "#C28B54", "#C28B54", "#C28B54", "#C28B54"'
  else if ATheme = mltVintageRose then
    Result := '"#FBE3E3", "#F2C9C9", "#784747", "#78474709", "#784747", "#784747", "#784747", "#784747", "#784747"'
  else if ATheme = mltMidnightForest then
    Result := '"#101E24", "#304C3B", "#E7F4EB", "#E7F4EB09", "#E7F4EB", "#E7F4EB", "#E7F4EB", "#087200", "#087200"'
  else if ATheme = mltTropicalParadise then
    Result := '"#F2FFDA", "#D7F2AA", "#5F814C", "#5F814C09", "#5F814C", "#5F814C", "#5F814C", "#77a07f", "#77a07f"'
  else if ATheme = mltSenchaFresh then
    Result := '"#90CE26", "#D7D7D7", "#333333", "#33333309", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#5b8219", "#5b8219"'
  else if ATheme = mltElectricVibes then
    Result := '"#000000", "#333333", "#FFD100", "#FFD10009", "#FFD100", "#FFD100", "#FFD100", "#E84949", "#FFD100"'
  else if ATheme = mltAeroGlass then
    Result := '"#D4E4F7", "#B2CBEF", "#3A679F", "#3A679F09", "#3A679F", "#3A679F", "#3A679F", "#3A679F", "#3A679F"'
  else if ATheme = mltModernMetro then
    Result := '"#FFFFFF", "#E4E4E4", "#0087C2", "#0087C209" ,"#0087C2", "#0087C2", "#0087C2", "#E84949", "#0087C2"'
  else if ATheme = mltFluentDesign then
    Result := '"#EDEDED", "#CCCCCC", "#0078D4", "#0078D409", "#0078D4", "#0078D4", "#0078D4", "#0078D4", "#0078D4"'
  else if ATheme = mltClassicBliss then
    Result := '"#C1D9F0", "#A5B9D1", "#2F5496", "#2F549609", "#2F5496", "#2F5496", "#2F5496", "#E84949", "#2F5496"'
  else if ATheme = mltLinuxMint then
    Result := '"#C5E0D8", "#A2C4B4", "#2E8572", "#2E857209", "#2E8572", "#2E8572", "#2E8572", "#E84949", "#2E8572"'
  else if ATheme = mltSunsetWarmth then
    Result := '"#FDB813", "#FFA600", "#D94E1F", "#D94E1F09", "#D94E1F", "#D94E1F", "#D94E1F", "#FF3C00", "#FF3C00"'
  else if ATheme = mltLilacGlow then
    Result := '"#E3D5EA", "#C6AEE7", "#8B5FA5", "#8B5FA509", "#8B5FA5", "#8B5FA5", "#8B5FA5", "#C675EC", "#C675EC"'
  else if ATheme = mltMysticMoonlight then
    Result := '"#0E1323", "#1A253E", "#A893D9", "#A893D909", "#A893D9", "#A893D9", "#A893D9", "#0A106D", "#0A106D"'
  else if ATheme = mltFreshBreeze then
    Result := '"#F0FFF4", "#D1E7DD", "#37A86E", "#37A86E09", "#37A86E", "#37A86E", "#37A86E", "#23C47A", "#23C47A"'
  else if ATheme = mltVibrantViolet then
    Result := '"#5D3A7B", "#412859", "#E17EFF", "#E17EFF09", "#E17EFF", "#E17EFF", "#E17EFF", "#823C8D", "#823C8D"'
  else if ATheme = mltCandyCrush then
    Result := '"#FFC300", "#FFD100", "#E60023", "#E6002309", "#E60023", "#E60023", "#E60023", "#FF47A4", "#FF47A4"'
  else if ATheme = mltMintyFresh then
    Result := '"#D1E7DD", "#A6CCC8", "#31A696", "#31A69609", "#31A696", "#31A696", "#31A696", "#00CFAA", "#00CFAA"'
  else if ATheme = mltChocoDelight then
    Result := '"#64493D", "#50382B", "#D18C57", "#D18C5709", "#D18C57", "#D18C57", "#D18C57", "#8B5A2B", "#8B5A2B"'
  else if ATheme = mltPastelPalette then
    Result := '"#F7E7CE", "#D5B9A2", "#A2C4B4", "#A2C4B409", "#A2C4B4", "#A2C4B4", "#A2C4B4", "#BFA5C4", "#BFA5C4"'
  else if ATheme = mltFloralElegance then
    Result := '"#F3CDA4", "#D4A783", "#DF8383", "#DF838309", "#DF8383", "#DF8383", "#DF8383", "#A97D7D", "#A97D7D"'
  else if ATheme = mltRoyalRegency then
    Result := '"#392F5A", "#1E1742", "#F2C057", "#F2C05709", "#F2C057", "#F2C057", "#F2C057", "#A83E4E", "#A83E4E"'
  else if ATheme = mltAutumnLeaves then
    Result := '"#E87B1D", "#B85D17", "#80360C", "#80360C09", "#80360C", "#80360C", "#80360C", "#A04F15", "#A04F15"'
  else if ATheme = mltAzureHorizon then
    Result := '"#E3F2FD", "#B0C7DB", "#1E88E5", "#1E88E509", "#1E88E5", "#1E88E5", "#1E88E5", "#1565C0", "#1565C0"'
  else if ATheme = mltGoldenHarvest then
    Result := '"#E2C391", "#D0A878", "#AF8756", "#AF875609", "#AF8756", "#AF8756", "#AF8756", "#C9A44A", "#C9A44A"'
  else if ATheme = mltFrostyMorning then
    Result := '"#F0F7F4", "#D1DFDB", "#5DA0A2", "#5DA0A209", "#5DA0A2", "#5DA0A2", "#5DA0A2", "#81C7D4", "#81C7D4"'
  else if ATheme = mltPumpkinSpice then
    Result := '"#FF9432", "#FFA03C", "#9E442E", "#9E442E09", "#9E442E", "#9E442E", "#9E442E", "#DE6B20", "#DE6B20"'
  else if ATheme = mltMoonlitMeadow then
    Result := '"#1E212F", "#2C2F3F", "#8E9AAF", "#8E9AAF09", "#8E9AAF", "#8E9AAF", "#8E9AAF", "#68778A", "#68778A"'
  else if ATheme = mltIcyElegance then
    Result := '"#F4F7F9", "#D9E2E5", "#8BA0B5", "#8BA0B509", "#8BA0B5", "#8BA0B5", "#8BA0B5", "#4F6C88", "#4F6C88"'
  else if ATheme = mltHarvestHues then
    Result := '"#E88034", "#CB6B1E", "#AA4910", "#AA491009", "#AA4910", "#AA4910", "#AA4910", "#DB5B20", "#DB5B20"'
  else if ATheme = mltRoyalVelvet then
    Result := '"#5E366A", "#4E2C5A", "#9C61A1", "#9C61A109", "#9C61A1", "#9C61A1", "#9C61A1", "#6E3F75", "#6E3F75"'
  else if ATheme = mltSummerSolstice then
    Result := '"#66FF66", "#66AA66", "#009900", "#00660009", "#006600", "#006600", "#006600", "#009900", "#009900"'
  else if ATheme = mltAutumnColors then
    Result := '"#D3D3D3", "#BEBEBE", "#666666", "#66666609", "#666666", "#666666", "#666666", "#CC6666", "#CC6666"'
  else if ATheme = mltWinterWonderland then
    Result := '"#FFFFFF", "#C0C0C0", "#333333", "#33333309", "#333333", "#333333", "#333333", "#FFFFFF", "#FFFFFF"'
  else if ATheme = mltNeonNightlife then
    Result := '"#000000", "#000080", "#00FF00", "#00FF0009", "#00FF00", "#00FF00", "#00FF00", "#00FFFF", "#00FF00"'
  else if ATheme = mltPastelDreams then
    Result := '"#F2F2F2", "#E4E4E4", "#F08080", "#F0808009", "#F08080", "#F08080", "#F08080", "#F08080", "#F08080"'
  else if ATheme = mltSeasideCottage then
    Result := '"#D9E0E3", "#B3C0C8", "#6B727A", "#6B727A09", "#6B727A", "#6B727A", "#6B727A", "#96A8AB", "#96A8AB"'
  else if ATheme = mltMountainMajesty then
    Result := '"#DEEBF0", "#B3C0C8", "#483D8B", "#483D8B09", "#483D8B", "#483D8B", "#483D8B", "#483D8B", "#483D8B"'
  else if ATheme = mltRainyDay then
    Result := '"#6D92AE", "#5F814C", "#263238", "#26323809", "#263238", "#263238", "#263238", "#284358", "#284358"'
  else
    Result := '"#FFF", "#edeeef", "#141414", "#00000009", "#141414", "#141414", "#141414", "#f42e2e", "#cddff0"';
end;

initialization
  UniDSASource.GetLink(TTypeUniDSASource.MenuLateral);

end.

