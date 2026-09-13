const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {chromium} = require('playwright');
const root = path.resolve(__dirname,'..');
const rule = JSON.parse(fs.readFileSync(path.join(root,'tmp/style-validation/imported-box.json'),'utf8').replace(/^\uFEFF/,''));
const css = fs.readFileSync(path.join(__dirname,'fixtures/style-box.css'),'utf8').replace(/&#x20;/g,' ').replace(/\.box/g,'#reference');
(async()=>{
  const browser = await chromium.launch({headless:true,...(process.env.CHROME_PATH?{executablePath:process.env.CHROME_PATH}:{})});
  try {
    const page = await browser.newPage({viewport:{width:960,height:600}});
    const errors=[]; page.on('pageerror',e=>errors.push(e.message));
    await page.setContent(`<style>body{background:#e0e0e0;font:16px Arial;margin:70px} #owner{display:flex;gap:100px}
      #imported,#reference{width:220px;height:190px;display:grid;place-items:center} ${css}
      #reference:hover{box-shadow:inset 0 0 5px red,1px 1px 3px rgba(0,0,0,0.2)}</style>
      <div id="owner"><div id="imported">Importado</div><div id="reference">Original</div></div>
      <button id="button" class="x-btn"><span class="x-btn-inner">Texto</span></button>
      <div id="panel" class="x-panel"><div class="x-panel-bodyWrap"><div class="x-panel-body">Painel</div></div></div>
      <div id="untouched">Sem estilo</div>`);
    await page.addScriptTag({path:path.join(root,'sources/UniDSAStyleRuntime.js')});
    const apply=layers=>page.evaluate(layers=>UniDSAStyle.attach('custom-test',{enabled:true,owner:'owner',items:[{id:'imported',layers}]}),layers);
    const read=(selector,property)=>page.locator(selector).evaluate((el,p)=>getComputedStyle(el)[p],property);
    // Deliberately conflicting typed shadow must lose to CustomCSS, which is applied last.
    const conflicting=structuredClone(rule); conflicting.appearance.Shadow={Enabled:2,Color:'#ff00ff',Blur:1};
    await apply([conflicting]);
    for(const property of ['borderRadius','backgroundColor','boxShadow'])
      assert.equal(await read('#imported',property),await read('#reference',property),property);
    const originalShadow=await read('#imported','boxShadow');
    await page.screenshot({path:path.join(root,'tmp/style-validation/custom-css-box.png')});
    await page.locator('#reference').hover(); const hoverShadow=await read('#reference','boxShadow');
    await page.locator('#imported').hover(); assert.equal(await read('#imported','boxShadow'),hoverShadow);
    await page.mouse.move(900,550); assert.equal(await read('#imported','boxShadow'),originalShadow);
    await page.locator('#imported').evaluate(el=>el.setAttribute('aria-disabled','true'));
    await page.locator('#imported').hover(); assert.equal(await read('#imported','boxShadow'),originalShadow);
    await page.mouse.move(900,550);
    await apply([{appearance:{CustomCSS:'filter: brightness(0.9)'}},rule,{appearance:{
      CustomCSS:'--Accent: rgb(1, 2, 3); color: var(--Accent); width: calc(200px + 20px);',
      Border:{Radius:1},Typography:{Color:'#ff0000'}
    }}]);
    assert.equal(await read('#imported','filter'),'brightness(0.9)','Fallback from previous layers must survive');
    assert.equal(await read('#imported','boxShadow'),originalShadow);
    assert.equal(await read('#imported','color'),'rgb(1, 2, 3)','CSS variables and final override');
    assert.equal(await read('#imported','width'),'220px');
    await page.evaluate(()=>UniDSAStyle.attach('adapters',{enabled:true,items:[
      {id:'button',layers:[{appearance:{Typography:{Color:'#ff0000'},CustomCSS:'color: rgb(7, 8, 9); font-family: monospace;'}}]},
      {id:'panel',layers:[{appearance:{Background:{Color:'#ff0000'},CustomCSS:'background: linear-gradient(red, blue);'}}]}
    ]}));
    assert.equal(await read('#button .x-btn-inner','color'),'rgb(7, 8, 9)');
    assert.match(await read('#panel .x-panel-body','backgroundImage'),/^linear-gradient/);
    assert.equal(await read('#untouched','boxShadow'),'none');
    await apply([{appearance:{Border:{Radius:3}}}]);
    assert.equal(await read('#imported','boxShadow'),'none','Replacing configuration must remove stale CustomCSS');
    assert.equal(await read('#imported','filter'),'none');
    await page.evaluate(()=>{UniDSAStyle.detach('custom-test');UniDSAStyle.detach('adapters');});
    assert.equal(await read('#imported','borderRadius'),'0px');
    // Use JSON exported by the Delphi replacement test on the same live control.
    const fixture=name=>JSON.parse(fs.readFileSync(path.join(root,'tmp/style-validation/replace-style-'+name+'.json'),'utf8').replace(/^\uFEFF/,''));
    await page.locator('#imported').evaluate(el=>el.removeAttribute('aria-disabled'));
    await apply([fixture('before')]);
    await page.waitForFunction(()=>getComputedStyle(document.getElementById('imported')).width==='500px');
    assert.equal(await page.locator('#imported').evaluate(el=>getComputedStyle(el,'::before').content),'"old"');
    await page.locator('#imported').hover();
    await page.waitForFunction(()=>getComputedStyle(document.getElementById('imported')).filter==='grayscale(1)');
    await apply([fixture('after')]);
    assert.equal(await read('#imported','width'),'220px','Old responsive width must be removed');
    assert.equal(await read('#imported','filter'),'none','Old hover CustomCSS must be removed');
    assert.equal(await read('#imported','transform'),'none','Old hover transform must be removed');
    assert.equal(await read('#imported','transitionDuration'),'0s','Old transition must be removed');
    assert.equal(await read('#imported','borderRadius'),'46px');
    assert.equal(await read('#imported','boxShadow'),originalShadow);
    assert.equal(await page.locator('#imported').evaluate(el=>getComputedStyle(el,'::before').content),'none','Old pseudo-element must be removed');
    await page.setViewportSize({width:600,height:600});
    assert.equal(await read('#imported','width'),await read('#reference','width'),'Resizing must use the current layout, not the removed breakpoint');
    await page.evaluate(()=>UniDSAStyle.detach('custom-test'));
    assert.deepEqual(errors,[]);
    console.log('PASS: CustomCSS multiple shadows match source, override typed properties, inherit across layers, support states/adapters, replace previous styles and clean up.');
  } finally {await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
