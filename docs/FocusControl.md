# TUniDSAFocusControl

Componente não visual da paleta UniDSA. Coloque uma instância no formulário para remover os indicadores visuais de foco dos controles desse formulário, inclusive nos frames filhos. Não exige StyleItems, eventos JavaScript ou arquivo CSS na aplicação.

- `Enabled = True` (padrão): remove outlines, sombras de foco e bordas internas de foco dos botões e abas Ext JS.
- `Enabled = False`: remove as regras do componente e restaura o comportamento do tema.
- Também pode ser colocado em um frame para limitar o alcance aos filhos desse frame.
- Controles adicionados posteriormente recebem as mesmas regras automaticamente.
- O foco real, Tab, Enter e eventos continuam funcionando. Os indicadores visuais de foco por teclado também ficam ocultos enquanto estiver habilitado.
- As bordas normais dos controles são preservadas. O componente tem prioridade sobre o outline de foco configurado no TUniDSAStyle.
- Janelas, menus flutuantes e documentos em iframes fora do painel do formulário não pertencem ao escopo. Coloque uma instância nos outros formulários que também precisem desse comportamento.

O runtime e suas regras são embutidos no componente. Ao destruir o formulário, as regras são removidas. Não é necessário reinstalar o pacote para alternar Enabled.

## Validação

`tools/test-focus-control.cjs` testa o exemplo WhatsAppWeb em CHAT_URL (padrão http://localhost:8078), usando Playwright e CHROME_PATH. Cobre botão, abas reais Ext JS, preservação do foco, isolamento, controles tardios, desativação e limpeza. Regenere o include após editar o runtime com `node tools/embed-focus-runtime.cjs`.
