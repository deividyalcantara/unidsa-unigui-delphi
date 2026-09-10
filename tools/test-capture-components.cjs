const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

const root = path.resolve(__dirname, '..');
const read = file => fs.readFileSync(path.join(root, file), 'utf8').replace(/^\uFEFF/, '');

const qrSource = read('sources/UniDSAQrCodeGenerator.pas');
const signatureSource = read('sources/UniDSASignature.pas');
const sourceLinks = read('sources/UniDSASource.pas');
const qrLibrary = read('dsa/qrcode_generator/js/qrcode.js');
const qrScript = read('dsa/qrcode_generator/js/script.js');
const qrCss = read('dsa/qrcode_generator/css/style.css');
const signatureScript = read('dsa/signature/js/script.js');
const signatureCss = read('dsa/signature/css/style.css');
const qrDemo = read('demo/View/FrameQrCodeGenerator.dfm');

assert.match(qrSource, /TUniDSAQrCodeGenerator = class/);
assert.match(qrSource, /procedure RequestData/);
assert.match(qrSource, /property DataURL: string/);
assert.match(qrSource, /property SVG: string/);
assert.match(signatureSource, /TUniDSASignature = class/);
assert.match(signatureSource, /procedure Undo/);
assert.match(signatureSource, /procedure Redo/);
assert.match(signatureSource, /function IsValid: Boolean/);
assert.match(sourceLinks, /qrcode_generator\/js\/qrcode\.js/);
assert.match(sourceLinks, /signature\/js\/script\.js/);
assert.match(qrDemo, /ModuleStyle = qmsSquare/);

const context = {};
vm.createContext(context);
vm.runInContext(qrLibrary, context);
assert.equal(typeof context.qrcode, 'function');
const generated = context.qrcode(0, 'M');
generated.addData('UniDSA');
generated.make();
assert.ok(generated.getModuleCount() > 0);

new vm.Script(qrScript);
new vm.Script(signatureScript);
assert.match(qrScript, /ClipboardItem/);
assert.match(qrScript, /createSvg/);
assert.match(qrScript, /isFinderModule/);
assert.match(qrScript, /drawCanvasFinder/);
assert.match(qrScript, /Math\.max\(4, Number\(options\.margin\)/);
assert.match(qrScript, /fill-rule="evenodd"/);
assert.match(signatureScript, /pointerdown/);
assert.match(signatureScript, /ResizeObserver/);
assert.match(signatureScript, /devicePixelRatio/);
assert.doesNotMatch(qrCss + signatureCss, /backdrop-filter/);

for (const folder of ['qrcode_generator', 'signature']) {
  const files = folder === 'qrcode_generator'
    ? ['css/style.css', 'js/qrcode.js', 'js/script.js']
    : ['css/style.css', 'js/script.js'];
  for (const file of files) {
    assert.equal(
      read(`demo/Files/dsa/${folder}/${file}`),
      read(`dsa/${folder}/${file}`),
      `asset parity: ${folder}/${file}`
    );
  }
}

assert.ok(fs.existsSync(path.join(root, 'images/TUniDSAQrCodeGenerator.bmp')));
assert.ok(fs.existsSync(path.join(root, 'images/TUniDSASignature.bmp')));
assert.ok(fs.statSync(path.join(root, 'images/TUniDSAQrCodeGenerator.bmp')).size > 1000);
assert.ok(fs.statSync(path.join(root, 'images/TUniDSASignature.bmp')).size > 1000);

console.log('PASS: QRCode Generator and Signature components, assets and icons');
