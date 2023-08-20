var LTamanhoMenuNormal = 250;
var LTamanhoMenuMinimizado = 34;
var LManterPosicaoMimizado = 'S';
var LMinimizado = 'N';
var LTema = 'C'; // C - CLARO - E - ESCURO

function AlterarTema() {
  if (LTema == 'E') {
    $(".uni-ml-config-usuario-tema-2").css("background-color","transparent");           
    $(".uni-ml-config-usuario-tema-1").css("background-color","#FFF");    

    $(".uni-ml-config-usuario-tema-1 span").css("color","var(--var-uni-ml-cor-tema-texto)");            
    $(".uni-ml-config-usuario-tema-2 span").css("color","var(--var-uni-ml-cor-tema-texto-selecionado)");      

    $(".uni-ml-config-usuario-tema-1 i").css("color","var(--var-uni-ml-cor-tema-texto)");                 
    $(".uni-ml-config-usuario-tema-2 i").css("color","var(--var-uni-ml-cor-tema-texto-selecionado)");      

    LTema = 'C';
  } else {

    $(".uni-ml-config-usuario-tema-1").css("background-color","transparent");
    $(".uni-ml-config-usuario-tema-2").css("background-color","#FFF"); 

    $(".uni-ml-config-usuario-tema-2 span").css("color","var(--var-uni-ml-cor-tema-texto)");      
    $(".uni-ml-config-usuario-tema-1 span").css("color","var(--var-uni-ml-cor-tema-texto-selecionado)");           

    $(".uni-ml-config-usuario-tema-2 i").css("color","var(--var-uni-ml-cor-tema-texto)");      
    $(".uni-ml-config-usuario-tema-1 i").css("color","var(--var-uni-ml-cor-tema-texto-selecionado)");   
    
    LTema = 'E';      
  };
};

function DefinirCorTema(ACorDeFundo, ACorDaBordaFundo, ACorIcones, ACorItensFundo, ACorItens, ACorTexto, ACorTemaTextoSelecionado, ACorIconeHoverSair) {
  var root = document.querySelector(":root");

  root.style.setProperty("--var-uni-ml-cor-bg", ACorDeFundo);
  root.style.setProperty("--var-uni-ml-cor-icones", ACorIcones);    
  root.style.setProperty("--var-uni-ml-cor-itens-fundo", ACorItensFundo);    
  root.style.setProperty("--var-uni-ml-cor-itens", ACorItens);   
  root.style.setProperty("--var-uni-ml-cor-texto", ACorTexto);  
  root.style.setProperty("--var-uni-ml-cor-tema-texto-selecionado",ACorTemaTextoSelecionado); 
  root.style.setProperty("--var-uni-ml-cor-icone-sair", ACorIconeHoverSair);     
  root.style.setProperty("--var-uni-ml-cor-borda", ACorDaBordaFundo);   
     
  AlterarTema();
};    

function TemaPadrao() {
  DefinirCorTema("#0a4ef5", "#000", "#FFF", "#00000021", "#FFF", "#FFF", "#FFF", "#f42e2e");
};

function MenuLateralMinimizado(){
  LMinimizado = 'S';

  document.documentElement.style.setProperty('--var-ml-tamanho', LTamanhoMenuMinimizado + 'px');   
  $("#uni-ml-logo-nome-empresa").hide();
  $("#uni-ml-pesquisar").hide();
  $(".uni-ml-pesquisa").css("padding-right", "0");
  $(".uni-ml-scroll-menu ul li span").hide();
  $(".uni-ml-scroll-menu ul li a").css("margin-right","0");

  if (LManterPosicaoMimizado == 'S') {
    $(".uni-ml-scroll-menu .uni-ml-titulo-menu").css("visibility","hidden");
    $(".uni-ml-scroll-menu .uni-ml-titulo-menu").show();
  } else {
    $(".uni-ml-scroll-menu .uni-ml-titulo-menu").css("visibility","visible");
    $(".uni-ml-scroll-menu .uni-ml-titulo-menu").hide();
  };

  $("#uni-ml-item-menu-notif").css("position","absolute");
  $("#uni-ml-item-menu-notif").css("margin-top","20px");
  $("#uni-ml-item-menu-notif").css("margin-left","18px");    
  $("#uni-ml-item-menu-notif").css("border-radius","50px");      
  $("#uni-ml-item-menu-notif").css("width","18px");   

  $(".fa-chevron-right").hide(); 
  
  $(".uni-ml-config-usuario-tema").css("flex-direction","column");
  $(".uni-ml-config-usuario-tema").css("min-height","calc(var(--var-ml-altura-itens) + var(--var-ml-altura-itens))");    

  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-1 span").hide();
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-2 span").hide();  
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-1 i").css("height","min-height: var(--var-ml-altura-itens)");
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-2 i").css("height","min-height: var(--var-ml-altura-itens)");  
  
  $(".uni-ml-perfil-desc").hide();
  $(".uni-ml-perfil i").hide();

  $(".uni-ml .uni-ml-config-usuario .uni-ml-perfil img").css("height","24px");
}; 

function MenuLateralMaximizado(){
  LMinimizado = 'N';

  document.documentElement.style.setProperty('--var-ml-tamanho', LTamanhoMenuNormal + 'px');  
  $("#uni-ml-logo-nome-empresa").show();
  $("#uni-ml-pesquisar").show();
  $(".uni-ml-pesquisa").css("padding-right", "15px");
  $(".uni-ml-scroll-menu ul li span").show();    
  $(".uni-ml-scroll-menu .uni-ml-titulo-menu").show();
  $(".uni-ml-scroll-menu .uni-ml-titulo-menu").css("visibility","visible");
  $(".uni-ml-scroll-menu .uni-ml-titulo-menu").show();
  $(".uni-ml-scroll-menu ul li a").css("margin-right","8px");    

  $("#uni-ml-item-menu-notif").css("position","");
  $("#uni-ml-item-menu-notif").css("margin-top","");
  $("#uni-ml-item-menu-notif").css("margin-left","");    
  $("#uni-ml-item-menu-notif").css("border-radius","8px");      
  $("#uni-ml-item-menu-notif").css("width","30px");   
  
  $(".fa-chevron-right").show();

  $(".uni-ml-config-usuario-tema").css("flex-direction","row");    
  $(".uni-ml-config-usuario-tema").css("min-height","var(--var-ml-altura-itens)");      

  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-1 span").show();
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-2 span").show();    
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-1 i").css("height","");
  $(".uni-ml .uni-ml-config-usuario .uni-ml-config-usuario-tema .uni-ml-config-usuario-tema-2 i").css("height",""); 

  $(".uni-ml-perfil-desc").show(); 
  $(".uni-ml-perfil i").show();   

  $(".uni-ml .uni-ml-config-usuario .uni-ml-perfil img").css("height","var(--var-ml-altura-itens)");
};   

$(document).ready(function() {
  function GetValorVariavel(AVariavel) {
    const LRootStyles = getComputedStyle(document.documentElement);
    const LValorEmPixel = LRootStyles.getPropertyValue(AVariavel);
    return parseInt(LValorEmPixel);
  };
  
  $(window).on("resize", function() {
    var larguraUniML = $(".uni-ml").width();

    if (larguraUniML <= 34) {
      MenuLateralMinimizado();
    } else {
      MenuLateralMaximizado();
    }
  });
    
  /* Minimizar ou maximizar menu */
  $(".uni-ml-logo").click(function() {
    if (GetValorVariavel("--var-ml-tamanho") == LTamanhoMenuMinimizado) {
      MenuLateralMaximizado()
    } else {
      MenuLateralMinimizado();   
    }
  });
   
  $(".uni-ml-pesquisa").click(function(){
    if (LMinimizado == 'S') {
      MenuLateralMaximizado();
      $("#uni-ml-pesquisar").focus();
    };
  });

  $(".uni-ml-config-usuario-tema-1").click(function () {  
    AlterarTema();
    TemaBlack();    
  });

  $(".uni-ml-config-usuario-tema-2").click(function () {  
    AlterarTema();
    TemaBlack();
  });  
});