.. _dijit/_FocusMixin:

=====================
dijit._FocusMixin
=====================

:Authors: Bill Keese
:Project owner: Bill Keese
:since: V1.7

.. contents ::
   :depth: 2


Introduction
============

dijit._FocusMixin is a mixin to supply the _onFocus() and _onBlur() callbacks on a widget when the widget enters / leaves the focus active stack.

See the :ref:`dijit.focus <dijit/focus>` documentation for details on the active stack.

Note that the underscore in the name implies not that _FocusMixin is a private class, but rather that it's a mixin, rather than a widget.

Usage
=====

Mixin dijit._FocusMixin when you declare your widget, and then reference _onFocus() and _onBlur():

.. js ::
 
   dojo.declare("MyWidget", [dijit._WidgetBase, dijit._TemplatedMixin, dijit._WidgetsInTemplateMixin, dijit._FocusMixin], {
      templateString: '<div><input data-dojo-type="dijit/form/TextBox"><input><input></div>',
      _onFocus: function(){
          console.log("One of my descendant widgets / nodes got focus");
          this.inherited(arguments);
      },
      _onBlur: function(){
          console.log("Focus left me and my descendant widgets");
          this.inherited(arguments);
      }
   });
