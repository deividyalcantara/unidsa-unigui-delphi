// Run against the compiled demo: node tools/test-menu-lateral.cjs [base URL]
const assert = require('node:assert/strict');
const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage({ viewport: { width: 1366, height: 900 } });
  const errors = [];
  page.on('pageerror', error => errors.push(error.message));
  page.on('response', async response => {
    if (response.request().method() !== 'POST') return;
    try {
      if (/EAccessViolation|Access violation|Ajax Error/.test(await response.text()))
        errors.push('Server error returned by ' + response.url());
    } catch { /* Response may be released during navigation. */ }
  });
  const row = caption => page.locator('.uni-ml-menu-row').filter({
    has: page.locator('span', { hasText: new RegExp('^' + caption + '$') })
  });
  async function expanded(caption, value) {
    await page.waitForFunction(({ caption, value }) => [...document.querySelectorAll('.uni-ml-menu-row')]
      .some(el => el.querySelector('span').textContent === caption && el.getAttribute('aria-expanded') === value),
    { caption, value: String(value) });
  }
  async function closeDialog() {
    await page.locator('.jconfirm-buttons button').filter({ hasText: /^OK$/ }).click();
    await page.locator('.jconfirm').waitFor({ state: 'detached' });
  }
  try {
    await page.goto(process.argv[2] || 'http://localhost:8077');
    await page.getByText('Entrar', { exact: true }).click();
    await row('Componentes').waitFor();
    await expanded('Componentes', true);
    // Let the welcome toast close: its callback previously dereferenced a missing item.
    await row('Menu Lateral').locator('.uni-ml-item-menu-notif').waitFor();
    await page.locator('#uni-ml-pesquisar').fill('pesquisa na Home');
    await page.locator('#uni-ml-pesquisar').press('Enter');
    for (const caption of ['Toast', 'Confirm', 'QrCode Reader', 'Kanban', 'FlexPanel', 'Home']) {
      await row(caption).click();
      const title = caption === 'FlexPanel' ? 'TUniDSAFlexPanel' : caption;
      await page.locator('.x-component').filter({ hasText: new RegExp('^' + title + '$') }).last().waitFor();
    }
    await page.evaluate(() => {
      const original = window.ajaxRequest;
      window.menuEvents = [];
      window.ajaxRequest = function(component, name, args) {
        if (name.startsWith('UniDSAMenuLateral')) window.menuEvents.push(name);
        return original.apply(this, arguments);
      };
    });
    await row('Componentes').click();
    await expanded('Componentes', false);
    assert.equal(await row('Menu Lateral').isVisible(), false);
    await row('Componentes').press('ArrowRight');
    await expanded('Componentes', true);
    await row('Menu Lateral').click();
    for (const [hide, show] of [
      ['Ocultar Pesquisa...', 'Habilitar Pesquisa...'],
      ['Ocultar escolha tema', 'Habilitar escolha tema'],
      ['Ocultar Perfil', 'Habilitar Perfil'],
      ['Ocultar Menu', 'Mostrar Menu']
    ]) {
      await page.getByText(hide, { exact: true }).click();
      await page.getByText(show, { exact: true }).click();
    }
    await page.getByText('Padrão', { exact: true }).click();
    await row('Gestão de Vendas').waitFor();
    await page.locator('#uni-ml-pesquisar').fill('pesquisa no menu de exemplo');
    await page.locator('#uni-ml-pesquisar').press('Enter');
    await row('Faturamento e Cobrança').click();
    await expanded('Faturamento e Cobrança', true);
    await row('Boletos').waitFor();
    await page.evaluate(() => { window.menuEvents = []; });
    await row('Boletos').locator('.uni-ml-item-menu-notif').press('Enter');
    await closeDialog();
    assert.equal(await row('Boletos').locator('.uni-ml-item-menu-notif').isVisible(), false);
    await expanded('Gestão de Vendas', true);
    await expanded('Faturamento e Cobrança', true);
    assert.deepEqual(await page.evaluate(() => window.menuEvents), ['UniDSAMenuLateralOnClickNotificationMenu']);
    await page.evaluate(() => { window.menuEvents = []; });
    await row('Pedidos de Vendas').press('Enter');
    await closeDialog();
    assert.deepEqual(await page.evaluate(() => window.menuEvents), ['UniDSAMenuLateralOnClickMenu']);
    await row('Boletos').click();
    await closeDialog();
    await row('Orçamentos').click();
    await closeDialog();
    await row('Faturamento e Cobrança').press('ArrowLeft');
    await expanded('Faturamento e Cobrança', false);
    await page.getByText('Notificações', { exact: true }).click();
    await row('Gestão de Vendas').locator('.uni-ml-item-menu-notif').waitFor();
    await expanded('Faturamento e Cobrança', false);
    await page.locator('.uni-ml-logo').click();
    await page.locator('.uni-ml-minimized').waitFor();
    assert.equal(await row('Pedidos de Vendas').isVisible(), false);
    await row('Gestão de Vendas').click();
    await page.locator('.uni-ml-minimized').waitFor({ state: 'detached' });
    await row('Pedidos de Vendas').waitFor();
    await page.getByText('Administrativo', { exact: true }).click();
    await row('Configurações e Administração').click();
    await row('Gerenciamento de Usuários').click();
    await closeDialog();
    while (await page.locator('.uni-ml-menu-row[aria-expanded="false"]').count()) {
      await page.locator('.uni-ml-menu-row[aria-expanded="false"]').first().click();
    }
    const leaves = await page.locator('.uni-ml-menu-row:not([aria-expanded]) > span').allTextContents();
    for (const caption of leaves) {
      await row(caption).click();
      await closeDialog();
    }
    await page.locator('.uni-ml-config-usuario-tema-2').click();
    await page.getByText('Padrão', { exact: true }).click();
    await row('Configurações e Administração').waitFor({ state: 'detached' });
    assert.equal(await row('Configurações e Administração').count(), 0);
    await row('Faturamento e Cobrança').click();
    await row('Boletos').waitFor();
    assert.equal(await page.locator('.uni-ml-menu-lista').count(), 1);
    assert.equal(await row('Gestão de Vendas').count(), 1);
    assert.deepEqual(errors, []);
    // Also close the welcome toast AFTER replacing its original menu item.
    const early = await browser.newPage();
    await early.goto(process.argv[2] || 'http://localhost:8077');
    await early.getByText('Entrar', { exact: true }).click();
    await early.locator('.uni-ml-menu-row').filter({ hasText: 'Menu Lateral' }).click();
    await early.getByText('Padrão', { exact: true }).click();
    await early.waitForTimeout(3000);
    assert.equal(await early.getByText('Ajax Error', { exact: true }).count(), 0);
    await early.close();
    console.log('PASS: component navigation, welcome callback before/after menu replacement, search, visibility controls, ' + leaves.length + ' admin actions, nested menus, keyboard, notifications and themes');
  } finally {
    await browser.close();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
