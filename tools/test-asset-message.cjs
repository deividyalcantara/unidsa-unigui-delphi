const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { chromium } = require('playwright');
const output = path.resolve(__dirname, '../tmp/asset-validation');
const html = fs.readFileSync(path.join(output, 'message-preview.html'), 'utf8');
const script = fs.readFileSync(path.join(output, 'message-preview.js'), 'utf8').replace(/^\uFEFF/, '');

(async () => {
  const browser = await chromium.launch({ channel: 'msedge', headless: true });
  try {
    const page = await browser.newPage({ viewport: { width: 1100, height: 800 } });
    const requests = [], errors = [];
    page.on('request', request => requests.push(request.url()));
    page.on('pageerror', error => errors.push(error.message));
    await page.setContent(html);
    const notice = page.locator('#dsa-assets-message');
    await notice.waitFor();
    assert.equal(await notice.locator('link,script,img').count(), 0);
    assert.match(await notice.innerText(), /TUniDSAFormStyle/);
    assert.doesNotMatch(await notice.innerText(), /[A-Z]:\\|ServerModule.FilesFolder/);
    for (const width of [1100, 390, 320]) {
      await page.setViewportSize({ width, height: 760 });
      assert.ok(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth),
        'The notice must fit narrow screens');
    }
    await page.setContent('<button id="previous">Abrir formulario</button>');
    await page.locator('#previous').focus();
    await page.evaluate(script);
    assert.equal(await page.locator('[data-dsa-reload]').evaluate(el => el === document.activeElement), true);
    await page.keyboard.press('Tab');
    assert.equal(await page.locator('[data-dsa-dismiss]').evaluate(el => el === document.activeElement), true);
    await page.keyboard.press('Shift+Tab');
    assert.equal(await page.locator('[data-dsa-reload]').evaluate(el => el === document.activeElement), true);
    await page.keyboard.press('Escape');
    assert.equal(await notice.count(), 0);
    assert.equal(await page.locator('#previous').evaluate(el => el === document.activeElement), true);
    await page.evaluate(script);
    await page.evaluate(script);
    assert.equal(await notice.count(), 1, 'Only one notice may be displayed');
    await page.getByRole('button', { name: 'Voltar' }).click();
    assert.equal(await notice.count(), 0);
    assert.equal(await page.locator('#previous').evaluate(el => el === document.activeElement), true);
    assert.deepEqual(requests, [], 'The notice must not request any external asset');
    assert.deepEqual(errors, []);
    console.log('PASS: embedded HTML/CSS/SVG, no external requests or paths, responsive layout, keyboard navigation, dismissal and focus restoration.');
  } finally {
    await browser.close();
  }
})().catch(error => { console.error(error); process.exit(1); });