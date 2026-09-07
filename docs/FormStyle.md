# TUniDSAFormStyle

Componente não visual para personalizar janelas desktop TUniForm do uniGUI.
Arraste da paleta **UniDSA** para o formulário. Não é necessário trocar sua
classe, definir BorderStyle=bsNone ou atribuir eventos em Pascal.

O título vem do Caption do formulário. O X continua fechando pela própria janela
Ext/uniGUI: ShowModal, OnClose e FreeOnClose permanecem sob controle da aplicação.
Use uma instância por formulário. O componente deve pertencer diretamente ao TUniForm.

## Configuração

| Grupo | Propriedades principais |
|---|---|
| Appearance | Radius, BackgroundColor, BorderColor, BorderWidth, Shadow |
| Header | Visible, ShowIcon, Height, FontSize, BackgroundColor, TextColor |
| CloseButton | Visible, Size, Color, HoverColor, CloseOnEscape |
| Backdrop | Color, Opacity (0–90), CloseOnClick |
| Sizing | MaxWidth, MaxHeight, MinHeight, ViewportMargin, AutoHeight |

Padrão: janela clara, raio 18 px, sombra, cabeçalho de 64 px, sem ícone do Delphi,
X de 32 px e margem de 24 px do viewport. Escape fecha; clicar fora **não fecha**.
Ocultar Header também oculta seu X; mantenha outra ação de fechamento.

Para medir altura natural de um formulário com painel alClient, atribua
**ContentControl** ao painel de conteúdo. Caso exista um botão/barra fixa inferior,
atribua **FooterControl** a esse controle. O componente reserva sua altura.
Sem ContentControl, a janela respeita os limites de Sizing, mas não tenta inferir
a altura natural de layouts arbitrários.

Exemplo no DFM:

```delphi
object FormStyle: TUniDSAFormStyle
  ContentControl = Page
  FooterControl = CloseButton
  Appearance.Radius = 20
  Sizing.MaxWidth = 860
  Sizing.MaxHeight = 800
  Backdrop.Opacity = 40
end
```

As propriedades são persistidas no DFM. Alterações feitas em runtime reaplicam
o estilo; Enabled=False remove a personalização. A visualização CSS acontece no
navegador, não no canvas VCL do designer. Os componentes de conteúdo não são criados,
movidos nem excluídos pelo FormStyle.

## Publicação e compatibilidade

Publique a pasta **dsa/form-style** em **files/dsa/form-style**, preservando
os subdiretórios css e js. UniDSASource registra os arquivos automaticamente.
Use navegador moderno com ResizeObserver e suporte CSS :has().
O componente não utiliza backdrop-filter, CDN ou bibliotecas adicionais.

Escopo do CSS limitado à janela marcada; a máscara compartilhada do Ext é
restaurada ao alternar/fechar janelas. Listeners e observers são removidos na
destruição/desativação. O componente não substitui OnShow, OnClose ou ClientEvents.

O X informa seu tamanho ao layout nativo do cabeçalho, mantendo alinhamento
vertical e espaço à direita mesmo ao personalizar CloseButton.Size.
Durante o arraste, liveDrag move a própria janela estilizada, sem a moldura
fantasma do tema uniGUI. Ao desativar o componente, o tamanho original do X
e a configuração anterior de arraste são restaurados.
Os assets usam a versão v=4 para invalidar cópias anteriores em cache.

## Instalação na IDE

Compilar UniDSA e UniDSADesign. Ambos são necessários para manter o conjunto
de componentes existente. A unidade se registra na paleta UniDSA pelo pacote UniDSA.
O novo ícone é gerado por tools/generate-form-style-icon.ps1.

Builds validados: Delphi 13 / Win32 Release, em **output/form-style/Win32**.
Não substituir BPLs carregados por bds.exe: salve e feche a IDE antes de atualizar
os pacotes instalados. No ambiente validado eles ficam em
C:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl.
Os DCPs correspondentes devem ser atualizados na pasta Dcp do mesmo Studio.

## Testes

- node --check dsa/form-style/js/script.js
- node tools/test-form-style.cjs
- Builds UniDSA, UniDSADesign e AutoManager Win32.
- AutoManager: sete editores usam o componente e dispensam os handlers repetidos
  EditorShow/ScreenResize e o ResizeObserver embutido em seus DFMs.
- Testes automatizados isolados cobrem limites do viewport, altura natural,
  Escape, clique na máscara, restauração da máscara de janela sem estilo,
  desativação antes do render e limpeza de listeners.
  Também cobrem tamanho personalizável do X, reaplicação e restauração do liveDrag.

Validação no navegador em 06/09/2026: sete editores abriram estilizados;
estoque com cerca de 860 x 341 px em desktop; OS com cerca de 342 x 797 px
em viewport de 390 px, com rolagem interna. X por mouse e Enter, Escape,
fechamento/reabertura e cabeçalho de formulário bsNone verificados.
Não foram executadas gravações de cadastros, estoque ou pagamentos nesta rodada.
AutoManager está executando o build Debug final em localhost:8077.

Ajuste de X/arraste validado em 06/09/2026: X centralizado nos editores de
clientes e veículos (incluindo bsNone), fechamento pelo X e movimento da
janela real confirmado, sem criação de elementos x-window-ghost.
UniDSA/UniDSADesign Release e AutoManager Debug/Release Win32 compilados sem erros.
