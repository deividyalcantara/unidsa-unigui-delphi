const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const {chromium}=require('playwright');
const root=path.resolve(__dirname,'..');
const rule=JSON.parse(fs.readFileSync(path.join(root,'tmp/style-validation/grouped-button.json'),'utf8').replace(/^\uFEFF/,''));
const css=fs.readFileSync(path.join(__dirname,'fixtures/style-button-grouped.css'),'utf8').replace(/&#x20;/g,' ').replace(/\.button-1/g,'#reference');
(async()=>{
  const browser=await chromium.launch({headless:true,...(process.env.CHROME_PATH?{executablePath:process.env.CHROME_PATH}:{})});
  try {
    const page=await browser.newPage({viewport:{width:900,height:380}});
    const errors=[];page.on('pageerror',e=>errors.push(e.message));
    await page.setContent(`<style>body{margin:50px}button{margin-right:24px}${css}</style>
      <div id="owner"><button id="imported">Botao</button><button id="reference">Botao</button>
      <button id="adapted" class="x-btn"><span class="x-btn-wrap"><span class="x-btn-inner">Botao uniGUI</span></span></button>
      <button id="unrelated">Original</button></div>`);
    await page.addScriptTag({path:path.join(root,'sources/UniDSAStyleRuntime.js')});
    await page.evaluate(rule=>UniDSAStyle.attach('groups',{owner:'owner',enabled:true,items:[
      {id:'imported',layers:[rule]},{id:'adapted',layers:[rule]}
    ]}),rule);
    const props=['backgroundColor','borderRadius','borderTopStyle','boxSizing','color','cursor','display','fontFamily',
      'fontSize','fontWeight','height','lineHeight','listStyleType','marginTop','marginLeft','outlineStyle',
      'paddingTop','paddingRight','paddingBottom','paddingLeft','position','textAlign','textDecorationLine',
      'transitionProperty','transitionDuration','verticalAlign','userSelect','touchAction'];
    const styles=selector=>page.locator(selector).evaluate((el,props)=>{
      const s=getComputedStyle(el);return Object.fromEntries(props.map(p=>[p,s[p]]));
    },props);
    const background=selector=>page.locator(selector).evaluate(el=>getComputedStyle(el).backgroundColor);
    await page.waitForFunction(()=>getComputedStyle(document.getElementById('imported')).color==='rgb(255, 255, 255)');
    assert.deepEqual(await styles('#imported'),await styles('#reference'),'Complete imported button must match original CSS');
    for(const selector of ['#reference','#imported','#adapted']) {
      await page.locator(selector).hover();
      assert.equal(await background(selector),'rgb(240, 130, 172)','Grouped hover');
    }
    await page.mouse.move(850,330);
    assert.equal(await background('#imported'),'rgb(234, 76, 137)');
    // Tab navigation must activate focus even without hovering the button.
    await page.keyboard.press('Tab');
    assert.equal(await page.locator('#imported').evaluate(el=>el===document.activeElement),true);
    assert.equal(await background('#imported'),'rgb(240, 130, 172)','Grouped keyboard focus');
    await page.keyboard.press('Tab');
    assert.equal(await background('#imported'),'rgb(234, 76, 137)','Blur must restore base');
    assert.equal(await background('#reference'),'rgb(240, 130, 172)');
    await page.keyboard.press('Tab');
    assert.equal(await background('#adapted'),'rgb(240, 130, 172)','uniGUI adapter keyboard focus');
    await page.keyboard.press('Tab');
    await page.locator('#imported').evaluate(el=>el.disabled=true);
    await page.locator('#imported').hover();
    assert.equal(await background('#imported'),'rgb(234, 76, 137)','Disabled controls must not apply hover');
    assert.notEqual(await background('#unrelated'),'rgb(234, 76, 137)','Selectors stay scoped');
    await page.evaluate(()=>UniDSAStyle.detach('groups'));
    assert.notEqual(await background('#imported'),'rgb(234, 76, 137)','Cleanup removes imported CSS');
    assert.deepEqual(errors,[]);
    console.log('PASS: full grouped button matches original CSS, mouse hover, keyboard focus, uniGUI adapter, disabled state and cleanup.');
  } finally {await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
