# UniChat — exemplo inspirado no WhatsApp Web

Aplicação standalone em Delphi/uniGUI, baseada no demo e no `FrameFlexPanel` deste repositório.

## Abrir e executar

1. Abra `WhatsAppWeb.dproj` no Delphi, com uniGUI e UniDSA instalados.
2. Compile em **Win32** e execute `bin\Win32\Debug\WhatsAppWeb.exe`.
3. Acesse **http://localhost:8078**.

O projeto usa os fontes UniDSA em `..\..\sources`. O build copia automaticamente `Files` e os assets de `..\..\dsa\flex` para a pasta `files` ao lado do executável. Para distribuir, leve o executável, essa pasta e o runtime web do uniGUI correspondente à instalação.

Também é possível compilar pelo PowerShell:

```powershell
.\Build.ps1
# Outra versão instalada do Delphi:
.\Build.ps1 -BdsVersion '37.0' -Config Release
```

Validado com Delphi 13 (37.0), uniGUI instalado localmente e Chrome. A porta é configurada em `ServerModule.dfm`.

## Composição no designer

- `Main.dfm`: dois frames **inline**, inseridos em design-time.
- Frames/FrameContatos.dfm: cabeçalho, pesquisa, filtros e cinco conversas.
- Frames/FrameContato.dfm: frame reutilizável usado nas prévias de contato do designer.
- `Frames/FrameConversa.dfm`: cabeçalho da conversa, aviso AutoHeight, histórico completo e campo de envio.
- `Frames/FrameMensagem.dfm`: frame reutilizável com linha, balão, texto e horário.
- `DadosChat.pas`: mensagens e dados de exemplo mantidos por sessão.

Todos os controles visuais são definidos nos DFMs. Em execução, cada mensagem instancia o `TFrMensagem` completo a partir do DFM; nenhum label ou painel é montado manualmente em Pascal. Enviar uma mensagem acrescenta apenas seu frame. Trocar de conversa libera os frames anteriores e carrega todo o histórico da conversa selecionada.

Os cabeçalhos, linhas de contato, linhas de mensagem, balões e rodapé usam `TUniDSAFlexPanel` com **`Flex.AutoHeight = True`**. Os balões também usam `Flex.AutoWidth = True`. `Responsive.XS.Span = 0` permite que os itens sigam `Basis`/`Grow`, em vez de ocupar as 12 colunas por padrão.

O contêiner raiz preenche o frame; histórico e lista usam `Grow = 1`, `Basis = '0px'` e `Overflow = foAuto`. O histórico usa `Wrap = fwNoWrap`, e cada `TFrMensagem` recebe um `FlexItem` com `Shrink = 0` e `Basis = 'auto'`. As mensagens mantêm sua altura natural e o excedente gera rolagem, sem virar faixas horizontais. O `FlexItems` do campo de envio distribui espaço entre o `TUniEdit` e o botão.

O histórico não usa paginação nem um limite de oito balões. Todas as mensagens ficam disponíveis pela rolagem. O `FrConversa` contém quatro `TFrMensagem` inline e o `FrContatos` contém três `TFrContato` inline para visualizar a composição na IDE. Ao carregar o site, essas prévias são ocultadas e liberadas após a carga inicial do uniGUI, antes de apresentar os dados reais.

O aviso usa `flexAviso.Flex.AutoHeight = True`, padding nativo e label com quebra de texto. O fundo acompanha a altura do conteúdo.

Fonte, tamanho, cor do texto e alinhamento são configurados pelas propriedades nativas `Font` e `Alignment` dos controles nos DFMs. Os componentes **`TUniDSAStyle`** ficam responsáveis pelos efeitos e recursos adicionais: estados Hover/Selected, bordas arredondadas, sombras, reticências, quebra de mensagens, scrollbar personalizada e breakpoints para telas estreitas. A lista e o histórico configuram `Appearance.Scrollbar` no próprio DFM. Foram removidos os vínculos usados apenas para formatação simples. Não há dependência de CSS ou JavaScript específico da aplicação. A navegação móvel é controlada pelos eventos Delphi do formulário, e TUniDSAFlexPanel.RolarParaFim encapsula a rolagem do navegador. Veja [a documentação do componente](../../docs/Style.md) para personalizar pelo Object Inspector.

## Funcionalidades

- Pesquisa por nome e filtro de conversas não lidas.
- Troca de conversa e preservação do rascunho de cada contato.
- Envio pelo botão ou Enter, com limite de 2.000 caracteres e rejeição de texto vazio.
- Histórico completo, horários, balões recebidos/enviados e prévia do último envio.
- Layout para desktop e celular, com botão para voltar à lista.
- Sessões independentes; texto exibido com conversão regular do `TUniLabel`, preservando `&` e escapando HTML.

Este exemplo simula conversas locais. Não conecta ao WhatsApp, não transmite para outros usuários e não grava em banco. Os dados se perdem quando a sessão termina.

## Validação no navegador

Com a aplicação em execução e o módulo Node `playwright` disponível:

```powershell
$env:CHROME_PATH = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
node tests\ui.cjs
```

Se o módulo estiver instalado em outro diretório, configure `NODE_PATH`. `CHAT_URL` permite testar outro endereço; sem `CHROME_PATH`, o teste usa o Chromium do Playwright. As capturas ficam em `tmp`.

O teste cobre carregamento dos frames/DFMs, filtros, busca sem resultados, envio por botão e Enter, texto com HTML literal, rascunhos, histórico integral, mensagem longa com AutoHeight, isolamento de sessões, dimensões do layout móvel, hover e ausência de carregamento de `chat.css`.

Os avatares e contadores usam FlexItems.Shrink = 0 no painel pai para manter a largura; as áreas de texto podem encolher. Font.OverrideDefaults força a fonte nativa configurada mesmo quando coincide com o padrão do uniGUI. Os testes verificam sobreposição e largura já no primeiro carregamento.

`DadosChat.pas` usa `TMensagemChat`, `TConversa` e `TConversas`, com campos em português. O método `AdicionarMensagem` valida texto vazio e o limite de caracteres; não há cálculo de páginas no modelo.
