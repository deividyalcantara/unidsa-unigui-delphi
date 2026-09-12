const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {chromium} = require('playwright');
const root = path.resolve(__dirname, '..');
const fixturePath = path.join(root, 'tmp/style-validation/skew-button.json');
if (!fs.existsSync(fixturePath)) throw new Error('Run tools/Test-UniDSAStyle.ps1 first to export the tested DFM fixture.');
const fixture = JSON.parse(fs.readFileSync(fixturePath, 'utf8').replace(/^\uFEFF/, ''));
(async () => {
  const browser = await chromium.launch({headless:true, ...(process.env.CHROME_PATH ? {executablePath:process.env.CHROME_PATH} : {})});
  try {
    const page = await browser.newPage({viewport:{width:760,height:340}});
    const errors = []; page.on('pageerror', e => errors.push(e.message));
    await page.setContent(`<style>
      body{margin:48px;background:#e9ecef;font:15px Arial} #owner{padding:40px} #owner > *{margin-right:32px;vertical-align:middle}
      .x-btn{display:inline-block;padding:0;border:0;box-sizing:border-box;text-decoration:none;white-space:nowrap;color:black}
      .x-btn-wrap,.x-btn-button,.x-btn-inner{display:inline-block} .x-btn-inner{color:black}
      #unrelated{background:orange;padding:10px 20px} .x-btn-disabled{cursor:default}
      </style><div id="owner"><a id="skew" class="x-btn keep-class" role="button" tabindex="0"><span class="x-btn-wrap"><span class="x-btn-button"><span class="x-btn-inner">Botão</span></span></span></a>
      <button id="unrelated">Normal</button><button id="plain" class="x-btn"><span class="x-btn-inner">Simples</span></button></div>`);
    await page.addScriptTag({path:path.join(root, 'sources/UniDSAStyleRuntime.js')});
    await page.evaluate(rule => {
      window.effectsConfig = {owner:'owner',enabled:true,items:[{id:'skew',layers:[rule]}]};
      UniDSAStyle.attach('effects', effectsConfig);
      document.getElementById('skew').onclick = () => window.clickCount = (window.clickCount || 0) + 1;
    }, fixture);
    const button = page.locator('#skew');
    const css = (selector, property, pseudo) => page.locator(selector).evaluate((el, args) => getComputedStyle(el, args.pseudo)[args.property], {property, pseudo});
    const before = property => css('#skew', property, '::before');
    assert.equal(await css('#skew', 'display'), 'inline-block');
    assert.equal(await css('#skew', 'width'), '120px');
    assert.equal(await css('#skew', 'cursor'), 'pointer');
    assert.equal(await css('#skew .x-btn-wrap', 'padding'), '10px 20px');
    assert.equal(await css('#skew .x-btn-inner', 'textTransform'), 'uppercase');
    assert.equal(await css('#skew .x-btn-inner', 'fontWeight'), '600');
    assert.equal(await css('#skew .x-btn-inner', 'transform'), 'none');
    assert.equal(await before('content'), '""');
    assert.equal(await before('right'), '120px');
    assert.equal(await before('width'), '0px');
    assert.equal(await before('opacity'), '0');
    assert.equal(await before('zIndex'), '-1');
    assert.equal(await before('backgroundColor'), 'rgb(20, 20, 20)');
    assert.equal(await before('transitionProperty'), 'all');
    assert.equal(await before('transitionDuration'), '0.5s');
    assert.equal(await before('pointerEvents'), 'none');
    const matrix = await button.evaluate(el => {
      const outer = new DOMMatrix(getComputedStyle(el).transform);
      const inner = new DOMMatrix(getComputedStyle(el.querySelector('.x-btn-wrap')).transform);
      return {outer:outer.c, inner:inner.c, combined:outer.multiply(inner).toString()};
    });
    assert.ok(matrix.outer < 0 && matrix.inner > 0);
    assert.equal(matrix.combined, 'matrix(1, 0, 0, 1, 0, 0)');
    await page.screenshot({path:path.join(root, 'tmp/style-validation/skew-normal.png')});
    await button.hover();
    await page.waitForFunction(() => {const s=getComputedStyle(document.getElementById('skew'),'::before');return +s.opacity > 0 && +s.opacity < 1 && parseFloat(s.right)>0 && parseFloat(s.right)<120;});
    await page.waitForFunction(() => getComputedStyle(document.getElementById('skew'),'::before').opacity === '1');
    assert.equal(await before('right'), '0px');
    assert.equal(await css('#skew .x-btn-inner', 'color'), 'rgb(255, 255, 255)');
    assert.equal(await css('#unrelated', 'backgroundColor'), 'rgb(255, 165, 0)');
    await page.screenshot({path:path.join(root, 'tmp/style-validation/skew-hover.png')});
    await button.click();
    assert.equal(await page.evaluate(() => window.clickCount), 1);
    await button.evaluate(el => el.setAttribute('aria-disabled', 'true'));
    await page.waitForFunction(() => getComputedStyle(document.getElementById('skew'),'::before').opacity === '0');
    assert.equal(await before('right'), '120px');
    assert.equal(await css('#skew .x-btn-inner', 'color'), 'rgb(0, 0, 0)');
    await button.evaluate(el => el.removeAttribute('aria-disabled'));
    await page.mouse.move(700,300);
    await page.waitForFunction(() => getComputedStyle(document.getElementById('skew'),'::before').opacity === '0');
    // Partial state geometry and durations preserve the other axis and transition scope.
    await page.evaluate(() => {
      effectsConfig.items[0].layers.push({appearance:{Transform:{SkewY:5}},states:{Hover:{Transform:{SkewX:0},Before:{Effects:{TransitionMs:0}}}},responsive:[{max:500,appearance:{Display:2,Content:{Transform:{SkewX:0}}}}]});
      UniDSAStyle.attach('effects', effectsConfig);
    });
    await button.hover();
    assert.equal(await button.evaluate(el => getComputedStyle(el).getPropertyValue('--unidsa-skew-y')), '5deg');
    assert.equal(await button.evaluate(el => getComputedStyle(el).getPropertyValue('--unidsa-skew-x')), '0deg');

    assert.equal(await page.locator('#skew .x-btn-wrap').evaluate(el=>getComputedStyle(el).getPropertyValue('--unidsa-skew-y')), '0deg');
    assert.equal(await before('transitionProperty'), 'all');
    assert.equal(await before('transitionDuration'), '0s');
    await page.setViewportSize({width:480,height:340});
    await page.waitForFunction(() => getComputedStyle(document.getElementById('skew')).display === 'block');
    assert.equal(await css('#skew .x-btn-wrap', 'transform'), 'matrix(1, 0, 0, 1, 0, 0)');
    // Explicit disable, reset, negative offsets, After text and a button without wrap.
    await page.evaluate(() => {
      UniDSAStyle.attach('effects', {owner:'owner',enabled:true,items:[
        {id:'skew',layers:[effectsConfig.items[0].layers[0],{appearance:{Transform:{SkewX:0},Before:{Enabled:1},After:{Enabled:2,Text:'Depois "ok"; {x}',Position:{Mode:3,Left:{Units:2,Value:-10}},Effects:{TransitionMs:0}}},states:{Hover:{Before:{Enabled:1}}}}]},
        {id:'plain',layers:[{appearance:{Content:{Display:4,Transform:{SkewX:21}}}}]}
      ]});
    });
    assert.equal(await before('content'), 'none');
    assert.equal(await css('#skew', 'transform'), 'matrix(1, 0, 0, 1, 0, 0)');
    assert.equal(await css('#skew', 'content', '::after'), JSON.stringify('Depois "ok"; {x}'));
    assert.equal(await css('#skew', 'left', '::after'), '-12px');
    assert.equal(await css('#plain .x-btn-inner', 'display'), 'inline-block');
    assert.ok((await css('#plain .x-btn-inner', 'transform')).includes('0.383864'));
    // The same pseudo-element supports selected, focus, pressed and disabled rules.
    await page.mouse.move(470, 320);
    await button.evaluate(el => el.blur());
    await page.evaluate(() => {
      const rule = {appearance:{Before:{Enabled:2,Effects:{TransitionMs:0}}},states:{
        Selected:{Before:{Background:{Color:'rgb(1,2,3)'}}},
        Focus:{Before:{Background:{Color:'rgb(4,5,6)'}}},
        Pressed:{Before:{Background:{Color:'rgb(7,8,9)'}}},
        Disabled:{Before:{Enabled:1}}
      }};
      UniDSAStyle.attach('effects',{owner:'owner',enabled:true,items:[{id:'skew',selected:true,layers:[rule]}]});
    });
    assert.equal(await before('backgroundColor'), 'rgb(1, 2, 3)');
    await button.focus();
    assert.equal(await before('backgroundColor'), 'rgb(4, 5, 6)');
    await button.hover();
    await page.mouse.down();
    assert.equal(await before('backgroundColor'), 'rgb(7, 8, 9)');
    await page.mouse.up();
    await button.evaluate(el => el.classList.add('x-btn-disabled'));
    assert.equal(await before('content'), 'none');
    await button.evaluate(el => el.classList.remove('x-btn-disabled'));
    await page.evaluate(() => UniDSAStyle.attach('effects',{owner:'owner',enabled:false,items:[]}));
    assert.equal(await css('#skew', 'transform'), 'none');
    assert.equal(await before('content'), 'none');
    assert.equal(await button.getAttribute('class'), 'x-btn keep-class');
    await page.evaluate(() => UniDSAStyle.detach('effects'));
    assert.equal(await page.locator('style[data-unidsa-style-sheet]').count(), 0);
    assert.deepEqual(errors, []);
    console.log('PASS: DFM-to-browser skew button, animated pseudo-element, upright text, clicks, disabled state, responsive parts, inheritance, After, resets and cleanup.');
  } finally { await browser.close(); }
})().catch(error => {console.error(error); process.exitCode = 1;});
