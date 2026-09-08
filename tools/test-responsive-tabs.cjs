const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

const scope = { window: {} };
const root = path.join(__dirname, '..');
const source = fs.readFileSync(path.join(root, 'dsa/responsive-page-control/js/script.js'), 'utf8');
vm.runInNewContext(source, scope);
const api = scope.window.UniDSAResponsiveTabs;
function visible(widths, space, active, keep = true) {
  const result = api.selectTabs(widths, space, active, keep);
  return widths.map((_, i) => i).filter(i => result.selected[i]);
}
assert.deepEqual(visible([100, 120, 140], 250, 2), [0, 2]);
assert.deepEqual(visible([100, 120, 140], 150, 2), [2]);
assert.deepEqual(visible([100, 120, 140], 400, 2), [0, 1, 2]);
assert.deepEqual(visible([100, 120, 140], 250, 2, false), [0, 1]);
assert.deepEqual(visible([100, 120, 140], 140, -1), [0]);
assert.deepEqual(visible([], 0, -1), []);

function emitter(value = {}) {
  const listeners = {};
  value.on = (name, fn) => (listeners[name] ||= []).push(fn);
  value.fire = (name, ...args) => (listeners[name] || []).forEach(fn => fn(...args));
  value.count = name => (listeners[name] || []).length;
  return value;
}
function element() {
  return { style: { setProperty(name, value) { this[name] = value; } },
    setAttribute(name, value) { this[name] = value; } };
}
function component(width) {
  const classes = new Set();
  return { width, classes, addCls: cls => classes.add(cls), removeCls: cls => classes.delete(cls) };
}
const tabs = [component(100), component(120), component(140)];
const menu = emitter({ el: { dom: element() }, rendered: true, addCls() {},
  items: { each() {} }, hide() { this.hidden = true; } });
const trigger = { el: { dom: element() }, setTooltip(text) { this.tooltip = text; } };
let nativeCalls = 0, updates = 0;
const handler = { type: 'menu', triggerTotalWidth: 36, menuItems: [], menu,
  menuTrigger: trigger, menuItemOverflowedCls: 'overflowed', showTrigger() { nativeCalls++; } };
const layout = { names: { width: 'width', x: 'x' }, overflowHandler: handler,
  setPack(value) { this.pack = value; } };
const bar = emitter({ el: { dom: element() }, width: 500, activeTab: tabs[2],
  getWidth() { return this.width; }, getLayout: () => layout, updateLayout() { updates++; } });
const panel = emitter({ rendered: true, el: { dom: element() }, getTabBar: () => bar });
const options = { alignment: 'center', keepActiveVisible: true,
  colors: { hover: '#abcdef', accent: '#123456' } };
api.attach(panel, options);
assert.equal(layout.pack, 'center');
assert.equal(trigger.el.dom['aria-label'], 'Mais abas');
assert.equal(panel.el.dom.style['--dsa-tabs-hover'], '#abcdef');
assert.equal(menu.el.dom.style['--dsa-tabs-accent'], '#123456');
const wrapper = handler.showTrigger;
api.attach(panel, { ...options, alignment: 'end', colors: { hover: '#fedcba' } });
assert.equal(handler.showTrigger, wrapper, 'reapply must not nest overflow wrappers');
assert.equal(panel.count('tabchange'), 1);
assert.equal(bar.count('resize'), 1);
assert.equal(panel.el.dom.style['--dsa-tabs-hover'], '#fedcba');
assert.equal(layout.pack, 'end');
menu.el = { dom: element() };
menu.fire('afterrender', menu);
assert.equal(menu.el.dom.style['--dsa-tabs-hover'], '#fedcba',
  'a menu first rendered after a palette change must receive the current colors');

function overflow(space) {
  const items = tabs.map(target => ({ target, props: { width: target.width },
    setProp(name, value) { this.props[name] = value; } }));
  handler.showTrigger({ childItems: items,
    state: { boxPlan: { targetSize: { width: space + handler.triggerTotalWidth } } } });
  return items;
}
let items = overflow(260);
assert.equal(nativeCalls, 1);
assert.deepEqual(handler.menuItems, [tabs[1]]);
assert.equal(tabs[2].classes.has('overflowed'), false);
assert.equal(items[0].props.x, 12, 'end alignment accounts for actual visible widths');
assert.equal(items[2].props.x, 116);
bar.activeTab = tabs[1];
panel.fire('tabchange');
overflow(150);
assert.deepEqual(handler.menuItems, [tabs[0], tabs[2]], 'menu selection promotes the new active tab');
bar.width = 190;
bar.fire('resize');
assert.equal(bar.dsaMaxTabWidth, 126);
assert.equal(bar.el.dom.style['--dsa-tab-max-width'], '126px');
assert.equal(menu.hidden, true);
bar.activeTab = tabs[2];
items = overflow(140);
assert.equal(tabs[2].classes.has('overflowed'), false);
assert.equal(items[2].props.x, 10);
bar.width = 900;
bar.fire('resize');
assert.equal(bar.dsaMaxTabWidth, 280, 'growing restores the caption width limit');
assert.ok(updates >= 5);
const unrendered = { rendered: false };
api.attach(unrendered, options);
api.attach({ destroyed: true }, options);
const scroller = { type: 'scroller' };
const scrollerLayout = { overflowHandler: scroller, setPack() {} };
const scrollerBar = emitter({ el: { dom: element() }, getWidth: () => 500,
  getLayout: () => scrollerLayout, updateLayout() {} });
api.attach(emitter({ rendered: true, el: { dom: element() },
  getTabBar: () => scrollerBar }), options);
assert.equal(scroller.dsaInstalled, undefined, 'the native scroller is not patched');

for (const asset of ['js/script.js', 'css/style.css']) {
  assert.equal(fs.readFileSync(path.join(root, 'dsa/responsive-page-control', asset), 'utf8'),
    fs.readFileSync(path.join(root, 'demo/Files/dsa/responsive-page-control', asset), 'utf8'),
    'demo asset must match distribution: ' + asset);
}
console.log('PASS: active tab priority, order, alignment, resizing, runtime colors, idempotence and asset parity');
