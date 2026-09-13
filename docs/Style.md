# TUniDSAStyle

Componente não visual para personalizar controles uniGUI pelo Object Inspector. As propriedades são persistidas no DFM. O componente gera regras isoladas por ID do controle, sem exigir classes em `ClientEvents`, seletores Ext JS ou arquivos CSS próprios da aplicação.

## Instalação

Atualize os pacotes `UniDSA` e `UniDSADesign`. Com o RAD Studio fechado, execute `tools\Install-UniDSA.ps1`, ou faça Build/Install pelo procedimento do README. `UniDSA` registra o componente na paleta; `UniDSADesign` acrescenta seleção de controles, lista de estilos em `StyleName` e o comando **Validar estilos e controles**.

O mecanismo JavaScript está incorporado ao Pascal em `UniDSAStyleRuntime.inc`. Não há nova pasta para publicar em `files`. Os assets originais do uniGUI e dos outros componentes, como FlexPanel, continuam necessários.

## Configurar pelo Object Inspector

1. Coloque um `TUniDSAStyle` no formulário ou frame.
2. Abra `Styles`, adicione um item e defina `Name`, por exemplo `PrimaryButton`.
3. Configure `Appearance` e, se necessário, `States.Hover`, `States.Focus` e os demais estados.
4. Em `StyleItems`, adicione um item, selecione `Control` e escolha `StyleName`.
5. Use `StyleItems[].Appearance`, `States` e `Responsive` para ajustes específicos daquele controle.

`Styles` contém estilos reutilizáveis dentro da instância do gerenciador. `StyleItems` permite controles uniGUI, frames e formulários. Um controle pode ter somente um item por gerenciador. Nomes de estilos são únicos e comparados sem diferenciar maiúsculas/minúsculas; renomear um estilo atualiza as referências em `StyleItems`. Uma referência inexistente é diagnosticada por `Validate` e ao aplicar a configuração.

`Defaults` define valores comuns a todos os itens. Opcionalmente, `TargetContainer` aplica esses padrões a um controle/painel/frame/formulário; `IncludeChildren = True` inclui os controles descendentes desse alvo. A aplicação aos descendentes é explícita e não afeta outras janelas.

## Colar CSS para configurar as propriedades

`ImportCSS` está disponível em `Styles[]`, `StyleItems[]` e `Defaults`. No Object Inspector:

1. Adicione ou selecione um item em `Styles`.
2. Abra o botão `...` de `ImportCSS`.
3. Cole o CSS, escolha **Substituir estilo** (padrão) ou **Mesclar com o atual** e clique em **Importar**.
4. Associe o estilo ao controle em `StyleItems`, usando `Control` e `StyleName`.

Também é possível importar diretamente em um `StyleItems[]` já associado a um controle. O nome do seletor, como `.card`, identifica os blocos do texto; não procura controles, não cria classes e não altera o `Name` do estilo.

| Bloco colado | Propriedades preenchidas |
|---|---|
| `.card { ... }` ou declarações sem seletor | `Appearance` |
| `.card:hover { ... }` | `States.Hover` |
| `.card:active { ... }` | `States.Pressed` |
| `.card:focus { ... }` | `States.Focus` |
| `.card:disabled { ... }` | `States.Disabled` |

Um bloco pode configurar vários estados ao mesmo tempo, inclusive com quebras de linha e comentários entre os seletores:

```css
.button-1:hover,
.button-1:focus {
  background-color: #F082AC;
}
```

Nesse caso, a declaração é aplicada a `States.Hover` e `States.Focus`, que continuam editáveis separadamente. Os campos `CustomCSS` dos estados também recebem as declarações sem conversão. Regras posteriores podem alterar somente um dos estados. Todos os seletores do grupo devem usar a mesma base; listas vazias, seletores diferentes ou estados sem suporte cancelam a importação sem alterar o estilo anterior.

O [exemplo completo do card](../tools/fixtures/style-card.css), atribuído a SteveBloX/Uiverse no próprio CSS, é aceito com comentários e espaços codificados como `&#x20;`, `&#32;` ou `&nbsp;`. A importação preenche dimensões, fundo com transparência, borda, raio, sombra, blur, alinhamento flex, tipografia, cursor, seleção de texto, transição, escala e rotação. Por exemplo:

```pascal
ControlStyle.Styles.Find('Card').ImportCSS :=
  '.card { background: rgba(217,217,217,0.58); border-radius: 17px; transition: all 0.5s; }' +
  '.card:hover { transform: scale(1.05); }' +
  '.card:active { transform: scale(0.95) rotateZ(1.7deg); }';
```

Depois da importação, os parâmetros continuam editáveis normalmente. O texto de `ImportCSS` não fica armazenado e não é executado ao carregar o formulário: o DFM salva as propriedades resultantes. No modo **Substituir estilo**, a importação começa com uma regra vazia e substitui `Appearance`, todos os estados, `Content`, `Before`, `After`, `Responsive` e seus campos `CustomCSS`. No modo **Mesclar com o atual**, atualiza as propriedades correspondentes e preserva as demais configurações, inclusive `Responsive`. As regras de herança e prioridade de estados do Style continuam valendo.

A conversão ocorre primeiro em uma cópia. Declarações sem conversão para propriedades são preservadas em `Appearance.CustomCSS` (ou no `CustomCSS` do estado correspondente), aplicado por último. Seletores sem suporte e erros estruturais, como chaves ou parênteses incompletos, ainda cancelam a importação inteira; em código, a falha lança `EArgumentException`. O editor mantém o texto para correção.

### Substituir ou limpar o estilo anterior

Use **Substituir estilo**, selecionado por padrão na janela, ao colar um novo visual completo. Isso evita que sombras, dimensões, hover, transições, pseudo-elementos ou CSS complementar do visual anterior continuem ativos. **Mesclar com o atual** é útil para importar apenas um ajuste.

A substituição só é aplicada depois de processar o novo texto inteiro. Se houver um erro estrutural, a regra anterior fica intacta. Cancelar, deixar o texto vazio ou colar somente comentários não limpa o estilo.

Em código, `LoadCSS` substitui por padrão; passe `False` para mesclar. `Reset` limpa a regra sem importar outro texto:

```pascal
// Novo visual completo: limpa a regra anterior e importa em uma única operação.
ControlStyle.Styles.Find('Card').LoadCSS(NovoCSS);

// Apenas um ajuste sobre o estilo atual.
ControlStyle.Styles.Find('Card').LoadCSS('border-radius: 12px;', False);

// Limpar somente as configurações deste estilo.
ControlStyle.Styles.Find('Card').Reset;
```

Os métodos também existem em `StyleItems[]` e `Defaults`. A atribuição direta à propriedade `ImportCSS` em código mantém o comportamento de mesclagem, por compatibilidade.

A limpeza é restrita à regra selecionada. Preserva `Name`, `Control`, `StyleName`, `Enabled` e `Selected` das associações. `Defaults`, um estilo nomeado herdado e as propriedades nativas do controle continuam valendo; limpar os ajustes locais de um `StyleItems[]` não apaga esses outros estilos. Substituir um item de `Styles[]` atualiza todos os controles que o utilizam.

### Formatos convertidos em propriedades

- Um seletor simples (classe, ID ou elemento), com os estados da tabela. Aceita grupos separados por vírgula quando todos usam o mesmo seletor base, como `.button-1:hover, .button-1:focus`. Blocos repetidos são processados na ordem do texto. Também aceita somente declarações.
- Dimensões e deslocamentos com `px`, `%`, `em`, `rem`, `vw`, `vh` e `dvh`, além dos valores automáticos do grupo `Sizing`.
- Cores `#RGB`, `#RRGGBB`, `rgb(r,g,b)` e `rgba(r,g,b,a)`, com canais RGB inteiros. Nomes aceitos: black, white, red, green, blue, yellow, gray/grey, silver, navy, teal, purple, maroon, lime, aqua, fuchsia e orange. `transparent` e alpha são aceitos no fundo e sombra; alpha é convertido para porcentagem inteira.
- Fundo de cor única; `border: largura tipo cor`, `border: none`, cor/largura/tipo independentes e raio uniforme em pixels inteiros.
- Uma sombra `x y [blur [spread]] cor`, com `inset` opcional no início, ou `none`. `backdrop-filter` aceita `blur(px)` e `none`.
- Display, alinhamento flex, cursor, user-select, opacidade, tipografia básica, overflow, posição, z-index e padding/margin de um a quatro valores inteiros em pixels.
- `transition: all <tempo> [ease]` ou duração sem `all`, com `s`/`ms`; `transition-duration` ajusta a duração. Outras curvas, delays e listas de transições são preservados em `CustomCSS`.
- `transform: scale(x[,y]) rotateZ(graus) skewX(graus) skewY(graus)`, nessa ordem, com funções opcionais e sem repetição; `rotate` é alias de `rotateZ`. Skew aceita graus inteiros entre -89 e 89. `none` redefine todos os eixos para a transformação identidade. Escala e rotação aceitam decimais.

Múltiplos seletores base, seletores compostos/descendentes, pseudo-elementos e regras `@media`/`@keyframes` não são importados. Configure `Before`, `After` e `Responsive` manualmente quando necessário. Declarações com múltiplas sombras, variáveis CSS, `calc()`, `!important`, gradientes, imagens ou valores que o modelo não representa são mantidas em `CustomCSS`. Isso também inclui valores reservados do modelo, como `margin: -1px`.

### CustomCSS: declarações aplicadas por último

`CustomCSS` é um campo de texto multilinha em `Appearance`, nos estados, em `Content`, `Before` e `After`. Abra seu botão `...` para editar as declarações. O DFM guarda esse conteúdo; edições em runtime notificam o gerenciador automaticamente.

Por exemplo, os dois formatos abaixo são equivalentes para `ImportCSS`: a regra `.box { ... }` inteira ou apenas seu conteúdo.

```css
.box {
  border-radius: 46px;
  background: #e0e0e0;
  box-shadow: 34px 34px 68px #a4a4a4,
              -34px -34px 68px #ffffff;
}
```

O resultado é:

- `Appearance.Border.Radius = 46`.
- `Appearance.Background.Color` recebe `#e0e0e0`.
- `Appearance.CustomCSS` recebe a declaração completa de `box-shadow`, incluindo as duas sombras e sua ordem.

O CSS complementar é aplicado depois das propriedades tipadas para aquela aparência/estado. Portanto, uma declaração em `CustomCSS` prevalece sobre uma propriedade que gere o mesmo CSS. Para voltar a controlar esse atributo somente pelas propriedades, remova a declaração do campo. Uma nova importação de uma declaração convertível, como `box-shadow: none`, remove automaticamente o fallback anterior de mesmo nome naquela aparência.

`Defaults`, estilos nomeados e ajustes do item combinam seus campos `CustomCSS` na ordem de herança. O navegador resolve declarações repetidas; os estados continuam respeitando a prioridade normal do Style e o bloqueio de hover/pressed quando desabilitado. O CSS é restrito aos controles associados e às partes reconhecidas pelo componente; não cria uma folha global.

Cole somente declarações em `CustomCSS`, sem seletores ou blocos. O navegador interpreta os valores e ignora declarações inválidas ou sem suporte. A importação preserva a grafia de variáveis como `--Accent` e `var(--Accent)`.

### Novas propriedades editáveis

- `Appearance.AlignItems` e `JustifyContent`: alinhamento dos filhos quando o display permite.
- `Transform.ScaleX` / `ScaleY`: fator de escala, sendo `1` o tamanho original; `RotateZ`: rotação em graus. `-1000` preserva a camada anterior em cada propriedade.
- `Effects.BackdropBlur`: blur do fundo em pixels; `-1` preserva a camada anterior e `0` remove o blur. Só é emitido quando configurado explicitamente.
- `Effects.UserSelect`: `susAuto`, `susNone`, `susText`, `susAll` e `susInherit`.
- `Typography.Weight`: também aceita `swBolder` e `swLighter`, relativos ao peso herdado.

Essas propriedades também podem ser usadas nos estados, conteúdo interno, pseudo-elementos e regras responsivas. Confira o resultado no navegador: o designer VCL não reproduz integralmente CSS.

## Grupos de propriedades

| Grupo | Propriedades |
|---|---|
| `Display` | `sdInherit`, `sdNone`, `sdBlock`, `sdInline`, `sdInlineBlock`, `sdFlex`, `sdInlineFlex`, `sdGrid` e `sdInlineGrid`. |
| `Transform` | Inclinação `SkewX`/`SkewY`, escala `ScaleX`/`ScaleY` e rotação `RotateZ`. `-1000` preserva a camada anterior; escala 1 e ângulo zero representam identidade. |
| `Content` | Aparência do conteúdo interno, incluindo `Display` e `Transform` independentes da raiz. |
| `Before` / `After` | Pseudo-elementos decorativos, com `Enabled`, `Text` e grupos de aparência próprios. |
| `Background` | Cor/opacidade do fundo, URL de imagem, tamanho/repetição, gradiente linear/radial, padrões de pontos/grade/linhas. |
| `Border` | Cor, largura e tipo; quatro lados independentes; raio geral ou por canto. |
| `Typography` | Família, tamanho em pixels, cor, peso, itálico, alinhamento, entrelinha, espaçamento de letras, quebra, reticências, transformação e decoração. |
| `Spacing` | `Padding` e `Margin`, com `All` e quatro lados. |
| `Sizing` | Largura/altura e limites mínimos/máximos, `MaxWidthPercent`, box sizing e overflow por eixo. |
| `Scrollbar` | Visibilidade, espessura, cor da trilha, cor do indicador, cor no hover e raio do indicador. |
| `Shadow` | Habilitação, cor, opacidade, deslocamentos, blur, spread e sombra interna. Múltiplas sombras importadas ficam em `CustomCSS`. |
| `CustomCSS` | Declarações complementares aplicadas após as propriedades, com editor de texto multilinha. |
| `Effects` | Opacidade do controle inteiro, cursor, `TransitionMs`, `TransitionAll`, `BackdropBlur`, `UserSelect`, outline/cor/deslocamento. |
| `Position` | Posicionamento, `Insets` em pixels, `Top`/`Right`/`Bottom`/`Left` com unidades e z-index. Use somente quando quiser substituir explicitamente o posicionamento do layout. |

Dimensões têm `Value` e `Units`: `suPx`, `suPercent`, `suEm`, `suRem`, `suVw`, `suVh`, `suDvh`, `suAuto`, `suFitContent`, `suMinContent` e `suMaxContent`. `suUnset` preserva a dimensão original. Nos valores automáticos, `Value` é ignorado.

`Sizing.MaxWidthPercent` pode ser usado junto com `Sizing.MaxWidth` para um limite como `min(82%, 620px)`. Isso é usado nos balões do exemplo.

### Rolagem e aparência da scrollbar

A existência da rolagem continua sendo definida pelo layout: use `Flex.Overflow = foAuto` em um `TUniDSAFlexPanel`, ou `Sizing.OverflowY = soAuto` quando o controle não oferece uma propriedade nativa equivalente. Em uma coluna de itens com altura automática, use `Flex.Wrap = fwNoWrap` no contêiner e `FlexItems[].Shrink = 0` nos filhos. Assim, cada filho conserva sua altura e o excedente passa a ser rolado.

`Appearance.Scrollbar` modifica somente o acabamento da área rolável:

- `Visible`: `ssInherit` preserva o navegador, `ssYes` mostra e `ssNo` oculta a barra sem desativar a rolagem.
- `Size`: espessura em pixels; `-1` preserva o valor atual.
- `TrackColor`: cor da trilha.
- `ThumbColor`: cor do indicador móvel.
- `ThumbHoverColor`: cor do indicador quando o ponteiro está sobre ele.
- `Radius`: arredondamento do indicador em pixels.

Para um FlexPanel, o componente aplica essas regras também ao contêiner interno criado pelo uniGUI/Ext JS. Isso permite configurar a lista no Object Inspector sem descobrir seletores internos nem manter um arquivo CSS.

Os controles suportam explicitamente adaptações para botões (incluindo o texto interno), campos `.x-field` como Edit/Memo/ComboBox, labels, contêineres, painéis, frames e formulários. Outros controles recebem as regras na raiz; partes especializadas de grids, árvores, menus e seus popups não têm editores de subpartes nesta versão.

## Valores não definidos e herança

A precedência é **Defaults → estilo nomeado → ajustes do item**. Dentro de cada camada, as regras responsivas aplicáveis são mescladas em ordem. Os estados são aplicados sobre a aparência resultante.

- `clNone`: cor não definida, preserva o valor da camada anterior ou do tema.
- `-1`: não definido para tamanhos inteiros/opacidade/espaçamento; zero é um valor explícito.
- `-1000`: não definido para valores que podem ser negativos, como letter spacing, deslocamento de sombra e z-index.
- `ssInherit`, `suUnset` e os demais enums `Inherit`: preservam o valor anterior.
- Para fundo transparente, configure uma cor e `Background.Opacity = 0`.
- `Typography.LineHeight` usa um multiplicador: `1.5` equivale a 150%.
- `Typography.TextOverflow = toEllipsis` deve ser combinado com `WhiteSpace = wsNoWrap` e `Sizing.OverflowX = soHidden`.

Propriedades não configuradas não geram declarações. `Enabled = False` remove as regras daquele gerenciador; reativá-lo as recompõe. `StyleItems[].Enabled = False` exclui aquela associação. Com `IncludeChildren = True`, o controle ainda pode receber os padrões do alvo como descendente.

## Hover e outros estados

Cada estado tem os mesmos grupos de propriedades de `Appearance`:

- `States.Hover`: ponteiro sobre um controle habilitado.
- `States.Focus`: foco no controle ou em seu campo interno.
- `States.Pressed`: enquanto o controle está sendo pressionado.
- `States.Disabled`: estado desabilitado reconhecido pelas classes/atributos uniGUI.
- `States.Selected`: ativado por `StyleItems[].Selected`; não desabilita o controle.

A prioridade dos estados é Selected → Hover → Focus → Pressed → Disabled, somente para propriedades configuradas. Hover/foco/pressionado não prevalecem em controles desabilitados. Não são acrescentados eventos Delphi ou sobrescritos `ClientEvents` para implementar esses estados. Configure `Appearance.Effects.TransitionMs` para transições de cores, bordas, sombras, opacidade e transformações. `TransitionAll = ssYes` inclui todas as propriedades CSS animáveis, como os deslocamentos de um pseudo-elemento. Cada parte possui sua própria configuração de transição. Alterar somente a duração em um estado preserva a seleção de propriedades da aparência base.

Exemplo de DFM:

```pascal
object ControlStyle: TUniDSAStyle
  Styles = <
    item
      Name = 'PrimaryButton'
      Appearance.Background.Color = 6913800
      Appearance.Border.Width = 0
      Appearance.Border.Radius = 9
      Appearance.Typography.Color = clWhite
      Appearance.Typography.Weight = swSemiBold
      Appearance.Effects.TransitionMs = 150
      States.Hover.Background.Color = 5860101
      States.Focus.Effects.OutlineWidth = 2
      States.Focus.Effects.OutlineColor = clTeal
      States.Disabled.Effects.Opacity = 50
    end>
  StyleItems = <
    item
      Control = btnSend
      StyleName = 'PrimaryButton'
    end>
end
```

## Botão inclinado com preenchimento no hover

O efeito com `skew(-21deg)`, texto reto e preenchimento animado pode ser configurado integralmente no Object Inspector. Crie um item em `Styles` e associe-o ao botão em `StyleItems`, usando `StyleName = SkewButton`.

- `Appearance.Display = sdInlineBlock` corresponde a `display: inline-block`. Um item de FlexPanel continua sujeito às regras de layout flex do navegador, que podem calcular seu display como block.
- `Appearance.Transform.SkewX = -21` inclina o botão. `Appearance.Content.Transform.SkewX = 21` compensa a inclinação no conteúdo. `Typography.Transform = ttUppercase` continua responsável apenas pelas maiúsculas.
- `Appearance.Before.Enabled = ssYes` cria `::before`; com `Text` vazio, equivale a `content: ''`. `ssNo` remove o pseudo-elemento e `ssInherit` preserva a camada anterior. `After` funciona da mesma forma. O texto é literal, sem interpretar CSS ou HTML; para limpar um texto herdado, configure `Enabled = ssYes` e `Text` vazio na camada de substituição.
- Configure `Before.Position.Right.Units = suPercent` e `Value = 100`; no hover, use zero. Os deslocamentos com unidades prevalecem sobre `Position.Insets` no mesmo lado e aceitam valores negativos. `suUnset` preserva a camada anterior.
- Configure `Before.Effects.TransitionMs = 500` e `TransitionAll = ssYes` para animar tanto o preenchimento quanto a opacidade.

`Content` aplica-se a um único contêiner interno: o wrap do botão (com texto e ícone), campo de entrada ou corpo do painel/contêiner. Não aplica a transformação a todos os spans descendentes. Controles sem um conteúdo interno reconhecido recebem apenas as propriedades da raiz. `Before` e `After` são gerados na raiz e não interceptam cliques; dependem do suporte do navegador ao pseudo-elemento naquele elemento (por exemplo, inputs nativos não o exibem). O posicionamento do controle continua explícito; o exemplo usa `poRelative` para ancorar a camada ao botão. A transformação cria o contexto de empilhamento necessário ao z-index negativo do exemplo.

Exemplo completo, também disponível em [tools/fixtures/style-skew-button.dfm](../tools/fixtures/style-skew-button.dfm):

~~~pascal
object SkewButtonStyle: TUniDSAStyle
  Styles = <
    item
      Name = 'SkewButton'
      Appearance.Display = sdInlineBlock
      Appearance.Background.Color = clWhite
      Appearance.Border.Width = 0
      Appearance.Border.Line = blNone
      Appearance.Border.Radius = 0
      Appearance.Typography.Color = clBlack
      Appearance.Typography.Size = 15
      Appearance.Typography.Weight = swSemiBold
      Appearance.Typography.Transform = ttUppercase
      Appearance.Spacing.Padding.Top = 10
      Appearance.Spacing.Padding.Right = 20
      Appearance.Spacing.Padding.Bottom = 10
      Appearance.Spacing.Padding.Left = 20
      Appearance.Sizing.Width.Value = 120.000000000000000000
      Appearance.Sizing.Width.Units = suPx
      Appearance.Effects.Cursor = scPointer
      Appearance.Position.Mode = poRelative
      Appearance.Transform.SkewX = -21
      Appearance.Content.Display = sdInlineBlock
      Appearance.Content.Transform.SkewX = 21
      Appearance.Before.Enabled = ssYes
      Appearance.Before.Background.Color = 1315860
      Appearance.Before.Position.Mode = poAbsolute
      Appearance.Before.Position.Insets.All = 0
      Appearance.Before.Position.Right.Value = 100.000000000000000000
      Appearance.Before.Position.Right.Units = suPercent
      Appearance.Before.Position.ZIndex = -1
      Appearance.Before.Effects.Opacity = 0
      Appearance.Before.Effects.TransitionMs = 500
      Appearance.Before.Effects.TransitionAll = ssYes
      States.Hover.Typography.Color = clWhite
      States.Hover.Before.Position.Right.Value = 0.000000000000000000
      States.Hover.Before.Position.Right.Units = suPercent
      States.Hover.Before.Effects.Opacity = 100
    end>
end
~~~

O hover respeita os estados desabilitados. As novas propriedades também podem ser usadas em `States.Focus`, `Pressed`, `Disabled`, `Selected` e `Responsive`. Cores numéricas do DFM usam TColor: `1315860` equivale a `RGB(20, 20, 20)`.

## Responsividade e FlexPanel

`Responsive` é uma coleção de regras com `MinWidth`, `MaxWidth` e `Orientation` (`orAny`, `orPortrait`, `orLandscape`). Os limites se referem à largura do viewport em pixels; zero significa sem limite. Cada regra contém `Appearance` e `States`. Regras posteriores prevalecem quando duas faixas se sobrepõem.

O componente acompanha o redimensionamento sem criar controles. `Flex.Direction`, `Grow`, `Basis`, `Gap`, `FlexItems` e `AutoHeight` continuam no FlexPanel. Deixe as dimensões do estilo como `suUnset` para preservar esse layout. Se configurar padding, posição ou dimensões também no estilo, a configuração explícita do estilo prevalece no navegador.

Não há reprodução completa de CSS ou hover no designer VCL. As propriedades são editáveis e persistidas no designer; confira o resultado visual no navegador.

## Alterações em runtime

As propriedades notificam alterações automaticamente. Agrupe operações relacionadas para evitar atualizações intermediárias, especialmente ao criar ou substituir itens de coleção em código:

```pascal
ControlStyle.BeginUpdate;
try
  ControlStyle.Styles.Find('PrimaryButton').States.Hover.Background.Color := clNavy;
  ControlStyle.StyleItems.FindByControl(btnSend).Selected := True;
finally
  ControlStyle.EndUpdate;
end;
```

`Apply` reaplica a configuração; `Validate` confere associações. Os controles visuais podem continuar integralmente no DFM, como no WhatsApp. A criação de objetos de propriedades/coleções é interna ao componente.

O runtime mantém uma folha de estilo por gerenciador, atualiza seu conteúdo e a remove quando o gerenciador ou a janela são destruídos. Usa seletores de IDs, preserva classes/eventos existentes e acompanha controles que renderizam depois. As referências Delphi são limpas por `FreeNotification`.

## Exemplo e testes

`examples/WhatsAppWeb` usa três gerenciadores: um no formulário e um em cada frame. Toda a aparência está nos DFMs. Não há `chat.css` nem eventos `beforeInit` para associar classes. O pequeno `chat.js` trata apenas navegação móvel e rolagem.

- `tools\Test-UniDSAStyle.ps1`: compila pacotes para `tmp/style-validation`, sem instalar ou substituir as BPLs em uso, e testa streaming DFM, Assign, notificações e referências.
- `node tools/test-style-effects.cjs`: após `Test-UniDSAStyle.ps1`, testa no Chrome/Chromium o JSON exportado do DFM do botão: preenchimento animado, compensação da inclinação, cliques, estados, herança, responsividade, After e remoção das regras. As capturas ficam em `tmp/style-validation/skew-normal.png` e `skew-hover.png`.
- `node tools/test-style-selector-groups.cjs`: após `Test-UniDSAStyle.ps1`, compara o botão completo com o CSS original e testa seletores agrupados, hover, foco pelo teclado, adaptadores, desabilitação e limpeza.
- `node tools/test-style-custom-css.cjs`: após `Test-UniDSAStyle.ps1`, compara o box com duas sombras com o CSS original e testa fallback, precedência, herança, estados, adaptadores e limpeza.
- `node tools/test-style-css-import.cjs`: após `Test-UniDSAStyle.ps1`, compara o card importado com o CSS original no Chrome, incluindo hover, active, blur, isolamento e limpeza.
- `node tools/test-style-runtime.cjs`: testes de CSS real em Chromium/Chrome, incluindo hover, estados, herança, responsividade e limpeza.
- `node examples/WhatsAppWeb/tests/ui.cjs`: teste completo da aplicação; configure `CHAT_URL` se a porta não for 8078.
- `node tools/embed-style-runtime.cjs --check`: verifica que o JavaScript incorporado corresponde ao fonte.

Os testes Node de navegador precisam do módulo `playwright` disponível (ou `NODE_PATH` configurado). `CHROME_PATH` permite usar um Chrome já instalado. Após editar `sources/UniDSAStyleRuntime.js`, execute `node tools/embed-style-runtime.cjs` e recompile o pacote/aplicação.

## Preferir as propriedades nativas

No uso cotidiano, configure fonte, tamanho, cor do texto e alinhamento no próprio controle uniGUI. Reserve StyleItems para efeitos, estados, responsividade ou regras compartilhadas que precisem do componente. As propriedades de tipografia continuam disponíveis para casos como mudança de cor no hover; não é necessário associar cada label ao TUniDSAStyle. O exemplo WhatsAppWeb segue essa abordagem.
