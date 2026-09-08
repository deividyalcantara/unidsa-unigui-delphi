(function () {
  'use strict';
  var frames = new Map(), scheduled = false;
  function refresh() {
    scheduled = false;
    frames.forEach(function (observer, el) {
      if (!el.isConnected) { observer.disconnect(); frames.delete(el); }
    });
    document.querySelectorAll('.demo-content > .dsa-flex-wrapper > .dsa-flex-inner > .x-panel, .demo-page .dsa-flex-inner > .x-panel, .demo-page .dsa-flex-inner > .dsa-flex-item:has(> [id$="-bodyWrap"])').forEach(function (el) {
      if (frames.has(el)) return;
      var width = -1, height = -1;
      var observer = new ResizeObserver(function () {
        requestAnimationFrame(function () {
          if (!el.isConnected) return;
          var cmp = Ext.getCmp(el.id), w = el.clientWidth, h = el.clientHeight;
          if (!cmp || cmp.destroyed || !w || !h || (w === width && h === height)) return;
          width = w; height = h;
          cmp.setSize(w, h);
          cmp.updateLayout();
        });
      });
      observer.observe(el);
      frames.set(el, observer);
    });
    document.querySelectorAll('.demo-status').forEach(function (el) { el.setAttribute('aria-live', 'polite'); });
    document.querySelectorAll('.demo-field, .demo-layout').forEach(function (field) {
      var label = field.querySelector('.demo-label'), input = field.querySelector('input');
      if (label && input && field.querySelectorAll('input').length === 1) input.setAttribute('aria-labelledby', label.id);
    });
    document.querySelectorAll('.demo-field').forEach(function (field) {
      var label = field.querySelector('.demo-label'), button = field.querySelector('.demo-button');
      if (label && button) button.setAttribute('aria-label', 'Aplicar ' + label.textContent.trim());
    });
    document.querySelectorAll('.demo-page .demo-input').forEach(function (field) {
      var label = field.previousElementSibling, input = field.querySelector('input, textarea');
      if (label && label.classList.contains('demo-label') && input) input.setAttribute('aria-labelledby', label.id);
    });
    document.querySelectorAll('.demo-shell .uni-ml-menu-row').forEach(function (row) {
      var label = row.querySelector('[id^="uni-ml-item-texto-"]');
      if (!label) return;
      row.setAttribute('aria-label', label.textContent.trim());
      row.setAttribute('title', label.textContent.trim());
    });
  }
  function schedule() {
    if (!scheduled) { scheduled = true; requestAnimationFrame(refresh); }
  }
  function start() {
    new MutationObserver(schedule).observe(document.body, { childList: true, subtree: true });
    schedule();
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', start);
  else start();
}());
