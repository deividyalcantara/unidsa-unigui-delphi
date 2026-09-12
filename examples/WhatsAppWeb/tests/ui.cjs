const assert = require('node:assert/strict');
const path = require('node:path');
const {chromium} = require('playwright');
const base = process.env.CHAT_URL || 'http://localhost:8078';
const output = path.resolve(__dirname, '../tmp');
const fs = require('node:fs');
fs.mkdirSync(output, {recursive:true});
(async () => {
  const browser = await chromium.launch({headless:true, ...(process.env.CHROME_PATH ? {executablePath:process.env.CHROME_PATH} : {})});
  try {
    const page = await browser.newPage({viewport:{width:1366,height:900}});
    const errors = [];
    page.on('pageerror', error => errors.push(error.message));
    const cssRequests = [];
    const jsRequests = [];
    const flexRequests = [];
    page.on('request', request => { if (/chat\.css(?:\?|$)/.test(request.url())) cssRequests.push(request.url()); });
    page.on('request', request => { if (request.url().includes('/chat.js')) jsRequests.push(request.url()); });
    page.on('request', request => { if (request.url().includes('/unidsa-flex.js')) flexRequests.push(request.url()); });
    const expectText = (selector, text) => page.waitForFunction(({selector,text}) => [...document.querySelectorAll(selector)].some(el => el.textContent === text), {selector,text});
    await page.goto(base);
    await page.waitForSelector('[data-unidsa-style-item="edtMensagem"] input');
    await page.waitForFunction(() => document.querySelectorAll('[data-unidsa-style-item="lblMensagem"]').length === 5);
    await page.waitForFunction(() => document.querySelectorAll('style[data-unidsa-style-sheet]').length === 8);
    // Check the first render, before clicks or resizing can hide layout regressions.
    await page.waitForFunction(() => [...document.querySelectorAll('[data-unidsa-style-item^="lblAvatar"]')].every(el => el.getBoundingClientRect().width >= 43));
    const initialLayout = await page.evaluate(() => {
      const rows = [...document.querySelectorAll('[data-unidsa-style-item^="flexContato"]')].filter(el => /flexContato\d$/.test(el.dataset.unidsaStyleItem));
      return rows.map(row => {
        const avatar = row.querySelector('[data-unidsa-style-item^="lblAvatar"]');
        const name = row.querySelector('[data-unidsa-style-item^="lblNome"]');
        return {gap: name.getBoundingClientRect().left - avatar.getBoundingClientRect().right, overflow: row.scrollWidth - row.clientWidth, font: getComputedStyle(name).fontFamily};
      });
    });
    for (const row of initialLayout) {
      assert.ok(row.gap >= 10, 'Avatar must not overlap the contact name');
      assert.ok(row.overflow <= 1, 'Contact row must not scroll horizontally');
      assert.ok(row.font.includes('Tahoma') || row.font.includes('Segoe UI'), 'uniGUI native Font must be preserved');
    }
    const expectCount = count => page.waitForFunction(count => document.querySelectorAll('[data-unidsa-style-item="lblMensagem"]').length === count, count);
    const input = page.locator('[data-unidsa-style-item="edtMensagem"] input');
    const send = page.locator('[data-unidsa-style-item="btnEnviar"]');
    await send.hover();
    await page.waitForFunction(() => getComputedStyle(document.querySelector('[data-unidsa-style-item="btnEnviar"]')).backgroundColor === 'rgb(5, 107, 89)');
    await page.mouse.move(0, 0);
    await page.waitForFunction(() => getComputedStyle(document.querySelector('[data-unidsa-style-item="btnEnviar"]')).backgroundColor === 'rgb(8, 127, 105)');
    const select = async name => {
      await page.locator('[data-unidsa-style-item="Contatos"] [data-unidsa-style-item^="lblNome"]').filter({hasText:name}).click();
      await expectText('[data-unidsa-style-item="flexCabecalho"] [data-unidsa-style-item^="lblNome"]',name);
    };
    assert.equal(await page.locator('[data-unidsa-style-item^="flexContato"]:not([data-unidsa-style-item="flexContatos"]):visible').count(), 5);
    await page.locator('[data-unidsa-style-item="btnTodas"],[data-unidsa-style-item="btnNaoLidas"]').filter({hasText:'Não lidas'}).click();
    await page.waitForFunction(() => [...document.querySelectorAll('[data-unidsa-style-item^="flexContato"]:not([data-unidsa-style-item="flexContatos"])')].filter(el => el.offsetHeight).length === 2);
    await select('Rafael Almeida');
    await page.waitForFunction(() => [...document.querySelectorAll('[data-unidsa-style-item^="flexContato"]:not([data-unidsa-style-item="flexContatos"])')].filter(el => el.offsetHeight).length === 1);
    await page.locator('[data-unidsa-style-item="btnTodas"],[data-unidsa-style-item="btnNaoLidas"]').filter({hasText:'Todas'}).click();
    await page.waitForFunction(() => [...document.querySelectorAll('[data-unidsa-style-item^="flexContato"]:not([data-unidsa-style-item="flexContatos"])')].filter(el => el.offsetHeight).length === 5);
    const search = page.locator('[data-unidsa-style-item="edtPesquisa"] input');
    await search.fill('sofia'); await search.press('Tab');
    await page.waitForFunction(() => [...document.querySelectorAll('[data-unidsa-style-item^="flexContato"]:not([data-unidsa-style-item="flexContatos"])')].filter(el => el.offsetHeight).length === 1);
    assert.equal(await page.locator('[data-unidsa-style-item^="flexContato"]:not([data-unidsa-style-item="flexContatos"]):visible [data-unidsa-style-item^="lblNome"]').innerText(), 'Sofia Martins');
    await search.fill('contato inexistente'); await search.press('Tab');
    await page.waitForSelector('[data-unidsa-style-item="lblVazio"]:visible');
    await search.fill(''); await search.press('Tab');
    await select('Mariana Costa');
    await input.fill('   '); await send.click();
    await page.waitForFunction(() => document.querySelectorAll('[data-unidsa-style-item="lblMensagem"]').length === 5);
    await page.waitForFunction(() => document.querySelectorAll('style[data-unidsa-style-sheet]').length === 8);
    const message = '<script>window.chatInjected=true</script> & Olá!';
    await input.fill(message); await input.press('Enter');
    await expectText('[data-unidsa-style-item^="lblMensagem"]', message);
    assert.equal(await page.evaluate(() => window.chatInjected), undefined);
    await expectCount(6);
    await page.waitForFunction(() => document.querySelector('[data-unidsa-style-item="edtMensagem"] input').value === '');
    await input.fill('rascunho preservado');
    await select('Sofia Martins');
    await page.waitForFunction(() => document.querySelector('[data-unidsa-style-item="edtMensagem"] input').value === '');
    assert.equal(await page.locator('[data-unidsa-style-item^="lblMensagem"]:visible').filter({hasText:message}).count(),0);
    await select('Mariana Costa');
    await page.waitForFunction(() => document.querySelector('[data-unidsa-style-item="edtMensagem"] input').value === 'rascunho preservado');
    for(let i=0;i<15;i++) {
      await input.fill('Mensagem de teste '+i); await send.click();
      await expectText('[data-unidsa-style-item^="lblMensagem"]','Mensagem de teste '+i);
      await page.waitForFunction(() => document.querySelector('[data-unidsa-style-item="edtMensagem"] input').value === '');
    }
    await expectCount(21);
    assert.equal(await page.getByText('Oi! Tudo bem por aí?', {exact:true}).count(), 1, 'Oldest message remains in the complete history');
    assert.equal(await page.getByText('Anteriores', {exact:true}).count(), 0);
    assert.equal(await page.getByText('Recentes', {exact:true}).count(), 0);
    assert.equal(await page.getByText('Prévia na IDE:', {exact:false}).count(), 0);
    const long = 'Uma mensagem longa deve aumentar a altura do balão sem cortar o texto. '.repeat(20);
    await input.fill(long); await send.click();
    await expectText('[data-unidsa-style-item^="lblMensagem"]',long.trim());
    const overflow = await page.locator('[data-unidsa-style-item^="lblMensagem"]').filter({hasText:long.trim()}).evaluate(el => ({height:el.clientHeight, scroll:el.scrollHeight, width:el.clientWidth, scrollWidth:el.scrollWidth}));
    assert.ok(overflow.height > 100);
    assert.ok(overflow.scroll <= overflow.height + 1);
    assert.ok(overflow.scrollWidth <= overflow.width + 1);
    // A coluna conserva a altura de cada mensagem e transfere o excesso para o scroll.
    const historyLayout = await page.locator('[data-unidsa-style-item="flexHistorico"]').evaluate(root => {
      const candidates = [root, ...root.querySelectorAll('.dsa-flex-inner,.x-autocontainer-innerCt')];
      const scroller = candidates.find(el => el.scrollHeight > el.clientHeight + 1);
      const messages = [...root.querySelectorAll('[data-unidsa-style-item^="lblMensagem"]')];
      const frameItems = scroller ? [...scroller.children].filter(el => el.matches('.x-panel')) : [];
      return {
        found: Boolean(scroller),
        overflowY: scroller ? getComputedStyle(scroller).overflowY : '',
        clientHeight: scroller ? scroller.clientHeight : 0,
        scrollHeight: scroller ? scroller.scrollHeight : 0,
        scrollbarWidth: scroller ? getComputedStyle(scroller, '::-webkit-scrollbar').width : '',
        clippedMessages: messages.filter(el => el.scrollHeight > el.clientHeight + 1).length,
        shrunkFrames: frameItems.filter(el => getComputedStyle(el).flexShrink !== '0').length
      };
    });
    assert.equal(historyLayout.found, true, 'Long history must have a scrolling element');
    assert.ok(['auto','scroll'].includes(historyLayout.overflowY), 'History overflow must permit vertical scroll');
    assert.ok(historyLayout.scrollHeight > historyLayout.clientHeight, 'History content must exceed the viewport');
    assert.equal(historyLayout.scrollbarWidth, '8px', 'History must use the configured scrollbar size');
    assert.equal(historyLayout.clippedMessages, 0, 'Message text must wrap without clipping');
    assert.equal(historyLayout.shrunkFrames, 0, 'Message frames must keep flex-shrink zero');
    await page.screenshot({path:path.join(output,'chat-scroll.png')});
    const other = await browser.newPage(); await other.goto(base);
    await other.waitForSelector('[data-unidsa-style-item="edtMensagem"] input');
    await other.waitForFunction(() => document.querySelectorAll('[data-unidsa-style-item="lblMensagem"]').length === 5);
    await other.close();
    await page.setViewportSize({width:390,height:844});
    await page.locator('[data-unidsa-style-item="btnVoltar"]').click();
    await page.waitForFunction(() => {
      const contatos = document.querySelector('[data-unidsa-style-item="Contatos"]');
      const conversa = document.querySelector('[data-unidsa-style-item="Conversa"]');
      const visivel = elemento => elemento && elemento.getBoundingClientRect().width > 0;
      return visivel(contatos) && !visivel(conversa);
    });
    await select('Equipe de produto');
    await page.waitForFunction(() => {
      const contatos = document.querySelector('[data-unidsa-style-item="Contatos"]');
      const conversa = document.querySelector('[data-unidsa-style-item="Conversa"]');
      const visivel = elemento => elemento && elemento.getBoundingClientRect().width > 0;
      return !visivel(contatos) && visivel(conversa);
    });
    await page.screenshot({path:path.join(output,'chat-mobile.png')});
    const rects = await page.locator('[data-unidsa-style-item="flexCabecalho"],[data-unidsa-style-item="flexHistorico"],[data-unidsa-style-item="flexCompositor"],[data-unidsa-style-item="edtMensagem"],[data-unidsa-style-item="btnEnviar"]').evaluateAll(els=>els.map(el=>({cls:el.className,x:el.getBoundingClientRect().x,right:el.getBoundingClientRect().right,width:el.getBoundingClientRect().width})));
    for(const rect of rects) assert.ok(rect.width>0 && rect.x>=-1 && rect.right<=391, 'Mobile overflow: '+JSON.stringify(rect));
    assert.ok((await input.boundingBox()).width > 180, 'Composer must remain usable on mobile');
    assert.deepEqual(errors, []);
    assert.deepEqual(cssRequests, [], 'Appearance must not load chat.css');
    assert.deepEqual(jsRequests, [], 'Application must not load chat.js');
    assert.ok(flexRequests.some(url => url.includes('v=1.0.8')), 'FlexPanel JavaScript must use the current cachebuster');
    await page.waitForFunction(() => document.querySelectorAll('style[data-unidsa-style-sheet]').length === 8);
    const aviso = page.locator('[data-unidsa-style-item="flexAviso"]');
    const alturaAviso = await aviso.evaluate(el => el.getBoundingClientRect().height);
    const textoAviso = await page.locator('[data-unidsa-style-item="lblAviso"]').innerText();
    await page.locator('[data-unidsa-style-item="lblAviso"]').evaluate(el => { el.textContent = 'Um aviso longo precisa aumentar o fundo automaticamente. '.repeat(8); });
    await page.waitForFunction(altura => document.querySelector('[data-unidsa-style-item="flexAviso"]').getBoundingClientRect().height > altura + 30, alturaAviso);
    assert.ok(await aviso.evaluate(el => { const label=el.querySelector('[data-unidsa-style-item="lblAviso"]'); return label.getBoundingClientRect().bottom <= el.getBoundingClientRect().bottom - 10; }));
    await page.locator('[data-unidsa-style-item="lblAviso"]').evaluate((el,texto) => { el.textContent = texto; }, textoAviso);
    await page.setViewportSize({width:1366,height:900});
    await select('Equipe de produto');
    await page.waitForFunction(() => {
      const el = document.querySelector('[data-unidsa-style-item="Conversa"]');
      const rect = el.getBoundingClientRect();
      const history = el.querySelector('[data-unidsa-style-item="flexHistorico"]').getBoundingClientRect();
      return rect.width > 900 && history.width > 900 && rect.right <= window.innerWidth + 1 && history.right > 1300;
    });
    await page.screenshot({path:path.join(output,'chat-desktop.png')});
    const notice = await page.locator('[data-unidsa-style-item="flexAviso"]').evaluate(el => {
      const label=el.querySelector('[data-unidsa-style-item="lblAviso"]');
      return {box:el.getBoundingClientRect().toJSON(),text:label.getBoundingClientRect().toJSON()};
    });
    assert.ok(notice.box.height >= notice.text.height + 20, 'Notice box must include its padding');
    console.log('PASS: streaming DFM, busca, não lidas, envio/Enter, texto seguro, rascunhos, histórico completo, scroll personalizado, frames DFM, AutoHeight, sessão isolada e mobile.');
  } finally { await browser.close(); }
})().catch(error => { console.error(error); process.exitCode=1; });
