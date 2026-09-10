(function (global) {
  "use strict";

  var instances = Object.create(null);

  function rootOf(id) {
    return document.getElementById(id);
  }

  function encode(value) {
    return encodeURIComponent(value == null ? "" : String(value));
  }

  function notify(instance, eventName, values) {
    if (!instance || !instance.ext || typeof global.ajaxRequest !== "function") return;
    global.ajaxRequest(instance.ext, eventName, values || []);
  }

  function setStatus(instance, text, isError) {
    instance.status.textContent = text || "";
    instance.status.classList.toggle("unidsa-barcode-generator__status--error", !!isError);
  }

  function syncHostHeight(instance) {
    if (!instance || !instance.ext || typeof instance.ext.setHeight !== "function") return;
    var bounds = instance.root.getBoundingClientRect();
    var height = Math.ceil(Math.max(instance.root.scrollHeight, bounds.height));
    if (height < 1) return;
    var current = typeof instance.ext.getHeight === "function" ? instance.ext.getHeight() : 0;
    if (Math.abs(current - height) <= 2) return;
    instance.ext.setHeight(height);
    if (instance.ext.ownerCt && typeof instance.ext.ownerCt.updateLayout === "function")
      instance.ext.ownerCt.updateLayout();
  }

  function scheduleHostHeight(instance) {
    if (instance.heightFrame) global.cancelAnimationFrame(instance.heightFrame);
    instance.heightFrame = global.requestAnimationFrame(function () {
      instance.heightFrame = 0;
      syncHostHeight(instance);
    });
  }

  function applyTheme(instance) {
    var root = instance.root;
    var o = instance.options;
    root.style.setProperty("--barcode-panel", o.panelBackground);
    root.style.setProperty("--barcode-surface", o.surface);
    root.style.setProperty("--barcode-border", o.border);
    root.style.setProperty("--barcode-text", o.textColor);
    root.style.setProperty("--barcode-muted", o.muted);
    root.style.setProperty("--barcode-primary", o.primary);
    root.style.setProperty("--barcode-radius", o.borderRadius + "px");
    root.style.setProperty("--barcode-max-width", o.maxWidth + "px");
    instance.actions.hidden = !o.showActions;
  }

  function cleanFileName(value) {
    return String(value || "barcode").replace(/[\\/:*?"<>|]+/g, "-");
  }

  function svgText(instance) {
    return new XMLSerializer().serializeToString(instance.svg);
  }

  function svgDataUrl(instance) {
    return "data:image/svg+xml;charset=utf-8," + encodeURIComponent(svgText(instance));
  }

  function toPng(instance) {
    return new Promise(function (resolve, reject) {
      var image = new Image();
      var blob = new Blob([svgText(instance)], { type: "image/svg+xml;charset=utf-8" });
      var url = URL.createObjectURL(blob);
      image.onload = function () {
        var scale = Math.max(1, global.devicePixelRatio || 1);
        var width = Math.max(1, Math.ceil(instance.svg.width.baseVal.value));
        var height = Math.max(1, Math.ceil(instance.svg.height.baseVal.value));
        var canvas = document.createElement("canvas");
        canvas.width = width * scale;
        canvas.height = height * scale;
        var context = canvas.getContext("2d");
        context.scale(scale, scale);
        context.fillStyle = instance.options.background;
        context.fillRect(0, 0, width, height);
        context.drawImage(image, 0, 0, width, height);
        URL.revokeObjectURL(url);
        resolve(canvas.toDataURL("image/png"));
      };
      image.onerror = function () {
        URL.revokeObjectURL(url);
        reject(new Error("Nao foi possivel converter o codigo de barras."));
      };
      image.src = url;
    });
  }

  function render(instance) {
    var o = instance.options;
    instance.empty.hidden = true;
    instance.svg.hidden = false;
    setStatus(instance, "", false);
    if (!String(o.value || "").trim()) {
      instance.svg.hidden = true;
      instance.empty.hidden = false;
      instance.empty.textContent = o.emptyText;
      instance.valid = false;
      scheduleHostHeight(instance);
      return;
    }
    try {
      global.JsBarcode(instance.svg, o.value, {
        format: o.format,
        width: o.barWidth,
        height: o.barHeight,
        margin: o.margin,
        displayValue: o.displayValue,
        text: o.humanReadableText || undefined,
        fontSize: o.fontSize,
        textMargin: o.textMargin,
        lineColor: o.lineColor,
        background: o.background,
        valid: function (valid) { instance.valid = valid; }
      });
      if (!instance.valid) throw new Error("Valor invalido para o formato selecionado.");
      instance.svg.setAttribute("role", "img");
      instance.svg.setAttribute("aria-label", "Codigo de barras " + o.value);
      setStatus(instance, "Codigo de barras gerado com sucesso.", false);
      notify(instance, "UniDSABarcodeGenerated", ["Value=" + encode(o.value)]);
    } catch (error) {
      instance.valid = false;
      instance.svg.hidden = true;
      instance.empty.hidden = false;
      instance.empty.textContent = error && error.message ? error.message : "Nao foi possivel gerar o codigo de barras.";
      setStatus(instance, instance.empty.textContent, true);
      notify(instance, "UniDSABarcodeError", ["Message=" + encode(instance.empty.textContent)]);
    }
    scheduleHostHeight(instance);
  }

  function downloadData(data, fileName) {
    var link = document.createElement("a");
    link.href = data;
    link.download = fileName;
    document.body.appendChild(link);
    link.click();
    link.remove();
  }

  function download(id, format, fileName) {
    var instance = instances[id];
    if (!instance || !instance.valid) return;
    var name = cleanFileName(fileName || instance.options.fileName);
    if (String(format).toLowerCase() === "svg") {
      downloadData(svgDataUrl(instance), name + ".svg");
      return;
    }
    toPng(instance).then(function (data) { downloadData(data, name + ".png"); });
  }

  function copy(id) {
    var instance = instances[id];
    if (!instance || !instance.valid) return;
    if (!navigator.clipboard || typeof global.ClipboardItem !== "function") {
      setStatus(instance, "A copia de imagem exige HTTPS e suporte do navegador.", true);
      return;
    }
    toPng(instance).then(function (data) {
      return fetch(data).then(function (response) { return response.blob(); });
    }).then(function (blob) {
      return navigator.clipboard.write([new ClipboardItem({ "image/png": blob })]);
    }).then(function () {
      setStatus(instance, "Imagem copiada para a area de transferencia.", false);
    }).catch(function () {
      setStatus(instance, "Nao foi possivel copiar a imagem.", true);
    });
  }

  function requestData(id) {
    var instance = instances[id];
    if (!instance || !instance.valid) {
      if (instance) notify(instance, "UniDSABarcodeData", ["Valid=false", "DataURL=", "SVG="]);
      return;
    }
    toPng(instance).then(function (dataUrl) {
      notify(instance, "UniDSABarcodeData", [
        "Valid=true",
        "DataURL=" + encode(dataUrl),
        "SVG=" + encode(svgText(instance))
      ]);
    }).catch(function (error) {
      setStatus(instance, error.message, true);
    });
  }

  function init(id, ext, options) {
    var root = rootOf(id);
    if (!root || typeof global.JsBarcode !== "function") return;
    var instance = instances[id];
    if (!instance) {
      instance = {
        root: root,
        ext: ext,
        svg: root.querySelector("svg"),
        empty: root.querySelector(".unidsa-barcode-generator__empty"),
        actions: root.querySelector(".unidsa-barcode-generator__actions"),
        status: root.querySelector(".unidsa-barcode-generator__status"),
        valid: false
      };
      root.addEventListener("click", function (event) {
        var button = event.target.closest("[data-barcode-action]");
        if (!button) return;
        if (button.dataset.barcodeAction === "download")
          download(id, instance.options.exportFormat, instance.options.fileName);
        else if (button.dataset.barcodeAction === "copy")
          copy(id);
      });
      if (typeof global.ResizeObserver === "function") {
        instance.resizeObserver = new global.ResizeObserver(function () {
          scheduleHostHeight(instance);
        });
        instance.resizeObserver.observe(root);
      }
      instances[id] = instance;
    }
    instance.ext = ext;
    instance.options = options;
    applyTheme(instance);
    render(instance);
    scheduleHostHeight(instance);
  }

  global.UniDSABarcodeGenerator = {
    init: init,
    render: function (id) { if (instances[id]) render(instances[id]); },
    download: download,
    copy: copy,
    requestData: requestData
  };
})(window);
