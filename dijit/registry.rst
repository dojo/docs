#format dojo_rst

dijit/registry
==============

:Author: Colin Snover
:Available: 1.7.0

.. contents::
   :depth: 2

============
Introduction
============

dijit/registry is a collection of all Dijit widgets within a page. It can be used for bulk operation and control of groups of widgets. In Dojo 1.6 and earlier, it is an instance of `Dijit WidgetSet <dijit/WidgetSet>`_. Starting in Dojo 1.7, it is a singleton and is accessible from the dijit/registry module.

Unlike earlier versions, starting in 1.7, dijit/registry does not include array iterator methods (forEach, filter, byClass, map, every, and some) by default. Until Dojo 2.0, including dijit.WidgetSet will re-enable these methods. If you need to iterate over the registry, call ``dijit.registry.toArray`` and use the standard `dojo/array`_ functions.

In 1.7 and beyond, dijit/registry contains many functions formerly found on the root ``dijit`` object, such as ``dijit.byId`` and ``dijit.byNode``.

=====
Usage
=====

Retrieving a widget from the registry using a widget ID:

.. code-block :: javascript
 :linenos:

  require(["dijit/registry"], function(registry){
      var widget = registry.byId(id);
  }

Retrieving a widget from the registry using the widget’s DOM node:

.. code-block :: javascript
 :linenos:

  require(["dijit/registry"], function(registry){
      var widget = registry.byNode(node);
  });

Finding all TextBox widgets underneath a DOM node:

.. code-block :: javascript
 :linenos:

  require(["dojo/_base/array", "dijit/registry", "dijit/form/TextBox"], function(arrayUtil, registry, TextBox){
      var textBoxes = arrayUtil.filter(registry.findWidgets(node), function(widget){
        return widget.isInstanceOf(TextBox);
      });
  });

Note that ``findWidgets`` will not descend into other widgets. That is to say, if you had a DOM like this:

.. code-block :: html
 :linenos:

  <div id="root">
      <form data-dojo-type="dijit.form.Form">
          <input data-dojo-type="dijit.form.TextBox">
      </form>
  </div>

Calling ``findWidgets`` on the ``<div id="root">`` will **only** find the dijit.form.Form.

Finding the nearest enclosing widget for a DOM node:

.. code-block :: javascript
 :linenos:

  require(["dijit/registry"], function(registry){
      var parentWidget = registry.getEnclosingWidget(node);
  });

========
See also
========

* `dijit.WidgetSet <dijit/WidgetSet>`_
* `dojo.NodeList <dojo/NodeList>`_
