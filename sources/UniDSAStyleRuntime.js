/* Runtime embedded by tools/embed-style-runtime.cjs. No external CSS/JS asset is required. */
(function (global) {
  'use strict';
  if (global.UniDSAStyle) return;
  const records = new Map();
  let observer = null, pending = 0;
  const own = (o, k) => Object.prototype.hasOwnProperty.call(o || {}, k);
  const clamp = (n, min, max) => Math.max(min, Math.min(max, Number(n)));
  const number = (v, fallback) => Number.isFinite(Number(v)) ? Number(v) : fallback;
  const px = v => number(v, 0) + 'px';
  const escapeID = value => global.CSS.escape(String(value));
  const line = n => ['', 'none', 'solid', 'dashed', 'dotted', 'double'][n];
  function rgba(color, opacity) {
    if (!color) return '';
    const m = /^#([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(color);
    if (opacity === undefined) return color;
    const rgb = /^rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)$/i.exec(color);
    const channels = m ? m.slice(1).map(v => parseInt(v, 16)) : rgb ? rgb.slice(1).map(Number) : null;
    return channels ? 'rgba(' + channels.join(',') + ',' + clamp(opacity, 0, 100) / 100 + ')' : color;
  }
  function clean(source) {
    const result = {};
    for (const key of Object.keys(source || {})) {
      const value = source[key];
      if (value && typeof value === 'object' && !Array.isArray(value)) {
        if (own(value, 'Units') && !value.Units) continue;
        const child = clean(value);
        if (Object.keys(child).length) result[key] = child;
      } else result[key] = value;
    }
    return result;
  }
  function merge(target, source) {
    for (const key of Object.keys(source || {})) {
      if (key === '__proto__' || key === 'constructor' || key === 'prototype') continue;
      const value = source[key];
      if (value && typeof value === 'object' && !Array.isArray(value)) {
        target[key] = merge(target[key] || {}, value);
      } else target[key] = value;
    }
    return target;
  }
  function length(value) {
    if (!value || !value.Units) return '';
    const suffix = ['', 'px', '%', 'em', 'rem', 'vw', 'vh', 'dvh'][value.Units];
    if (suffix) return Math.max(0, number(value.Value, 0)) + suffix;
    return ({8:'auto', 9:'fit-content', 10:'min-content', 11:'max-content'})[value.Units] || '';
  }
  function matches(rule) {
    const width = global.innerWidth, height = global.innerHeight;
    return (!rule.min || width >= rule.min) && (!rule.max || width <= rule.max) &&
      (!rule.orientation || (rule.orientation === 1 ? height >= width : width > height));
  }
  function resolve(layers) {
    const result = {appearance:{}, states:{}};
    for (const layer of layers || []) {
      merge(result.appearance, clean(layer.appearance));
      merge(result.states, clean(layer.states));
      for (const rule of layer.responsive || []) if (matches(rule)) {
        merge(result.appearance, clean(rule.appearance));
        merge(result.states, clean(rule.states));
      }
    }
    return result;
  }
  function declarations(appearance) {
    const result = {surface:{}, text:{}, content:{}, root:{}};
    const put = (group, property, value) => {
      if (value !== '' && value !== undefined && value !== null) result[group][property] = String(value);
    };
    const a = appearance || {}, b = a.Background || {}, border = a.Border || {}, t = a.Typography || {};
    put('surface', 'background-color', rgba(b.Color, b.Opacity));
    if (b.Color) put('surface', 'background-image', 'none');
    if (b.ImageURL) {
      // Values are data, never selectors or arbitrary declarations.
      const url = String(b.ImageURL).trim();
      if (!/^(?:javascript|vbscript):/i.test(url)) put('surface', 'background-image', 'url(' + JSON.stringify(url) + ')');
    }
    if (b.ImageSize) put('surface', 'background-size', ['', 'auto', 'cover', 'contain'][b.ImageSize]);
    if (b.RepeatMode) put('surface', 'background-repeat', ['', 'repeat', 'no-repeat', 'repeat-x', 'repeat-y'][b.RepeatMode]);
    if (b.Pattern === 1 || b.Gradient === 1) put('surface', 'background-image', 'none');
    if (b.Gradient >= 2) {
      const start = b.Color || 'transparent', end = b.GradientColor || 'transparent';
      put('surface', 'background-image', b.Gradient === 2 ?
        'linear-gradient(' + number(b.GradientAngle, 180) + 'deg,' + start + ',' + end + ')' :
        'radial-gradient(circle,' + start + ',' + end + ')');
    }
    if (b.Pattern >= 2) {
      const color = b.PatternColor || '#dddddd', size = Math.max(2, number(b.PatternSize, 18));
      const patterns = {2:'radial-gradient(' + color + ' 0.8px,transparent 0.8px)',
        3:'linear-gradient(' + color + ' 1px,transparent 1px),linear-gradient(90deg,' + color + ' 1px,transparent 1px)',
        4:'linear-gradient(' + color + ' 1px,transparent 1px)'};
      put('surface', 'background-image', patterns[b.Pattern]);
      put('surface', 'background-size', size + 'px ' + size + 'px');
    }
    if (own(border, 'Width')) {
      put('surface', 'border-width', px(Math.max(0, border.Width)));
      if (!border.Line) put('surface', 'border-style', 'solid');
    }
    put('surface', 'border-color', border.Color);
    put('surface', 'border-style', line(border.Line));
    if (own(border, 'Radius')) put('surface', 'border-radius', px(Math.max(0, border.Radius)));
    for (const side of ['Top','Right','Bottom','Left']) {
      const edge = border[side] || {}, prefix = 'border-' + side.toLowerCase();
      if (own(edge, 'Width')) {
        put('surface', prefix + '-width', px(Math.max(0, edge.Width)));
        if (!edge.Line) put('surface', prefix + '-style', 'solid');
      }
      put('surface', prefix + '-color', edge.Color);
      put('surface', prefix + '-style', line(edge.Line));
    }
    for (const corner of ['TopLeft','TopRight','BottomLeft','BottomRight'])
      if (own(border, corner + 'Radius')) put('surface', 'border-' + corner.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase() + '-radius', px(Math.max(0, border[corner + 'Radius'])));
    if (t.Family) put('text', 'font-family', JSON.stringify(t.Family));
    put('text', 'color', t.Color);
    if (own(t, 'Size')) put('text', 'font-size', px(Math.max(1, t.Size)));
    if (t.Weight) put('text', 'font-weight', ['', '400', '500', '600', '700'][t.Weight]);
    if (t.Italic) put('text', 'font-style', t.Italic === 2 ? 'italic' : 'normal');
    if (t.Alignment) put('text', 'text-align', ['', 'left','center','right','justify'][t.Alignment]);
    if (own(t, 'LineHeight')) put('text', 'line-height', Math.max(0.1, t.LineHeight));
    if (own(t, 'LetterSpacing')) put('text', 'letter-spacing', px(t.LetterSpacing));
    if (t.WhiteSpace) put('text', 'white-space', ['', 'normal','nowrap','pre','pre-wrap','pre-line'][t.WhiteSpace]);
    if (t.TextOverflow) put('text', 'text-overflow', t.TextOverflow === 2 ? 'ellipsis' : 'clip');
    if (t.WrapAnywhere) put('text', 'overflow-wrap', t.WrapAnywhere === 2 ? 'anywhere' : 'normal');
    if (t.Transform) put('text', 'text-transform', ['', 'none','uppercase','lowercase','capitalize'][t.Transform]);
    if (t.Decoration) put('text', 'text-decoration', ['', 'none','underline','line-through'][t.Decoration]);
    function edges(group, prefix, value, nonnegative) {
      if (!value) return;
      const n = v => px(nonnegative ? Math.max(0, v) : v);
      if (own(value, 'All')) put(group, prefix, n(value.All));
      for (const side of ['Top','Right','Bottom','Left']) if (own(value, side)) put(group, prefix + '-' + side.toLowerCase(), n(value[side]));
    }
    edges('content', 'padding', (a.Spacing || {}).Padding, true);
    edges('root', 'margin', (a.Spacing || {}).Margin, false);
    const s = a.Sizing || {};
    for (const field of ['Width','Height','MinWidth','MaxWidth','MinHeight','MaxHeight'])
      put('root', field.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase(), length(s[field]));
    if (own(s, 'MaxWidthPercent')) {
      const cap = length(s.MaxWidth), percentage = clamp(s.MaxWidthPercent, 0, 100) + '%';
      put('root', 'max-width', cap && !['auto','fit-content','min-content','max-content'].includes(cap) ? 'min(' + percentage + ',' + cap + ')' : percentage);
    }
    if (s.BoxSizing) put('root', 'box-sizing', s.BoxSizing === 1 ? 'border-box' : 'content-box');
    for (const axis of ['X','Y']) if (s['Overflow' + axis])
      put('root', 'overflow-' + axis.toLowerCase(), ['', 'visible','hidden','auto','scroll'][s['Overflow' + axis]]);
    const shadow = a.Shadow || {};
    if (shadow.Enabled === 1) put('surface', 'box-shadow', 'none');
    if (shadow.Enabled === 2) put('surface', 'box-shadow',
      (shadow.Inset === 2 ? 'inset ' : '') + px(number(shadow.OffsetX, 0)) + ' ' + px(number(shadow.OffsetY, 2)) + ' ' +
      px(Math.max(0, number(shadow.Blur, 8))) + ' ' + px(number(shadow.Spread, 0)) + ' ' + rgba(shadow.Color || '#000000', number(shadow.Opacity, 15)));
    const effects = a.Effects || {};
    if (own(effects, 'Opacity')) put('root', 'opacity', clamp(effects.Opacity, 0, 100) / 100);
    if (effects.Cursor) put('root', 'cursor', ['', 'default','pointer','text','not-allowed','grab'][effects.Cursor]);
    if (own(effects, 'TransitionMs')) {
      const ms = Math.max(0, effects.TransitionMs) + 'ms';
      put('surface', 'transition', ['background-color','border-color','box-shadow','color','opacity'].map(p => p + ' ' + ms + ' ease').join(','));
      put('text', 'transition', 'color ' + ms + ' ease');
    }
    if (own(effects, 'OutlineWidth')) { put('root', 'outline-width', px(Math.max(0, effects.OutlineWidth))); put('root', 'outline-style', 'solid'); }
    put('root', 'outline-color', effects.OutlineColor);
    if (own(effects, 'OutlineOffset')) put('root', 'outline-offset', px(effects.OutlineOffset));
    const position = a.Position || {};
    if (position.Mode) put('root', 'position', ['', 'static','relative','absolute','fixed','sticky'][position.Mode]);
    if (own(position, 'ZIndex')) put('root', 'z-index', Math.trunc(position.ZIndex));
    const inset = position.Insets || {};
    if (own(inset, 'All')) for (const side of ['top','right','bottom','left']) put('root', side, px(inset.All));
    for (const side of ['Top','Right','Bottom','Left']) if (own(inset, side)) put('root', side.toLowerCase(), px(inset[side]));
    return result;
  }
  function adapter(el) {
    if (el.matches('.x-btn')) return {surface:[''], text:[' .x-btn-inner'], content:[' .x-btn-wrap'], root:['']};
    if (el.matches('.x-field')) return {surface:[' .x-form-trigger-wrap',' .x-form-text'], text:[' .x-form-text'], content:[' .x-form-text'], root:['']};
    if (el.matches('.x-panel,.x-window')) return {surface:[''], text:[''], content:[' > .x-panel-bodyWrap > .x-panel-body',' > .x-window-bodyWrap > .x-window-body'], root:['']};
    if (el.matches('.x-container')) return {surface:[''], text:[''], content:[' > .x-autocontainer-outerCt > .x-autocontainer-innerCt'], root:['']};
    return {surface:[''], text:[''], content:[''], root:['']};
  }
  function cssRule(selectors, values) {
    const list = [];
    for (const [property, value] of Object.entries(values)) {
      // CSS.supports validates a single property value; reject declaration delimiters too.
      if (/[{};\u0000]/.test(value) || !global.CSS.supports(property, value)) continue;
      list.push(property + ':' + value + '!important');
    }
    return list.length && selectors.length ? selectors.join(',') + '{' + list.join(';') + '}\n' : '';
  }
  function scrollbarCSS(el, bases, appearance) {
    const scrollbar = (appearance || {}).Scrollbar || {};
    if (!Object.keys(scrollbar).length) return '';
    const targets = [''];
    if (el.matches('.x-container')) {
      targets.push(' .dsa-flex-inner');
      targets.push(' > .x-autocontainer-outerCt > .x-autocontainer-innerCt');
    }
    if (el.matches('.x-panel,.x-window')) {
      targets.push(' > .x-panel-bodyWrap > .x-panel-body');
      targets.push(' > .x-window-bodyWrap > .x-window-body');
    }
    const selectors = bases.flatMap(base => targets.map(target => base + target));
    const hidden = scrollbar.Visible === 1;
    const size = own(scrollbar, 'Size') ? Math.max(0, number(scrollbar.Size, 0)) : -1;
    const standard = {};
    if (hidden) {
      standard['scrollbar-width'] = 'none';
      standard['-ms-overflow-style'] = 'none';
    } else {
      if (size >= 0) standard['scrollbar-width'] = size <= 8 ? 'thin' : 'auto';
      if (scrollbar.ThumbColor)
        standard['scrollbar-color'] = scrollbar.ThumbColor + ' ' + (scrollbar.TrackColor || 'transparent');
    }
    let css = cssRule(selectors, standard);
    if (hidden || size >= 0) {
      const thickness = hidden ? '0px' : px(size);
      css += cssRule(selectors.map(selector => selector + '::-webkit-scrollbar'), {
        width: thickness,
        height: thickness
      });
    }
    if (scrollbar.TrackColor)
      css += cssRule(selectors.map(selector => selector + '::-webkit-scrollbar-track'), {
        'background-color': scrollbar.TrackColor
      });
    const thumb = {};
    if (scrollbar.ThumbColor) thumb['background-color'] = scrollbar.ThumbColor;
    if (own(scrollbar, 'Radius')) thumb['border-radius'] = px(Math.max(0, scrollbar.Radius));
    css += cssRule(selectors.map(selector => selector + '::-webkit-scrollbar-thumb'), thumb);
    if (scrollbar.ThumbHoverColor)
      css += cssRule(selectors.map(selector => selector + '::-webkit-scrollbar-thumb:hover'), {
        'background-color': scrollbar.ThumbHoverColor
      });
    return css;
  }

  function emit(el, suffixes, appearance) {
    const rules = declarations(appearance), map = adapter(el), id = '#' + escapeID(el.id);
    const bases = suffixes.map(s => id + id + s);
    let css = '';
    for (const group of ['surface','text','content','root'])
      css += cssRule(bases.flatMap(base => map[group].map(suffix => base + suffix)), rules[group]);
    css += scrollbarCSS(el, bases, appearance);
    if (el.matches('.x-panel,.x-window')) {
      const bodies = [' > .x-panel-bodyWrap > .x-panel-body',' > .x-window-bodyWrap > .x-window-body'];
      const backgrounds = Object.fromEntries(Object.entries(rules.surface).filter(([p]) => p.startsWith('background')));
      css += cssRule(bases.flatMap(b => bodies.map(s => b + s)), backgrounds);
      const dimensions = {};
      if (rules.root.width) dimensions.width = '100%';
      if (rules.root.height) dimensions.height = rules.root.height === 'auto' ? 'auto' : '100%';
      const fills = [' > .x-panel-bodyWrap',...bodies,' > .x-window-bodyWrap',...bodies.map(s => s + ' > .x-fit-item')];
      css += cssRule(bases.flatMap(b => fills.map(s => b + s)), dimensions);
    }
    if (el.matches('.x-field')) {
      // Ext may draw its own inset frame even when the requested border is zero.
      if (rules.surface['border-width'] === '0px') css += cssRule(bases.map(b => b + ' .x-form-text-wrap'), {'border-width':'0px','box-shadow':'none'});
      if (rules.surface['border-width'] === '0px') css += cssRule(bases.map(b => b + ' .x-form-trigger-wrap'), {'box-shadow':'none'});
      if (Object.keys(rules.content).length) css += cssRule(bases.map(b => b + ' .x-form-text'), {'box-sizing':'border-box'});
      if (rules.surface['border-radius']) css += cssRule(bases.map(b => b + ' .x-form-trigger-wrap'), {'overflow':'hidden'});
    }
    return css;
  }
  const live = ':not(.x-item-disabled):not(.x-btn-disabled):not([aria-disabled="true"]):not(:disabled)';
  function controlCSS(el, layers, selected) {
    const rule = resolve(layers);
    let css = emit(el, [''], rule.appearance);
    if (selected) css += emit(el, [''], rule.states.Selected || {});
    css += emit(el, [live + ':hover'], rule.states.Hover || {});
    css += emit(el, [live + ':focus-visible',live + ':focus-within'], rule.states.Focus || {});
    css += emit(el, [live + ':active'], rule.states.Pressed || {});
    css += emit(el, ['.x-item-disabled','.x-btn-disabled','[aria-disabled="true"]',':disabled'], rule.states.Disabled || {});
    return css;
  }
  function clearTags(record) {
    for (const el of record.tagged) if (el.dataset.unidsaStyleManager === record.key) {
      delete el.dataset.unidsaStyleManager;
      delete el.dataset.unidsaStyleItem;
    }
    record.tagged.clear();
  }
  function render(record) {
    const config = record.config;
    const owner = config.owner && document.getElementById(config.owner);
    if (owner) record.seenOwner = true;
    if (config.owner && record.seenOwner && !owner) { detach(record.key); return; }
    clearTags(record);
    let css = '';
    if (config.enabled) {
      const targets = new Map();
      const scope = config.scope && document.getElementById(config.scope);
      if (scope) {
        targets.set(scope.id, {id:scope.id, layers:[config.defaults]});
        if (config.children) for (const el of scope.querySelectorAll('.x-component[id],.x-container[id],.x-field[id],.x-btn[id],.x-panel[id]'))
          targets.set(el.id, {id:el.id, layers:[config.defaults]});
      }
      for (const item of config.items || []) targets.set(item.id, item);
      for (const item of targets.values()) {
        const el = document.getElementById(item.id);
        if (!el) continue;
        css += controlCSS(el, item.layers, item.selected);
        if (item.name) {
          el.dataset.unidsaStyleManager = record.key;
          el.dataset.unidsaStyleItem = item.name;
          record.tagged.add(el);
        }
      }
    }
    if (record.style.textContent !== css) record.style.textContent = css;
  }
  function schedule() {
    if (pending || !records.size) return;
    pending = global.requestAnimationFrame(function () {
      pending = 0;
      for (const record of records.values()) render(record);
    });
  }
  function start() {
    if (observer) return;
    observer = new MutationObserver(function (changes) {
      if (changes.some(change => !(change.target.nodeType === 1 && change.target.matches('style[data-unidsa-style-sheet]')))) schedule();
    });
    observer.observe(document.documentElement, {childList:true, subtree:true});
    global.addEventListener('resize', schedule);
  }
  function detach(key) {
    const record = records.get(key);
    if (!record) return;
    clearTags(record);
    record.style.remove();
    records.delete(key);
    if (!records.size && observer) {
      observer.disconnect(); observer = null;
      global.removeEventListener('resize', schedule);
      if (pending) { global.cancelAnimationFrame(pending); pending = 0; }
    }
  }
  function attach(key, config) {
    let record = records.get(key);
    if (!record) {
      const style = document.createElement('style');
      style.dataset.unidsaStyleSheet = key;
      document.head.appendChild(style);
      record = {key, style, tagged:new Set(), seenOwner:false};
      records.set(key, record);
    }
    record.config = config;
    start();
    render(record);
    schedule();
  }
  global.UniDSAStyle = {attach, detach};
})(window);
