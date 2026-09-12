const assert=require('node:assert/strict');
const {chromium}=require('playwright');
(async()=>{
 const b=await chromium.launch({executablePath:process.env.CHROME_PATH});
 try {
 const p=await b.newPage();await p.goto(process.env.CHAT_URL||'http://localhost:8078');
 await p.waitForSelector('style[data-unidsa-focus-control]',{state:'attached'});
 const filter=p.locator('[data-unidsa-style-item="btnNaoLidas"]');await filter.click();
 assert.equal(await filter.evaluate(e=>getComputedStyle(e).outlineStyle),'none');
 const result=await p.evaluate(()=>{
  const root=document.querySelector('[data-unidsa-style-item="Contatos"]').parentElement;
  const tabs=Ext.create('Ext.tab.Panel',{renderTo:root,width:300,height:120,items:[{title:'First'},{title:'Second'}]});
  tabs.setActiveTab(1);const tab=tabs.getTabBar().items.getAt(1);tab.focus();
  const el=tab.el.dom;
  const focusPreserved=document.activeElement===el||el.contains(document.activeElement);
  const styles=[el,...el.querySelectorAll('*')].map(n=>({outline:getComputedStyle(n).outlineStyle,border:getComputedStyle(n).borderColor}));
  tabs.destroy();return {focusPreserved,styles};
 });
 assert.equal(result.focusPreserved,true);assert.ok(result.styles.every(s=>s.outline==='none'));
 // Independent scopes, late controls, reversible disabling, automatic cleanup.
 await p.evaluate(()=>{
  const a=document.createElement('div');a.id='focus-test-a';document.body.appendChild(a);
  const other=document.createElement('button');other.id='focus-test-other';other.style.outline='2px dotted red';document.body.appendChild(other);
  UniDSAFocusControl.attach('test',{root:a.id,enabled:true});
  a.innerHTML='<button id="focus-test-button" style="outline:2px dotted red">Test</button>';
 });
 assert.equal(await p.locator('#focus-test-button').evaluate(e=>getComputedStyle(e).outlineStyle),'none');
 assert.equal(await p.locator('#focus-test-other').evaluate(e=>getComputedStyle(e).outlineStyle),'dotted');
 await p.evaluate(()=>UniDSAFocusControl.attach('test',{root:'focus-test-a',enabled:false}));
 assert.equal(await p.locator('#focus-test-button').evaluate(e=>getComputedStyle(e).outlineStyle),'dotted');
 await p.evaluate(()=>{UniDSAFocusControl.attach('test',{root:'focus-test-a',enabled:true});document.getElementById('focus-test-a').remove();});
 await p.waitForFunction(()=>!document.querySelector('style[data-unidsa-focus-control="test"]'));
 console.log('PASS: button, real Ext tabs, focus preserved, scopes, late controls, disabled and cleanup');
 }finally{await b.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
