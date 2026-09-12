(function (global) {
  'use strict';
  const states = new Map(), masks = new Map();
  const visible = win => !win.destroyed && win.rendered && win.isVisible();
  function restoreMasks() {
    masks.forEach((saved, el) => {
      el.style.backgroundColor = saved.color;
      el.style.opacity = saved.opacity;
    });
    masks.clear();
  }
  function syncMasks() {
    restoreMasks();
    states.forEach(state => {
      const win = state.win, manager = win.zIndexManager;
      if (!visible(win) || !win.modal || !manager || !manager.mask) return;
      // A shared Ext mask must follow its active window, not the last styled form.
      if (manager.getActive && manager.getActive() !== win) return;
      const el = manager.mask.dom;
      if (!el) return;
      masks.set(el, {color: el.style.backgroundColor, opacity: el.style.opacity});
      el.style.backgroundColor = state.options.backdropColor;
      el.style.opacity = state.options.backdropOpacity / 100;
    });
  }
  function detach(win) {
    const state = states.get(win);
    if (!state) return;
    states.delete(win);
    if (state.frame) cancelAnimationFrame(state.frame);
    state.resize.disconnect();
    state.mutations.disconnect();
    state.listeners.forEach(([event, fn]) => win.un(event, fn));
    document.removeEventListener('pointerdown', state.outside);
    document.removeEventListener('keydown', state.keydown);
    if (state.closeElement) state.closeAttributes.forEach(([name, value]) => {
      if (value === null) state.closeElement.removeAttribute(name);
      else state.closeElement.setAttribute(name, value);
    });
    win.onEsc = state.onEsc;
    if (state.ownsLiveDrag) win.liveDrag = state.liveDrag;
    else delete win.liveDrag;
    if (win.el) {
      win.removeCls('dsa-form-style');
      state.classes.forEach(cls => win.removeCls(cls));
      state.variables.forEach(name => win.el.dom.style.removeProperty(name));
    }
    if (state.content) state.content.classList.remove('dsa-form-content');
    if (state.footer) state.footer.classList.remove('dsa-form-footer');
    if (!win.destroying && !win.destroyed) {
      state.tools.forEach(({tool, width, height}) => {
        if (!tool.destroyed) tool.setSize(width, height);
      });
      if (win.header) {
        if (state.headerHeight) win.header.setHeight(state.headerHeight);
        win.header.setVisible(state.headerVisible);
      }
      if (state.shadow && win.el && win.el.enableShadow) win.el.enableShadow();
      win.setSize(state.width, state.height);
    }
    syncMasks();
  }
  function attach(win, options) {
    if (!win || win.destroyed) return;
    if (win.dsaFormStylePending) {
      win.un('afterrender', win.dsaFormStylePending);
      delete win.dsaFormStylePending;
    }
    detach(win);
    if (!options.enabled) return;
    if (!win.rendered) {
      // Replace only our pending listener; never replace the form's own events.
      const pending = function () {
        delete win.dsaFormStylePending;
        attach(win, options);
      };
      win.dsaFormStylePending = pending;
      win.on('afterrender', pending, null, {single: true});
      return;
    }
    const state = {
      win, options, width: win.getWidth(), height: win.getHeight(),
      headerHeight: win.header && win.header.getHeight(),
      headerVisible: win.header && win.header.isVisible(),
      onEsc: win.onEsc, shadow: win.el.shadow && !win.el.shadow.disabled,
      liveDrag: win.liveDrag, ownsLiveDrag: Object.prototype.hasOwnProperty.call(win, 'liveDrag'),
      listeners: [], variables: [], classes: [], frame: 0,
      content: options.content && document.getElementById(options.content),
      footer: options.footer && document.getElementById(options.footer)
    };
    states.set(win, state);
    // ComponentDragger otherwise replaces the window with an unstyled ghost.
    // Keep the actual window (and its rounded header, content and shadow) visible.
    win.liveDrag = true;
    // bsNone suppresses Ext's header. Re-enable the native header/tool strip,
    // without changing the Delphi BorderStyle or creating a separate HTML close action.
    if (!win.header && options.headerVisible && win.updateHeader) {
      win.header = true;
      win.updateHeader(true);
    }
    function css(name, value) {
      name = '--dsa-form-' + name;
      state.variables.push(name);
      win.el.dom.style.setProperty(name, value);
    }
    // Capture the native dimensions before CSS changes the tool's measured size.
    state.tools = [];
    if (win.header && win.header.down) {
      ['close','minimize','maximize','restore'].forEach(type => {
        const tool = win.header.down('tool[type=' + type + ']');
        if (tool && !state.tools.some(saved => saved.tool === tool)) {
          state.tools.push({tool, width: tool.getWidth(), height: tool.getHeight()});
        }
      });
    }
    win.addCls('dsa-form-style');
    ['radius','borderWidth','fontSize','closeSize'].forEach(name => css(name, options[name] + 'px'));
    ['background','borderColor','headerBackground','titleColor','closeColor','closeHover'].forEach(name => css(name, options[name]));
    css('shadow', options.shadow ? '0 24px 80px rgba(15,23,42,.22),0 4px 16px rgba(15,23,42,.10)' : 'none');
    [['dsa-form-no-icon',!options.showIcon],['dsa-form-no-close',!options.closeVisible]].forEach(([cls, enabled]) => {
      if (enabled) { state.classes.push(cls); win.addCls(cls); }
    });
    if (win.el.disableShadow) win.el.disableShadow();
    if (win.header) {
      // Reserve the same slot for every window action in Ext's hbox layout.
      state.tools.forEach(({tool}) => tool.setSize(options.closeSize, options.closeSize));
      win.header.setVisible(options.headerVisible);
      win.header.setHeight(options.headerHeight);
      win.header.updateLayout();
    }
    const closeIcon = win.el.dom.querySelector('.x-tool-close');
    state.closeElement = closeIcon && closeIcon.parentElement;
    if (state.closeElement) {
      state.closeAttributes = ['role','aria-label','tabindex'].map(name => [name,state.closeElement.getAttribute(name)]);
      state.closeElement.setAttribute('role','button');
      state.closeElement.setAttribute('aria-label','Fechar janela');
      state.closeElement.setAttribute('tabindex','0');
    }
    if (state.content) state.content.classList.add('dsa-form-content');
    if (state.footer) state.footer.classList.add('dsa-form-footer');
    win.onEsc = function () {
      if (options.escape && win.closable !== false) win.close();
    };
    function fit() {
      state.frame = 0;
      if (!visible(win)) return;
      const margin = Math.max(0, options.margin);
      const maxW = Math.max(1, Math.min(options.maxWidth, global.innerWidth - 2 * margin));
      const maxH = Math.max(1, Math.min(options.maxHeight, global.innerHeight - 2 * margin));
      const footerHeight = state.footer && state.footer.offsetParent !== null ? state.footer.offsetHeight : 0;
      cssFooter(footerHeight);
      // Set width first so wrapped text is measured at the correct breakpoint.
      if (Math.abs(win.getWidth() - maxW) > 1) win.setWidth(maxW);
      let height = maxH;
      if (options.autoHeight && state.content) {
        const inner = state.content.querySelector(':scope > .x-autocontainer-outerCt > .x-autocontainer-innerCt') || state.content;
        const origin = inner.getBoundingClientRect().top;
        let bottom = 0;
        Array.from(inner.children).forEach(child => {
          if (getComputedStyle(child).display !== 'none') bottom = Math.max(bottom, child.getBoundingClientRect().bottom - origin);
        });
        const padding = parseFloat(getComputedStyle(inner).paddingBottom) || 0;
        const chrome = options.headerVisible && win.header ? options.headerHeight : 0;
        height = Math.min(maxH, Math.max(options.minHeight, Math.ceil(bottom + padding + footerHeight + chrome + 8)));
      }
      if (Math.abs(win.getHeight() - height) > 1) win.setHeight(height);
      win.setPosition(Math.max(0, (global.innerWidth - maxW) / 2), Math.max(0, (global.innerHeight - height) / 2));
      syncMasks();
    }
    function cssFooter(height) { win.el.dom.style.setProperty('--dsa-form-footerHeight', height + 'px'); }
    state.variables.push('--dsa-form-footerHeight');
    function schedule() {
      if (!state.frame && visible(win)) state.frame = requestAnimationFrame(fit);
    }
    state.resize = new ResizeObserver(schedule);
    state.resize.observe(document.documentElement);
    if (state.content) {
      state.resize.observe(state.content);
      const inner = state.content.querySelector(':scope > .x-autocontainer-outerCt > .x-autocontainer-innerCt') || state.content;
      Array.from(inner.children).forEach(child => state.resize.observe(child));
    }
    state.mutations = new MutationObserver(schedule);
    if (state.content) state.mutations.observe(state.content, {childList:true, subtree:true, characterData:true});
    function listen(event, fn) { state.listeners.push([event, fn]); win.on(event, fn); }
    listen('show', schedule);
    listen('activate', syncMasks);
    listen('deactivate', () => requestAnimationFrame(syncMasks));
    listen('hide', () => requestAnimationFrame(syncMasks));
    listen('destroy', () => detach(win));
    state.outside = function (event) {
      const manager = win.zIndexManager;
      if (options.backdropClose && visible(win) && win.modal && manager &&
          manager.mask && event.target === manager.mask.dom &&
          (!manager.getActive || manager.getActive() === win) && win.closable !== false) win.close();
    };
    document.addEventListener('pointerdown', state.outside);
    state.keydown = function (event) {
      const manager = win.zIndexManager;
      if ((event.key === 'Enter' || event.key === ' ') && !event.defaultPrevented &&
          event.target === state.closeElement && options.closeVisible &&
          visible(win) && win.closable !== false) {
        event.preventDefault();
        win.close();
        return;
      }
      if (event.key === 'Escape' && !event.defaultPrevented && options.escape &&
          visible(win) && win.closable !== false &&
          (!manager || !manager.getActive || manager.getActive() === win)) {
        event.preventDefault();
        win.close();
      }
    };
    document.addEventListener('keydown', state.keydown);
    schedule();
  }
  global.UniDSAFormStyle = {attach, detach};
})(window);
