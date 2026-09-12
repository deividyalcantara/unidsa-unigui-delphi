const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {chromium} = require('playwright');
const root = path.resolve(__dirname, '..');
const cases = JSON.parse(fs.readFileSync(path.join(root, 'tmp/flex-validation/preview-cases.json'), 'utf8').replace(/^\uFEFF/, ''));
(async () => {
  const browser = await chromium.launch({headless:true, ...(process.env.CHROME_PATH ? {executablePath:process.env.CHROME_PATH} : {})});
  try {
    const page = await browser.newPage();
    await page.setContent('<style>body{margin:0}#panel{display:flex;box-sizing:border-box;padding:10px;row-gap:18px;column-gap:14px;align-items:center}#panel>div{box-sizing:border-box;flex-shrink:0}</style><div id="panel"></div>');
    for (const fixture of cases) {
      const actual = await page.evaluate(fixture => {
        const panel = document.getElementById('panel');
        Object.assign(panel.style, {
          width:fixture.width+'px',height:fixture.height+'px',
          flexDirection:['row','row-reverse','column','column-reverse'][fixture.direction],
          justifyContent:['flex-start','center','flex-end','space-between','space-around','space-evenly'][fixture.justify],
          flexWrap:['nowrap','wrap','wrap-reverse'][fixture.wrap],
          alignContent:['stretch','flex-start','center','flex-end'][fixture.alignContent],
          alignItems:['stretch','flex-start','center','flex-end'][fixture.alignItems]
        });
        panel.replaceChildren(...fixture.items.map(item => {
          const child = document.createElement('div');
          Object.assign(child.style,{width:item.width+'px',height:item.height+'px',order:item.order});
          if(fixture.direction>=2 && fixture.alignItems===0) child.style.width='auto';
          return child;
        }));
        return Array.from(panel.children, el => {const r=el.getBoundingClientRect();return [r.x,r.y,r.width,r.height];});
      }, fixture);
      fixture.items.forEach((item, i) => {
        const expected = [item.x,item.y,item.actualWidth,item.actualHeight];
        expected.forEach((value, axis) => assert.ok(Math.abs(actual[i][axis]-value)<=1,
          `${JSON.stringify(fixture)} child ${i}, axis ${axis}: design ${value}, browser ${actual[i][axis]}`));
      });
    }
    console.log(`PASS: ${cases.length} VCL previews match browser Flexbox (within 1 px).`);
  } finally {await browser.close();}
})().catch(error => {console.error(error);process.exit(1);});
