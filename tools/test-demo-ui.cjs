const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const root = path.resolve(__dirname, '..');
const read = file => fs.readFileSync(path.join(root, file), 'utf8').replace(/^\uFEFF/, '').replace(/\r\n/g, '\n');

// DFM migrations must keep the component fields and remove legacy fixed-layout groups.
const views = fs.readdirSync(path.join(root, 'demo/View')).filter(file => file.endsWith('.dfm'));
for (const file of views) {
  const dfm = read('demo/View/' + file);
  const pas = read('demo/View/' + file.replace('.dfm', '.pas'));
  assert.doesNotMatch(dfm, /:\s*TUni(?:GroupBox|ContainerPanel|ScrollBox)\b/, file);
  assert.match(dfm, /object flexDemoPage: TUniDSAFlexPanel/, file);
  for (const [, name, type] of dfm.matchAll(/^\s+(?:object|inherited) (\w+): (\w+)/gm)) {
    assert.match(pas, new RegExp('\\b' + name + ':\\s*' + type + '\\b'), file + ': ' + name);
  }
}
assert.match(read('demo/Main.dfm'), /object flexShell: TUniDSAFlexPanel/);
assert.match(read('demo/Main.dfm'), /object flexContent: TUniDSAFlexPanel/);
assert.match(read('demo/Login.dfm'), /object flexLogin: TUniDSAFlexPanel/);
assert.doesNotMatch(read('demo/Login.dfm'), /window\.onresize/);
assert.match(read('sources/UniDSAMenuLateral.pas'), /property Align;/);

const main = read('demo/Main.pas'), helper = read('demo/Library/DemoUI.pas');
assert.match(main, /OnScreenResize := UniFormScreenResize/);
assert.match(main, /FFrame\.Layout := 'fit'/);
assert.match(helper, /TUniTabSheet\(LControl\)\.Layout := 'fit'/);
assert.match(helper, /FlexItems\.FindByControl/);
assert.match(helper, /TNetEncoding\.HTML\.Encode/);
assert.match(helper, /TryStrToInt/);
assert.match(helper, /FStatus\.Visible := True/);
for (const property of ['HideAfter', 'Dismiss.BackgroundDismiss', 'Style.PaddingTop',
  'WIPLimit', 'QrBox', 'TabColors.HoverColor', 'KeepActiveTabVisible']) {
  assert.ok(main.includes("'" + property + "'"), property);
}
assert.doesNotMatch(read('demo/View/FrameMenuLateral.pas'), /mlMenu\.Menu\.Clear/);
assert.match(read('demo/View/FrameToast.pas'), /Toast\.Text := edtMensagem\.Text/);
assert.doesNotMatch(read('demo/View/FrameConfirm.pas'), /\bClearEvents\b/);
assert.match(read('demo/View/FormLeitorQrCode.pas'), /if Assigned\(LForm\.qrcLeitor\) then LForm\.qrcLeitor\.Stop/);

const script = read('demo/Files/demo/demo.js'), css = read('demo/Files/demo/demo.css');
new vm.Script(script);
assert.match(script, /observer\.disconnect\(\)/);
assert.match(script, /aria-labelledby/);
assert.match(script, /aria-live/);
assert.match(script, /-bodyWrap/); // uniGUI PageControl has a wrapper without x-panel class.
assert.match(css, /max-width: 899px/);
assert.match(css, /\.uni-ml\.uni-ml-minimized/);
assert.doesNotMatch(css, /backdrop-filter/);
for (const file of ['css/style.css', 'js/script.js']) {
  assert.equal(read('demo/Files/dsa/form-style/' + file), read('dsa/form-style/' + file));
}
console.log('Demo UI: DFM, bindings, layouts, accessibility hooks and assets OK.');
