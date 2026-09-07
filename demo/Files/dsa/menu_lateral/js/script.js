var LUniDSAMenuLateralTamanhoMenuNormal = 250;
var LUniDSAMenuLateralTamanhoMenuMinimizado = 34;
var LUniDSAMenuLateralManterPosicaoMimizado = 'S';
var LUniDSAMenuLateralMinimizado = 'N';
var LUniDSAMenuLateralTema = 'T1';

var LUniDSAMenuLateralCorFundo1 = "#FFF";
var LUniDSAMenuLateralCorBordaFundo1 = "#edeeef";
var LUniDSAMenuLateralCorIcones1 = "#141414";
var LUniDSAMenuLateralCorItensFundo1 = "#00000009";
var LUniDSAMenuLateralCorItens1 = "#141414";
var LUniDSAMenuLateralCorTexto1 = "#141414";
var LUniDSAMenuLateralCorTemaTextoSelecionado1 = "#141414";
var LUniDSAMenuLateralCorIconesHoverSair1 = "#f42e2e";
var LUniDSAMenuLateralCorFundoNotificacoes1 = '#F42E2E';

var LUniDSAMenuLateralCorFundo2 = "#1C1C1C"; // Fundo escuro
var LUniDSAMenuLateralCorBordaFundo2 = "#2D2D2D"; // Borda de fundo escuro
var LUniDSAMenuLateralCorIcones2 = "#FFFFFF"; // Ícones em branco
var LUniDSAMenuLateralCorItensFundo2 = "#FFFFFF09"; // Fundo dos itens com transparência
var LUniDSAMenuLateralCorItens2 = "#FFFFFF"; // Texto dos itens em branco
var LUniDSAMenuLateralCorTexto2 = "#FFFFFF"; // Texto geral em branco
var LUniDSAMenuLateralCorTemaTextoSelecionado2 = "#FFFFFF"; // Texto selecionado em branco
var LUniDSAMenuLateralCorIconesHoverSair2 = "#F42E2E"; // Ícones de hover (pode permanecer a mesma cor)
var LUniDSAMenuLateralCorFundoNotificacoes2 = '#F42E2E';


function AlterarTema() {
  if (LUniDSAMenuLateralTema == 'T2') {
    $(".uni-ml-config-usuario-tema-1").css("background-color", "transparent");
    $(".uni-ml-config-usuario-tema-2").css("background-color", "#FFF");

    $(".uni-ml-config-usuario-tema-2 span").css("color", "var(--var-uni-ml-cor-tema-texto)");
    $(".uni-ml-config-usuario-tema-1 span").css("color", "var(--var-uni-ml-cor-tema-texto-selecionado)");

    $(".uni-ml-config-usuario-tema-2 i").css("color", "var(--var-uni-ml-cor-tema-texto)");
    $(".uni-ml-config-usuario-tema-1 i").css("color", "var(--var-uni-ml-cor-tema-texto-selecionado)");
  } else {
    $(".uni-ml-config-usuario-tema-2").css("background-color", "transparent");
    $(".uni-ml-config-usuario-tema-1").css("background-color", "#FFF");

    $(".uni-ml-config-usuario-tema-1 span").css("color", "var(--var-uni-ml-cor-tema-texto)");
    $(".uni-ml-config-usuario-tema-2 span").css("color", "var(--var-uni-ml-cor-tema-texto-selecionado)");

    $(".uni-ml-config-usuario-tema-1 i").css("color", "var(--var-uni-ml-cor-tema-texto)");
    $(".uni-ml-config-usuario-tema-2 i").css("color", "var(--var-uni-ml-cor-tema-texto-selecionado)");
  };
};

function ConfigurarCorTema(
  LUniDSAMenuLateralTema,
  LUniDSAMenuLateralCorFundo,
  LUniDSAMenuLateralCorBordaFundo,
  LUniDSAMenuLateralCorIcones,
  LUniDSAMenuLateralCorItensFundo,
  LUniDSAMenuLateralCorItens,
  LUniDSAMenuLateralCorTexto,
  LUniDSAMenuLateralCorTemaTextoSelecionado,
  LUniDSAMenuLateralCorIconesHoverSair,
  LUniDSAMenuLateralCorFundoNotificacoes
) {
  if (LUniDSAMenuLateralTema == 'T1') {
    LUniDSAMenuLateralCorFundo1 = LUniDSAMenuLateralCorFundo;
    LUniDSAMenuLateralCorBordaFundo1 = LUniDSAMenuLateralCorBordaFundo;
    LUniDSAMenuLateralCorIcones1 = LUniDSAMenuLateralCorIcones;
    LUniDSAMenuLateralCorItensFundo1 = LUniDSAMenuLateralCorItensFundo;
    LUniDSAMenuLateralCorItens1 = LUniDSAMenuLateralCorItens;
    LUniDSAMenuLateralCorTexto1 = LUniDSAMenuLateralCorTexto;
    LUniDSAMenuLateralCorTemaTextoSelecionado1 = LUniDSAMenuLateralCorTemaTextoSelecionado;
    LUniDSAMenuLateralCorIconesHoverSair1 = LUniDSAMenuLateralCorIconesHoverSair;
    LUniDSAMenuLateralCorFundoNotificacoes1 = LUniDSAMenuLateralCorFundoNotificacoes;
  } else {
    LUniDSAMenuLateralCorFundo2 = LUniDSAMenuLateralCorFundo;
    LUniDSAMenuLateralCorBordaFundo2 = LUniDSAMenuLateralCorBordaFundo;
    LUniDSAMenuLateralCorIcones2 = LUniDSAMenuLateralCorIcones;
    LUniDSAMenuLateralCorItensFundo2 = LUniDSAMenuLateralCorItensFundo;
    LUniDSAMenuLateralCorItens2 = LUniDSAMenuLateralCorItens;
    LUniDSAMenuLateralCorTexto2 = LUniDSAMenuLateralCorTexto;
    LUniDSAMenuLateralCorTemaTextoSelecionado2 = LUniDSAMenuLateralCorTemaTextoSelecionado;
    LUniDSAMenuLateralCorIconesHoverSair2 = LUniDSAMenuLateralCorIconesHoverSair;
    LUniDSAMenuLateralCorFundoNotificacoes2 = LUniDSAMenuLateralCorFundoNotificacoes;
  }

  AlterarTema();
};

function DefinirCorTema(
  LUniDSAMenuLateralCorFundo,
  LUniDSAMenuLateralCorBordaFundo,
  LUniDSAMenuLateralCorIcones,
  LUniDSAMenuLateralCorItensFundo,
  LUniDSAMenuLateralCorItens,
  LUniDSAMenuLateralCorTexto,
  LUniDSAMenuLateralCorTemaTextoSelecionado,
  LUniDSAMenuLateralCorIconesHoverSair,
  LUniDSAMenuLateralCorFundoNotificacoes
) {
  var root = document.querySelector(":root");

  root.style.setProperty("--var-uni-ml-cor-bg", LUniDSAMenuLateralCorFundo);
  root.style.setProperty("--var-uni-ml-cor-icones", LUniDSAMenuLateralCorIcones);
  root.style.setProperty("--var-uni-ml-cor-itens-fundo", LUniDSAMenuLateralCorItensFundo);
  root.style.setProperty("--var-uni-ml-cor-itens", LUniDSAMenuLateralCorItens);
  root.style.setProperty("--var-uni-ml-cor-texto", LUniDSAMenuLateralCorTexto);
  root.style.setProperty("--var-uni-ml-cor-tema-texto-selecionado", LUniDSAMenuLateralCorTemaTextoSelecionado);
  root.style.setProperty("--var-uni-ml-cor-icone-sair", LUniDSAMenuLateralCorIconesHoverSair);
  root.style.setProperty("--var-uni-ml-cor-borda", LUniDSAMenuLateralCorBordaFundo);
  root.style.setProperty("--var-uni-ml-cor-notificacao", LUniDSAMenuLateralCorFundoNotificacoes);

  AlterarTema();
};

function Tema1() {
  LUniDSAMenuLateralTema = 'T1';

  DefinirCorTema(
    LUniDSAMenuLateralCorFundo1,
    LUniDSAMenuLateralCorBordaFundo1,
    LUniDSAMenuLateralCorIcones1,
    LUniDSAMenuLateralCorItensFundo1,
    LUniDSAMenuLateralCorItens1,
    LUniDSAMenuLateralCorTexto1,
    LUniDSAMenuLateralCorTemaTextoSelecionado1,
    LUniDSAMenuLateralCorIconesHoverSair1,
    LUniDSAMenuLateralCorFundoNotificacoes1
  );
};

function Tema2() {
  LUniDSAMenuLateralTema = 'T2';

  DefinirCorTema(
    LUniDSAMenuLateralCorFundo2,
    LUniDSAMenuLateralCorBordaFundo2,
    LUniDSAMenuLateralCorIcones2,
    LUniDSAMenuLateralCorItensFundo2,
    LUniDSAMenuLateralCorItens2,
    LUniDSAMenuLateralCorTexto2,
    LUniDSAMenuLateralCorTemaTextoSelecionado2,
    LUniDSAMenuLateralCorIconesHoverSair2,
    LUniDSAMenuLateralCorFundoNotificacoes2
  );
};

function MenuLateralMinimizado() {
  LUniDSAMenuLateralMinimizado = 'S';

  document.documentElement.style.setProperty('--var-ml-tamanho', LUniDSAMenuLateralTamanhoMenuMinimizado + 'px');
  $("#uni-ml-logo-nome-empresa").hide();
  $("#uni-ml-pesquisar").hide();
  $(".uni-ml-pesquisa").css("padding-right", "0");
  $(".uni-ml-scroll-menu ul li span").hide();
  $(".uni-ml-scroll-menu ul li a").css("margin-right", "0");
  $(".uni-ml-scroll-menu").css("overflow-y", "hidden");
  $(".uni-ml-scroll-menu ul").css("overflow-y", "hidden");

  if (LUniDSAMenuLateralManterPosicaoMimizado == 'S') {
    $(".uni-ml-scroll-menu .uni-ml-titulo-menu").css("visibility", "hidden");
    $(".uni-ml-scroll-menu .uni-ml-titulo-menu").show();
  } else {
    $(".uni-ml-scroll-menu .uni-ml-titulo-menu").css("visibility", "visible");
    $(".uni-ml-scroll-menu .uni-ml-titulo-menu").hide();
  };

  $("#uni-ml-item-menu-notif").css("position", "absolute");
  $("#uni-ml-item-menu-notif").css("margin-top", "20px");
  $("#uni-ml-item-menu-notif").css("margin-left", "18px");
  $("#uni-ml-item-menu-notif").css("border-radius", "50px");
  $("#uni-ml-item-menu-notif").css("width", "18px");

  $(".fa-chevron-right").hide();

  $(".uni-ml-config-usuario-tema").css("flex-direction", "column");
  $(".uni-ml-config-usuario-tema").css("min-height", "calc(var(--var-ml-altura-itens) + var(--var-ml-altura-itens))");

  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-1 span").hide();
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-2 span").hide();
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-1 i").css("height", "min-height: var(--var-ml-altura-itens)");
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-2 i").css("height", "min-height: var(--var-ml-altura-itens)");

  $(".uni-ml-perfil-desc").hide();
  $(".uni-ml-perfil i").hide();

  $(".uni-ml .uni-ml-config-usuario .uni-ml-perfil img").css("height", "24px");
};

function MenuLateralMaximizado() {
  LUniDSAMenuLateralMinimizado = 'N';

  document.documentElement.style.setProperty('--var-ml-tamanho', LUniDSAMenuLateralTamanhoMenuNormal + 'px');
  $("#uni-ml-logo-nome-empresa").show();
  $("#uni-ml-pesquisar").show();
  $(".uni-ml-pesquisa").css("padding-right", "15px");
  $(".uni-ml-scroll-menu ul li span").show();
  $(".uni-ml-scroll-menu .uni-ml-titulo-menu").show();
  $(".uni-ml-scroll-menu .uni-ml-titulo-menu").css("visibility", "visible");
  $(".uni-ml-scroll-menu .uni-ml-titulo-menu").show();
  $(".uni-ml-scroll-menu ul li a").css("margin-right", "8px");
  $(".uni-ml-scroll-menu").css("overflow-y", "auto");
  $(".uni-ml-scroll-menu ul").css("overflow-y", "auto");

  $("#uni-ml-item-menu-notif").css("position", "");
  $("#uni-ml-item-menu-notif").css("margin-top", "");
  $("#uni-ml-item-menu-notif").css("margin-left", "");
  $("#uni-ml-item-menu-notif").css("border-radius", "8px");
  $("#uni-ml-item-menu-notif").css("width", "30px");

  $(".fa-chevron-right").show();

  $(".uni-ml-config-usuario-tema").css("flex-direction", "row");
  $(".uni-ml-config-usuario-tema").css("min-height", "var(--var-ml-altura-itens)");

  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-1 span").show();
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-2 span").show();
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-1 i").css("height", "");
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-2 i").css("height", "");
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema").css("height", "calc(var(--var-ml-altura-itens) + 6px)");

  $(".uni-ml-perfil-desc").show();
  $(".uni-ml-perfil i").show();

  $(".uni-ml .uni-ml-config-usuario .uni-ml-perfil img").css("height", "var(--var-ml-altura-itens)");
};


function UniDSAMenuLateralOnClickLogo(AJSName) {
  ajaxRequest(AJSName, 'UniDSAMenuLateralOnClickLogo', []);
};

function UniDSAMenuLateralOnClickMenu(AJSName, ANomeMenu) {
  ajaxRequest(AJSName, 'UniDSAMenuLateralOnClickMenu', ["menu=" + ANomeMenu]);
};

function UniDSAMenuLateralOnClickNotificationMenu(AJSName, ANomeMenu, AEvent) {
  ajaxRequest(AJSName, 'UniDSAMenuLateralOnClickNotificationMenu', ["menu=" + ANomeMenu]);
  AEvent.stopPropagation();
};

function UniDSAMenuLateralOnAfterSelectTheme(AJSName, AEvent) {
  var LOpcao = AEvent.target.getAttribute("option");

  AlterarTema();

  if (LOpcao == 'T2') {
    Tema2();
  } else {
    Tema1();
  };

  ajaxRequest(AJSName, 'UniDSAMenuLateralOnAfterSelectTheme', ["tema=" + LOpcao]);
};

function UniDSAMenuLateralOnClickProfile(AJSName) {
  ajaxRequest(AJSName, 'UniDSAMenuLateralOnClickProfile', []);
};

function UniDSAMenuLateralOnClickLogoff(AJSName) {
  ajaxRequest(AJSName, 'UniDSAMenuLateralOnClickLogoff', []);
};

function UniDSAMenuLateralOnSearchEnter(AJSName, AValor) {
  ajaxRequest(AJSName, 'UniDSAMenuLateralOnSearchEnter', ["texto=" + AValor]);
};

function UniDSAMenuLateralOnClickIconSearch(AJSName) {
  ajaxRequest(AJSName, 'UniDSAMenuLateralOnClickIconSearch', []);
};

function UniDSAMenuLateralOnKeyUpSearch(AJSName, AEvent) {
  ajaxRequest(AJSName, 'UniDSAMenuLateralGetSearchValue', ["texto=" + AEvent.target.value]);
};

function UniDSAMenuLateralOnKeyDownSearch(AJSName, AEvent) {
  if (AEvent.keyCode === 13) {
    const LValorInput = AEvent.target.value;

    UniDSAMenuLateralOnSearchEnter(AJSName, LValorInput)
  }
};
