const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const frames = new Map(), events = new Map();
let seq = 0, active;
function element() {
  const classes = new Set();
  return {
    style: {setProperty(k,v){this[k]=v},removeProperty(k){delete this[k]}},
    classList: {add:k=>classes.add(k),remove:k=>classes.delete(k)}, classes,
    children: [], offsetHeight:44, offsetParent:{},
    getBoundingClientRect:()=>({top:0,bottom:160}),
    querySelector:()=>null
  };
}
const content = element(), footer = element(), mask = element();
content.children = [element()];
const document = {
  documentElement:element(), getElementById:id=>({content,footer}[id]),
  addEventListener(name,fn){if(!events.has(name))events.set(name,new Set());events.get(name).add(fn)},
  removeEventListener(name,fn){events.get(name)?.delete(fn)}
};
class Observer {observe(){} disconnect(){this.disconnected=true}}
const global = {
  innerWidth:1200,innerHeight:900,document,ResizeObserver:Observer,MutationObserver:Observer,
  requestAnimationFrame(fn){frames.set(++seq,fn);return seq},cancelAnimationFrame:id=>frames.delete(id),
  getComputedStyle:()=>({display:'block',paddingBottom:'18'})
};
global.window=global;
vm.runInNewContext(fs.readFileSync(path.join(__dirname,'../dsa/form-style/js/script.js'),'utf8'),global);
function flush(){for(let i=0;frames.size&&i<10;i++){const callbacks=[...frames.values()];frames.clear();callbacks.forEach(fn=>fn())}}
function windowMock(rendered=true) {
  const el=element(), listeners=new Map();
  const tools=Object.fromEntries(['close','minimize','maximize'].map(type=>[type,{
    type,width:16,height:16,getWidth(){return this.width},getHeight(){return this.height},
    setSize(w,h){this.width=w;this.height=h}}]));
  const win={
    rendered,modal:true,shown:true,closable:true,width:900,height:700,onEsc(){},
    el:{dom:el,shadow:{disabled:false},disableShadow(){this.shadow.disabled=true},enableShadow(){this.shadow.disabled=false}},
    header:{height:28,shown:true,getHeight(){return this.height},setHeight(h){this.height=h},isVisible(){return this.shown},setVisible(v){this.shown=v},
      down:selector=>Object.values(tools).find(tool=>selector==='tool[type='+tool.type+']')||null,updateLayout(){this.layoutUpdated=true}},
    zIndexManager:{mask:{dom:mask},getActive:()=>active},
    getWidth(){return this.width},getHeight(){return this.height},
    setSize(w,h){this.width=w;this.height=h},setWidth(w){this.width=w},setHeight(h){this.height=h},
    setPosition(x,y){this.x=x;this.y=y},isVisible(){return this.shown},
    addCls:c=>el.classes.add(c),removeCls:c=>el.classes.delete(c),
    on(e,fn){if(!listeners.has(e))listeners.set(e,new Set());listeners.get(e).add(fn)},
    un(e,fn){listeners.get(e)?.delete(fn)},
    fire(e){[...(listeners.get(e)||[])].forEach(fn=>fn())},
    close(){this.shown=false;this.closed=true;this.fire('hide')}
  };
  return win;
}
const options={enabled:true,radius:18,borderWidth:1,fontSize:18,closeSize:32,background:'white',borderColor:'#ddd',
  headerBackground:'white',titleColor:'#111',closeColor:'#222',closeHover:'#eee',shadow:true,showIcon:false,
  headerVisible:true,headerHeight:64,closeVisible:true,escape:true,backdropColor:'navy',backdropOpacity:40,
  backdropClose:false,maxWidth:960,maxHeight:800,minHeight:180,margin:24,autoHeight:true,content:'content',footer:'footer'};
const api=global.UniDSAFormStyle;
const borderless=windowMock();
const borderlessHeader=borderless.header;
borderless.header=false;
borderless.updateHeader=()=>{borderless.header=borderlessHeader};
active=borderless;api.attach(borderless,options);flush();
assert.equal(borderless.header.shown,true,'bsNone gets a native header while styled');
api.detach(borderless);assert.equal(borderless.header.shown,false);
const win=windowMock(), originalEsc=win.onEsc; active=win;
api.attach(win,options);flush();
assert.equal(win.width,960);assert.equal(win.height,294);
assert.equal(mask.style.opacity,.4);assert.equal(win.header.height,64);
assert.equal(win.liveDrag,true,'drag the real styled window, not the native ghost');
assert.equal(win.header.down('tool[type=close]').width,32,'native hbox reserves the full close button width');
assert.equal(win.header.down('tool[type=close]').height,32,'native hbox centers the full close button height');
assert.equal(win.header.layoutUpdated,true);
const minimizeTool=win.header.down('tool[type=minimize]');
const maximizeTool=win.header.down('tool[type=maximize]');
for(const tool of [minimizeTool,maximizeTool]){
  assert.equal(tool.width,32,'all window actions reserve the same width');
  assert.equal(tool.height,32,'all window actions reserve the same height');
}
maximizeTool.type='restore'; // Ext reuses its maximize tool when the window is maximized.
api.attach(win,{...options,closeSize:40});flush();
assert.equal(win.header.down('tool[type=close]').width,40,'changing close size updates native layout');
for(const tool of [minimizeTool,maximizeTool]){
  assert.equal(tool.width,40,'reapply includes minimize and the active restore tool');
  assert.equal(tool.height,40);
}
global.innerWidth=390;global.innerHeight=500;win.fire('show');flush();
assert.equal(win.width,342);assert.ok(win.x>=0);assert.ok(win.y>=0);
for(const fn of events.get('pointerdown'))fn({target:mask});
assert.equal(win.closed,undefined,'outside click is disabled by default');
for(const fn of events.get('keydown'))fn({key:'Escape',defaultPrevented:false,preventDefault(){}});
flush();assert.equal(win.closed,true);
win.shown=true;win.fire('show');flush();assert.equal(mask.style.opacity,.4);
active={};win.fire('deactivate');flush();assert.equal(mask.style.opacity,undefined,'unstyled modal restores mask');
api.attach(win,{...options,enabled:false});
assert.equal(win.onEsc,originalEsc);assert.equal(win.header.height,28);
assert.equal(win.width,900);assert.equal(win.height,700);
assert.equal(Object.hasOwn(win,'liveDrag'),false,'detach restores inherited drag setting');
assert.equal(win.header.down('tool[type=close]').width,16);
assert.equal(win.header.down('tool[type=close]').height,16);
for(const tool of [minimizeTool,maximizeTool]){
  assert.equal(tool.width,16,'disable restores native window action width');
  assert.equal(tool.height,16,'disable restores native window action height');
}
assert.equal(win.el.dom.classes.has('dsa-form-style'),false);
assert.equal(events.get('keydown').size,0);
const pending=windowMock(false);
const nativeDrag=windowMock();nativeDrag.liveDrag=false;
api.attach(nativeDrag,options);flush();api.detach(nativeDrag);
assert.equal(nativeDrag.liveDrag,false,'explicit native ghost drag is restored on detach');
nativeDrag.liveDrag=true;
api.attach(nativeDrag,options);flush();api.detach(nativeDrag);
assert.equal(nativeDrag.liveDrag,true,'explicit native live drag is preserved');
api.attach(pending,options);api.attach(pending,{...options,enabled:false});
pending.rendered=true;pending.fire('afterrender');flush();
assert.equal(pending.el.dom.classes.has('dsa-form-style'),false,'disabled pending attach must not run');
active=win;api.attach(win,{...options,escape:false,backdropClose:true});flush();
win.closed=false;win.onEsc();assert.equal(win.closed,false);
for(const fn of events.get('pointerdown'))fn({target:mask});
assert.equal(win.closed,true);
win.destroying=true;win.fire('destroy');flush();
assert.equal(events.get('pointerdown').size,0);
assert.equal(events.get('keydown').size,0);
console.log('PASS: sizing, auto height, viewport limits, native close/minimize/maximize/restore sizing, live drag and restoration, Escape, backdrop, unstyled modal, disabled pending attach, detach and listener cleanup.');
