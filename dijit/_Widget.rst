.. _dijit/_Widget:

dijit._Widget
=============

:Authors: Bill Keese
:Project owner: Bill Keese
:Available: since V0.9

.. contents::
   :depth: 2


`dijit._Widget <http://dojotoolkit.org/api/dijit/_Widget>`_ was the previous base class for widgets.
It has been replaced by `dijit._WidgetBase <http://dojotoolkit.org/api/dijit/_WidgetBase>`_.

If you are converting a widget from extending dijit._Widget to extending  `dijit._WidgetBase <http://dojotoolkit.org/api/dijit/_WidgetBase>`_,
you may also want to extend the follow mixins:

  * :ref:`dijit._OnDijitClickMixin <dijit/_OnDijitClickMixin>` - for widgets that connect to "ondijitclick" instead of "onclick" (for accessibility)
  * :ref:`dijit._FocusMixin <dijit/_FocusMixin>` - for widgets that want the onFocus() / onBlur() callback


In addition, you may want to require these modules:

  * :ref:`dojo.uacss <dojo/uacss>` - for widgets that have browser specific CSS
  * :ref:`dijit.hccss <dijit/hccss>` - for widgets that have high-contrast mode specific CSS or layout
