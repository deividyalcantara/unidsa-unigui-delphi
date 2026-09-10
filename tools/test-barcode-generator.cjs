const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

const root = path.resolve(__dirname, '..');
const read = file => fs.readFileSync(path.join(root, file), 'utf8').replace(/^\uFEFF/, '');

const source = read('sources/UniDSABarcodeGenerator.pas');
const links = read('sources/UniDSASource.pas');
const script = read('dsa/barcode_generator/js/script.js');
const library = read('dsa/barcode_generator/js/JsBarcode.all.min.js');
const css = read('dsa/barcode_generator/css/style.css');
const demoSource = read('demo/View/FrameBarcodeGenerator.pas');
const demoForm = read('demo/View/FrameBarcodeGenerator.dfm');
const menu = read('demo/Main.pas');

assert.match(source, /TUniDSABarcodeGenerator = class/);
assert.match(source, /bcCode128, bcEAN13, bcEAN8, bcUPCA, bcCode39/);
assert.match(source, /procedure RequestData/);
assert.match(source, /property Valid: Boolean/);
assert.match(source, /property LastError: string/);
assert.match(links, /barcode_generator\/js\/JsBarcode\.all\.min\.js\?v=3\.12\.3/);
assert.match(demoSource, /TFrBarcodeGenerator = class/);
assert.match(demoForm, /object BarcodeGenerator: TUniDSABarcodeGenerator/);
assert.match(menu, /AddComponent\('Barcode Generator'/);

const context = {};
context.window = context;
context.self = context;
vm.createContext(context);
vm.runInContext(library, context);
assert.equal(typeof context.JsBarcode, 'function');
for (const [format, value] of [
  ['CODE128', 'ABC123'],
  ['EAN13', '7891234567895'],
  ['EAN8', '12345670'],
  ['UPC', '123456789012'],
  ['CODE39', 'ABC-123'],
  ['ITF14', '12345678901231'],
  ['codabar', 'A1234B']
]) {
  const Encoder = context.JsBarcode.getModule(format);
  const encoded = new Encoder(value, {});
  assert.equal(encoded.valid(), true, `${format} must accept its sample value`);
  assert.ok(JSON.stringify(encoded.encode()).length > 20, `${format} must produce bars`);
}
new vm.Script(script);
assert.match(script, /global\.JsBarcode/);
assert.match(script, /ClipboardItem/);
assert.match(script, /XMLSerializer/);
assert.match(script, /devicePixelRatio/);
assert.doesNotMatch(css, /backdrop-filter/);

const nodes = {
  svg: { hidden: false, attributes: {}, setAttribute(name, value) { this.attributes[name] = value; } },
  empty: { hidden: false, textContent: '' },
  actions: { hidden: false },
  status: { textContent: '', classList: { toggle() {} } }
};
const rootNode = {
  scrollHeight: 360,
  getBoundingClientRect() { return { height: 360 }; },
  style: { setProperty() {} },
  querySelector(selector) {
    return {
      svg: nodes.svg,
      '.unidsa-barcode-generator__empty': nodes.empty,
      '.unidsa-barcode-generator__actions': nodes.actions,
      '.unidsa-barcode-generator__status': nodes.status
    }[selector];
  },
  addEventListener() {}
};
const wrapperContext = {
  document: { getElementById: id => id === 'barcode' ? rootNode : null },
  navigator: {},
  ajaxRequest() {},
  requestAnimationFrame(callback) { callback(); return 1; },
  cancelAnimationFrame() {},
  JsBarcode(svg, value, options) {
    assert.equal(value, 'ABC123');
    assert.equal(options.format, 'CODE128');
    options.valid(true);
  }
};
wrapperContext.window = wrapperContext;
vm.createContext(wrapperContext);
vm.runInContext(script, wrapperContext);
let hostHeight = 0;
wrapperContext.UniDSABarcodeGenerator.init('barcode', {
  getHeight() { return hostHeight; },
  setHeight(value) { hostHeight = value; },
  ownerCt: { updateLayout() {} }
}, {
  value: 'ABC123', format: 'CODE128', barWidth: 2, barHeight: 100,
  margin: 12, displayValue: true, humanReadableText: '', fontSize: 18,
  textMargin: 4, lineColor: '#000', background: '#fff', exportFormat: 'png',
  fileName: 'barcode', emptyText: 'empty', showActions: true,
  panelBackground: '#f8fafc', surface: '#fff', border: '#ddd',
  textColor: '#222', muted: '#666', primary: '#2563eb', borderRadius: 16,
  maxWidth: 840
});
assert.equal(nodes.svg.hidden, false);
assert.equal(nodes.svg.attributes.role, 'img');
assert.match(nodes.status.textContent, /sucesso/);
assert.equal(hostHeight, 360);

for (const file of ['css/style.css', 'js/JsBarcode.all.min.js', 'js/script.js', 'LICENSE']) {
  assert.equal(
    read(`demo/Files/dsa/barcode_generator/${file}`),
    read(`dsa/barcode_generator/${file}`),
    `asset parity: barcode_generator/${file}`
  );
}

const icon = path.join(root, 'images/TUniDSABarcodeGenerator.bmp');
assert.ok(fs.existsSync(icon));
assert.ok(fs.statSync(icon).size > 1000);

console.log('PASS: Barcode Generator component, formats, local assets, demo and icon');
