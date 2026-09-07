(function () {
  'use strict';

  if (!window.Ext || Ext.ClassManager.get('UniDSA.container.Flex')) {
    return;
  }

  Ext.define('UniDSA.container.Flex', {
    extend: 'Ext.container.Container',
    alias: 'widget.unidsaflex',
    layout: 'auto',

    initComponent: function () {
      var me = this;

      if (Ext.container.Container.prototype.initComponent) {
        Ext.container.Container.prototype.initComponent.apply(me, arguments);
      }
      me.on({
        afterrender: me.dsaAfterRender,
        add: me.dsaScheduleFlex,
        remove: me.dsaScheduleFlex,
        resize: me.dsaScheduleFlex,
        show: me.dsaScheduleFlex,
        scope: me
      });

    },

    dsaAfterRender: function () {
      this.dsaObserveSize();
      this.dsaApplyFlex();
    },

    beforeDestroy: function () {
      if (this.dsaResizeObserver) {
        this.dsaResizeObserver.disconnect();
        this.dsaResizeObserver = null;
      }
      if (this.dsaWindowResizeHandler) {
        Ext.un('resize', this.dsaWindowResizeHandler, this);
        this.dsaWindowResizeHandler = null;
      }
      if (Ext.container.Container.prototype.beforeDestroy) {
        Ext.container.Container.prototype.beforeDestroy.apply(this, arguments);
      }
    },

    setDsaFlexConfig: function (config) {
      this.dsaFlex = Ext.apply({}, config || {});
      this.dsaApplyFlex();
      if (this.ownerCt && this.ownerCt.dsaScheduleFlex) {
        this.ownerCt.dsaScheduleFlex();
      }
    },

    setDsaFlexItemConfig: function (config) {
      this.dsaFlexItem = Ext.apply({}, config || {});
      if (this.ownerCt && this.ownerCt.dsaApplyFlex) {
        this.ownerCt.dsaApplyFlex();
      }
    },

    setDsaFlexItemsConfig: function (config) {
      this.dsaFlexItems = Ext.apply({}, config || {});
      this.dsaApplyFlex();
    },

    dsaScheduleFlex: function () {
      var me = this;
      if (me.dsaFlexScheduled || me.destroyed) {
        return;
      }
      me.dsaFlexScheduled = true;
      Ext.asap(function () {
        me.dsaFlexScheduled = false;
        if (!me.destroyed) {
          me.dsaApplyFlex();
        }
      });
    },

    dsaObserveSize: function () {
      var me = this;

      if (window.ResizeObserver && me.el && me.el.dom) {
        me.dsaResizeObserver = new ResizeObserver(function () {
          me.dsaScheduleFlex();
        });
        me.dsaResizeObserver.observe(me.el.dom);
      } else {
        me.dsaWindowResizeHandler = me.dsaScheduleFlex;
        Ext.on('resize', me.dsaWindowResizeHandler, me);
      }
    },

    dsaTargetElement: function () {
      var layout = this.getLayout && this.getLayout();
      var target;

      if (layout && layout.getRenderTarget) {
        target = layout.getRenderTarget();
      }

      if (!target) {
        target = this.getTargetEl ? this.getTargetEl() : this.el;
      }

      return target && target.dom ? target : Ext.get(target);
    },

    dsaBreakpointForWidth: function (width, config) {
      var points = config.breakpoints || {};
      if (width >= (points.xxl || 1400)) { return 'xxl'; }
      if (width >= (points.xl || 1200)) { return 'xl'; }
      if (width >= (points.lg || 992)) { return 'lg'; }
      if (width >= (points.md || 768)) { return 'md'; }
      if (width >= (points.sm || 576)) { return 'sm'; }
      return 'xs';
    },

    dsaConfigForItem: function (item) {
      var itemConfig = Ext.apply({}, item.dsaFlexItem || {});
      var itemId = item.getId ? item.getId() : item.id;
      var override = itemId && this.dsaFlexItems ? this.dsaFlexItems[itemId] : null;

      if (override) {
        itemConfig = Ext.apply(itemConfig, override);
        itemConfig.spans = Ext.apply({}, override.spans || {});
      }
      return itemConfig;
    },

    dsaSpanForItem: function (itemConfig, breakpoint, config) {
      var spans = itemConfig.spans || {};
      var names = ['xs', 'sm', 'md', 'lg', 'xl', 'xxl'];
      var span = 0;
      var i;

      for (i = 0; i < names.length; i += 1) {
        if (Number(spans[names[i]]) > 0) {
          span = Number(spans[names[i]]);
        }
        if (names[i] === breakpoint) {
          break;
        }
      }

      return span || Number(config.defaultSpan) || 0;
    },

    dsaApplyItem: function (item, breakpoint, config) {
      var itemConfig;
      var style;
      var span;
      var columns;
      var columnGap;
      var basis;
      var direction;
      var alignSelf;
      var autoHeight;
      var autoWidth;
      var stretchesAcrossColumn;
      var stretchesAcrossRow;
      var preservesWidth;

      if (!item || !item.el || !item.el.dom) {
        return;
      }

      itemConfig = this.dsaConfigForItem(item);
      style = item.el.dom.style;
      span = this.dsaSpanForItem(itemConfig, breakpoint, config);
      columns = Math.max(1, Number(config.columns) || 12);
      columnGap = Math.max(0, Number(config.columnGap) || 0);
      basis = itemConfig.basis || 'auto';
      direction = String(config.direction || 'row');
      alignSelf = itemConfig.alignSelf || 'auto';
      autoHeight = Boolean(item.dsaFlex && item.dsaFlex.autoHeight);
      autoWidth = Boolean(item.dsaFlex && item.dsaFlex.autoWidth);
      stretchesAcrossColumn = !autoWidth && direction.indexOf('column') === 0 &&
        (alignSelf === 'stretch' || (alignSelf === 'auto' && config.alignItems === 'stretch'));
      stretchesAcrossRow = autoHeight && direction.indexOf('row') === 0 &&
        (alignSelf === 'stretch' || (alignSelf === 'auto' && config.alignItems === 'stretch'));
      preservesWidth = autoWidth && direction.indexOf('column') === 0 &&
        (alignSelf === 'stretch' || (alignSelf === 'auto' && config.alignItems === 'stretch'));

      item.el.addCls('dsa-flex-item');
      if (stretchesAcrossColumn) {
        item.el.addCls('dsa-flex-item-stretch-width');
      } else {
        item.el.removeCls('dsa-flex-item-stretch-width');
      }
      style.flexGrow = String(Math.max(0, Number(itemConfig.grow) || 0));
      style.flexShrink = String(Math.max(0, itemConfig.shrink === undefined ? 1 : Number(itemConfig.shrink)));
      style.order = String(Number(itemConfig.order) || 0);
      style.alignSelf = (stretchesAcrossRow || preservesWidth) ? 'flex-start' : alignSelf;

      if (span > 0 && direction.indexOf('row') === 0) {
        span = Math.min(columns, Math.max(1, span));
        basis = 'calc(((100% + ' + columnGap + 'px) * ' + span + ' / ' + columns + ') - ' + columnGap + 'px)';
        item.el.addCls('dsa-flex-item-managed-width');
      } else {
        item.el.removeCls('dsa-flex-item-managed-width');
      }

      style.flexBasis = basis;
      style.maxWidth = (span > 0 && direction.indexOf('row') === 0) ? basis : '';
    },

    dsaApplyFlex: function () {
      var me = this;
      var config = Ext.apply({
        direction: 'row',
        wrap: 'wrap',
        justifyContent: 'flex-start',
        alignItems: 'stretch',
        alignContent: 'stretch',
        rowGap: 12,
        columnGap: 12,
        padding: 0,
        columns: 12,
        defaultSpan: 0,
        overflow: 'visible',
        autoHeight: false,
        autoWidth: false
      }, me.dsaFlex || {});
      var target = me.dsaTargetElement();
      var targetStyle;
      var width;
      var breakpoint;

      if (!target || !target.dom) {
        return;
      }

      target.addCls('dsa-flex-inner');
      // Ext's auto layout inserts table wrappers with cached dimensions. Keep
      // those wrappers in normal flow so wrapping children determine height.
      var wrapper = target.dom.parentElement;
      while (wrapper && me.el && wrapper !== me.el.dom) {
        wrapper.classList.add('dsa-flex-wrapper');
        wrapper.classList.toggle('dsa-flex-auto-height', !!config.autoHeight);
        wrapper.classList.toggle('dsa-flex-auto-width', !!config.autoWidth);
        wrapper = wrapper.parentElement;
      }
      targetStyle = target.dom.style;
      targetStyle.display = 'flex';
      targetStyle.flexDirection = config.direction;
      targetStyle.flexWrap = config.wrap;
      targetStyle.justifyContent = config.justifyContent;
      targetStyle.alignItems = config.alignItems;
      targetStyle.alignContent = config.alignContent;
      targetStyle.rowGap = Math.max(0, Number(config.rowGap) || 0) + 'px';
      targetStyle.columnGap = Math.max(0, Number(config.columnGap) || 0) + 'px';
      targetStyle.padding = Math.max(0, Number(config.padding) || 0) + 'px';
      targetStyle.overflow = config.overflow;

      if (config.autoHeight) {
        target.addCls('dsa-flex-auto-height');
        if (me.el && me.el !== target) {
          me.el.addCls('dsa-flex-auto-height');
        }
      } else {
        target.removeCls('dsa-flex-auto-height');
        if (me.el && me.el !== target) {
          me.el.removeCls('dsa-flex-auto-height');
        }
      }

      if (config.autoWidth) {
        target.addCls('dsa-flex-auto-width');
        if (me.el && me.el !== target) {
          me.el.addCls('dsa-flex-auto-width');
        }
      } else {
        target.removeCls('dsa-flex-auto-width');
        if (me.el && me.el !== target) {
          me.el.removeCls('dsa-flex-auto-width');
        }
      }

      width = target.dom.clientWidth || (me.getWidth ? me.getWidth() : 0);
      breakpoint = me.dsaBreakpointForWidth(width, config);
      target.dom.setAttribute('data-dsa-breakpoint', breakpoint);

      if (me.items && me.items.each) {
        me.items.each(function (item) {
          me.dsaApplyItem(item, breakpoint, config);
        });
      }
    }
  });
}());
