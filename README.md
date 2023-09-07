# Paleta de componentes UniDSA para UniGUI no Delphi

![](https://i.ibb.co/VvFk21N/logo-unidsa.png)

O **UniDSA** é uma paleta inovadora de componentes desenvolvida especificamente para aprimorar e estender as capacidades do **UniGUI no Delphi**. Composta por ferramentas altamente customizáveis, esta paleta visa oferecer soluções mais elegantes e eficazes para a construção de interfaces de usuário modernas.


**Componentes disponíveis**

> TUniDSAQrCodeReader
> TUniDSAConfirm
> TUniDSAToast
> TUniDSAMenuLateral

## [![TUniDSAQrCodeReader](https://i.ibb.co/rvfWQs8/TUni-DSAQr-Code-Reader.png "TUniDSAQrCodeReader")](https://i.ibb.co/rvfWQs8/TUni-DSAQr-Code-Reader.png "TUniDSAQrCodeReader")  TUniDSAQrCodeReader 

Este é um componente avançado desenvolvido para aproveitar o poder do **HTML5** na leitura de uma ampla gama de** códigos de barras e QR codes**. Projetado para ser altamente flexível, o TUniDSAQrCodeReader oferece aos desenvolvedores a capacidade de personalizar exatamente quais tipos de códigos desejam ler, bem como a opção de escolher o dispositivo específico para leitura.

#### Compatibilidade de Tipos de Códigos:

| Tipo | Descrição |
|------------- | -------------|
|QR_CODE|  Permite a leitura de QR codes padrão.|
|AZTEC| Suporte para leitura de códigos Aztec|
|CODABAR| Identifica e lê códigos Codabar|
|CODE_39, CODE_93, CODE_128| Leitura abrangente de códigos Code, cobrindo variações 39, 93 e 128.|
|DATA_MATRIX| Habilitado para reconhecer e interpretar códigos Data Matrix.|
|MAXICODE| Suporte para códigos MaxiCode.|
|ITF| Compatível com códigos Interleaved 2 of 5 (ITF).|
|EAN_13, EAN_8| Leitura de códigos EAN, incluindo as variações 13 e 8.|
|PDF_417| Suporte para códigos PDF417.|
|RSS_14, RSS_EXPANDED| Habilitado para códigos RSS, tanto na versão 14 quanto na versão expandida.|
|UPC_A, UPC_E, UPC_EAN_EXTENSION| Compatível com variações UPC, incluindo extensões EAN.|

#### Características Principais:

+ Seleção de Tipo de Código: Os desenvolvedores têm a liberdade de marcar ou desmarcar tipos de códigos específicos para leitura, de acordo com as necessidades de sua aplicação.

+ Escolha do Dispositivo: Fornece a opção de selecionar o dispositivo específico para leitura, garantindo maior versatilidade na captação dos códigos.

#### Imagem:

[![](https://i.ibb.co/NjD2Nvg/image.png)](https://i.ibb.co/NjD2Nvg/image.png)

> Imagem ilustrativa, pois o componente pode ter opções de personalizações...


## [![TUniDSAConfirm](https://i.ibb.co/F7whv8F/TUni-DSAConfirm.png "TUniDSAConfirm")](https://i.ibb.co/F7whv8F/TUni-DSAConfirm.png "TUniDSAConfirm") TUniDSAConfirm

O TUniDSAConfirm serve para criar e gerenciar janelas de diálogo modais para confirmações, alertas e prompts, sendo baseado no plugin disponível em [jquery-confirm](https://github.com/craftpip/jquery-confirm "jquery-confirm") . Este componente fornece uma ampla gama de propriedades e métodos que permitem uma personalização detalhada das janelas de diálogo, englobando desde o conteúdo exibido até aspectos estéticos e funcionais da janela.

#### Principais Propriedades e Métodos:

 **Gerais**:

+ `Title` Define o título da janela de diálogo.
+ `Content` Define o conteúdo principal da janela de diálogo.
+ `Icon` Permite definir um ícone para a janela de diálogo.
+ `Theme` Define o tema da janela, permitindo personalização estética.

**Controle de Janela:**

+ `Draggable` Controla se a janela pode ser arrastada.

**Conteúdo:**

+ `ContentFile` Permite carregar o conteúdo da janela a partir de um arquivo externo.
+ `SmoothContent` Habilita uma transição suave para o conteúdo.

**Botões:**

+ `Buttons` Define os botões disponíveis na janela de diálogo.
+ `OnButtonClick` Evento acionado ao clicar em um botão.

**Animações:**

+ `Animation` Define o tipo de animação usado ao abrir e fechar a janela.
+ `TypeAnimated` Define se a janela terá animação ao mudar de tipo.

**Layout e Estilo:**

+ `BoxWidth` Define a largura da janela.
+ `ColumnClass` `TitleClass` Permite definir classes customizadas para diferentes elementos da janela.

**Eventos:**

+ `OnOpen`, `OnClose`, `OnDestroy`, `OnAction`, `OnContentReady` Diversos eventos que permitem o controle detalhado do ciclo de vida da janela de diálogo.

**Outras Propriedades:**

+ `Type` Define o tipo de janela de diálogo (confirm, alert, etc.).
+ `UseBootstrap` Define se o Bootstrap será usado para estilização.
+ `RTL` Habilita o suporte a idiomas escritos da direita para a esquerda.

**Métodos Públicos:**

+ `Show` Exibe a janela de diálogo.
+ `Alert`, `Dialog`, `Prompt`, `Confirm` Exibem janelas de diálogo com características pré-definidas para diferentes finalidades.
+ `Clear`, `ClearEvents` Métodos para limpar propriedades e eventos associados à janela.


#### Imagem:

[![](https://i.ibb.co/PhvMbfb/image.png)](https://i.ibb.co/PhvMbfb/image.png)

> Imagem ilustrativa, pois o componente pode ter opções de personalizações...


## [![TUniDSAToast](https://i.ibb.co/sKG9YDB/TUni-DSAToast.png "TUniDSAToast")](https://i.ibb.co/sKG9YDB/TUni-DSAToast.png "TUniDSAToast") TUniDSAToast

O TUniDSAToast é uma classe que representa uma notificação simples e breve, frequentemente usada para fornecer feedback aos usuários sobre uma ação ou evento em uma aplicação. Baseado no plugin jquery-toast-plugin, este componente permite criar notificações toast estilizadas e personalizadas para aplicações UniGUI desenvolvidas em Delphi.

**Principais propriedades e métodos:**

**Gerais:**

+ `Text` Define o texto principal da notificação.
+ `Heading` Define o cabeçalho ou título da notificação.
+ `Icon` Define um ícone para a notificação. Diferentes ícones podem ser usados para + indicar o tipo ou a importância da notificação.

**Comportamento:**

- `ShowHideTransition` Determina o tipo de transição usado ao mostrar ou esconder a notificação.
- `HideAfter` Define o tempo (em milissegundos) após o qual a notificação será automaticamente escondida.
- `AllowToastClose` Se True, permite que os usuários fechem a notificação manualmente.
- `Stack` Define quantas notificações podem ser exibidas simultaneamente.

**Estilo e Aparência:**

- `BgColor` Define a cor de fundo da notificação.
- `TextColor` Define a cor do texto da notificação.
- `TextAlign` Define o alinhamento do texto na notificação.
- `Position` Define a posição na tela onde a notificação aparecerá.
- `Loader` Especifica o tipo e o comportamento do carregador mostrado nas notificações.

**Eventos:**

- `OnBeforeShow` Acionado antes da notificação ser exibida.
- `OnAfterShown` Acionado após a notificação ser exibida.
- `OnBeforeHide` Acionado antes da notificação ser escondida.
- `OnAfterHidden` Acionado após a notificação ser escondida.

**Métodos Públicos:**

- `Show` Exibe a notificação com as propriedades definidas.
- `Clear` Limpa a notificação atual.
- `Reset` Reinicializa a notificação para seus valores padrão.

O componente **TUniDSAToast** proporciona uma maneira flexível e elegante de fornecer feedback para os usuários, sem ser intrusivo. Ao utilizar este componente em projetos Delphi com UniGUI, os desenvolvedores podem melhorar significativamente a experiência do usuário, fornecendo notificações contextuais relevantes em resposta a diversas ações e eventos.

#### Imagem:

[![](https://i.ibb.co/HC6cC7h/image.png)](https://i.ibb.co/HC6cC7h/image.png)

> Imagem ilustrativa, pois o componente pode ter opções de personalizações...

## [![TUniDSAMenuLateral](https://i.ibb.co/ScfMkHd/TUni-DSAMenu-Lateral.png "TUniDSAMenuLateral")](https://i.ibb.co/ScfMkHd/TUni-DSAMenu-Lateral.png "TUniDSAMenuLateral") TUniDSAMenuLateral

Este é um componente que representa um menu lateral, comumente usado em aplicações web para fornecer navegação e opções adicionais, normalmente situado no lado esquerdo ou direito da página.

**Principais propriedades e métodos:**

**Gerais:**

- `Logo`: Controla a aparência e comportamento do logotipo na parte superior do menu.
 - `UrlImage` Define a imagem do logo
 - `CompanyName` Define o nome do cliente/empresa
- `Search`: Permite a pesquisa dentro do menu.
 - `Icon` Define o icone da área de pesquisa.
 - `TextPrompt` Define o texto informativo que será exibido na área da pesquisa, padrão "Pesquisar.."
 - `AutoComplete` Habilitar ou desabilitar a sugestão com bases nos textos já utilizados.
 - `Visible` Define se o pesquisar será exibido.
 - `SearchText` Texto pesquisado pelo usuário.
- `Theme` Define o tema visual do menu.
 - `TitleLeft` Título do tema a esquerda.
 - `TitleRight` Título do tema a direita.
 - `StyleLeft` Estilo do tema a esquerda
  - `StyleRight` Estilo do tema a direita
  - `Visible` Define se ficará visível para o usuário a opção de mudança de temas
- `Menu`: Controla os itens individuais dentro do menu.
 - `Icon` Define o icone do menu (Font Awesome 5.15.4)
 - `Caption` Descrição do menu
 - `NotificationCount` Quando maior que 0 será exibido ao lado do menu a quantidade de notificações.
 - `Visible` Define se o menu ficará visivel.
 - `Enabled` Define se o menu ficará ativo
 - `Hidden` Define se o menu ficará visível mantendo o local do mesmo.
 - `Separator` Define que o menu será um separador de menus
 - `Hint` Descrição do menu ao passar o mouse por cima.
 - `OnClick` Acionado ao clicar no menu
 - `OnClickNotification` Acionado ao clicar na notificação do menu.
 - `OnClickRef` Acionado ao clicar no menu (Usado em runtime)
 - `OnClickNotificationRef` Acionado ao clicar na notificação do menu (Usado em runtime)
- `Profile` Permite exibir informações de perfil, como nome de usuário ou imagem, no menu.
 - `Name` Nome do usuário do sistema
 - `Email` E-mail do usuário do sistema
 - `ImageURL` Imagem do usuário do sistema
 - `Visible` Indica se o perfil do usuário será visível.
- `Style` Controla o estilo visual geral do menu.
 - `PaddingTop` Similiar ao padding-top do CSS. Define o espaço interno no topo do elemento.
 - `PaddingLeft` Similar ao padding-left do CSS. Define o espaço interno à esquerda do elemento.
 - `PaddingRight` Similar ao padding-right do CSS. Define o espaço interno à direita do elemento.
 - `PaddingBottom` Similar ao padding-bottom do CSS. Define o espaço interno na parte inferior do elemento.
 - `BorderRadiusTopLeft` Similar ao border-top-left-radius do CSS. Define o raio da borda no canto superior esquerdo.
 - `BorderRadiusTopRight` Similar ao border-top-right-radius do CSS. Define o raio da borda no canto superior direito.
 - `BorderRadiusBottomLeft` Similar ao border-bottom-left-radius do CSS. Define o raio da borda no canto inferior esquerdo.
 - `BorderRadiusBottomRight` Similar ao border-bottom-right-radius do CSS. Define o raio da borda no canto inferior direito.
 - `BorderTop` Similar ao border-top do CSS. Define a espessura da borda superior do elemento.
 - `BorderLeft` Similar ao border-left do CSS. Define a espessura da borda à esquerda do elemento.
 - `BorderRight` Similar ao border-right do CSS. Define a espessura da borda à direita do elemento.
 - `BorderBottom` Similar ao border-bottom do CSS. Define a espessura da borda inferior do elemento.

**Comportamento:**

- `MenuState` Define o estado atual do menu (por exemplo, minimizado ou maximizado).
- `SelectedDiretionTheme` Determina a direção do tema selecionado.
- `SelectedTheme` Especifica o tema de estilo selecionado.
- `SelectedMenu` Indica qual item de menu foi selecionado.
- `AjaxSecurity` Um booleano que determina se a segurança Ajax está habilitada ou não.

**Métodos Públicos:**

- `MinimizeMaximize` Alterna entre os estados minimizado e maximizado do menu.
- `HideMenu` Oculta o menu.
- `ShowMenu` Exibe o menu.
- `SetTheme` Define o tema do menu.

**Eventos:**

- `OnClickLogo` Acionado quando o logotipo é clicado.
- `OnClickMenu` Acionado ao clicar em um item do menu.
- `OnClickNotificationMenu` Acionado ao clicar em uma notificação no menu.
- `OnAfterSelectTheme` Acionado após selecionar um tema.
- `OnClickProfile` Acionado ao clicar no perfil.
- `OnClickLogoff` Acionado ao clicar no botão de sair/logoff.
- `OnSearchEnter` Acionado quando um termo de pesquisa é inserido.
- `OnClickIconSearch` Acionado ao clicar no ícone de pesquisa.

#### Imagem:

[![](https://i.ibb.co/c1r46Bf/image.png)](https://i.ibb.co/c1r46Bf/image.png)

> Imagem ilustrativa, pois o componente pode ter opções de personalizações...


