(function (global) {
  'use strict';
  if (global.UniDSAFocusControl) return;
  const records = new Map();
  let observer;
  function detach(key) {
    const record = records.get(key);
    if (!record) return;
    record.sheet.remove();
    records.delete(key);
    if (!records.size && observer) { observer.disconnect(); observer = null; }
  }
  function cleanup() {
    for (const [key, record] of records) {
      if (document.getElementById(record.root)) record.seen = true;
      else if (record.seen) detach(key);
    }
  }
  function attach(key, config) {
    if (!config.enabled) { detach(key); return; }
    let record = records.get(key);
    if (!record) {
      const sheet = document.createElement('style');
      sheet.dataset.unidsaFocusControl = key;
      document.head.appendChild(sheet);
      record = {sheet, seen:false};
      records.set(key, record);
    }
    record.root = config.root;
    // Repeated scope IDs override theme and TUniDSAStyle focus declarations.
    const root = ('#' + CSS.escape(config.root)).repeat(4);
    const focused = [':focus', ':focus-visible', '[class*="-focus"]'];
    const targets = focused.flatMap(state => [root + state, root + ' ' + state]);
    const wrappers = ['.x-btn-wrap', '.x-btn-button', '.x-tab-wrap', '.x-tab-button'];
    record.sheet.textContent =
      root + ',' + root + ' *{outline:none!important;outline-offset:0!important;}' +
      targets.concat(targets.map(s => s + '::before'), targets.map(s => s + '::after')).join(',') + '{outline:none!important;box-shadow:none!important;}' +
      targets.flatMap(s => wrappers.map(w => s + ' ' + w)).join(',') + '{outline:none!important;border-color:transparent!important;box-shadow:none!important;}' +
      root + ' button::-moz-focus-inner,' + root + ' input::-moz-focus-inner{border:0!important;}';
    if (!observer) {
      observer = new MutationObserver(cleanup);
      observer.observe(document.documentElement, {childList:true, subtree:true});
    }
    cleanup();
  }
  global.UniDSAFocusControl = {attach, detach};
})(window);
