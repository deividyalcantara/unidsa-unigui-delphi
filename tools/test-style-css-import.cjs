const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {chromium} = require('playwright');
const root = path.resolve(__dirname, '..');
const rule = JSON.parse(fs.readFileSync(path.join(root, 'tmp/style-validation/imported-card.json'), 'utf8').replace(/^\uFEFF/, ''));
const referenceCSS = fs.readFileSync(path.join(__dirname, 'fixtures/style-card.css'), 'utf8')
  .replace(/&#x20;/g, ' ').replace(/\.card/g, '#reference');
(async () => {
  const browser = await chromium.launch({headless:true, ...(process.env.CHROME_PATH ? {executablePath:process.env.CHROME_PATH} : {})});
  try {
    const page = await browser.newPage({viewport:{width:840,height:480}});
    const errors = []; page.on('pageerror', error => errors.push(error.message));
    await page.setContent(`<style>body{margin:60px;font:16px Arial;background:linear-gradient(115deg,#daf0eb,#dce8fc)}
      #owner{display:flex;gap:80px} ${referenceCSS}</style>
      <div id="owner"><div id="imported" tabindex="0">Importado</div><div id="reference">Original</div></div>
      <p id="unrelated">Controle sem estilo</p>`);
    await page.addScriptTag({path:path.join(root,'sources/UniDSAStyleRuntime.js')});
    await page.evaluate(rule => UniDSAStyle.attach('import-test',{owner:'owner',enabled:true,items:[{id:'imported',layers:[rule]}]}),rule);
    await page.waitForFunction(() => {
      const style=getComputedStyle(document.getElementById('imported'));
      return style.backdropFilter==='blur(6px)' && style.fontWeight==='700';
    });
    const properties=['width','height','boxSizing','backgroundColor','borderTopWidth','borderTopColor','borderTopStyle',
      'borderRadius','boxShadow','backdropFilter','textAlign','cursor','display','alignItems','justifyContent','userSelect',
      'fontWeight','color','transitionProperty','transitionDuration','transitionTimingFunction'];
    const appearance = id => page.locator('#'+id).evaluate((el,props) => {
      const style=getComputedStyle(el); return Object.fromEntries(props.map(p=>[p,style[p]]));
    },properties);
    assert.deepEqual(await appearance('imported'),await appearance('reference'),'Imported parameters must render like the supplied CSS');
    const matrix = id => page.locator('#'+id).evaluate(el => Array.from(new DOMMatrix(getComputedStyle(el).transform==='none'?undefined:getComputedStyle(el).transform).toFloat64Array()));
    const settle = async (id, a, b=0) => page.waitForFunction(({id,a,b}) => {
      const style=getComputedStyle(document.getElementById(id)); const m=new DOMMatrix(style.transform==='none'?undefined:style.transform);
      return Math.abs(m.a-a)<0.00001 && Math.abs(m.b-b)<0.00001;
    },{id,a,b});
    for(const id of ['reference','imported']) {
      await page.locator('#'+id).hover(); await settle(id,1.05);
      assert.equal((await appearance(id)).borderTopColor,'rgb(0, 0, 0)');
    }
    await page.screenshot({path:path.join(root,'tmp/style-validation/imported-card-hover.png')});
    const angle=1.7*Math.PI/180, a=0.95*Math.cos(angle), b=0.95*Math.sin(angle);
    const pressed=[];
    for(const id of ['reference','imported']) {
      await page.locator('#'+id).hover(); await page.mouse.down();
      try {await settle(id,a,b); pressed.push(await matrix(id));} finally {await page.mouse.up();}
    }
    pressed[0].forEach((value,index) => assert.ok(Math.abs(value-pressed[1][index])<0.00001, 'Pressed state must preserve scale and rotation order'));
    await page.mouse.move(800,440); await settle('imported',1);
    await page.locator('#imported').evaluate(el=>el.setAttribute('aria-disabled','true'));
    await page.locator('#imported').hover(); await settle('imported',1);
    await page.mouse.down(); try {await settle('imported',1);} finally {await page.mouse.up();}
    assert.equal((await appearance('imported')).borderTopColor,'rgb(255, 255, 255)');
    assert.equal(await page.locator('#unrelated').evaluate(el=>getComputedStyle(el).backdropFilter),'none');
    await page.evaluate(()=>UniDSAStyle.detach('import-test'));
    assert.equal((await appearance('imported')).backdropFilter,'none');
    assert.equal((await appearance('imported')).borderRadius,'0px');
    assert.deepEqual(errors,[]);
    console.log('PASS: imported CSS matches original card in Chrome, including hover, active, blur, disabled isolation and cleanup.');
  } finally {await browser.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
