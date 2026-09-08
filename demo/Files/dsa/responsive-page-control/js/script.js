(function () {
  'use strict';

  function applyColors(el, colors) {
    if (!el) return;
    Object.keys(colors || {}).forEach(function (name) {
      el.style.setProperty('--dsa-tabs-' + name, colors[name]);
    });
  }

  // Select visible tabs without reordering either the tab bar or its pages.
  function selectTabs(widths, available, activeIndex, keepActive) {
    var selected = [], used = 0;
    if (keepActive && activeIndex >= 0) {
      selected[activeIndex] = true;
      used = widths[activeIndex];
    }
    widths.forEach(function (width, index) {
      if (!selected[index] && used + width <= available) {
        selected[index] = true;
        used += width;
      }
    });
    return { selected: selected, used: used };
  }

  function installOverflow(panel, bar) {
    var layout = bar.getLayout(), handler = layout.overflowHandler;
    if (!handler || handler.type !== 'menu' || handler.dsaInstalled) return;
    handler.dsaInstalled = true;
    var nativeShow = handler.showTrigger;
    handler.showTrigger = function (context) {
      nativeShow.call(this, context);
      var me = this, names = layout.names, items = context.childItems;
      var options = panel.dsaTabs, activeIndex = -1;
      var available = Math.max(0,
        context.state.boxPlan.targetSize[names.width] - me.triggerTotalWidth);
      var widths = items.map(function (item, index) {
        if (item.target === bar.activeTab) activeIndex = index;
        return Math.min(item.props[names.width], bar.dsaMaxTabWidth) + 4;
      });
      var result = selectTabs(widths, available, activeIndex, options.keepActiveVisible);
      var remaining = Math.max(0, available - result.used);
      var position = options.alignment === 'center' ? Math.floor(remaining / 2) :
        (options.alignment === 'end' ? remaining : 0);
      me.menuItems.length = 0;
      items.forEach(function (item, index) {
        if (result.selected[index]) {
          item.target.removeCls(me.menuItemOverflowedCls);
          item.setProp(names.x, position);
          position += widths[index];
        } else {
          item.target.addCls(me.menuItemOverflowedCls);
          me.menuItems.push(item.target);
        }
      });
    };
    if (handler.menu) {
      handler.menu.addCls('dsa-responsive-tabs-menu');
      handler.menu.on('afterrender', function (menu) {
        applyColors(menu.el.dom, panel.dsaTabs.colors);
      });
      handler.menu.on('beforeshow', function (menu) {
        applyColors(menu.el && menu.el.dom, panel.dsaTabs.colors);
        menu.items.each(function (item) {
          var active = item.masterComponent === bar.activeTab;
          item[active ? 'addCls' : 'removeCls']('dsa-tabs-menu-active');
        });
      });
    }
    if (handler.menuTrigger) {
      handler.menuTrigger.setTooltip('Mais abas');
      handler.menuTrigger.el.dom.setAttribute('aria-label', 'Mais abas');
    }
  }

  function constrainTabs(bar) {
    var maxWidth = Math.max(24, Math.min(280, bar.getWidth() - 64));
    if (bar.dsaMaxTabWidth === maxWidth) return false;
    bar.dsaMaxTabWidth = maxWidth;
    bar.el.dom.style.setProperty('--dsa-tab-max-width', maxWidth + 'px');
    return true;
  }

  function attach(panel, options) {
    if (!panel || panel.destroyed) return;
    panel.dsaTabs = options;
    if (!panel.rendered) return;
    var bar = panel.getTabBar(), layout = bar.getLayout();
    applyColors(panel.el.dom, options.colors);
    constrainTabs(bar);
    layout.setPack(options.alignment);
    if (!panel.dsaTabsAttached) {
      panel.dsaTabsAttached = true;
      panel.on('tabchange', function () { bar.updateLayout(); });
      bar.on('resize', function () {
        var handler = bar.getLayout().overflowHandler;
        if (handler && handler.menu) handler.menu.hide();
        if (constrainTabs(bar)) bar.updateLayout();
      });
    }
    installOverflow(panel, bar);
    var handler = layout.overflowHandler;
    if (handler && handler.menu && handler.menu.rendered) {
      applyColors(handler.menu.el.dom, options.colors);
    }
    bar.updateLayout();
  }

  window.UniDSAResponsiveTabs = { attach: attach, selectTabs: selectTabs };
}());
