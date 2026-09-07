(function (global) {
  "use strict";

  var API = global.UniDSATour = global.UniDSATour || {};
  var current = null;

  function el(tag, cls) {
    var node = document.createElement(tag);
    if (cls) node.className = cls;
    return node;
  }

  function send(state, name, data) {
    var args = [];
    var key;
    data = data || {};
    for (key in data) {
      if (Object.prototype.hasOwnProperty.call(data, key)) {
        args.push(key + '=' + String(data[key]));
      }
    }
    if (typeof global.ajaxRequest === 'function' && state.owner) {
      global.ajaxRequest(state.owner, name, args);
    }
  }

  function getByPath(path) {
    var value = global;
    var parts;
    var i;
    if (!path) return null;
    parts = String(path).split('.');
    for (i = 0; i < parts.length; i++) {
      if (!parts[i] || value == null) return null;
      value = value[parts[i]];
    }
    return value || null;
  }

  function componentElement(targetName) {
    var cmp;
    var extEl;
    var byId;
    if (!targetName) return null;

    cmp = getByPath(targetName);
    try {
      if (cmp && cmp.el && cmp.el.dom) return cmp.el.dom;
      if (cmp && typeof cmp.getEl === 'function') {
        extEl = cmp.getEl();
        if (extEl && extEl.dom) return extEl.dom;
      }
    } catch (_) { }

    try {
      if (global.Ext && typeof global.Ext.getCmp === 'function') {
        cmp = global.Ext.getCmp(targetName);
        if (cmp && typeof cmp.getEl === 'function') {
          extEl = cmp.getEl();
          if (extEl && extEl.dom) return extEl.dom;
        }
      }
    } catch (_) { }

    byId = document.getElementById(targetName) || document.getElementById(targetName + '_id');
    return byId || null;
  }

  function querySelectorSafe(root, selector) {
    if (!root || !selector) return null;
    try {
      if (root.nodeType === 1 && typeof root.matches === 'function' && root.matches(selector)) {
        return root;
      }
      if (typeof root.querySelector === 'function') return root.querySelector(selector);
    } catch (_) { }
    return null;
  }

  function resolve(step) {
    var root = null;
    var found = null;
    if (!step) return null;

    if (step.target) root = componentElement(step.target);

    // TargetSelector is the most specific target. If Target is also set,
    // first search inside that component and then fall back to the document.
    if (step.selector) {
      found = querySelectorSafe(root, step.selector);
      if (found) return found;
      found = querySelectorSafe(document, step.selector);
      if (found) return found;
    }

    return root;
  }

  function hasTargetReference(step) {
    return !!(step && (step.target || step.selector));
  }

  function targetIsReady(target) {
    var rect;
    if (!target) return false;
    if (typeof target.isConnected === 'boolean' && !target.isConnected) return false;
    try {
      rect = target.getBoundingClientRect();
      return !!(rect && (rect.width > 0 || rect.height > 0));
    } catch (_) {
      return false;
    }
  }

  function geometryKey(rect) {
    return [
      Math.round(rect.left * 10),
      Math.round(rect.top * 10),
      Math.round(rect.width * 10),
      Math.round(rect.height * 10)
    ].join(':');
  }

  function waitResolve(state, step, token, done) {
    var target = resolve(step);
    var wait = state.options.waitForTarget !== false;
    var timeout = parseInt(state.options.targetWaitTimeout, 10);
    var interval = parseInt(state.options.targetWaitInterval, 10);
    var started = Date.now();
    var observer = null;
    var timer = null;
    var finished = false;

    if (isNaN(timeout) || timeout < 0) timeout = 5000;
    if (isNaN(interval) || interval < 25) interval = 100;

    if (!hasTargetReference(step)) {
      done(null, false);
      return;
    }

    if (target && (!wait || targetIsReady(target))) {
      done(target, false);
      return;
    }

    if (!wait) {
      done(target, !target);
      return;
    }

    function finish(found, timedOut) {
      if (finished) return;
      finished = true;
      if (timer) global.clearTimeout(timer);
      if (observer) {
        try { observer.disconnect(); } catch (_) { }
      }
      done(found, timedOut);
    }

    function check() {
      var found;
      if (finished || current !== state || token !== state.renderToken) {
        finish(null, false);
        return;
      }

      found = resolve(step);
      if (found && targetIsReady(found)) {
        finish(found, false);
        return;
      }

      if (Date.now() - started >= timeout) {
        finish(found || null, true);
        return;
      }

      timer = global.setTimeout(check, interval);
    }

    if (typeof global.MutationObserver === 'function' && document.documentElement) {
      try {
        observer = new global.MutationObserver(function () {
          var found;
          if (finished || current !== state || token !== state.renderToken) return;
          found = resolve(step);
          if (found && targetIsReady(found)) finish(found, false);
        });
        observer.observe(document.documentElement, { childList: true, subtree: true });
      } catch (_) {
        observer = null;
      }
    }

    timer = global.setTimeout(check, interval);
  }

  function cleanup() {
    var old;
    if (!current) return;
    old = current;
    global.removeEventListener('resize', current.reposition, true);
    global.removeEventListener('scroll', current.reposition, true);
    document.removeEventListener('keydown', current.keydown, true);
    if (current.geometryTimer) global.clearInterval(current.geometryTimer);
    if (current.target) current.target.classList.remove('unidsa-tour-target-pulse');
    if (current.overlay && current.overlay.parentNode) current.overlay.parentNode.removeChild(current.overlay);
    current = null;
    if (old.previousFocus && document.documentElement.contains(old.previousFocus) && typeof old.previousFocus.focus === 'function') {
      try { old.previousFocus.focus(); } catch (_) { }
    }
  }

  function positionPopover(state, target, step) {
    var pop = state.popover;
    var margin = 12;
    var viewport = { w: global.innerWidth, h: global.innerHeight };
    var popRect;
    var targetRect;
    var placement;
    var candidates;
    var chosen;
    var i;
    var candidate;
    var left;
    var top;

    pop.style.left = '12px';
    pop.style.top = '12px';
    popRect = pop.getBoundingClientRect();

    if (!target) {
      pop.style.left = Math.max(margin, (viewport.w - popRect.width) / 2) + 'px';
      pop.style.top = Math.max(margin, (viewport.h - popRect.height) / 2) + 'px';
      return;
    }

    targetRect = target.getBoundingClientRect();
    placement = step.placement || 'auto';
    candidates = placement === 'auto' ? ['bottom', 'right', 'top', 'left'] : [placement];
    chosen = candidates[0];

    for (i = 0; i < candidates.length; i++) {
      candidate = candidates[i];
      if (candidate === 'bottom' && viewport.h - targetRect.bottom >= popRect.height + margin) { chosen = candidate; break; }
      if (candidate === 'top' && targetRect.top >= popRect.height + margin) { chosen = candidate; break; }
      if (candidate === 'right' && viewport.w - targetRect.right >= popRect.width + margin) { chosen = candidate; break; }
      if (candidate === 'left' && targetRect.left >= popRect.width + margin) { chosen = candidate; break; }
    }

    if (chosen === 'bottom') {
      left = targetRect.left + (targetRect.width - popRect.width) / 2;
      top = targetRect.bottom + margin;
    } else if (chosen === 'top') {
      left = targetRect.left + (targetRect.width - popRect.width) / 2;
      top = targetRect.top - popRect.height - margin;
    } else if (chosen === 'right') {
      left = targetRect.right + margin;
      top = targetRect.top + (targetRect.height - popRect.height) / 2;
    } else {
      left = targetRect.left - popRect.width - margin;
      top = targetRect.top + (targetRect.height - popRect.height) / 2;
    }

    left = Math.max(margin, Math.min(left, viewport.w - popRect.width - margin));
    top = Math.max(margin, Math.min(top, viewport.h - popRect.height - margin));
    pop.style.left = left + 'px';
    pop.style.top = top + 'px';
  }

  function setBlockers(state, target, pad, allowInteraction) {
    var blockers = state.blockers;
    var width = global.innerWidth;
    var height = global.innerHeight;
    var rect;
    var left;
    var top;
    var right;
    var bottom;
    var areas;
    var i;
    var area;

    if (!blockers) return;

    if (!target) {
      blockers[0].style.cssText = 'position:fixed;z-index:2147482000;pointer-events:auto;left:0;top:0;width:' + width + 'px;height:' + height + 'px;background:rgba(15,23,42,var(--dsa-tour-opacity,.62))';
      for (i = 1; i < 4; i++) {
        blockers[i].style.width = '0px';
        blockers[i].style.height = '0px';
        blockers[i].style.background = 'transparent';
      }
      state.spot.style.pointerEvents = 'none';
      return;
    }

    rect = target.getBoundingClientRect();
    left = Math.max(0, rect.left - pad);
    top = Math.max(0, rect.top - pad);
    right = Math.min(width, rect.right + pad);
    bottom = Math.min(height, rect.bottom + pad);
    areas = [
      [0, 0, width, top],
      [0, top, left, Math.max(0, bottom - top)],
      [right, top, Math.max(0, width - right), Math.max(0, bottom - top)],
      [0, bottom, width, Math.max(0, height - bottom)]
    ];

    for (i = 0; i < 4; i++) {
      area = areas[i];
      blockers[i].style.left = area[0] + 'px';
      blockers[i].style.top = area[1] + 'px';
      blockers[i].style.width = area[2] + 'px';
      blockers[i].style.height = area[3] + 'px';
      blockers[i].style.background = 'transparent';
    }

    state.spot.style.pointerEvents = allowInteraction ? 'none' : 'auto';
  }

  function updateGeometry(state) {
    var steps = state.options.steps || [];
    var step = steps[state.index] || {};
    var target = state.target;
    var pad = parseInt(step.padding != null ? step.padding : state.options.padding, 10);
    var radius;
    var rect;

    if (isNaN(pad)) pad = 8;

    if (target && targetIsReady(target)) {
      rect = target.getBoundingClientRect();
      state.spot.style.display = 'block';
      state.spot.style.left = (rect.left - pad) + 'px';
      state.spot.style.top = (rect.top - pad) + 'px';
      state.spot.style.width = (rect.width + pad * 2) + 'px';
      state.spot.style.height = (rect.height + pad * 2) + 'px';
      radius = parseInt(step.radius != null ? step.radius : state.options.radius, 10);
      if (isNaN(radius)) radius = 12;
      state.spot.style.borderRadius = Math.max(0, radius) + 'px';
      setBlockers(state, target, pad, !!step.allowInteraction);
      positionPopover(state, target, step);
      state.geometryTarget = target;
      state.geometryKey = geometryKey(rect);
    } else {
      state.target = null;
      state.geometryTarget = null;
      state.geometryKey = '';
      state.spot.style.display = 'none';
      setBlockers(state, null, pad, false);
      positionPopover(state, null, step);
    }
  }

  function watchGeometry(state) {
    state.geometryTimer = global.setInterval(function () {
      var steps;
      var step;
      var resolved;
      var rect;
      var key;

      if (current !== state || !state.ready) return;

      steps = state.options.steps || [];
      step = steps[state.index] || {};
      resolved = resolve(step);

      if (resolved && targetIsReady(resolved) && resolved !== state.target) {
        if (state.target) state.target.classList.remove('unidsa-tour-target-pulse');
        state.target = resolved;
        state.target.classList.add('unidsa-tour-target-pulse');
        state.geometryTarget = null;
        state.geometryKey = '';
      }

      if (!state.target || !targetIsReady(state.target)) return;

      rect = state.target.getBoundingClientRect();
      key = geometryKey(rect);
      if (state.geometryTarget !== state.target || state.geometryKey !== key) {
        updateGeometry(state);
      }
    }, 100);
  }

  function render(state, index, notify) {
    var steps = state.options.steps || [];
    var step;
    var token;

    if (!steps.length) {
      cleanup();
      return;
    }

    index = Math.max(0, Math.min(index, steps.length - 1));
    state.index = index;
    state.renderToken = (state.renderToken || 0) + 1;
    token = state.renderToken;
    step = steps[index];

    if (state.target) state.target.classList.remove('unidsa-tour-target-pulse');
    state.target = null;
    state.geometryTarget = null;
    state.geometryKey = '';
    if (!state.ready) state.overlay.style.visibility = 'hidden';

    waitResolve(state, step, token, function (target, timedOut) {
      if (current !== state || token !== state.renderToken) return;

      state.target = target && targetIsReady(target) ? target : null;

      if (timedOut && hasTargetReference(step) && !state.target) {
        if (global.console && typeof global.console.warn === 'function') {
          global.console.warn('UniDSATour: alvo não encontrado para o passo', step.id || index, step.selector || step.target || '');
        }
        send(state, 'UniDSATourTargetNotFound', { step: index });
      }

      if (state.target && state.options.scrollToTarget !== false) {
        try {
          state.target.scrollIntoView({
            behavior: state.options.reducedMotion ? 'auto' : 'smooth',
            block: 'center',
            inline: 'center'
          });
        } catch (_) {
          try { state.target.scrollIntoView(); } catch (__) { }
        }
      }

      global.setTimeout(function () {
        if (current !== state || token !== state.renderToken) return;

        state.title.textContent = step.title || '';
        state.content.textContent = step.content || '';
        state.modal = !step.allowInteraction || !state.target;
        if (state.modal) state.popover.setAttribute('aria-modal', 'true');
        else state.popover.removeAttribute('aria-modal');

        state.progress.textContent = (index + 1) + ' de ' + steps.length;
        state.back.style.visibility = index === 0 ? 'hidden' : 'visible';
        state.next.textContent = index === steps.length - 1 ? (state.options.finishCaption || 'Concluir') : (state.options.nextCaption || 'Próximo');
        state.skip.style.display = state.options.allowSkip === false ? 'none' : '';
        state.close.style.display = state.options.allowSkip === false ? 'none' : '';

        updateGeometry(state);
        if (state.target) state.target.classList.add('unidsa-tour-target-pulse');

        state.ready = true;
        state.overlay.style.visibility = 'visible';
        try { state.title.focus(); } catch (_) { }
        if (notify) send(state, 'UniDSATourStepChange', { step: index });
      }, state.options.reducedMotion ? 0 : 80);
    });
  }

  API.start = function (owner, options) {
    var state;
    var overlay;
    var spotlight;
    var blockers;
    var popover;
    var uid;
    var titleRow;
    var title;
    var close;
    var content;
    var progress;
    var actions;
    var skip;
    var actionsRight;
    var back;
    var next;
    var i;

    cleanup();
    options = options || {};
    state = {
      owner: owner,
      options: options,
      index: 0,
      target: null,
      previousFocus: document.activeElement,
      renderToken: 0,
      ready: false,
      geometryTarget: null,
      geometryKey: '',
      geometryTimer: null
    };

    overlay = el('div', 'unidsa-tour-overlay');
    overlay.setAttribute('role', 'presentation');
    overlay.style.setProperty('--dsa-tour-opacity', String(options.overlayOpacity == null ? 0.62 : options.overlayOpacity));

    spotlight = el('div', 'unidsa-tour-spotlight');
    blockers = [
      el('div', 'unidsa-tour-blocker'),
      el('div', 'unidsa-tour-blocker'),
      el('div', 'unidsa-tour-blocker'),
      el('div', 'unidsa-tour-blocker')
    ];

    popover = el('div', 'unidsa-tour-popover');
    popover.setAttribute('role', 'dialog');
    uid = 'unidsa-tour-' + Date.now();
    popover.setAttribute('aria-labelledby', uid + '-title');
    popover.setAttribute('aria-describedby', uid + '-content');

    titleRow = el('div', 'unidsa-tour-title-row');
    title = el('h3', 'unidsa-tour-title');
    close = el('button', 'unidsa-tour-close');
    title.id = uid + '-title';
    title.setAttribute('tabindex', '-1');
    close.type = 'button';
    close.setAttribute('aria-label', 'Fechar apresentação');
    close.textContent = '×';
    titleRow.appendChild(title);
    titleRow.appendChild(close);

    content = el('div', 'unidsa-tour-content');
    content.id = uid + '-content';
    progress = el('div', 'unidsa-tour-progress');
    actions = el('div', 'unidsa-tour-actions');
    skip = el('button', 'unidsa-tour-btn unidsa-tour-btn-link');
    actionsRight = el('div', 'unidsa-tour-actions-right');
    back = el('button', 'unidsa-tour-btn');
    next = el('button', 'unidsa-tour-btn unidsa-tour-btn-primary');

    skip.type = 'button';
    back.type = 'button';
    next.type = 'button';
    skip.textContent = options.skipCaption || 'Pular';
    back.textContent = options.backCaption || 'Voltar';
    next.textContent = options.nextCaption || 'Próximo';

    actionsRight.appendChild(back);
    actionsRight.appendChild(next);
    actions.appendChild(skip);
    actions.appendChild(actionsRight);
    popover.appendChild(titleRow);
    popover.appendChild(content);
    if (options.showProgress !== false) popover.appendChild(progress);
    popover.appendChild(actions);

    for (i = 0; i < blockers.length; i++) overlay.appendChild(blockers[i]);
    overlay.appendChild(spotlight);
    overlay.appendChild(popover);
    document.body.appendChild(overlay);

    state.overlay = overlay;
    state.spot = spotlight;
    state.blockers = blockers;
    state.popover = popover;
    state.title = title;
    state.content = content;
    state.progress = progress;
    state.skip = skip;
    state.close = close;
    state.back = back;
    state.next = next;

    state.reposition = function () {
      if (current !== state || !state.ready) return;
      updateGeometry(state);
    };

    state.keydown = function (event) {
      var focusable;
      var first;
      var last;
      if (current !== state) return;

      if (event.key === 'Tab' && state.modal) {
        focusable = Array.prototype.slice.call(state.popover.querySelectorAll('button:not([disabled]),[href],input:not([disabled]),select:not([disabled]),textarea:not([disabled]),[tabindex]:not([tabindex="-1"])'));
        focusable = focusable.filter(function (node) { return node.offsetParent !== null; });
        if (focusable.length) {
          first = focusable[0];
          last = focusable[focusable.length - 1];
          if (event.shiftKey && (document.activeElement === first || document.activeElement === state.title)) {
            event.preventDefault();
            last.focus();
          } else if (!event.shiftKey && document.activeElement === last) {
            event.preventDefault();
            first.focus();
          }
        }
      } else if (event.key === 'Escape' && options.allowSkip !== false && options.closeOnEscape !== false) {
        event.preventDefault();
        send(state, 'UniDSATourSkip', { step: state.index });
        cleanup();
      } else if (options.keyboardNavigation !== false && event.key === 'ArrowRight') {
        event.preventDefault();
        next.click();
      } else if (options.keyboardNavigation !== false && event.key === 'ArrowLeft') {
        event.preventDefault();
        back.click();
      }
    };

    close.onclick = skip.onclick = function () {
      send(state, 'UniDSATourSkip', { step: state.index });
      cleanup();
    };

    back.onclick = function () {
      if (state.index > 0) render(state, state.index - 1, true);
    };

    next.onclick = function () {
      if (state.index < (options.steps || []).length - 1) {
        render(state, state.index + 1, true);
      } else {
        send(state, 'UniDSATourFinish', { step: state.index });
        cleanup();
      }
    };

    global.addEventListener('resize', state.reposition, true);
    global.addEventListener('scroll', state.reposition, true);
    document.addEventListener('keydown', state.keydown, true);

    current = state;
    watchGeometry(state);
    send(state, 'UniDSATourStart', { step: parseInt(options.startStep, 10) || 0 });
    render(state, parseInt(options.startStep, 10) || 0, true);
  };

  API.stop = function () { cleanup(); };
  API.next = function () { if (current) current.next.click(); };
  API.previous = function () { if (current) current.back.click(); };
  API.goTo = function (index) { if (current) render(current, parseInt(index, 10) || 0, true); };
})(window);
