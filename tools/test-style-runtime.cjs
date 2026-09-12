const assert = require('node:assert/strict');
const path = require('node:path');
const {chromium} = require('playwright');
(async () => {
  const browser = await chromium.launch({headless:true, ...(process.env.CHROME_PATH ? {executablePath:process.env.CHROME_PATH} : {})});
  try {
    const page = await browser.newPage({viewport:{width:1000,height:700}});
    const errors = []; page.on('pageerror', e => errors.push(e.message));
    await page.setContent(`<style>.x-btn{width:140px;height:44px;background:linear-gradient(white,gray)} .x-btn-inner{color:black} #scope{width:500px}</style>
      <div id="owner"><button id="first" class="x-btn keep-class"><span class="x-btn-inner">First</span></button>
      <button id="second" class="x-btn"><span class="x-btn-inner">Second</span></button>
      <div id="field" class="x-field"><div class="x-form-trigger-wrap"><div class="x-form-text-wrap"><input class="x-form-text"></div></div></div>
      <label id="message" class="x-component" style="height:20px">Text</label><div id="scope" class="x-container"><label id="child" class="x-component">Child</label></div>
      <div id="scroll" class="x-container"><div class="x-autocontainer-outerCt"><div id="scroll-inner" class="x-autocontainer-innerCt dsa-flex-inner" style="width:120px;height:80px;overflow:auto"><div style="width:400px;height:300px"></div></div></div></div></div>`);
    await page.addScriptTag({path:path.resolve(__dirname,'../sources/UniDSAStyleRuntime.js')});
    await page.evaluate(() => {
      window.configA = {owner:'owner', enabled:true, items:[{id:'first', name:'First', selected:false, layers:[
        {appearance:{Background:{Color:'rgb(8,127,105)'},Typography:{Color:'rgb(255,255,255)',Size:16},Border:{Radius:9},Effects:{TransitionMs:0}}, states:{
          Hover:{Background:{Color:'rgb(5,107,89)'},Shadow:{Enabled:2,Opacity:20,Color:'rgb(0,0,0)'}},
          Focus:{Effects:{OutlineWidth:3,OutlineColor:'rgb(0,0,255)'}},
          Pressed:{Background:{Color:'rgb(3,78,66)'}},
          Disabled:{Background:{Color:'rgb(150,150,150)'},Effects:{Opacity:40}},
          Selected:{Background:{Color:'rgb(10,20,30)'}}}},
        {appearance:{Typography:{Weight:4}}}]}]};
      UniDSAStyle.attach('manager-a', configA);
      UniDSAStyle.attach('manager-b', {owner:'owner',enabled:true,items:[{id:'second',layers:[{appearance:{Background:{Color:'rgb(200,0,0)'}}}]}]});
      document.getElementById('first').onclick = function () { window.clicked = true; };
    });
    const first = page.locator('#first');
    assert.equal(await first.evaluate(el=>getComputedStyle(el).backgroundImage),'none');
    assert.equal(await page.locator('#first .x-btn-inner').evaluate(el=>getComputedStyle(el).fontWeight),'700');
    await first.hover();
    assert.equal(await first.evaluate(el=>getComputedStyle(el).backgroundColor),'rgb(5, 107, 89)');
    assert.ok((await first.evaluate(el=>getComputedStyle(el).boxShadow)).includes('0.2'));
    assert.equal(await page.locator('#second').evaluate(el=>getComputedStyle(el).backgroundColor),'rgb(200, 0, 0)');
    await first.focus();
    assert.equal(await first.evaluate(el=>getComputedStyle(el).outlineWidth),'3px');
    await page.mouse.down();
    assert.equal(await first.evaluate(el=>getComputedStyle(el).backgroundColor),'rgb(3, 78, 66)');
    await page.mouse.up();
    assert.equal(await page.evaluate(()=>window.clicked),true);
    await first.evaluate(el=>el.setAttribute('aria-disabled','true'));
    assert.equal(await first.evaluate(el=>getComputedStyle(el).backgroundColor),'rgb(150, 150, 150)');
    assert.equal(await first.evaluate(el=>getComputedStyle(el).opacity),'0.4');
    await first.evaluate(el=>el.removeAttribute('aria-disabled'));
    await page.mouse.move(900,600);
    await page.evaluate(()=>{configA.items[0].selected=true; UniDSAStyle.attach('manager-a',configA);});
    assert.equal(await first.evaluate(el=>getComputedStyle(el).backgroundColor),'rgb(10, 20, 30)');
    assert.equal(await page.locator('style[data-unidsa-style-sheet="manager-a"]').count(),1);
    await page.evaluate(()=>UniDSAStyle.attach('fields',{owner:'owner',enabled:true,items:[
      {id:'field',layers:[{appearance:{Background:{Color:'rgb(1,2,3)'},Typography:{Color:'rgb(4,5,6)'},Border:{Width:0,Radius:8},Spacing:{Padding:{Left:12}}}}]},
      {id:'message',layers:[{appearance:{Sizing:{Height:{Units:8,Value:0}},Typography:{WrapAnywhere:2,WhiteSpace:4}}}]}
    ]}));
    assert.equal(await page.locator('#field input').evaluate(el=>getComputedStyle(el).color),'rgb(4, 5, 6)');
    assert.equal(await page.locator('#field .x-form-trigger-wrap').evaluate(el=>getComputedStyle(el).borderRadius),'8px');
    assert.equal(await page.locator('#field input').evaluate(el=>getComputedStyle(el).paddingLeft),'12px');
    await page.evaluate(()=>UniDSAStyle.attach('scrollbars',{owner:'owner',enabled:true,items:[
      {id:'scroll',layers:[{appearance:{Scrollbar:{Visible:2,Size:8,TrackColor:'rgb(240,241,242)',ThumbColor:'rgb(8,127,105)',ThumbHoverColor:'rgb(5,107,89)',Radius:999}}}]}
    ]}));
    assert.equal(await page.locator('#scroll-inner').evaluate(el=>getComputedStyle(el,'::-webkit-scrollbar').width),'8px');
    assert.equal(await page.locator('#scroll-inner').evaluate(el=>getComputedStyle(el,'::-webkit-scrollbar-thumb').backgroundColor),'rgb(8, 127, 105)');
    assert.equal(await page.locator('#scroll-inner').evaluate(el=>getComputedStyle(el,'::-webkit-scrollbar-thumb').borderRadius),'999px');
    const scrollbarSheet = await page.locator('style[data-unidsa-style-sheet="scrollbars"]').textContent();
    assert.ok(scrollbarSheet.includes('::-webkit-scrollbar-thumb:hover'));
    await page.evaluate(()=>{
      configA.items[0].layers.push({appearance:{Sizing:{Width:{Units:1,Value:120}}},responsive:[{max:500,appearance:{Sizing:{Width:{Units:1,Value:240}}}}]});
      UniDSAStyle.attach('manager-a',configA);
    });
    assert.equal((await first.boundingBox()).width,120);
    await page.setViewportSize({width:450,height:700});
    await page.waitForFunction(()=>document.getElementById('first').getBoundingClientRect().width===240);
    // A local unset length must not erase the named style's width.
    await page.evaluate(()=>{configA.items[0].layers.push({appearance:{Sizing:{Width:{Units:0,Value:0}}}});UniDSAStyle.attach('manager-a',configA);});
    assert.equal((await first.boundingBox()).width,240);
    // Declarations disappear when no longer configured; underlying theme is restored.
    await page.evaluate(()=>UniDSAStyle.attach('manager-a',{owner:'owner',enabled:true,items:[{id:'first',layers:[{appearance:{Typography:{Color:'rgb(0,0,0)'}}}]}]}));
    assert.ok((await first.evaluate(el=>getComputedStyle(el).backgroundImage)).includes('linear-gradient'));
    assert.equal(await first.getAttribute('class'),'x-btn keep-class');
    await page.evaluate(()=>UniDSAStyle.attach('scope-manager',{owner:'owner',enabled:true,scope:'scope',children:true,defaults:{appearance:{Typography:{Color:'rgb(60,70,80)'}}},items:[{id:'child',layers:[{appearance:{Typography:{Color:'rgb(90,100,110)'}}}]}]}));
    assert.equal(await page.locator('#child').evaluate(el=>getComputedStyle(el).color),'rgb(90, 100, 110)');
    // Late rendering is supported without replacing client events.
    await page.evaluate(()=>{UniDSAStyle.attach('late',{owner:'owner',enabled:true,items:[{id:'later',layers:[{appearance:{Typography:{Color:'rgb(1,2,3)'}}}]}]});const el=document.createElement('label');el.id='later';el.textContent='late';document.getElementById('owner').appendChild(el);});
    await page.waitForFunction(()=>getComputedStyle(document.getElementById('later')).color==='rgb(1, 2, 3)');
    await page.evaluate(()=>UniDSAStyle.attach('unsafe',{owner:'owner',enabled:true,items:[{id:'second',layers:[{appearance:{Background:{ImageURL:'javascript:alert(1)'},Typography:{Family:'x"; } body { display:none } /*'}}}]}]}));
    assert.equal(await page.locator('style[data-unidsa-style-sheet="unsafe"]').textContent(),'');
    await page.evaluate(()=>UniDSAStyle.detach('manager-b'));
    assert.equal(await page.locator('style[data-unidsa-style-sheet="manager-b"]').count(),0);
    await page.evaluate(()=>document.getElementById('owner').remove());
    await page.waitForFunction(()=>document.querySelectorAll('style[data-unidsa-style-sheet]').length===0);
    assert.deepEqual(errors,[]);
    console.log('PASS: hover/focus/pressed/disabled/selected, compound inheritance, input adapters, responsive sizing, scoping, scrollbar, lifecycle, events, and value safety.');
  } finally { await browser.close(); }
})().catch(e=>{console.error(e);process.exitCode=1;});
