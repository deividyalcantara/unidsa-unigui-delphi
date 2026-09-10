(function (global) {
  'use strict';
  var API = global.UniDSAQrCodeReader = global.UniDSAQrCodeReader || {};

  function setVariable(root, name, value) {
    if (value !== undefined && value !== null) root.style.setProperty(name, value);
  }

  function decorate(root) {
    root.classList.add('unidsa-qrcode-reader');
    root.setAttribute('role', 'region');
    root.setAttribute('aria-label', 'Leitor de QR Code e códigos de barras');
    Array.prototype.forEach.call(root.querySelectorAll('button, input, select, a'), function (control) {
      if (!control.title && control.textContent) control.title = control.textContent.trim();
    });
    var video = root.querySelector('video');
    if (video) video.setAttribute('aria-label', 'Visualização da câmera');
  }

  function syncHostHeight(root, owner) {
    if (!owner || typeof owner.setHeight !== 'function') return;
    var bounds = root.getBoundingClientRect();
    var height = Math.ceil(Math.max(root.scrollHeight, bounds.height));
    if (height < 1) return;
    var current = typeof owner.getHeight === 'function' ? owner.getHeight() : 0;
    if (Math.abs(current - height) <= 2) return;
    owner.setHeight(height);
    if (owner.ownerCt && typeof owner.ownerCt.updateLayout === 'function')
      owner.ownerCt.updateLayout();
  }

  function scheduleHostHeight(root, owner) {
    if (root._uniDSAQrCodeReaderHeightFrame)
      global.cancelAnimationFrame(root._uniDSAQrCodeReaderHeightFrame);
    root._uniDSAQrCodeReaderHeightFrame = global.requestAnimationFrame(function () {
      root._uniDSAQrCodeReaderHeightFrame = 0;
      syncHostHeight(root, owner);
    });
  }

  API.attach = function (rootId, owner, options) {
    var root = document.getElementById(rootId);
    if (!root) return;
    options = options || {};
    setVariable(root, '--dsa-qr-background', options.background);
    setVariable(root, '--dsa-qr-surface', options.surface);
    setVariable(root, '--dsa-qr-border', options.border);
    setVariable(root, '--dsa-qr-text', options.text);
    setVariable(root, '--dsa-qr-muted', options.muted);
    setVariable(root, '--dsa-qr-primary', options.primary);
    setVariable(root, '--dsa-qr-radius', options.radius + 'px');
    setVariable(root, '--dsa-qr-max-width', options.maxWidth + 'px');
    setVariable(root, '--dsa-qr-video-max-height', options.videoMaxHeight + 'px');
    root.style.width = '100%';
    root.style.maxWidth = options.maxWidth + 'px';
    root.style.marginLeft = 'auto';
    root.style.marginRight = 'auto';
    decorate(root);
    if (root._uniDSAQrCodeReaderObserver) root._uniDSAQrCodeReaderObserver.disconnect();
    root._uniDSAQrCodeReaderObserver = new MutationObserver(function () {
      decorate(root);
      scheduleHostHeight(root, owner);
    });
    root._uniDSAQrCodeReaderObserver.observe(root, {childList: true, subtree: true});
    if (root._uniDSAQrCodeReaderResizeObserver) root._uniDSAQrCodeReaderResizeObserver.disconnect();
    if (typeof global.ResizeObserver === 'function') {
      root._uniDSAQrCodeReaderResizeObserver = new global.ResizeObserver(function () {
        scheduleHostHeight(root, owner);
      });
      root._uniDSAQrCodeReaderResizeObserver.observe(root);
    }
    scheduleHostHeight(root, owner);
  };
}(window));
