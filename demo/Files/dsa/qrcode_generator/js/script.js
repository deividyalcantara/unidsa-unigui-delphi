(function (global) {
  'use strict';
  var API = global.UniDSAQrCodeGenerator = global.UniDSAQrCodeGenerator || {};

  function utf8Bytes(text) {
    var value = unescape(encodeURIComponent(text));
    var bytes = [];
    for (var i = 0; i < value.length; i += 1) bytes.push(value.charCodeAt(i));
    return bytes;
  }

  function roundedRect(context, x, y, width, height, radius) {
    var r = Math.min(radius, width / 2, height / 2);
    context.beginPath();
    context.moveTo(x + r, y);
    context.arcTo(x + width, y, x + width, y + height, r);
    context.arcTo(x + width, y + height, x, y + height, r);
    context.arcTo(x, y + height, x, y, r);
    context.arcTo(x, y, x + width, y, r);
    context.closePath();
    context.fill();
  }

  function isFinderModule(row, column, count) {
    var top = row < 7;
    var left = column < 7;
    var right = column >= count - 7;
    var bottom = row >= count - 7;
    return (top && left) || (top && right) || (bottom && left);
  }

  function drawCanvasFinder(context, x, y, cell, foreground, background) {
    context.fillStyle = foreground;
    context.fillRect(x, y, cell * 7, cell * 7);
    context.fillStyle = background;
    context.fillRect(x + cell, y + cell, cell * 5, cell * 5);
    context.fillStyle = foreground;
    context.fillRect(x + cell * 2, y + cell * 2, cell * 3, cell * 3);
  }

  function createMatrix(text, correction) {
    var previousEncoder = global.qrcode.stringToBytes;
    global.qrcode.stringToBytes = utf8Bytes;
    try {
      var code = global.qrcode(0, correction || 'M');
      code.addData(text, 'Byte');
      code.make();
      return code;
    } finally {
      global.qrcode.stringToBytes = previousEncoder;
    }
  }

  function renderCanvas(state, code) {
    var options = state.options;
    var canvas = state.canvas;
    var context = canvas.getContext('2d');
    var count = code.getModuleCount();
    var margin = Math.max(4, Number(options.margin) || 4);
    var logicalSize = Math.max(120, Number(options.size) || 280);
    var ratio = global.devicePixelRatio || 1;
    var cells = count + (margin * 2);
    var cell = logicalSize / cells;

    canvas.width = Math.round(logicalSize * ratio);
    canvas.height = Math.round(logicalSize * ratio);
    canvas.style.setProperty('--dsa-qrgen-size', logicalSize + 'px');
    context.setTransform(ratio, 0, 0, ratio, 0, 0);
    context.fillStyle = options.background;
    context.fillRect(0, 0, logicalSize, logicalSize);
    context.fillStyle = options.foreground;

    for (var row = 0; row < count; row += 1) {
      for (var column = 0; column < count; column += 1) {
        if (!code.isDark(row, column) || isFinderModule(row, column, count)) continue;
        var x = (column + margin) * cell;
        var y = (row + margin) * cell;
        if (options.moduleStyle === 'dots') {
          context.beginPath();
          context.arc(x + cell / 2, y + cell / 2, cell * .47, 0, Math.PI * 2);
          context.fill();
        } else if (options.moduleStyle === 'rounded') {
          roundedRect(context, x + cell * .015, y + cell * .015,
            cell * .97, cell * .97, cell * .16);
        } else {
          context.fillRect(Math.floor(x), Math.floor(y), Math.ceil(cell), Math.ceil(cell));
        }
      }
    }

    drawCanvasFinder(context, margin * cell, margin * cell, cell,
      options.foreground, options.background);
    drawCanvasFinder(context, (margin + count - 7) * cell, margin * cell, cell,
      options.foreground, options.background);
    drawCanvasFinder(context, margin * cell, (margin + count - 7) * cell, cell,
      options.foreground, options.background);

    if (options.logoUrl) drawLogo(state, logicalSize);
  }

  function drawLogo(state, logicalSize) {
    var image = new Image();
    image.crossOrigin = 'anonymous';
    image.onload = function () {
      var context = state.canvas.getContext('2d');
      var ratio = global.devicePixelRatio || 1;
      var size = logicalSize * Math.max(10, Math.min(35, Number(state.options.logoSize) || 20)) / 100;
      var x = (logicalSize - size) / 2;
      context.setTransform(ratio, 0, 0, ratio, 0, 0);
      context.fillStyle = state.options.background;
      roundedRect(context, x - 5, x - 5, size + 10, size + 10, 8);
      context.drawImage(image, x, x, size, size);
    };
    image.src = state.options.logoUrl;
  }

  function createSvg(code, options) {
    var count = code.getModuleCount();
    var margin = Math.max(4, Number(options.margin) || 4);
    var size = count + margin * 2;
    var modules = [];
    for (var row = 0; row < count; row += 1) {
      for (var column = 0; column < count; column += 1) {
        if (!code.isDark(row, column) || isFinderModule(row, column, count)) continue;
        var x = column + margin;
        var y = row + margin;
        if (options.moduleStyle === 'dots')
          modules.push('<circle cx="' + (x + .5) + '" cy="' + (y + .5) + '" r=".47"/>');
        else if (options.moduleStyle === 'rounded')
          modules.push('<rect x="' + (x + .015) + '" y="' + (y + .015) +
            '" width=".97" height=".97" rx=".16"/>');
        else
          modules.push('<path d="M' + x + ' ' + y + 'h1v1h-1z"/>');
      }
    }
    function finder(x, y) {
      return '<path d="M' + x + ' ' + y + 'h7v7h-7zM' + (x + 1) + ' ' + (y + 1) +
        'v5h5v-5zM' + (x + 2) + ' ' + (y + 2) + 'h3v3h-3z" fill-rule="evenodd"/>';
    }
    modules.push(finder(margin, margin));
    modules.push(finder(margin + count - 7, margin));
    modules.push(finder(margin, margin + count - 7));
    var logo = options.logoUrl ? '<image href="' + String(options.logoUrl).replace(/&/g, '&amp;').replace(/"/g, '&quot;') + '" x="40%" y="40%" width="20%" height="20%" preserveAspectRatio="xMidYMid meet"/>' : '';
    var rendering = options.moduleStyle === 'square' ? 'crispEdges' : 'geometricPrecision';
    return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ' + size + ' ' + size +
      '" shape-rendering="' + rendering + '"><rect width="100%" height="100%" fill="' +
      options.background + '"/><g fill="' + options.foreground + '">' + modules.join('') +
      '</g>' + logo + '</svg>';
  }

  function setStatus(state, message) {
    state.status.textContent = message || '';
  }

  function downloadBlob(blob, fileName) {
    var url = URL.createObjectURL(blob);
    var link = document.createElement('a');
    link.href = url;
    link.download = fileName;
    document.body.appendChild(link);
    link.click();
    link.remove();
    setTimeout(function () { URL.revokeObjectURL(url); }, 500);
  }

  function render(state) {
    state.root.style.maxWidth = (state.options.maxWidth || 720) + 'px';
    state.root.style.setProperty('--dsa-qrgen-background', state.options.panelBackground);
    state.root.style.setProperty('--dsa-qrgen-surface', state.options.surface);
    state.root.style.setProperty('--dsa-qrgen-border', state.options.border);
    state.root.style.setProperty('--dsa-qrgen-text', state.options.textColor);
    state.root.style.setProperty('--dsa-qrgen-muted', state.options.muted);
    state.root.style.setProperty('--dsa-qrgen-primary', state.options.primary);
    state.root.style.setProperty('--dsa-qrgen-radius', (state.options.borderRadius || 0) + 'px');
    state.actions.hidden = !state.options.showActions;
    state.empty.hidden = !!state.options.text;
    state.canvas.hidden = !state.options.text;
    if (!state.options.text) {
      state.code = null;
      setStatus(state, '');
      return;
    }
    try {
      state.code = createMatrix(state.options.text, state.options.correction);
      renderCanvas(state, state.code);
      state.svg = createSvg(state.code, state.options);
      setStatus(state, 'QR Code atualizado');
      if (state.sender) ajaxRequest(state.sender, 'UniDSAQrCodeGeneratorGenerated', []);
    } catch (error) {
      state.code = null;
      state.canvas.hidden = true;
      state.empty.hidden = false;
      state.empty.textContent = 'Não foi possível gerar o QR Code. Reduza o conteúdo ou altere a correção de erro.';
      setStatus(state, error.message || 'Erro ao gerar');
    }
  }

  API.init = function (rootId, sender, options) {
    var root = document.getElementById(rootId);
    if (!root || !global.qrcode) return;
    var state = root._uniDSAQrCodeGenerator;
    if (!state) {
      state = {
        root: root,
        canvas: root.querySelector('canvas'),
        empty: root.querySelector('.unidsa-qrcode-generator__empty'),
        actions: root.querySelector('.unidsa-qrcode-generator__actions'),
        status: root.querySelector('.unidsa-qrcode-generator__status')
      };
      root._uniDSAQrCodeGenerator = state;
      root.addEventListener('click', function (event) {
        var action = event.target.closest('[data-qrgen-action]');
        if (!action) return;
        if (action.dataset.qrgenAction === 'download') API.download(rootId, state.options.format, state.options.fileName);
        if (action.dataset.qrgenAction === 'copy') API.copy(rootId);
      });
    }
    state.sender = sender;
    state.options = options || {};
    state.empty.textContent = state.options.emptyText || 'Informe um conteúdo para gerar o QR Code.';
    render(state);
  };

  API.download = function (rootId, format, fileName) {
    var state = document.getElementById(rootId)._uniDSAQrCodeGenerator;
    if (!state || !state.code) return;
    var name = fileName || 'qrcode';
    if (String(format).toLowerCase() === 'svg') {
      downloadBlob(new Blob([state.svg], {type: 'image/svg+xml;charset=utf-8'}), name + '.svg');
    } else {
      state.canvas.toBlob(function (blob) { downloadBlob(blob, name + '.png'); }, 'image/png');
    }
    setStatus(state, 'Arquivo preparado para download');
  };

  API.copy = function (rootId) {
    var state = document.getElementById(rootId)._uniDSAQrCodeGenerator;
    if (!state || !state.code) return;
    state.canvas.toBlob(function (blob) {
      if (navigator.clipboard && global.ClipboardItem) {
        navigator.clipboard.write([new ClipboardItem({'image/png': blob})]).then(function () {
          setStatus(state, 'Imagem copiada');
        }).catch(function () { setStatus(state, 'O navegador não permitiu copiar a imagem'); });
      } else {
        setStatus(state, 'Cópia de imagem não suportada neste navegador');
      }
    }, 'image/png');
  };

  API.requestData = function (rootId) {
    var state = document.getElementById(rootId)._uniDSAQrCodeGenerator;
    if (!state || !state.code || !state.sender) return;
    ajaxRequest(state.sender, 'UniDSAQrCodeGeneratorData', [
      'DataURL=' + encodeURIComponent(state.canvas.toDataURL('image/png')),
      'SVG=' + encodeURIComponent(state.svg)
    ]);
  };
}(window));
