(function (global) {
  'use strict';
  var API = global.UniDSASignature = global.UniDSASignature || {};

  function pointFromEvent(state, event) {
    var rect = state.canvas.getBoundingClientRect();
    return {
      x: (event.clientX - rect.left) / Math.max(1, rect.width),
      y: (event.clientY - rect.top) / Math.max(1, rect.height),
      pressure: event.pressure > 0 ? event.pressure : .5
    };
  }

  function configureCanvas(state) {
    var rect = state.canvas.getBoundingClientRect();
    var ratio = global.devicePixelRatio || 1;
    var width = Math.max(1, Math.round(rect.width * ratio));
    var height = Math.max(1, Math.round(rect.height * ratio));
    if (state.canvas.width !== width || state.canvas.height !== height) {
      state.canvas.width = width;
      state.canvas.height = height;
    }
    state.context.setTransform(ratio, 0, 0, ratio, 0, 0);
    state.width = rect.width;
    state.height = rect.height;
  }

  function drawStroke(state, stroke) {
    if (!stroke || stroke.length === 0) return;
    var context = state.context;
    context.strokeStyle = state.options.penColor;
    context.fillStyle = state.options.penColor;
    context.lineCap = 'round';
    context.lineJoin = 'round';
    if (stroke.length === 1) {
      context.beginPath();
      context.arc(stroke[0].x * state.width, stroke[0].y * state.height, state.options.penWidth / 2, 0, Math.PI * 2);
      context.fill();
      return;
    }
    context.beginPath();
    context.moveTo(stroke[0].x * state.width, stroke[0].y * state.height);
    for (var i = 1; i < stroke.length; i += 1) {
      context.lineWidth = Math.max(1, state.options.penWidth * (.65 + stroke[i].pressure * .7));
      context.lineTo(stroke[i].x * state.width, stroke[i].y * state.height);
    }
    context.stroke();
  }

  function redraw(state) {
    configureCanvas(state);
    state.context.clearRect(0, 0, state.width, state.height);
    if (state.loadedImage) state.context.drawImage(state.loadedImage, 0, 0, state.width, state.height);
    state.strokes.forEach(function (stroke) { drawStroke(state, stroke); });
    var empty = !state.loadedImage && state.strokes.length === 0;
    state.root.classList.toggle('is-empty', empty);
    state.undoButton.disabled = state.options.readOnly || state.strokes.length === 0;
    state.redoButton.disabled = state.options.readOnly || state.redo.length === 0;
    state.clearButton.disabled = state.options.readOnly || empty;
    state.status.textContent = empty ? 'Aguardando assinatura' : 'Assinatura registrada';
  }

  function value(state) {
    var exportCanvas = document.createElement('canvas');
    exportCanvas.width = state.canvas.width;
    exportCanvas.height = state.canvas.height;
    var context = exportCanvas.getContext('2d');
    context.fillStyle = state.options.background;
    context.fillRect(0, 0, exportCanvas.width, exportCanvas.height);
    context.drawImage(state.canvas, 0, 0);
    return exportCanvas.toDataURL(state.options.format === 'jpeg' ? 'image/jpeg' : 'image/png', .92);
  }

  function notifyChange(state) {
    if (!state.sender) return;
    var isEmpty = !state.loadedImage && state.strokes.length === 0;
    ajaxRequest(state.sender, 'UniDSASignatureChange', [
      'Empty=' + (isEmpty ? '1' : '0'),
      'Value=' + encodeURIComponent(isEmpty ? '' : value(state))
    ]);
  }

  function pointerDown(state, event) {
    if (state.options.readOnly || event.button > 0) return;
    event.preventDefault();
    state.drawing = true;
    state.current = [pointFromEvent(state, event)];
    state.redo = [];
    state.canvas.setPointerCapture(event.pointerId);
    if (state.sender) ajaxRequest(state.sender, 'UniDSASignatureBeginDraw', []);
  }

  function pointerMove(state, event) {
    if (!state.drawing) return;
    event.preventDefault();
    state.current.push(pointFromEvent(state, event));
    redraw(state);
    drawStroke(state, state.current);
    state.root.classList.remove('is-empty');
  }

  function pointerUp(state, event) {
    if (!state.drawing) return;
    event.preventDefault();
    state.drawing = false;
    state.current.push(pointFromEvent(state, event));
    state.strokes.push(state.current);
    state.current = null;
    redraw(state);
    notifyChange(state);
    if (state.sender) ajaxRequest(state.sender, 'UniDSASignatureEndDraw', []);
  }

  function download(state, fileName) {
    if (state.root.classList.contains('is-empty')) return;
    var link = document.createElement('a');
    link.href = value(state);
    link.download = (fileName || 'assinatura') + (state.options.format === 'jpeg' ? '.jpg' : '.png');
    document.body.appendChild(link);
    link.click();
    link.remove();
  }

  function createState(root, sender) {
    var state = {
      root: root,
      sender: sender,
      canvas: root.querySelector('canvas'),
      context: root.querySelector('canvas').getContext('2d'),
      toolbar: root.querySelector('.unidsa-signature__toolbar'),
      status: root.querySelector('.unidsa-signature__status'),
      undoButton: root.querySelector('[data-signature-action="undo"]'),
      redoButton: root.querySelector('[data-signature-action="redo"]'),
      clearButton: root.querySelector('[data-signature-action="clear"]'),
      strokes: [],
      redo: [],
      current: null,
      drawing: false,
      loadedImage: null
    };
    state.canvas.addEventListener('pointerdown', function (event) { pointerDown(state, event); });
    state.canvas.addEventListener('pointermove', function (event) { pointerMove(state, event); });
    state.canvas.addEventListener('pointerup', function (event) { pointerUp(state, event); });
    state.canvas.addEventListener('pointercancel', function (event) { pointerUp(state, event); });
    root.addEventListener('click', function (event) {
      var button = event.target.closest('[data-signature-action]');
      if (!button) return;
      var action = button.dataset.signatureAction;
      if (action === 'undo') API.undo(root.id);
      if (action === 'redo') API.redo(root.id);
      if (action === 'clear') API.clear(root.id);
      if (action === 'download') download(state, state.options.fileName);
    });
    if (global.ResizeObserver) {
      state.resizeObserver = new ResizeObserver(function () { redraw(state); });
      state.resizeObserver.observe(root);
    } else {
      global.addEventListener('resize', function () { redraw(state); });
    }
    return state;
  }

  API.init = function (rootId, sender, options) {
    var root = document.getElementById(rootId);
    if (!root) return;
    var state = root._uniDSASignature || createState(root, sender);
    root._uniDSASignature = state;
    state.sender = sender;
    state.options = options || {};
    root.style.maxWidth = (state.options.maxWidth || 900) + 'px';
    root.style.setProperty('--dsa-signature-background', state.options.background);
    root.style.setProperty('--dsa-signature-border', state.options.border);
    root.style.setProperty('--dsa-signature-text', state.options.textColor);
    root.style.setProperty('--dsa-signature-muted', state.options.muted);
    root.style.setProperty('--dsa-signature-primary', state.options.primary);
    root.style.setProperty('--dsa-signature-radius', (state.options.borderRadius || 0) + 'px');
    root.style.setProperty('--dsa-signature-height', (state.options.canvasHeight || 260) + 'px');
    root.classList.toggle('is-readonly', !!state.options.readOnly);
    root.classList.toggle('is-required', !!state.options.required);
    root.querySelector('.unidsa-signature__placeholder').textContent = state.options.placeholder;
    state.toolbar.hidden = !state.options.showToolbar;
    redraw(state);
  };

  API.clear = function (rootId, silent) {
    var state = document.getElementById(rootId)._uniDSASignature;
    if (!state || (state.options.readOnly && !silent)) return;
    state.strokes = [];
    state.redo = [];
    state.loadedImage = null;
    redraw(state);
    if (!silent) notifyChange(state);
  };

  API.undo = function (rootId) {
    var state = document.getElementById(rootId)._uniDSASignature;
    if (!state || state.options.readOnly || state.strokes.length === 0) return;
    state.redo.push(state.strokes.pop());
    redraw(state);
    notifyChange(state);
  };

  API.redo = function (rootId) {
    var state = document.getElementById(rootId)._uniDSASignature;
    if (!state || state.options.readOnly || state.redo.length === 0) return;
    state.strokes.push(state.redo.pop());
    redraw(state);
    notifyChange(state);
  };

  API.load = function (rootId, dataUrl) {
    var state = document.getElementById(rootId)._uniDSASignature;
    if (!state) return;
    if (!dataUrl) { API.clear(rootId, true); return; }
    var image = new Image();
    image.onload = function () { state.loadedImage = image; state.strokes = []; state.redo = []; redraw(state); };
    image.src = dataUrl;
  };

  API.download = function (rootId, fileName) {
    var state = document.getElementById(rootId)._uniDSASignature;
    if (state) download(state, fileName);
  };

  API.requestValue = function (rootId) {
    var state = document.getElementById(rootId)._uniDSASignature;
    if (state) notifyChange(state);
  };
}(window));
