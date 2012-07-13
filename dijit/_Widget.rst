.. _dijit/_Widget:

=============
dijit._Widget
=============

.. contents ::
   :depth: 2


dijit._Widget was the previous base class for widgets.
It has been replaced by :ref:`dijit._WidgetBase <dijit/_WidgetBase>`.

If you are converting a widget from extending dijit._Widget to extending  :ref:`dijit._WidgetBase <dijit/_WidgetBase>`,
you may also want to extend the follow mixins:

  * :ref:`dijit._OnDijitClickMixin <dijit/_OnDijitClickMixin>` - for widgets that connect to "ondijitclick" instead of "onclick" (for accessibility)
  * :ref:`dijit._FocusMixin <dijit/_FocusMixin>` - for widgets that want the onFocus() / onBlur() callback


In addition, you may want to require these modules:

  * :ref:`dojo.uacss <dojo/uacss>` - for widgets that have browser specific CSS
  * :ref:`dijit.hccss <dijit/hccss>` - for widgets that have high-contrast mode specific CSS or layout

See Also
========
* :ref:`dijit._WidgetBase <dijit/_WidgetBase>`
