unit UniDSAStyle;

interface

uses
  System.Classes, System.SysUtils, System.JSON, Vcl.Graphics, Vcl.Controls,
  uniGUIClasses, uniGUIFrame, uniGUIForm, UniDSABase;

type
  TUniDSAStyle = class;
  TUniDSAStylePersistent = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FUpdateCount: Integer;
    FDirty: Boolean;
  protected
    procedure Changed;
    procedure ChildChanged(Sender: TObject);
  public
    constructor Create(AOnChange: TNotifyEvent); virtual;
    procedure BeginUpdate;
    procedure EndUpdate;
  end;

  TUniDSAStyleSwitch = (ssInherit, ssNo, ssYes);
  TUniDSAStyleUnit = (suUnset, suPx, suPercent, suEm, suRem, suVw, suVh, suDvh, suAuto, suFitContent, suMinContent, suMaxContent);
  TUniDSAStyleBorderLine = (blInherit, blNone, blSolid, blDashed, blDotted, blDouble);
  TUniDSAStyleWeight = (swInherit, swNormal, swMedium, swSemiBold, swBold);
  TUniDSAStyleAlign = (saInherit, saLeft, saCenter, saRight, saJustify);
  TUniDSAStyleWhiteSpace = (wsInherit, wsNormal, wsNoWrap, wsPre, wsPreWrap, wsPreLine);
  TUniDSAStyleTextOverflow = (toInherit, toClip, toEllipsis);
  TUniDSAStyleTransform = (ttInherit, ttNone, ttUppercase, ttLowercase, ttCapitalize);
  TUniDSAStyleDecoration = (tdInherit, tdNone, tdUnderline, tdLineThrough);
  TUniDSAStyleOverflow = (soInherit, soVisible, soHidden, soAuto, soScroll);
  TUniDSAStyleCursor = (scInherit, scDefault, scPointer, scText, scNotAllowed, scGrab);
  TUniDSAStyleImageSize = (isInherit, isAuto, isCover, isContain);
  TUniDSAStyleRepeat = (srInherit, srRepeat, srNoRepeat, srRepeatX, srRepeatY);
  TUniDSAStylePattern = (spInherit, spNone, spDots, spGrid, spLines);
  TUniDSAStyleGradient = (sgInherit, sgNone, sgLinear, sgRadial);
  TUniDSAStylePositionMode = (poInherit, poStatic, poRelative, poAbsolute, poFixed, poSticky);
  TUniDSAStyleBoxSizing = (bsInherit, bsBorderBox, bsContentBox);
  TUniDSAStyleDisplay = (sdInherit, sdNone, sdBlock, sdInline, sdInlineBlock, sdFlex, sdInlineFlex, sdGrid, sdInlineGrid);
  TUniDSAStyleOrientation = (orAny, orPortrait, orLandscape);
  TUniDSAStyleLength = class(TUniDSAStylePersistent)
  private
    FValue: Double;
    FUnits: TUniDSAStyleUnit;
    procedure SetValue(const Value: Double);
    procedure SetUnits(const Value: TUniDSAStyleUnit);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Value: Double read FValue write SetValue;
    property Units: TUniDSAStyleUnit read FUnits write SetUnits default suUnset;
  end;

  TUniDSAStyleEdges = class(TUniDSAStylePersistent)
  private
    FAll: Integer;
    FLeft: Integer;
    FTop: Integer;
    FRight: Integer;
    FBottom: Integer;
    procedure SetAll(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetRight(const Value: Integer);
    procedure SetBottom(const Value: Integer);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property All: Integer read FAll write SetAll default -1;
    property Left: Integer read FLeft write SetLeft default -1;
    property Top: Integer read FTop write SetTop default -1;
    property Right: Integer read FRight write SetRight default -1;
    property Bottom: Integer read FBottom write SetBottom default -1;
  end;

  TUniDSAStyleBorderEdge = class(TUniDSAStylePersistent)
  private
    FWidth: Integer;
    FColor: TColor;
    FLine: TUniDSAStyleBorderLine;
    procedure SetWidth(const Value: Integer);
    procedure SetColor(const Value: TColor);
    procedure SetLine(const Value: TUniDSAStyleBorderLine);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Width: Integer read FWidth write SetWidth default -1;
    property Color: TColor read FColor write SetColor default clNone;
    property Line: TUniDSAStyleBorderLine read FLine write SetLine default blInherit;
  end;

  TUniDSAStyleBackground = class(TUniDSAStylePersistent)
  private
    FColor: TColor;
    FOpacity: Integer;
    FImageURL: string;
    FImageSize: TUniDSAStyleImageSize;
    FRepeatMode: TUniDSAStyleRepeat;
    FPattern: TUniDSAStylePattern;
    FPatternColor: TColor;
    FPatternSize: Integer;
    FGradient: TUniDSAStyleGradient;
    FGradientColor: TColor;
    FGradientAngle: Integer;
    procedure SetColor(const Value: TColor);
    procedure SetOpacity(const Value: Integer);
    procedure SetImageURL(const Value: string);
    procedure SetImageSize(const Value: TUniDSAStyleImageSize);
    procedure SetRepeatMode(const Value: TUniDSAStyleRepeat);
    procedure SetPattern(const Value: TUniDSAStylePattern);
    procedure SetPatternColor(const Value: TColor);
    procedure SetPatternSize(const Value: Integer);
    procedure SetGradient(const Value: TUniDSAStyleGradient);
    procedure SetGradientColor(const Value: TColor);
    procedure SetGradientAngle(const Value: Integer);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Color: TColor read FColor write SetColor default clNone;
    property Opacity: Integer read FOpacity write SetOpacity default -1;
    property ImageURL: string read FImageURL write SetImageURL;
    property ImageSize: TUniDSAStyleImageSize read FImageSize write SetImageSize default isInherit;
    property RepeatMode: TUniDSAStyleRepeat read FRepeatMode write SetRepeatMode default srInherit;
    property Pattern: TUniDSAStylePattern read FPattern write SetPattern default spInherit;
    property PatternColor: TColor read FPatternColor write SetPatternColor default clNone;
    property PatternSize: Integer read FPatternSize write SetPatternSize default -1;
    property Gradient: TUniDSAStyleGradient read FGradient write SetGradient default sgInherit;
    property GradientColor: TColor read FGradientColor write SetGradientColor default clNone;
    property GradientAngle: Integer read FGradientAngle write SetGradientAngle default -1000;
  end;

  TUniDSAStyleBorder = class(TUniDSAStylePersistent)
  private
    FWidth: Integer;
    FColor: TColor;
    FLine: TUniDSAStyleBorderLine;
    FRadius: Integer;
    FTopLeftRadius: Integer;
    FTopRightRadius: Integer;
    FBottomLeftRadius: Integer;
    FBottomRightRadius: Integer;
    FTop: TUniDSAStyleBorderEdge;
    FRight: TUniDSAStyleBorderEdge;
    FBottom: TUniDSAStyleBorderEdge;
    FLeft: TUniDSAStyleBorderEdge;
    procedure SetWidth(const Value: Integer);
    procedure SetColor(const Value: TColor);
    procedure SetLine(const Value: TUniDSAStyleBorderLine);
    procedure SetRadius(const Value: Integer);
    procedure SetTopLeftRadius(const Value: Integer);
    procedure SetTopRightRadius(const Value: Integer);
    procedure SetBottomLeftRadius(const Value: Integer);
    procedure SetBottomRightRadius(const Value: Integer);
    procedure SetTop(const Value: TUniDSAStyleBorderEdge);
    procedure SetRight(const Value: TUniDSAStyleBorderEdge);
    procedure SetBottom(const Value: TUniDSAStyleBorderEdge);
    procedure SetLeft(const Value: TUniDSAStyleBorderEdge);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Width: Integer read FWidth write SetWidth default -1;
    property Color: TColor read FColor write SetColor default clNone;
    property Line: TUniDSAStyleBorderLine read FLine write SetLine default blInherit;
    property Radius: Integer read FRadius write SetRadius default -1;
    property TopLeftRadius: Integer read FTopLeftRadius write SetTopLeftRadius default -1;
    property TopRightRadius: Integer read FTopRightRadius write SetTopRightRadius default -1;
    property BottomLeftRadius: Integer read FBottomLeftRadius write SetBottomLeftRadius default -1;
    property BottomRightRadius: Integer read FBottomRightRadius write SetBottomRightRadius default -1;
    property Top: TUniDSAStyleBorderEdge read FTop write SetTop;
    property Right: TUniDSAStyleBorderEdge read FRight write SetRight;
    property Bottom: TUniDSAStyleBorderEdge read FBottom write SetBottom;
    property Left: TUniDSAStyleBorderEdge read FLeft write SetLeft;
  end;

  TUniDSAStyleTypography = class(TUniDSAStylePersistent)
  private
    FFamily: string;
    FColor: TColor;
    FSize: Integer;
    FWeight: TUniDSAStyleWeight;
    FItalic: TUniDSAStyleSwitch;
    FAlignment: TUniDSAStyleAlign;
    FLineHeight: Double;
    FLetterSpacing: Double;
    FWhiteSpace: TUniDSAStyleWhiteSpace;
    FTextOverflow: TUniDSAStyleTextOverflow;
    FWrapAnywhere: TUniDSAStyleSwitch;
    FTransform: TUniDSAStyleTransform;
    FDecoration: TUniDSAStyleDecoration;
    procedure SetFamily(const Value: string);
    procedure SetColor(const Value: TColor);
    procedure SetSize(const Value: Integer);
    procedure SetWeight(const Value: TUniDSAStyleWeight);
    procedure SetItalic(const Value: TUniDSAStyleSwitch);
    procedure SetAlignment(const Value: TUniDSAStyleAlign);
    procedure SetLineHeight(const Value: Double);
    procedure SetLetterSpacing(const Value: Double);
    procedure SetWhiteSpace(const Value: TUniDSAStyleWhiteSpace);
    procedure SetTextOverflow(const Value: TUniDSAStyleTextOverflow);
    procedure SetWrapAnywhere(const Value: TUniDSAStyleSwitch);
    procedure SetTransform(const Value: TUniDSAStyleTransform);
    procedure SetDecoration(const Value: TUniDSAStyleDecoration);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Family: string read FFamily write SetFamily;
    property Color: TColor read FColor write SetColor default clNone;
    property Size: Integer read FSize write SetSize default -1;
    property Weight: TUniDSAStyleWeight read FWeight write SetWeight default swInherit;
    property Italic: TUniDSAStyleSwitch read FItalic write SetItalic default ssInherit;
    property Alignment: TUniDSAStyleAlign read FAlignment write SetAlignment default saInherit;
    property LineHeight: Double read FLineHeight write SetLineHeight;
    property LetterSpacing: Double read FLetterSpacing write SetLetterSpacing;
    property WhiteSpace: TUniDSAStyleWhiteSpace read FWhiteSpace write SetWhiteSpace default wsInherit;
    property TextOverflow: TUniDSAStyleTextOverflow read FTextOverflow write SetTextOverflow default toInherit;
    property WrapAnywhere: TUniDSAStyleSwitch read FWrapAnywhere write SetWrapAnywhere default ssInherit;
    property Transform: TUniDSAStyleTransform read FTransform write SetTransform default ttInherit;
    property Decoration: TUniDSAStyleDecoration read FDecoration write SetDecoration default tdInherit;
  end;

  TUniDSAStyleSpacing = class(TUniDSAStylePersistent)
  private
    FPadding: TUniDSAStyleEdges;
    FMargin: TUniDSAStyleEdges;
    procedure SetPadding(const Value: TUniDSAStyleEdges);
    procedure SetMargin(const Value: TUniDSAStyleEdges);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Padding: TUniDSAStyleEdges read FPadding write SetPadding;
    property Margin: TUniDSAStyleEdges read FMargin write SetMargin;
  end;

  TUniDSAStyleSizing = class(TUniDSAStylePersistent)
  private
    FWidth: TUniDSAStyleLength;
    FHeight: TUniDSAStyleLength;
    FMinWidth: TUniDSAStyleLength;
    FMaxWidth: TUniDSAStyleLength;
    FMinHeight: TUniDSAStyleLength;
    FMaxHeight: TUniDSAStyleLength;
    FMaxWidthPercent: Integer;
    FBoxSizing: TUniDSAStyleBoxSizing;
    FOverflowX: TUniDSAStyleOverflow;
    FOverflowY: TUniDSAStyleOverflow;
    procedure SetWidth(const Value: TUniDSAStyleLength);
    procedure SetHeight(const Value: TUniDSAStyleLength);
    procedure SetMinWidth(const Value: TUniDSAStyleLength);
    procedure SetMaxWidth(const Value: TUniDSAStyleLength);
    procedure SetMinHeight(const Value: TUniDSAStyleLength);
    procedure SetMaxHeight(const Value: TUniDSAStyleLength);
    procedure SetMaxWidthPercent(const Value: Integer);
    procedure SetBoxSizing(const Value: TUniDSAStyleBoxSizing);
    procedure SetOverflowX(const Value: TUniDSAStyleOverflow);
    procedure SetOverflowY(const Value: TUniDSAStyleOverflow);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Width: TUniDSAStyleLength read FWidth write SetWidth;
    property Height: TUniDSAStyleLength read FHeight write SetHeight;
    property MinWidth: TUniDSAStyleLength read FMinWidth write SetMinWidth;
    property MaxWidth: TUniDSAStyleLength read FMaxWidth write SetMaxWidth;
    property MinHeight: TUniDSAStyleLength read FMinHeight write SetMinHeight;
    property MaxHeight: TUniDSAStyleLength read FMaxHeight write SetMaxHeight;
    property MaxWidthPercent: Integer read FMaxWidthPercent write SetMaxWidthPercent default -1;
    property BoxSizing: TUniDSAStyleBoxSizing read FBoxSizing write SetBoxSizing default bsInherit;
    property OverflowX: TUniDSAStyleOverflow read FOverflowX write SetOverflowX default soInherit;
    property OverflowY: TUniDSAStyleOverflow read FOverflowY write SetOverflowY default soInherit;
  end;

  { Personaliza a barra de rolagem sem exigir CSS externo. As cores clNone e
    os valores -1 preservam o acabamento padrão do navegador/tema. }
  TUniDSAStyleScrollbar = class(TUniDSAStylePersistent)
  private
    FVisible: TUniDSAStyleSwitch;
    FSize: Integer;
    FTrackColor: TColor;
    FThumbColor: TColor;
    FThumbHoverColor: TColor;
    FRadius: Integer;
    procedure SetVisible(const Value: TUniDSAStyleSwitch);
    procedure SetSize(const Value: Integer);
    procedure SetTrackColor(const Value: TColor);
    procedure SetThumbColor(const Value: TColor);
    procedure SetThumbHoverColor(const Value: TColor);
    procedure SetRadius(const Value: Integer);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Visible: TUniDSAStyleSwitch read FVisible write SetVisible default ssInherit;
    property Size: Integer read FSize write SetSize default -1;
    property TrackColor: TColor read FTrackColor write SetTrackColor default clNone;
    property ThumbColor: TColor read FThumbColor write SetThumbColor default clNone;
    property ThumbHoverColor: TColor read FThumbHoverColor write SetThumbHoverColor default clNone;
    property Radius: Integer read FRadius write SetRadius default -1;
  end;

  TUniDSAStyleShadow = class(TUniDSAStylePersistent)
  private
    FEnabled: TUniDSAStyleSwitch;
    FColor: TColor;
    FOpacity: Integer;
    FOffsetX: Integer;
    FOffsetY: Integer;
    FBlur: Integer;
    FSpread: Integer;
    FInset: TUniDSAStyleSwitch;
    procedure SetEnabled(const Value: TUniDSAStyleSwitch);
    procedure SetColor(const Value: TColor);
    procedure SetOpacity(const Value: Integer);
    procedure SetOffsetX(const Value: Integer);
    procedure SetOffsetY(const Value: Integer);
    procedure SetBlur(const Value: Integer);
    procedure SetSpread(const Value: Integer);
    procedure SetInset(const Value: TUniDSAStyleSwitch);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Enabled: TUniDSAStyleSwitch read FEnabled write SetEnabled default ssInherit;
    property Color: TColor read FColor write SetColor default clNone;
    property Opacity: Integer read FOpacity write SetOpacity default -1;
    property OffsetX: Integer read FOffsetX write SetOffsetX default -1000;
    property OffsetY: Integer read FOffsetY write SetOffsetY default -1000;
    property Blur: Integer read FBlur write SetBlur default -1;
    property Spread: Integer read FSpread write SetSpread default -1000;
    property Inset: TUniDSAStyleSwitch read FInset write SetInset default ssInherit;
  end;

  TUniDSAStyleEffects = class(TUniDSAStylePersistent)
  private
    FOpacity: Integer;
    FCursor: TUniDSAStyleCursor;
    FTransitionMs: Integer;
    FTransitionAll: TUniDSAStyleSwitch;
    FOutlineWidth: Integer;
    FOutlineColor: TColor;
    FOutlineOffset: Integer;
    procedure SetOpacity(const Value: Integer);
    procedure SetCursor(const Value: TUniDSAStyleCursor);
    procedure SetTransitionMs(const Value: Integer);
    procedure SetTransitionAll(const Value: TUniDSAStyleSwitch);
    procedure SetOutlineWidth(const Value: Integer);
    procedure SetOutlineColor(const Value: TColor);
    procedure SetOutlineOffset(const Value: Integer);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Opacity: Integer read FOpacity write SetOpacity default -1;
    property Cursor: TUniDSAStyleCursor read FCursor write SetCursor default scInherit;
    property TransitionAll: TUniDSAStyleSwitch read FTransitionAll write SetTransitionAll default ssInherit;
    property TransitionMs: Integer read FTransitionMs write SetTransitionMs default -1;
    property OutlineWidth: Integer read FOutlineWidth write SetOutlineWidth default -1;
    property OutlineColor: TColor read FOutlineColor write SetOutlineColor default clNone;
    property OutlineOffset: Integer read FOutlineOffset write SetOutlineOffset default -1000;
  end;

  TUniDSAStylePosition = class(TUniDSAStylePersistent)
  private
    FMode: TUniDSAStylePositionMode;
    FTop: TUniDSAStyleLength;
    FRight: TUniDSAStyleLength;
    FBottom: TUniDSAStyleLength;
    FLeft: TUniDSAStyleLength;
    FInsets: TUniDSAStyleEdges;
    FZIndex: Integer;
    procedure SetMode(const Value: TUniDSAStylePositionMode);
    procedure SetTop(const Value: TUniDSAStyleLength);
    procedure SetRight(const Value: TUniDSAStyleLength);
    procedure SetBottom(const Value: TUniDSAStyleLength);
    procedure SetLeft(const Value: TUniDSAStyleLength);
    procedure SetInsets(const Value: TUniDSAStyleEdges);
    procedure SetZIndex(const Value: Integer);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Mode: TUniDSAStylePositionMode read FMode write SetMode default poInherit;
    property Top: TUniDSAStyleLength read FTop write SetTop;
    property Right: TUniDSAStyleLength read FRight write SetRight;
    property Bottom: TUniDSAStyleLength read FBottom write SetBottom;
    property Left: TUniDSAStyleLength read FLeft write SetLeft;
    property Insets: TUniDSAStyleEdges read FInsets write SetInsets;
    property ZIndex: Integer read FZIndex write SetZIndex default -1000;
  end;

  { Geometry is independent of Typography.Transform (uppercase/lowercase). }
  TUniDSAStyleGeometry = class(TUniDSAStylePersistent)
  private
    FSkewX, FSkewY: Integer;
    procedure SetSkewX(const Value: Integer);
    procedure SetSkewY(const Value: Integer);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property SkewX: Integer read FSkewX write SetSkewX default -1000;
    property SkewY: Integer read FSkewY write SetSkewY default -1000;
  end;

  TUniDSAStyleVisual = class(TUniDSAStylePersistent)
  private
    FDisplay: TUniDSAStyleDisplay;
    FTransform: TUniDSAStyleGeometry;
    FBackground: TUniDSAStyleBackground;
    FBorder: TUniDSAStyleBorder;
    FTypography: TUniDSAStyleTypography;
    FSpacing: TUniDSAStyleSpacing;
    FSizing: TUniDSAStyleSizing;
    FShadow: TUniDSAStyleShadow;
    FEffects: TUniDSAStyleEffects;
    FPosition: TUniDSAStylePosition;
    procedure SetDisplay(const Value: TUniDSAStyleDisplay);
    procedure SetTransform(const Value: TUniDSAStyleGeometry);
    procedure SetBackground(const Value: TUniDSAStyleBackground);
    procedure SetBorder(const Value: TUniDSAStyleBorder);
    procedure SetTypography(const Value: TUniDSAStyleTypography);
    procedure SetSpacing(const Value: TUniDSAStyleSpacing);
    procedure SetSizing(const Value: TUniDSAStyleSizing);
    procedure SetShadow(const Value: TUniDSAStyleShadow);
    procedure SetEffects(const Value: TUniDSAStyleEffects);
    procedure SetPosition(const Value: TUniDSAStylePosition);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject; virtual;
  published
    property Display: TUniDSAStyleDisplay read FDisplay write SetDisplay default sdInherit;
    property Transform: TUniDSAStyleGeometry read FTransform write SetTransform;
    property Background: TUniDSAStyleBackground read FBackground write SetBackground;
    property Border: TUniDSAStyleBorder read FBorder write SetBorder;
    property Typography: TUniDSAStyleTypography read FTypography write SetTypography;
    property Spacing: TUniDSAStyleSpacing read FSpacing write SetSpacing;
    property Sizing: TUniDSAStyleSizing read FSizing write SetSizing;
    property Shadow: TUniDSAStyleShadow read FShadow write SetShadow;
    property Effects: TUniDSAStyleEffects read FEffects write SetEffects;
    property Position: TUniDSAStylePosition read FPosition write SetPosition;
  end;

  TUniDSAStylePseudoElement = class(TUniDSAStyleVisual)
  private
    FEnabled: TUniDSAStyleSwitch;
    FText: string;
    procedure SetEnabled(const Value: TUniDSAStyleSwitch);
    procedure SetText(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject; override;
  published
    property Enabled: TUniDSAStyleSwitch read FEnabled write SetEnabled default ssInherit;
    property Text: string read FText write SetText;
  end;

  TUniDSAStyleAppearance = class(TUniDSAStyleVisual)
  private
    FScrollbar: TUniDSAStyleScrollbar;
    FContent: TUniDSAStyleVisual;
    FBefore, FAfter: TUniDSAStylePseudoElement;
    procedure SetScrollbar(const Value: TUniDSAStyleScrollbar);
    procedure SetContent(const Value: TUniDSAStyleVisual);
    procedure SetBefore(const Value: TUniDSAStylePseudoElement);
    procedure SetAfter(const Value: TUniDSAStylePseudoElement);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject; override;
  published
    property Scrollbar: TUniDSAStyleScrollbar read FScrollbar write SetScrollbar;
    property Content: TUniDSAStyleVisual read FContent write SetContent;
    property Before: TUniDSAStylePseudoElement read FBefore write SetBefore;
    property After: TUniDSAStylePseudoElement read FAfter write SetAfter;
  end;

  TUniDSAStyleStates = class(TUniDSAStylePersistent)
  private
    FHover: TUniDSAStyleAppearance;
    FFocus: TUniDSAStyleAppearance;
    FPressed: TUniDSAStyleAppearance;
    FDisabled: TUniDSAStyleAppearance;
    FSelected: TUniDSAStyleAppearance;
    procedure SetHover(const Value: TUniDSAStyleAppearance);
    procedure SetFocus(const Value: TUniDSAStyleAppearance);
    procedure SetPressed(const Value: TUniDSAStyleAppearance);
    procedure SetDisabled(const Value: TUniDSAStyleAppearance);
    procedure SetSelected(const Value: TUniDSAStyleAppearance);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Hover: TUniDSAStyleAppearance read FHover write SetHover;
    property Focus: TUniDSAStyleAppearance read FFocus write SetFocus;
    property Pressed: TUniDSAStyleAppearance read FPressed write SetPressed;
    property Disabled: TUniDSAStyleAppearance read FDisabled write SetDisabled;
    property Selected: TUniDSAStyleAppearance read FSelected write SetSelected;
  end;


  TUniDSAStyleBreakpoint = class(TCollectionItem)
  private
    FOrientation: TUniDSAStyleOrientation;
    FAppearance: TUniDSAStyleAppearance;
    FStates: TUniDSAStyleStates;
    FMinWidth, FMaxWidth: Integer;
    procedure ChildChanged(Sender: TObject);
    procedure SetMinWidth(Value: Integer);
    procedure SetMaxWidth(Value: Integer);
    procedure SetOrientation(Value: TUniDSAStyleOrientation);
    procedure SetAppearance(Value: TUniDSAStyleAppearance);
    procedure SetStates(Value: TUniDSAStyleStates);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property MinWidth: Integer read FMinWidth write SetMinWidth default 0;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 0;
    property Orientation: TUniDSAStyleOrientation read FOrientation write SetOrientation default orAny;
    property Appearance: TUniDSAStyleAppearance read FAppearance write SetAppearance;
    property States: TUniDSAStyleStates read FStates write SetStates;
  end;

  TUniDSAStyleBreakpoints = class(TOwnedCollection)
  private
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TUniDSAStyleBreakpoint;
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent; AOnChange: TNotifyEvent);
    function Add: TUniDSAStyleBreakpoint;
    function ToJSON: TJSONArray;
    property Items[Index: Integer]: TUniDSAStyleBreakpoint read GetItem; default;
  end;

  TUniDSAStyleRule = class(TUniDSAStylePersistent)
  private
    FAppearance: TUniDSAStyleAppearance;
    FStates: TUniDSAStyleStates;
    FResponsive: TUniDSAStyleBreakpoints;
    procedure SetAppearance(Value: TUniDSAStyleAppearance);
    procedure SetStates(Value: TUniDSAStyleStates);
    procedure SetResponsive(Value: TUniDSAStyleBreakpoints);
  public
    constructor Create(AOnChange: TNotifyEvent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ToJSON: TJSONObject;
  published
    property Appearance: TUniDSAStyleAppearance read FAppearance write SetAppearance;
    property States: TUniDSAStyleStates read FStates write SetStates;
    property Responsive: TUniDSAStyleBreakpoints read FResponsive write SetResponsive;
  end;

  TUniDSANamedStyle = class(TCollectionItem)
  private
    FName: string;
    FRule: TUniDSAStyleRule;
    procedure ChildChanged(Sender: TObject);
    procedure SetName(const Value: string);
    function GetAppearance: TUniDSAStyleAppearance;
    function GetStates: TUniDSAStyleStates;
    function GetResponsive: TUniDSAStyleBreakpoints;
    procedure SetAppearance(Value: TUniDSAStyleAppearance);
    procedure SetStates(Value: TUniDSAStyleStates);
    procedure SetResponsive(Value: TUniDSAStyleBreakpoints);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Rule: TUniDSAStyleRule read FRule;
  published
    property Name: string read FName write SetName;
    property Appearance: TUniDSAStyleAppearance read GetAppearance write SetAppearance;
    property States: TUniDSAStyleStates read GetStates write SetStates;
    property Responsive: TUniDSAStyleBreakpoints read GetResponsive write SetResponsive;
  end;

  TUniDSAStyleItem = class(TUniDSANamedStyle)
  private
    FControl: TComponent;
    FStyleName: string;
    FEnabled, FSelected: Boolean;
    procedure SetControl(Value: TComponent);
    procedure SetStyleName(const Value: string);
    procedure SetEnabled(Value: Boolean);
    procedure SetSelected(Value: Boolean);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Control: TComponent read FControl write SetControl;
    property StyleName: string read FStyleName write SetStyleName;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Selected: Boolean read FSelected write SetSelected default False;
  end;

  TUniDSANamedStyles = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TUniDSANamedStyle;
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TUniDSAStyle);
    function Add: TUniDSANamedStyle;
    function Find(const AName: string): TUniDSANamedStyle;
    property Items[Index: Integer]: TUniDSANamedStyle read GetItem; default;
  end;

  TUniDSAStyleItems = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TUniDSAStyleItem;
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TUniDSAStyle);
    function Add: TUniDSAStyleItem;
    function FindByControl(AControl: TComponent): TUniDSAStyleItem;
    property Items[Index: Integer]: TUniDSAStyleItem read GetItem; default;
  end;

  TUniDSAStyle = class(TUniDSABaseComponent)
  private
    FStyles: TUniDSANamedStyles;
    FStyleItems: TUniDSAStyleItems;
    FDefaults: TUniDSAStyleRule;
    FTargetContainer: TComponent;
    FUpdateCount: Integer;
    FDirty: Boolean;
    FIncludeChildren, FEnabled, FReady: Boolean;
    procedure ChildChanged(Sender: TObject);
    procedure SetStyles(Value: TUniDSANamedStyles);
    procedure SetStyleItems(Value: TUniDSAStyleItems);
    procedure SetDefaults(Value: TUniDSAStyleRule);
    procedure SetTargetContainer(Value: TComponent);
    procedure SetIncludeChildren(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    function BuildConfig: string;
  protected
    procedure LoadCompleted; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Apply;
    procedure Validate;
    class function SupportsControl(AControl: TComponent): Boolean; static;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Styles: TUniDSANamedStyles read FStyles write SetStyles;
    property StyleItems: TUniDSAStyleItems read FStyleItems write SetStyleItems;
    property Defaults: TUniDSAStyleRule read FDefaults write SetDefaults;
    property TargetContainer: TComponent read FTargetContainer write SetTargetContainer;
    property IncludeChildren: Boolean read FIncludeChildren write SetIncludeChildren default False;
  end;

procedure Register;

implementation

uses UniDSAWebUtils;

{$I UniDSAStyleRuntime.inc}

procedure Register;
begin
  RegisterComponents('UniDSA', [TUniDSAStyle]);
end;

constructor TUniDSAStylePersistent.Create(AOnChange: TNotifyEvent);
begin
  inherited Create;
  FOnChange := AOnChange;
end;

procedure TUniDSAStylePersistent.Changed;
begin
  FDirty := True;
  if FUpdateCount > 0 then Exit;
  FDirty := False;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TUniDSAStylePersistent.ChildChanged(Sender: TObject);
begin
  Changed;
end;

procedure TUniDSAStylePersistent.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TUniDSAStylePersistent.EndUpdate;
begin
  if FUpdateCount = 0 then Exit;
  Dec(FUpdateCount);
  if FDirty and (FUpdateCount = 0) then Changed;
end;

constructor TUniDSAStyleLength.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FValue := 0;
  FUnits := suUnset;
end;

procedure TUniDSAStyleLength.Assign(Source: TPersistent);
var S: TUniDSAStyleLength;
begin
  if not (Source is TUniDSAStyleLength) then begin inherited; Exit; end;
  S := TUniDSAStyleLength(Source);
  BeginUpdate;
  try
    FValue := S.FValue;
    FUnits := S.FUnits;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleLength.SetValue(const Value: Double);
begin
  if FValue = Value then Exit;
  FValue := Value;
  Changed;
end;

procedure TUniDSAStyleLength.SetUnits(const Value: TUniDSAStyleUnit);
begin
  if FUnits = Value then Exit;
  FUnits := Value;
  Changed;
end;

function TUniDSAStyleLength.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('Value', TJSONNumber.Create(FValue));
  Result.AddPair('Units', TJSONNumber.Create(Ord(FUnits)));
end;

constructor TUniDSAStyleEdges.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FAll := -1;
  FLeft := -1;
  FTop := -1;
  FRight := -1;
  FBottom := -1;
end;

procedure TUniDSAStyleEdges.Assign(Source: TPersistent);
var S: TUniDSAStyleEdges;
begin
  if not (Source is TUniDSAStyleEdges) then begin inherited; Exit; end;
  S := TUniDSAStyleEdges(Source);
  BeginUpdate;
  try
    FAll := S.FAll;
    FLeft := S.FLeft;
    FTop := S.FTop;
    FRight := S.FRight;
    FBottom := S.FBottom;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleEdges.SetAll(const Value: Integer);
begin
  if FAll = Value then Exit;
  FAll := Value;
  Changed;
end;

procedure TUniDSAStyleEdges.SetLeft(const Value: Integer);
begin
  if FLeft = Value then Exit;
  FLeft := Value;
  Changed;
end;

procedure TUniDSAStyleEdges.SetTop(const Value: Integer);
begin
  if FTop = Value then Exit;
  FTop := Value;
  Changed;
end;

procedure TUniDSAStyleEdges.SetRight(const Value: Integer);
begin
  if FRight = Value then Exit;
  FRight := Value;
  Changed;
end;

procedure TUniDSAStyleEdges.SetBottom(const Value: Integer);
begin
  if FBottom = Value then Exit;
  FBottom := Value;
  Changed;
end;

function TUniDSAStyleEdges.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FAll <> -1 then Result.AddPair('All', TJSONNumber.Create(FAll));
  if FLeft <> -1 then Result.AddPair('Left', TJSONNumber.Create(FLeft));
  if FTop <> -1 then Result.AddPair('Top', TJSONNumber.Create(FTop));
  if FRight <> -1 then Result.AddPair('Right', TJSONNumber.Create(FRight));
  if FBottom <> -1 then Result.AddPair('Bottom', TJSONNumber.Create(FBottom));
end;

constructor TUniDSAStyleBorderEdge.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FWidth := -1;
  FColor := clNone;
  FLine := blInherit;
end;

procedure TUniDSAStyleBorderEdge.Assign(Source: TPersistent);
var S: TUniDSAStyleBorderEdge;
begin
  if not (Source is TUniDSAStyleBorderEdge) then begin inherited; Exit; end;
  S := TUniDSAStyleBorderEdge(Source);
  BeginUpdate;
  try
    FWidth := S.FWidth;
    FColor := S.FColor;
    FLine := S.FLine;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleBorderEdge.SetWidth(const Value: Integer);
begin
  if FWidth = Value then Exit;
  FWidth := Value;
  Changed;
end;

procedure TUniDSAStyleBorderEdge.SetColor(const Value: TColor);
begin
  if FColor = Value then Exit;
  FColor := Value;
  Changed;
end;

procedure TUniDSAStyleBorderEdge.SetLine(const Value: TUniDSAStyleBorderLine);
begin
  if FLine = Value then Exit;
  FLine := Value;
  Changed;
end;

function TUniDSAStyleBorderEdge.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FWidth <> -1 then Result.AddPair('Width', TJSONNumber.Create(FWidth));
  if FColor <> clNone then Result.AddPair('Color', UniDSAColorToCSS(FColor));
  if FLine <> blInherit then Result.AddPair('Line', TJSONNumber.Create(Ord(FLine)));
end;

constructor TUniDSAStyleBackground.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FColor := clNone;
  FOpacity := -1;
  FImageURL := '';
  FImageSize := isInherit;
  FRepeatMode := srInherit;
  FPattern := spInherit;
  FPatternColor := clNone;
  FPatternSize := -1;
  FGradient := sgInherit;
  FGradientColor := clNone;
  FGradientAngle := -1000;
end;

procedure TUniDSAStyleBackground.Assign(Source: TPersistent);
var S: TUniDSAStyleBackground;
begin
  if not (Source is TUniDSAStyleBackground) then begin inherited; Exit; end;
  S := TUniDSAStyleBackground(Source);
  BeginUpdate;
  try
    FColor := S.FColor;
    FOpacity := S.FOpacity;
    FImageURL := S.FImageURL;
    FImageSize := S.FImageSize;
    FRepeatMode := S.FRepeatMode;
    FPattern := S.FPattern;
    FPatternColor := S.FPatternColor;
    FPatternSize := S.FPatternSize;
    FGradient := S.FGradient;
    FGradientColor := S.FGradientColor;
    FGradientAngle := S.FGradientAngle;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleBackground.SetColor(const Value: TColor);
begin
  if FColor = Value then Exit;
  FColor := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetOpacity(const Value: Integer);
begin
  if FOpacity = Value then Exit;
  FOpacity := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetImageURL(const Value: string);
begin
  if FImageURL = Value then Exit;
  FImageURL := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetImageSize(const Value: TUniDSAStyleImageSize);
begin
  if FImageSize = Value then Exit;
  FImageSize := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetRepeatMode(const Value: TUniDSAStyleRepeat);
begin
  if FRepeatMode = Value then Exit;
  FRepeatMode := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetPattern(const Value: TUniDSAStylePattern);
begin
  if FPattern = Value then Exit;
  FPattern := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetPatternColor(const Value: TColor);
begin
  if FPatternColor = Value then Exit;
  FPatternColor := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetPatternSize(const Value: Integer);
begin
  if FPatternSize = Value then Exit;
  FPatternSize := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetGradient(const Value: TUniDSAStyleGradient);
begin
  if FGradient = Value then Exit;
  FGradient := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetGradientColor(const Value: TColor);
begin
  if FGradientColor = Value then Exit;
  FGradientColor := Value;
  Changed;
end;

procedure TUniDSAStyleBackground.SetGradientAngle(const Value: Integer);
begin
  if FGradientAngle = Value then Exit;
  FGradientAngle := Value;
  Changed;
end;

function TUniDSAStyleBackground.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FColor <> clNone then Result.AddPair('Color', UniDSAColorToCSS(FColor));
  if FOpacity <> -1 then Result.AddPair('Opacity', TJSONNumber.Create(FOpacity));
  if FImageURL <> '' then Result.AddPair('ImageURL', FImageURL);
  if FImageSize <> isInherit then Result.AddPair('ImageSize', TJSONNumber.Create(Ord(FImageSize)));
  if FRepeatMode <> srInherit then Result.AddPair('RepeatMode', TJSONNumber.Create(Ord(FRepeatMode)));
  if FPattern <> spInherit then Result.AddPair('Pattern', TJSONNumber.Create(Ord(FPattern)));
  if FPatternColor <> clNone then Result.AddPair('PatternColor', UniDSAColorToCSS(FPatternColor));
  if FPatternSize <> -1 then Result.AddPair('PatternSize', TJSONNumber.Create(FPatternSize));
  if FGradient <> sgInherit then Result.AddPair('Gradient', TJSONNumber.Create(Ord(FGradient)));
  if FGradientColor <> clNone then Result.AddPair('GradientColor', UniDSAColorToCSS(FGradientColor));
  if FGradientAngle <> -1000 then Result.AddPair('GradientAngle', TJSONNumber.Create(FGradientAngle));
end;

constructor TUniDSAStyleBorder.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FWidth := -1;
  FColor := clNone;
  FLine := blInherit;
  FRadius := -1;
  FTopLeftRadius := -1;
  FTopRightRadius := -1;
  FBottomLeftRadius := -1;
  FBottomRightRadius := -1;
  FTop := TUniDSAStyleBorderEdge.Create(ChildChanged);
  FRight := TUniDSAStyleBorderEdge.Create(ChildChanged);
  FBottom := TUniDSAStyleBorderEdge.Create(ChildChanged);
  FLeft := TUniDSAStyleBorderEdge.Create(ChildChanged);
end;

destructor TUniDSAStyleBorder.Destroy;
begin
  FTop.Free;
  FRight.Free;
  FBottom.Free;
  FLeft.Free;
  inherited;
end;

procedure TUniDSAStyleBorder.Assign(Source: TPersistent);
var S: TUniDSAStyleBorder;
begin
  if not (Source is TUniDSAStyleBorder) then begin inherited; Exit; end;
  S := TUniDSAStyleBorder(Source);
  BeginUpdate;
  try
    FWidth := S.FWidth;
    FColor := S.FColor;
    FLine := S.FLine;
    FRadius := S.FRadius;
    FTopLeftRadius := S.FTopLeftRadius;
    FTopRightRadius := S.FTopRightRadius;
    FBottomLeftRadius := S.FBottomLeftRadius;
    FBottomRightRadius := S.FBottomRightRadius;
    FTop.Assign(S.FTop);
    FRight.Assign(S.FRight);
    FBottom.Assign(S.FBottom);
    FLeft.Assign(S.FLeft);
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleBorder.SetWidth(const Value: Integer);
begin
  if FWidth = Value then Exit;
  FWidth := Value;
  Changed;
end;

procedure TUniDSAStyleBorder.SetColor(const Value: TColor);
begin
  if FColor = Value then Exit;
  FColor := Value;
  Changed;
end;

procedure TUniDSAStyleBorder.SetLine(const Value: TUniDSAStyleBorderLine);
begin
  if FLine = Value then Exit;
  FLine := Value;
  Changed;
end;

procedure TUniDSAStyleBorder.SetRadius(const Value: Integer);
begin
  if FRadius = Value then Exit;
  FRadius := Value;
  Changed;
end;

procedure TUniDSAStyleBorder.SetTopLeftRadius(const Value: Integer);
begin
  if FTopLeftRadius = Value then Exit;
  FTopLeftRadius := Value;
  Changed;
end;

procedure TUniDSAStyleBorder.SetTopRightRadius(const Value: Integer);
begin
  if FTopRightRadius = Value then Exit;
  FTopRightRadius := Value;
  Changed;
end;

procedure TUniDSAStyleBorder.SetBottomLeftRadius(const Value: Integer);
begin
  if FBottomLeftRadius = Value then Exit;
  FBottomLeftRadius := Value;
  Changed;
end;

procedure TUniDSAStyleBorder.SetBottomRightRadius(const Value: Integer);
begin
  if FBottomRightRadius = Value then Exit;
  FBottomRightRadius := Value;
  Changed;
end;

procedure TUniDSAStyleBorder.SetTop(const Value: TUniDSAStyleBorderEdge);
begin
  if Assigned(Value) then FTop.Assign(Value);
end;

procedure TUniDSAStyleBorder.SetRight(const Value: TUniDSAStyleBorderEdge);
begin
  if Assigned(Value) then FRight.Assign(Value);
end;

procedure TUniDSAStyleBorder.SetBottom(const Value: TUniDSAStyleBorderEdge);
begin
  if Assigned(Value) then FBottom.Assign(Value);
end;

procedure TUniDSAStyleBorder.SetLeft(const Value: TUniDSAStyleBorderEdge);
begin
  if Assigned(Value) then FLeft.Assign(Value);
end;

function TUniDSAStyleBorder.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FWidth <> -1 then Result.AddPair('Width', TJSONNumber.Create(FWidth));
  if FColor <> clNone then Result.AddPair('Color', UniDSAColorToCSS(FColor));
  if FLine <> blInherit then Result.AddPair('Line', TJSONNumber.Create(Ord(FLine)));
  if FRadius <> -1 then Result.AddPair('Radius', TJSONNumber.Create(FRadius));
  if FTopLeftRadius <> -1 then Result.AddPair('TopLeftRadius', TJSONNumber.Create(FTopLeftRadius));
  if FTopRightRadius <> -1 then Result.AddPair('TopRightRadius', TJSONNumber.Create(FTopRightRadius));
  if FBottomLeftRadius <> -1 then Result.AddPair('BottomLeftRadius', TJSONNumber.Create(FBottomLeftRadius));
  if FBottomRightRadius <> -1 then Result.AddPair('BottomRightRadius', TJSONNumber.Create(FBottomRightRadius));
  Result.AddPair('Top', FTop.ToJSON);
  Result.AddPair('Right', FRight.ToJSON);
  Result.AddPair('Bottom', FBottom.ToJSON);
  Result.AddPair('Left', FLeft.ToJSON);
end;

constructor TUniDSAStyleTypography.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FFamily := '';
  FColor := clNone;
  FSize := -1;
  FWeight := swInherit;
  FItalic := ssInherit;
  FAlignment := saInherit;
  FLineHeight := -1;
  FLetterSpacing := -1000;
  FWhiteSpace := wsInherit;
  FTextOverflow := toInherit;
  FWrapAnywhere := ssInherit;
  FTransform := ttInherit;
  FDecoration := tdInherit;
end;

procedure TUniDSAStyleTypography.Assign(Source: TPersistent);
var S: TUniDSAStyleTypography;
begin
  if not (Source is TUniDSAStyleTypography) then begin inherited; Exit; end;
  S := TUniDSAStyleTypography(Source);
  BeginUpdate;
  try
    FFamily := S.FFamily;
    FColor := S.FColor;
    FSize := S.FSize;
    FWeight := S.FWeight;
    FItalic := S.FItalic;
    FAlignment := S.FAlignment;
    FLineHeight := S.FLineHeight;
    FLetterSpacing := S.FLetterSpacing;
    FWhiteSpace := S.FWhiteSpace;
    FTextOverflow := S.FTextOverflow;
    FWrapAnywhere := S.FWrapAnywhere;
    FTransform := S.FTransform;
    FDecoration := S.FDecoration;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleTypography.SetFamily(const Value: string);
begin
  if FFamily = Value then Exit;
  FFamily := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetColor(const Value: TColor);
begin
  if FColor = Value then Exit;
  FColor := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetSize(const Value: Integer);
begin
  if FSize = Value then Exit;
  FSize := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetWeight(const Value: TUniDSAStyleWeight);
begin
  if FWeight = Value then Exit;
  FWeight := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetItalic(const Value: TUniDSAStyleSwitch);
begin
  if FItalic = Value then Exit;
  FItalic := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetAlignment(const Value: TUniDSAStyleAlign);
begin
  if FAlignment = Value then Exit;
  FAlignment := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetLineHeight(const Value: Double);
begin
  if FLineHeight = Value then Exit;
  FLineHeight := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetLetterSpacing(const Value: Double);
begin
  if FLetterSpacing = Value then Exit;
  FLetterSpacing := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetWhiteSpace(const Value: TUniDSAStyleWhiteSpace);
begin
  if FWhiteSpace = Value then Exit;
  FWhiteSpace := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetTextOverflow(const Value: TUniDSAStyleTextOverflow);
begin
  if FTextOverflow = Value then Exit;
  FTextOverflow := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetWrapAnywhere(const Value: TUniDSAStyleSwitch);
begin
  if FWrapAnywhere = Value then Exit;
  FWrapAnywhere := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetTransform(const Value: TUniDSAStyleTransform);
begin
  if FTransform = Value then Exit;
  FTransform := Value;
  Changed;
end;

procedure TUniDSAStyleTypography.SetDecoration(const Value: TUniDSAStyleDecoration);
begin
  if FDecoration = Value then Exit;
  FDecoration := Value;
  Changed;
end;

function TUniDSAStyleTypography.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FFamily <> '' then Result.AddPair('Family', FFamily);
  if FColor <> clNone then Result.AddPair('Color', UniDSAColorToCSS(FColor));
  if FSize <> -1 then Result.AddPair('Size', TJSONNumber.Create(FSize));
  if FWeight <> swInherit then Result.AddPair('Weight', TJSONNumber.Create(Ord(FWeight)));
  if FItalic <> ssInherit then Result.AddPair('Italic', TJSONNumber.Create(Ord(FItalic)));
  if FAlignment <> saInherit then Result.AddPair('Alignment', TJSONNumber.Create(Ord(FAlignment)));
  if FLineHeight <> -1 then Result.AddPair('LineHeight', TJSONNumber.Create(FLineHeight));
  if FLetterSpacing <> -1000 then Result.AddPair('LetterSpacing', TJSONNumber.Create(FLetterSpacing));
  if FWhiteSpace <> wsInherit then Result.AddPair('WhiteSpace', TJSONNumber.Create(Ord(FWhiteSpace)));
  if FTextOverflow <> toInherit then Result.AddPair('TextOverflow', TJSONNumber.Create(Ord(FTextOverflow)));
  if FWrapAnywhere <> ssInherit then Result.AddPair('WrapAnywhere', TJSONNumber.Create(Ord(FWrapAnywhere)));
  if FTransform <> ttInherit then Result.AddPair('Transform', TJSONNumber.Create(Ord(FTransform)));
  if FDecoration <> tdInherit then Result.AddPair('Decoration', TJSONNumber.Create(Ord(FDecoration)));
end;

constructor TUniDSAStyleSpacing.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FPadding := TUniDSAStyleEdges.Create(ChildChanged);
  FMargin := TUniDSAStyleEdges.Create(ChildChanged);
end;

destructor TUniDSAStyleSpacing.Destroy;
begin
  FPadding.Free;
  FMargin.Free;
  inherited;
end;

procedure TUniDSAStyleSpacing.Assign(Source: TPersistent);
var S: TUniDSAStyleSpacing;
begin
  if not (Source is TUniDSAStyleSpacing) then begin inherited; Exit; end;
  S := TUniDSAStyleSpacing(Source);
  BeginUpdate;
  try
    FPadding.Assign(S.FPadding);
    FMargin.Assign(S.FMargin);
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleSpacing.SetPadding(const Value: TUniDSAStyleEdges);
begin
  if Assigned(Value) then FPadding.Assign(Value);
end;

procedure TUniDSAStyleSpacing.SetMargin(const Value: TUniDSAStyleEdges);
begin
  if Assigned(Value) then FMargin.Assign(Value);
end;

function TUniDSAStyleSpacing.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('Padding', FPadding.ToJSON);
  Result.AddPair('Margin', FMargin.ToJSON);
end;

constructor TUniDSAStyleSizing.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FWidth := TUniDSAStyleLength.Create(ChildChanged);
  FHeight := TUniDSAStyleLength.Create(ChildChanged);
  FMinWidth := TUniDSAStyleLength.Create(ChildChanged);
  FMaxWidth := TUniDSAStyleLength.Create(ChildChanged);
  FMinHeight := TUniDSAStyleLength.Create(ChildChanged);
  FMaxHeight := TUniDSAStyleLength.Create(ChildChanged);
  FMaxWidthPercent := -1;
  FBoxSizing := bsInherit;
  FOverflowX := soInherit;
  FOverflowY := soInherit;
end;

destructor TUniDSAStyleSizing.Destroy;
begin
  FWidth.Free;
  FHeight.Free;
  FMinWidth.Free;
  FMaxWidth.Free;
  FMinHeight.Free;
  FMaxHeight.Free;
  inherited;
end;

procedure TUniDSAStyleSizing.Assign(Source: TPersistent);
var S: TUniDSAStyleSizing;
begin
  if not (Source is TUniDSAStyleSizing) then begin inherited; Exit; end;
  S := TUniDSAStyleSizing(Source);
  BeginUpdate;
  try
    FWidth.Assign(S.FWidth);
    FHeight.Assign(S.FHeight);
    FMinWidth.Assign(S.FMinWidth);
    FMaxWidth.Assign(S.FMaxWidth);
    FMinHeight.Assign(S.FMinHeight);
    FMaxHeight.Assign(S.FMaxHeight);
    FMaxWidthPercent := S.FMaxWidthPercent;
    FBoxSizing := S.FBoxSizing;
    FOverflowX := S.FOverflowX;
    FOverflowY := S.FOverflowY;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleSizing.SetWidth(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FWidth.Assign(Value);
end;

procedure TUniDSAStyleSizing.SetHeight(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FHeight.Assign(Value);
end;

procedure TUniDSAStyleSizing.SetMinWidth(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FMinWidth.Assign(Value);
end;

procedure TUniDSAStyleSizing.SetMaxWidth(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FMaxWidth.Assign(Value);
end;

procedure TUniDSAStyleSizing.SetMinHeight(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FMinHeight.Assign(Value);
end;

procedure TUniDSAStyleSizing.SetMaxHeight(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FMaxHeight.Assign(Value);
end;

procedure TUniDSAStyleSizing.SetMaxWidthPercent(const Value: Integer);
begin
  if FMaxWidthPercent = Value then Exit;
  FMaxWidthPercent := Value;
  Changed;
end;

procedure TUniDSAStyleSizing.SetBoxSizing(const Value: TUniDSAStyleBoxSizing);
begin
  if FBoxSizing = Value then Exit;
  FBoxSizing := Value;
  Changed;
end;

procedure TUniDSAStyleSizing.SetOverflowX(const Value: TUniDSAStyleOverflow);
begin
  if FOverflowX = Value then Exit;
  FOverflowX := Value;
  Changed;
end;

procedure TUniDSAStyleSizing.SetOverflowY(const Value: TUniDSAStyleOverflow);
begin
  if FOverflowY = Value then Exit;
  FOverflowY := Value;
  Changed;
end;

function TUniDSAStyleSizing.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('Width', FWidth.ToJSON);
  Result.AddPair('Height', FHeight.ToJSON);
  Result.AddPair('MinWidth', FMinWidth.ToJSON);
  Result.AddPair('MaxWidth', FMaxWidth.ToJSON);
  Result.AddPair('MinHeight', FMinHeight.ToJSON);
  Result.AddPair('MaxHeight', FMaxHeight.ToJSON);
  if FMaxWidthPercent <> -1 then Result.AddPair('MaxWidthPercent', TJSONNumber.Create(FMaxWidthPercent));
  if FBoxSizing <> bsInherit then Result.AddPair('BoxSizing', TJSONNumber.Create(Ord(FBoxSizing)));
  if FOverflowX <> soInherit then Result.AddPair('OverflowX', TJSONNumber.Create(Ord(FOverflowX)));
  if FOverflowY <> soInherit then Result.AddPair('OverflowY', TJSONNumber.Create(Ord(FOverflowY)));
end;

constructor TUniDSAStyleScrollbar.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FVisible := ssInherit;
  FSize := -1;
  FTrackColor := clNone;
  FThumbColor := clNone;
  FThumbHoverColor := clNone;
  FRadius := -1;
end;

procedure TUniDSAStyleScrollbar.Assign(Source: TPersistent);
var
  S: TUniDSAStyleScrollbar;
begin
  if not (Source is TUniDSAStyleScrollbar) then
  begin
    inherited;
    Exit;
  end;
  S := TUniDSAStyleScrollbar(Source);
  BeginUpdate;
  try
    FVisible := S.FVisible;
    FSize := S.FSize;
    FTrackColor := S.FTrackColor;
    FThumbColor := S.FThumbColor;
    FThumbHoverColor := S.FThumbHoverColor;
    FRadius := S.FRadius;
    Changed;
  finally
    EndUpdate;
  end;
end;

procedure TUniDSAStyleScrollbar.SetVisible(const Value: TUniDSAStyleSwitch);
begin
  if FVisible = Value then Exit;
  FVisible := Value;
  Changed;
end;

procedure TUniDSAStyleScrollbar.SetSize(const Value: Integer);
begin
  if FSize = Value then Exit;
  FSize := Value;
  Changed;
end;

procedure TUniDSAStyleScrollbar.SetTrackColor(const Value: TColor);
begin
  if FTrackColor = Value then Exit;
  FTrackColor := Value;
  Changed;
end;

procedure TUniDSAStyleScrollbar.SetThumbColor(const Value: TColor);
begin
  if FThumbColor = Value then Exit;
  FThumbColor := Value;
  Changed;
end;

procedure TUniDSAStyleScrollbar.SetThumbHoverColor(const Value: TColor);
begin
  if FThumbHoverColor = Value then Exit;
  FThumbHoverColor := Value;
  Changed;
end;

procedure TUniDSAStyleScrollbar.SetRadius(const Value: Integer);
begin
  if FRadius = Value then Exit;
  FRadius := Value;
  Changed;
end;

function TUniDSAStyleScrollbar.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FVisible <> ssInherit then
    Result.AddPair('Visible', TJSONNumber.Create(Ord(FVisible)));
  if FSize <> -1 then
    Result.AddPair('Size', TJSONNumber.Create(FSize));
  if FTrackColor <> clNone then
    Result.AddPair('TrackColor', UniDSAColorToCSS(FTrackColor));
  if FThumbColor <> clNone then
    Result.AddPair('ThumbColor', UniDSAColorToCSS(FThumbColor));
  if FThumbHoverColor <> clNone then
    Result.AddPair('ThumbHoverColor', UniDSAColorToCSS(FThumbHoverColor));
  if FRadius <> -1 then
    Result.AddPair('Radius', TJSONNumber.Create(FRadius));
end;

constructor TUniDSAStyleShadow.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FEnabled := ssInherit;
  FColor := clNone;
  FOpacity := -1;
  FOffsetX := -1000;
  FOffsetY := -1000;
  FBlur := -1;
  FSpread := -1000;
  FInset := ssInherit;
end;

procedure TUniDSAStyleShadow.Assign(Source: TPersistent);
var S: TUniDSAStyleShadow;
begin
  if not (Source is TUniDSAStyleShadow) then begin inherited; Exit; end;
  S := TUniDSAStyleShadow(Source);
  BeginUpdate;
  try
    FEnabled := S.FEnabled;
    FColor := S.FColor;
    FOpacity := S.FOpacity;
    FOffsetX := S.FOffsetX;
    FOffsetY := S.FOffsetY;
    FBlur := S.FBlur;
    FSpread := S.FSpread;
    FInset := S.FInset;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleShadow.SetEnabled(const Value: TUniDSAStyleSwitch);
begin
  if FEnabled = Value then Exit;
  FEnabled := Value;
  Changed;
end;

procedure TUniDSAStyleShadow.SetColor(const Value: TColor);
begin
  if FColor = Value then Exit;
  FColor := Value;
  Changed;
end;

procedure TUniDSAStyleShadow.SetOpacity(const Value: Integer);
begin
  if FOpacity = Value then Exit;
  FOpacity := Value;
  Changed;
end;

procedure TUniDSAStyleShadow.SetOffsetX(const Value: Integer);
begin
  if FOffsetX = Value then Exit;
  FOffsetX := Value;
  Changed;
end;

procedure TUniDSAStyleShadow.SetOffsetY(const Value: Integer);
begin
  if FOffsetY = Value then Exit;
  FOffsetY := Value;
  Changed;
end;

procedure TUniDSAStyleShadow.SetBlur(const Value: Integer);
begin
  if FBlur = Value then Exit;
  FBlur := Value;
  Changed;
end;

procedure TUniDSAStyleShadow.SetSpread(const Value: Integer);
begin
  if FSpread = Value then Exit;
  FSpread := Value;
  Changed;
end;

procedure TUniDSAStyleShadow.SetInset(const Value: TUniDSAStyleSwitch);
begin
  if FInset = Value then Exit;
  FInset := Value;
  Changed;
end;

function TUniDSAStyleShadow.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FEnabled <> ssInherit then Result.AddPair('Enabled', TJSONNumber.Create(Ord(FEnabled)));
  if FColor <> clNone then Result.AddPair('Color', UniDSAColorToCSS(FColor));
  if FOpacity <> -1 then Result.AddPair('Opacity', TJSONNumber.Create(FOpacity));
  if FOffsetX <> -1000 then Result.AddPair('OffsetX', TJSONNumber.Create(FOffsetX));
  if FOffsetY <> -1000 then Result.AddPair('OffsetY', TJSONNumber.Create(FOffsetY));
  if FBlur <> -1 then Result.AddPair('Blur', TJSONNumber.Create(FBlur));
  if FSpread <> -1000 then Result.AddPair('Spread', TJSONNumber.Create(FSpread));
  if FInset <> ssInherit then Result.AddPair('Inset', TJSONNumber.Create(Ord(FInset)));
end;

constructor TUniDSAStyleEffects.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FOpacity := -1;
  FCursor := scInherit;
  FTransitionMs := -1;
  FTransitionAll := ssInherit;
  FOutlineWidth := -1;
  FOutlineColor := clNone;
  FOutlineOffset := -1000;
end;

procedure TUniDSAStyleEffects.Assign(Source: TPersistent);
var S: TUniDSAStyleEffects;
begin
  if not (Source is TUniDSAStyleEffects) then begin inherited; Exit; end;
  S := TUniDSAStyleEffects(Source);
  BeginUpdate;
  try
    FOpacity := S.FOpacity;
    FCursor := S.FCursor;
    FTransitionMs := S.FTransitionMs;
    FTransitionAll := S.FTransitionAll;
    FOutlineWidth := S.FOutlineWidth;
    FOutlineColor := S.FOutlineColor;
    FOutlineOffset := S.FOutlineOffset;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleEffects.SetOpacity(const Value: Integer);
begin
  if FOpacity = Value then Exit;
  FOpacity := Value;
  Changed;
end;

procedure TUniDSAStyleEffects.SetCursor(const Value: TUniDSAStyleCursor);
begin
  if FCursor = Value then Exit;
  FCursor := Value;
  Changed;
end;

procedure TUniDSAStyleEffects.SetTransitionAll(const Value: TUniDSAStyleSwitch);
begin
  if FTransitionAll = Value then Exit;
  FTransitionAll := Value;
  Changed;
end;

procedure TUniDSAStyleEffects.SetTransitionMs(const Value: Integer);
begin
  if FTransitionMs = Value then Exit;
  FTransitionMs := Value;
  Changed;
end;

procedure TUniDSAStyleEffects.SetOutlineWidth(const Value: Integer);
begin
  if FOutlineWidth = Value then Exit;
  FOutlineWidth := Value;
  Changed;
end;

procedure TUniDSAStyleEffects.SetOutlineColor(const Value: TColor);
begin
  if FOutlineColor = Value then Exit;
  FOutlineColor := Value;
  Changed;
end;

procedure TUniDSAStyleEffects.SetOutlineOffset(const Value: Integer);
begin
  if FOutlineOffset = Value then Exit;
  FOutlineOffset := Value;
  Changed;
end;

function TUniDSAStyleEffects.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FOpacity <> -1 then Result.AddPair('Opacity', TJSONNumber.Create(FOpacity));
  if FCursor <> scInherit then Result.AddPair('Cursor', TJSONNumber.Create(Ord(FCursor)));
  if FTransitionAll <> ssInherit then Result.AddPair('TransitionAll', TJSONNumber.Create(Ord(FTransitionAll)));
  if FTransitionMs <> -1 then Result.AddPair('TransitionMs', TJSONNumber.Create(FTransitionMs));
  if FOutlineWidth <> -1 then Result.AddPair('OutlineWidth', TJSONNumber.Create(FOutlineWidth));
  if FOutlineColor <> clNone then Result.AddPair('OutlineColor', UniDSAColorToCSS(FOutlineColor));
  if FOutlineOffset <> -1000 then Result.AddPair('OutlineOffset', TJSONNumber.Create(FOutlineOffset));
end;

constructor TUniDSAStylePosition.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FMode := poInherit;
  FTop := TUniDSAStyleLength.Create(ChildChanged);
  FRight := TUniDSAStyleLength.Create(ChildChanged);
  FBottom := TUniDSAStyleLength.Create(ChildChanged);
  FLeft := TUniDSAStyleLength.Create(ChildChanged);
  FInsets := TUniDSAStyleEdges.Create(ChildChanged);
  FZIndex := -1000;
end;

destructor TUniDSAStylePosition.Destroy;
begin
  FTop.Free;
  FRight.Free;
  FBottom.Free;
  FLeft.Free;
  FInsets.Free;
  inherited;
end;

procedure TUniDSAStylePosition.Assign(Source: TPersistent);
var S: TUniDSAStylePosition;
begin
  if not (Source is TUniDSAStylePosition) then begin inherited; Exit; end;
  S := TUniDSAStylePosition(Source);
  BeginUpdate;
  try
    FMode := S.FMode;
    FTop.Assign(S.FTop);
    FRight.Assign(S.FRight);
    FBottom.Assign(S.FBottom);
    FLeft.Assign(S.FLeft);
    FInsets.Assign(S.FInsets);
    FZIndex := S.FZIndex;
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStylePosition.SetMode(const Value: TUniDSAStylePositionMode);
begin
  if FMode = Value then Exit;
  FMode := Value;
  Changed;
end;

procedure TUniDSAStylePosition.SetTop(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FTop.Assign(Value);
end;

procedure TUniDSAStylePosition.SetRight(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FRight.Assign(Value);
end;

procedure TUniDSAStylePosition.SetBottom(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FBottom.Assign(Value);
end;

procedure TUniDSAStylePosition.SetLeft(const Value: TUniDSAStyleLength);
begin
  if Assigned(Value) then FLeft.Assign(Value);
end;

procedure TUniDSAStylePosition.SetInsets(const Value: TUniDSAStyleEdges);
begin
  if Assigned(Value) then FInsets.Assign(Value);
end;

procedure TUniDSAStylePosition.SetZIndex(const Value: Integer);
begin
  if FZIndex = Value then Exit;
  FZIndex := Value;
  Changed;
end;

function TUniDSAStylePosition.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FMode <> poInherit then Result.AddPair('Mode', TJSONNumber.Create(Ord(FMode)));
  Result.AddPair('Top', FTop.ToJSON);
  Result.AddPair('Right', FRight.ToJSON);
  Result.AddPair('Bottom', FBottom.ToJSON);
  Result.AddPair('Left', FLeft.ToJSON);
  Result.AddPair('Insets', FInsets.ToJSON);
  if FZIndex <> -1000 then Result.AddPair('ZIndex', TJSONNumber.Create(FZIndex));
end;

constructor TUniDSAStyleVisual.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FDisplay := sdInherit;
  FTransform := TUniDSAStyleGeometry.Create(ChildChanged);
  FBackground := TUniDSAStyleBackground.Create(ChildChanged);
  FBorder := TUniDSAStyleBorder.Create(ChildChanged);
  FTypography := TUniDSAStyleTypography.Create(ChildChanged);
  FSpacing := TUniDSAStyleSpacing.Create(ChildChanged);
  FSizing := TUniDSAStyleSizing.Create(ChildChanged);
  FShadow := TUniDSAStyleShadow.Create(ChildChanged);
  FEffects := TUniDSAStyleEffects.Create(ChildChanged);
  FPosition := TUniDSAStylePosition.Create(ChildChanged);
end;

destructor TUniDSAStyleVisual.Destroy;
begin
  FTransform.Free;
  FBackground.Free;
  FBorder.Free;
  FTypography.Free;
  FSpacing.Free;
  FSizing.Free;
  FShadow.Free;
  FEffects.Free;
  FPosition.Free;
  inherited;
end;

procedure TUniDSAStyleVisual.Assign(Source: TPersistent);
var S: TUniDSAStyleVisual;
begin
  if not (Source is TUniDSAStyleVisual) then begin inherited; Exit; end;
  S := TUniDSAStyleVisual(Source);
  BeginUpdate;
  try
    FDisplay := S.FDisplay;
    FTransform.Assign(S.FTransform);
    FBackground.Assign(S.FBackground);
    FBorder.Assign(S.FBorder);
    FTypography.Assign(S.FTypography);
    FSpacing.Assign(S.FSpacing);
    FSizing.Assign(S.FSizing);
    FShadow.Assign(S.FShadow);
    FEffects.Assign(S.FEffects);
    FPosition.Assign(S.FPosition);
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleVisual.SetBackground(const Value: TUniDSAStyleBackground);
begin
  if Assigned(Value) then FBackground.Assign(Value);
end;

procedure TUniDSAStyleVisual.SetBorder(const Value: TUniDSAStyleBorder);
begin
  if Assigned(Value) then FBorder.Assign(Value);
end;

procedure TUniDSAStyleVisual.SetTypography(const Value: TUniDSAStyleTypography);
begin
  if Assigned(Value) then FTypography.Assign(Value);
end;

procedure TUniDSAStyleVisual.SetSpacing(const Value: TUniDSAStyleSpacing);
begin
  if Assigned(Value) then FSpacing.Assign(Value);
end;

procedure TUniDSAStyleVisual.SetSizing(const Value: TUniDSAStyleSizing);
begin
  if Assigned(Value) then FSizing.Assign(Value);
end;

procedure TUniDSAStyleAppearance.SetScrollbar(const Value: TUniDSAStyleScrollbar);
begin
  if Assigned(Value) then FScrollbar.Assign(Value);
end;

procedure TUniDSAStyleVisual.SetShadow(const Value: TUniDSAStyleShadow);
begin
  if Assigned(Value) then FShadow.Assign(Value);
end;

procedure TUniDSAStyleVisual.SetEffects(const Value: TUniDSAStyleEffects);
begin
  if Assigned(Value) then FEffects.Assign(Value);
end;

procedure TUniDSAStyleVisual.SetPosition(const Value: TUniDSAStylePosition);
begin
  if Assigned(Value) then FPosition.Assign(Value);
end;

function TUniDSAStyleVisual.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FDisplay <> sdInherit then Result.AddPair('Display', TJSONNumber.Create(Ord(FDisplay)));
  Result.AddPair('Transform', FTransform.ToJSON);
  Result.AddPair('Background', FBackground.ToJSON);
  Result.AddPair('Border', FBorder.ToJSON);
  Result.AddPair('Typography', FTypography.ToJSON);
  Result.AddPair('Spacing', FSpacing.ToJSON);
  Result.AddPair('Sizing', FSizing.ToJSON);
  Result.AddPair('Shadow', FShadow.ToJSON);
  Result.AddPair('Effects', FEffects.ToJSON);
  Result.AddPair('Position', FPosition.ToJSON);
end;

procedure TUniDSAStyleVisual.SetDisplay(const Value: TUniDSAStyleDisplay);
begin
  if FDisplay = Value then Exit;
  FDisplay := Value;
  Changed;
end;

procedure TUniDSAStyleVisual.SetTransform(const Value: TUniDSAStyleGeometry);
begin
  if Assigned(Value) then FTransform.Assign(Value);
end;

constructor TUniDSAStyleGeometry.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FSkewX := -1000;
  FSkewY := -1000;
end;

procedure TUniDSAStyleGeometry.Assign(Source: TPersistent);
var S: TUniDSAStyleGeometry;
begin
  if not (Source is TUniDSAStyleGeometry) then begin inherited; Exit; end;
  S := TUniDSAStyleGeometry(Source);
  BeginUpdate;
  try
    FSkewX := S.FSkewX;
    FSkewY := S.FSkewY;
    Changed;
  finally EndUpdate; end;
end;

function TUniDSAStyleGeometry.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if FSkewX <> -1000 then Result.AddPair('SkewX', TJSONNumber.Create(FSkewX));
  if FSkewY <> -1000 then Result.AddPair('SkewY', TJSONNumber.Create(FSkewY));
end;

procedure TUniDSAStyleGeometry.SetSkewX(const Value: Integer);
begin
  if FSkewX = Value then Exit;
  FSkewX := Value;
  Changed;
end;

procedure TUniDSAStyleGeometry.SetSkewY(const Value: Integer);
begin
  if FSkewY = Value then Exit;
  FSkewY := Value;
  Changed;
end;

procedure TUniDSAStylePseudoElement.Assign(Source: TPersistent);
var S: TUniDSAStylePseudoElement;
begin
  if not (Source is TUniDSAStylePseudoElement) then begin inherited; Exit; end;
  S := TUniDSAStylePseudoElement(Source);
  BeginUpdate;
  try
    inherited Assign(Source);
    FEnabled := S.FEnabled;
    FText := S.FText;
    Changed;
  finally EndUpdate; end;
end;

function TUniDSAStylePseudoElement.ToJSON: TJSONObject;
begin
  Result := inherited ToJSON;
  if FEnabled <> ssInherit then Result.AddPair('Enabled', TJSONNumber.Create(Ord(FEnabled)));
  if (FText <> '') or (FEnabled = ssYes) then Result.AddPair('Text', FText);
end;

procedure TUniDSAStylePseudoElement.SetEnabled(const Value: TUniDSAStyleSwitch);
begin
  if FEnabled = Value then Exit;
  FEnabled := Value;
  Changed;
end;

procedure TUniDSAStylePseudoElement.SetText(const Value: string);
begin
  if FText = Value then Exit;
  FText := Value;
  Changed;
end;

constructor TUniDSAStyleAppearance.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FScrollbar := TUniDSAStyleScrollbar.Create(ChildChanged);
  FContent := TUniDSAStyleVisual.Create(ChildChanged);
  FBefore := TUniDSAStylePseudoElement.Create(ChildChanged);
  FAfter := TUniDSAStylePseudoElement.Create(ChildChanged);
end;

destructor TUniDSAStyleAppearance.Destroy;
begin
  FScrollbar.Free;
  FContent.Free;
  FBefore.Free;
  FAfter.Free;
  inherited;
end;

procedure TUniDSAStyleAppearance.Assign(Source: TPersistent);
var S: TUniDSAStyleAppearance;
begin
  if not (Source is TUniDSAStyleAppearance) then begin inherited; Exit; end;
  S := TUniDSAStyleAppearance(Source);
  BeginUpdate;
  try
    inherited Assign(Source);
    FScrollbar.Assign(S.FScrollbar);
    FContent.Assign(S.FContent);
    FBefore.Assign(S.FBefore);
    FAfter.Assign(S.FAfter);
    Changed;
  finally EndUpdate; end;
end;

function TUniDSAStyleAppearance.ToJSON: TJSONObject;
begin
  Result := inherited ToJSON;
  Result.AddPair('Scrollbar', FScrollbar.ToJSON);
  Result.AddPair('Content', FContent.ToJSON);
  Result.AddPair('Before', FBefore.ToJSON);
  Result.AddPair('After', FAfter.ToJSON);
end;

procedure TUniDSAStyleAppearance.SetContent(const Value: TUniDSAStyleVisual);
begin
  if Assigned(Value) then FContent.Assign(Value);
end;

procedure TUniDSAStyleAppearance.SetBefore(const Value: TUniDSAStylePseudoElement);
begin
  if Assigned(Value) then FBefore.Assign(Value);
end;

procedure TUniDSAStyleAppearance.SetAfter(const Value: TUniDSAStylePseudoElement);
begin
  if Assigned(Value) then FAfter.Assign(Value);
end;

constructor TUniDSAStyleStates.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FHover := TUniDSAStyleAppearance.Create(ChildChanged);
  FFocus := TUniDSAStyleAppearance.Create(ChildChanged);
  FPressed := TUniDSAStyleAppearance.Create(ChildChanged);
  FDisabled := TUniDSAStyleAppearance.Create(ChildChanged);
  FSelected := TUniDSAStyleAppearance.Create(ChildChanged);
end;

destructor TUniDSAStyleStates.Destroy;
begin
  FHover.Free;
  FFocus.Free;
  FPressed.Free;
  FDisabled.Free;
  FSelected.Free;
  inherited;
end;

procedure TUniDSAStyleStates.Assign(Source: TPersistent);
var S: TUniDSAStyleStates;
begin
  if not (Source is TUniDSAStyleStates) then begin inherited; Exit; end;
  S := TUniDSAStyleStates(Source);
  BeginUpdate;
  try
    FHover.Assign(S.FHover);
    FFocus.Assign(S.FFocus);
    FPressed.Assign(S.FPressed);
    FDisabled.Assign(S.FDisabled);
    FSelected.Assign(S.FSelected);
    Changed;
  finally EndUpdate; end;
end;

procedure TUniDSAStyleStates.SetHover(const Value: TUniDSAStyleAppearance);
begin
  if Assigned(Value) then FHover.Assign(Value);
end;

procedure TUniDSAStyleStates.SetFocus(const Value: TUniDSAStyleAppearance);
begin
  if Assigned(Value) then FFocus.Assign(Value);
end;

procedure TUniDSAStyleStates.SetPressed(const Value: TUniDSAStyleAppearance);
begin
  if Assigned(Value) then FPressed.Assign(Value);
end;

procedure TUniDSAStyleStates.SetDisabled(const Value: TUniDSAStyleAppearance);
begin
  if Assigned(Value) then FDisabled.Assign(Value);
end;

procedure TUniDSAStyleStates.SetSelected(const Value: TUniDSAStyleAppearance);
begin
  if Assigned(Value) then FSelected.Assign(Value);
end;

function TUniDSAStyleStates.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('Hover', FHover.ToJSON);
  Result.AddPair('Focus', FFocus.ToJSON);
  Result.AddPair('Pressed', FPressed.ToJSON);
  Result.AddPair('Disabled', FDisabled.ToJSON);
  Result.AddPair('Selected', FSelected.ToJSON);
end;


constructor TUniDSAStyleBreakpoint.Create(Collection: TCollection);
begin
  inherited;
  FAppearance := TUniDSAStyleAppearance.Create(ChildChanged);
  FStates := TUniDSAStyleStates.Create(ChildChanged);
end;
destructor TUniDSAStyleBreakpoint.Destroy;
begin
  FAppearance.Free;
  FStates.Free;
  inherited;
end;
procedure TUniDSAStyleBreakpoint.ChildChanged(Sender: TObject);
begin
  Changed(False);
end;
procedure TUniDSAStyleBreakpoint.SetMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FMinWidth := Value; Changed(False);
end;
procedure TUniDSAStyleBreakpoint.SetMaxWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FMaxWidth := Value; Changed(False);
end;
procedure TUniDSAStyleBreakpoint.SetOrientation(Value: TUniDSAStyleOrientation);
begin
  FOrientation := Value; Changed(False);
end;
procedure TUniDSAStyleBreakpoint.SetAppearance(Value: TUniDSAStyleAppearance);
begin
  FAppearance.Assign(Value);
end;
procedure TUniDSAStyleBreakpoint.SetStates(Value: TUniDSAStyleStates);
begin
  FStates.Assign(Value);
end;
function TUniDSAStyleBreakpoint.GetDisplayName: string;
begin
  Result := Format('%d..%d px', [FMinWidth, FMaxWidth]);
end;
procedure TUniDSAStyleBreakpoint.Assign(Source: TPersistent);
var S: TUniDSAStyleBreakpoint;
begin
  if not (Source is TUniDSAStyleBreakpoint) then begin inherited; Exit; end;
  S := TUniDSAStyleBreakpoint(Source);
  Collection.BeginUpdate;
  try
    FMinWidth := S.FMinWidth; FMaxWidth := S.FMaxWidth; FOrientation := S.FOrientation;
    FAppearance.Assign(S.FAppearance); FStates.Assign(S.FStates);
    Changed(False);
  finally Collection.EndUpdate; end;
end;
function TUniDSAStyleBreakpoint.ToJSON: TJSONObject;
begin
  if (FMaxWidth > 0) and (FMaxWidth < FMinWidth) then
    raise EArgumentException.Create('Responsive: MaxWidth deve ser zero ou maior/igual a MinWidth.');
  Result := TJSONObject.Create;
  Result.AddPair('min', TJSONNumber.Create(FMinWidth));
  Result.AddPair('max', TJSONNumber.Create(FMaxWidth));
  Result.AddPair('orientation', TJSONNumber.Create(Ord(FOrientation)));
  Result.AddPair('appearance', FAppearance.ToJSON);
  Result.AddPair('states', FStates.ToJSON);
end;
constructor TUniDSAStyleBreakpoints.Create(AOwner: TPersistent; AOnChange: TNotifyEvent);
begin
  inherited Create(AOwner, TUniDSAStyleBreakpoint);
  FOnChange := AOnChange;
end;
procedure TUniDSAStyleBreakpoints.Update(Item: TCollectionItem);
begin
  inherited;
  if Assigned(FOnChange) then FOnChange(Self);
end;
function TUniDSAStyleBreakpoints.GetItem(Index: Integer): TUniDSAStyleBreakpoint;
begin
  Result := TUniDSAStyleBreakpoint(inherited Items[Index]);
end;
function TUniDSAStyleBreakpoints.Add: TUniDSAStyleBreakpoint;
begin
  Result := TUniDSAStyleBreakpoint(inherited Add);
end;
function TUniDSAStyleBreakpoints.ToJSON: TJSONArray;
var I: Integer;
begin
  Result := TJSONArray.Create;
  try
    for I := 0 to Count - 1 do Result.AddElement(Items[I].ToJSON);
  except Result.Free; raise; end;
end;
constructor TUniDSAStyleRule.Create(AOnChange: TNotifyEvent);
begin
  inherited;
  FAppearance := TUniDSAStyleAppearance.Create(ChildChanged);
  FStates := TUniDSAStyleStates.Create(ChildChanged);
  FResponsive := TUniDSAStyleBreakpoints.Create(Self, ChildChanged);
end;
destructor TUniDSAStyleRule.Destroy;
begin
  FResponsive.Free; FStates.Free; FAppearance.Free;
  inherited;
end;
procedure TUniDSAStyleRule.SetAppearance(Value: TUniDSAStyleAppearance);
begin
  FAppearance.Assign(Value);
end;
procedure TUniDSAStyleRule.SetStates(Value: TUniDSAStyleStates);
begin
  FStates.Assign(Value);
end;
procedure TUniDSAStyleRule.SetResponsive(Value: TUniDSAStyleBreakpoints);
begin
  FResponsive.Assign(Value);
end;
procedure TUniDSAStyleRule.Assign(Source: TPersistent);
var S: TUniDSAStyleRule;
begin
  if not (Source is TUniDSAStyleRule) then begin inherited; Exit; end;
  S := TUniDSAStyleRule(Source);
  BeginUpdate;
  try
    FAppearance.Assign(S.FAppearance); FStates.Assign(S.FStates); FResponsive.Assign(S.FResponsive);
    Changed;
  finally EndUpdate; end;
end;
function TUniDSAStyleRule.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    Result.AddPair('appearance', FAppearance.ToJSON);
    Result.AddPair('states', FStates.ToJSON);
    Result.AddPair('responsive', FResponsive.ToJSON);
  except Result.Free; raise; end;
end;
constructor TUniDSANamedStyle.Create(Collection: TCollection);
begin
  inherited;
  FRule := TUniDSAStyleRule.Create(ChildChanged);
end;
destructor TUniDSANamedStyle.Destroy;
begin
  FRule.Free;
  inherited;
end;
procedure TUniDSANamedStyle.ChildChanged(Sender: TObject);
begin
  Changed(False);
end;
procedure TUniDSANamedStyle.SetName(const Value: string);
var M: TUniDSAStyle; I: Integer;
begin
  if FName = Trim(Value) then Exit;
  M := TUniDSAStyle(TOwnedCollection(Collection).Owner);
  if (Self is TUniDSAStyleItem) = False then
  begin
    if Assigned(M.Styles.Find(Trim(Value))) and (M.Styles.Find(Trim(Value)) <> Self) then
      raise EArgumentException.Create('Nome de estilo duplicado: ' + Value);
    M.BeginUpdate;
    try
      if FName <> '' then
        for I := 0 to M.StyleItems.Count - 1 do
          if SameText(M.StyleItems[I].StyleName, FName) then M.StyleItems[I].StyleName := Trim(Value);
      FName := Trim(Value);
      Changed(False);
    finally M.EndUpdate; end;
  end
  else begin FName := Trim(Value); Changed(False); end;
end;
function TUniDSANamedStyle.GetDisplayName: string;
begin
  if FName <> '' then Result := FName else Result := inherited GetDisplayName;
end;
function TUniDSANamedStyle.GetAppearance: TUniDSAStyleAppearance;
begin Result := FRule.Appearance; end;
function TUniDSANamedStyle.GetStates: TUniDSAStyleStates;
begin Result := FRule.States; end;
function TUniDSANamedStyle.GetResponsive: TUniDSAStyleBreakpoints;
begin Result := FRule.Responsive; end;
procedure TUniDSANamedStyle.SetAppearance(Value: TUniDSAStyleAppearance);
begin FRule.Appearance.Assign(Value); end;
procedure TUniDSANamedStyle.SetStates(Value: TUniDSAStyleStates);
begin FRule.States.Assign(Value); end;
procedure TUniDSANamedStyle.SetResponsive(Value: TUniDSAStyleBreakpoints);
begin FRule.Responsive.Assign(Value); end;
procedure TUniDSANamedStyle.Assign(Source: TPersistent);
var S: TUniDSANamedStyle;
begin
  if not (Source is TUniDSANamedStyle) then begin inherited; Exit; end;
  S := TUniDSANamedStyle(Source);
  Collection.BeginUpdate;
  try FName := S.FName; FRule.Assign(S.FRule); Changed(False);
  finally Collection.EndUpdate; end;
end;
constructor TUniDSAStyleItem.Create(Collection: TCollection);
begin
  inherited;
  FEnabled := True;
end;
procedure TUniDSAStyleItem.SetControl(Value: TComponent);
var M: TUniDSAStyle;
begin
  if FControl = Value then Exit;
  if Assigned(Value) and not TUniDSAStyle.SupportsControl(Value) then
    raise EArgumentException.Create('Control deve ser um controle, frame ou formulario uniGUI.');
  M := TUniDSAStyle(TOwnedCollection(Collection).Owner);
  // A manager may reference the same component as its scope and as an item.
  // Notifications are retained until manager destruction, so replacing one
  // reference cannot invalidate another reference to the same component.
  FControl := Value;
  if Assigned(Value) then Value.FreeNotification(M);
  Changed(False);
end;
procedure TUniDSAStyleItem.SetStyleName(const Value: string);
begin FStyleName := Trim(Value); Changed(False); end;
procedure TUniDSAStyleItem.SetEnabled(Value: Boolean);
begin FEnabled := Value; Changed(False); end;
procedure TUniDSAStyleItem.SetSelected(Value: Boolean);
begin FSelected := Value; Changed(False); end;
function TUniDSAStyleItem.GetDisplayName: string;
begin
  if Assigned(FControl) then Result := FControl.Name else Result := inherited GetDisplayName;
  if FStyleName <> '' then Result := Result + ' [' + FStyleName + ']';
end;
procedure TUniDSAStyleItem.Assign(Source: TPersistent);
var S: TUniDSAStyleItem;
begin
  if not (Source is TUniDSAStyleItem) then begin inherited; Exit; end;
  S := TUniDSAStyleItem(Source);
  Collection.BeginUpdate;
  try
    inherited;
    Control := S.FControl; FStyleName := S.FStyleName; FEnabled := S.FEnabled; FSelected := S.FSelected;
    Changed(False);
  finally Collection.EndUpdate; end;
end;
constructor TUniDSANamedStyles.Create(AOwner: TUniDSAStyle);
begin inherited Create(AOwner, TUniDSANamedStyle); end;
procedure TUniDSANamedStyles.Update(Item: TCollectionItem);
begin inherited; TUniDSAStyle(Owner).Apply; end;
function TUniDSANamedStyles.GetItem(Index: Integer): TUniDSANamedStyle;
begin Result := TUniDSANamedStyle(inherited Items[Index]); end;
function TUniDSANamedStyles.Add: TUniDSANamedStyle;
begin Result := TUniDSANamedStyle(inherited Add); end;
function TUniDSANamedStyles.Find(const AName: string): TUniDSANamedStyle;
var I: Integer;
begin
  Result := nil;
  if AName = '' then Exit;
  for I := 0 to Count - 1 do if SameText(Items[I].Name, AName) then Exit(Items[I]);
end;
constructor TUniDSAStyleItems.Create(AOwner: TUniDSAStyle);
begin inherited Create(AOwner, TUniDSAStyleItem); end;
procedure TUniDSAStyleItems.Update(Item: TCollectionItem);
begin inherited; TUniDSAStyle(Owner).Apply; end;
function TUniDSAStyleItems.GetItem(Index: Integer): TUniDSAStyleItem;
begin Result := TUniDSAStyleItem(inherited Items[Index]); end;
function TUniDSAStyleItems.Add: TUniDSAStyleItem;
begin Result := TUniDSAStyleItem(inherited Add); end;
function TUniDSAStyleItems.FindByControl(AControl: TComponent): TUniDSAStyleItem;
var I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do if Items[I].Control = AControl then Exit(Items[I]);
end;
constructor TUniDSAStyle.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  FStyles := TUniDSANamedStyles.Create(Self);
  FStyleItems := TUniDSAStyleItems.Create(Self);
  FDefaults := TUniDSAStyleRule.Create(ChildChanged);
end;
destructor TUniDSAStyle.Destroy;
var Key: TJSONString;
begin
  if FReady and WebMode and Assigned(Owner) and not (csDestroying in Owner.ComponentState) then
  begin
    Key := TJSONString.Create(JSName);
    try UniSession.AddJS('if(window.UniDSAStyle)UniDSAStyle.detach(' + Key.ToJSON + ');');
    finally Key.Free; end;
  end;
  FReady := False;
  FreeAndNil(FDefaults); FreeAndNil(FStyleItems); FreeAndNil(FStyles);
  inherited;
end;
class function TUniDSAStyle.SupportsControl(AControl: TComponent): Boolean;
begin
  Result := (AControl is TUniControl) or (AControl is TUniFrame) or (AControl is TUniForm);
end;
procedure TUniDSAStyle.ChildChanged(Sender: TObject);
begin Apply; end;
procedure TUniDSAStyle.SetStyles(Value: TUniDSANamedStyles);
begin
  BeginUpdate;
  try FStyles.Assign(Value); finally EndUpdate; end;
end;
procedure TUniDSAStyle.SetStyleItems(Value: TUniDSAStyleItems);
begin
  BeginUpdate;
  try FStyleItems.Assign(Value); finally EndUpdate; end;
end;
procedure TUniDSAStyle.SetDefaults(Value: TUniDSAStyleRule);
begin FDefaults.Assign(Value); end;
procedure TUniDSAStyle.SetTargetContainer(Value: TComponent);
begin
  if FTargetContainer = Value then Exit;
  if Assigned(Value) and not SupportsControl(Value) then
    raise EArgumentException.Create('TargetContainer deve ser um controle, frame ou formulario uniGUI.');
  FTargetContainer := Value;
  if Assigned(Value) then Value.FreeNotification(Self);
  Apply;
end;
procedure TUniDSAStyle.SetIncludeChildren(Value: Boolean);
begin FIncludeChildren := Value; Apply; end;
procedure TUniDSAStyle.SetEnabled(Value: Boolean);
begin FEnabled := Value; Apply; end;
procedure TUniDSAStyle.Notification(AComponent: TComponent; Operation: TOperation);
var I: Integer;
begin
  inherited;
  if (Operation <> opRemove) or not Assigned(FStyleItems) then Exit;
  if FTargetContainer = AComponent then FTargetContainer := nil;
  for I := 0 to FStyleItems.Count - 1 do
    if FStyleItems[I].FControl = AComponent then FStyleItems[I].FControl := nil;
  Apply;
end;
procedure TUniDSAStyle.BeginUpdate;
begin Inc(FUpdateCount); end;
procedure TUniDSAStyle.EndUpdate;
begin
  if FUpdateCount = 0 then Exit;
  Dec(FUpdateCount);
  if FDirty and (FUpdateCount = 0) then Apply;
end;
procedure TUniDSAStyle.Validate;
var I, J: Integer;
begin
  for I := 0 to FStyles.Count - 1 do
  begin
    if FStyles[I].Name = '' then raise EArgumentException.Create('Styles: informe um Name para cada estilo.');
    for J := I + 1 to FStyles.Count - 1 do
      if SameText(FStyles[I].Name, FStyles[J].Name) then
        raise EArgumentException.Create('Styles: nome duplicado: ' + FStyles[I].Name);
  end;
  for I := 0 to FStyleItems.Count - 1 do
  begin
    if (FStyleItems[I].StyleName <> '') and not Assigned(FStyles.Find(FStyleItems[I].StyleName)) then
      raise EArgumentException.Create('StyleItems: estilo inexistente: ' + FStyleItems[I].StyleName);
    if not Assigned(FStyleItems[I].Control) then Continue;
    for J := I + 1 to FStyleItems.Count - 1 do
      if FStyleItems[I].Control = FStyleItems[J].Control then
        raise EArgumentException.Create('StyleItems: controle duplicado: ' + FStyleItems[I].Control.Name);
  end;
end;
function ControlID(C: TComponent): string;
begin
  Result := '';
  if not Assigned(C) or (csDestroying in C.ComponentState) then Exit;
  if C is TUniFrame then Result := TUniFrame(C).FormRegion.JSName
  else if C is TUniForm then Result := TUniForm(C).WebForm.JSName
  else if C is TUniControl then Result := TUniControl(C).JSName;
  if Result <> '' then Result := Result + '_id';
end;
function TUniDSAStyle.BuildConfig: string;
var O, Item: TJSONObject; A, Layers: TJSONArray; I: Integer; Named: TUniDSANamedStyle;
begin
  Validate;
  O := TJSONObject.Create;
  try
    O.AddPair('enabled', TJSONBool.Create(FEnabled));
    O.AddPair('scope', ControlID(FTargetContainer));
    O.AddPair('children', TJSONBool.Create(FIncludeChildren));
    O.AddPair('owner', ControlID(Owner));
    O.AddPair('defaults', FDefaults.ToJSON);
    A := TJSONArray.Create;
    O.AddPair('items', A);
    for I := 0 to FStyleItems.Count - 1 do
    begin
      if not FStyleItems[I].Enabled or (ControlID(FStyleItems[I].Control) = '') then Continue;
      Item := TJSONObject.Create;
      A.AddElement(Item);
      Item.AddPair('id', ControlID(FStyleItems[I].Control));
      Item.AddPair('name', FStyleItems[I].Control.Name);
      Item.AddPair('selected', TJSONBool.Create(FStyleItems[I].Selected));
      Layers := TJSONArray.Create;
      Item.AddPair('layers', Layers);
      Layers.AddElement(FDefaults.ToJSON);
      Named := FStyles.Find(FStyleItems[I].StyleName);
      if Assigned(Named) then Layers.AddElement(Named.Rule.ToJSON);
      Layers.AddElement(FStyleItems[I].Rule.ToJSON);
    end;
    Result := O.ToJSON;
  finally O.Free; end;
end;
procedure TUniDSAStyle.Apply;
var Key: TJSONString; Config: string;
begin
  FDirty := True;
  if not FReady or not WebMode or (FUpdateCount > 0) or
    (csLoading in ComponentState) or (csDestroying in ComponentState) or
    (Assigned(Owner) and (csDestroying in Owner.ComponentState)) then Exit;
  Config := BuildConfig;
  Key := TJSONString.Create(JSName);
  try UniSession.AddJS('UniDSAStyle.attach(' + Key.ToJSON + ',' + Config + ');');
  finally Key.Free; end;
  FDirty := False;
end;
procedure TUniDSAStyle.LoadCompleted;
begin
  inherited;
  UniSession.AddJS(UniDSAStyleRuntime);
  FReady := True;
  Apply;
end;
end.
