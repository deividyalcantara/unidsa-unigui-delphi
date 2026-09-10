const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const root = path.resolve(__dirname, '..');
const read = file => fs.readFileSync(path.join(root, file), 'utf8').replace(/^\uFEFF/, '').replace(/\r\n/g, '\n');

function componentFields(pas) {
  const fields = [];
  let insideClass = false;
  for (const line of pas.split('\n')) {
    if (!insideClass && /=\s*class\s*\(/i.test(line)) {
      insideClass = true;
      continue;
    }
    if (!insideClass) continue;
    if (/^\s*(?:private|protected|public|published)\b/i.test(line) || /^\s*end;/i.test(line)) break;
    if (/^\s*(?:procedure|function|constructor|destructor)\b/i.test(line)) break;
    const match = /^\s*(\w+)\s*:\s*(T\w+)\s*;/.exec(line);
    if (match) fields.push({ name: match[1], type: match[2] });
  }
  return fields;
}

function validateFormPair(dfmFile) {
  const pasFile = dfmFile.replace(/\.dfm$/i, '.pas');
  const dfm = read(dfmFile);
  const pas = read(pasFile);
  const objects = new Map();
  const objectMatches = Array.from(dfm.matchAll(/^\s*(?:object|inherited) (\w+): (\w+)/gm));
  for (const [, name, type] of objectMatches)
    objects.set(name.toLowerCase(), type.toLowerCase());
  const fields = componentFields(pas);
  const fieldsByName = new Map(fields.map(field => [field.name.toLowerCase(), field.type.toLowerCase()]));
  for (const [, name, type] of objectMatches.slice(1)) {
    assert.ok(fieldsByName.has(name.toLowerCase()), `${dfmFile}: objeto ${name} sem campo no PAS`);
    assert.equal(fieldsByName.get(name.toLowerCase()), type.toLowerCase(),
      `${dfmFile}: tipo divergente em ${name}`);
  }
  for (const field of fields) {
    if (!objects.has(field.name.toLowerCase())) {
      assert.match(pas, new RegExp('\\b' + field.name + '\\s*:=\\s*' + field.type + '\\.Create\\s*\\(', 'i'),
        `${dfmFile}: campo ${field.name} sem objeto no DFM ou criacao em runtime`);
      continue;
    }
    assert.equal(objects.get(field.name.toLowerCase()), field.type.toLowerCase(),
      `${dfmFile}: tipo divergente em ${field.name}`);
  }
  for (const [, handler] of dfm.matchAll(/^\s+On\w+\s*=\s*(\w+)\s*$/gm)) {
    assert.match(pas, new RegExp('procedure\\s+' + handler + '\\s*\\(', 'i'),
      `${dfmFile}: evento ${handler} sem declaracao`);
    assert.match(pas, new RegExp('procedure\\s+T\\w+\\.' + handler + '\\s*\\(', 'i'),
      `${dfmFile}: evento ${handler} sem implementacao`);
  }
}

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
const rootForms = fs.readdirSync(path.join(root, 'demo')).filter(file => file.endsWith('.dfm'));
for (const file of rootForms)
  validateFormPair('demo/' + file);
for (const file of views)
  validateFormPair('demo/View/' + file);
assert.match(read('demo/Main.dfm'), /object flexShell: TUniDSAFlexPanel/);
assert.match(read('demo/Main.dfm'), /object flexContent: TUniDSAFlexPanel/);
assert.match(read('demo/Main.dfm'), /^  object mlMenu: TUniDSAMenuLateral/m);
assert.doesNotMatch(read('demo/Main.dfm'), /FlexItems = <[\s\S]*?Control = mlMenu/);
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
console.log(`Demo UI: ${rootForms.length + views.length} PAS/DFM pairs, events, layouts, accessibility hooks and assets OK.`);
