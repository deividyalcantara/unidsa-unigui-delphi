const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const root = path.resolve(__dirname, '..');
const read = file => fs.readFileSync(path.join(root, file), 'utf8').replace(/^\uFEFF/, '');

const source = read('sources/UniDSAQrCodeReader.pas');
const links = read('sources/UniDSASource.pas');
const css = read('dsa/qrcode_reader/css/style.css');
const script = read('dsa/qrcode_reader/js/script.js');

assert.match(source, /TUniDSAQrCodeReaderStyle = class\(TPersistent\)/);
assert.match(source, /property Style: TUniDSAQrCodeReaderStyle/);
assert.match(source, /Style\.MaxWidth/);
assert.match(source, /Style\.VideoMaxHeight/);
assert.match(source, /UniDSAQrCodeReader\.attach/);
assert.doesNotMatch(source, /style="width:/);
assert.match(links, /qrcode_reader\/css\/style\.css/);
assert.match(links, /qrcode_reader\/js\/script\.js/);
assert.match(css, /--dsa-qr-max-width/);
assert.match(css, /max-height: var\(--dsa-qr-video-max-height\)/);
assert.match(css, /span\.html5-qrcode-element \{/);
assert.match(css, /padding: 9px 14px !important/);
assert.doesNotMatch(css, /backdrop-filter/);
new vm.Script(script);
assert.match(script, /MutationObserver/);
assert.match(script, /aria-label/);
assert.match(script, /root\.style\.maxWidth/);

for (const file of ['css/style.css', 'js/script.js']) {
  assert.equal(read('demo/Files/dsa/qrcode_reader/' + file),
    read('dsa/qrcode_reader/' + file), 'asset parity: ' + file);
}

console.log('PASS: QRCode responsive layout, runtime style and asset parity');
