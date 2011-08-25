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

dijit/registry stores a collection of all the dijit widgets within a page. It is commonly used to retrieve a reference to a widget from a related piece of data (such as the widget’s DOM node or ID). It contains many functions formerly found on the root ``dijit`` object, such as ``dijit.byId`` and ``dijit.byNode``.

In Dojo 1.6 and earlier, the registry is an instance of `dijit/WidgetSet`_. Starting in Dojo 1.7, it is an object.

Starting in Dojo 1.7, the registry does not include array iterator methods by default (forEach, filter, byClass, map, every, and some). Requiring dijit/WidgetSet will automatically re-add these methods (until Dojo 2.0). If you need to iterate over the entire registry, it is best to call ``registry.toArray`` and use the standard `dojo/array`_ functions.

=====
Usage
=====

Retrieving a widget from the registry using a widget ID
-------------------------------------------------------

.. code-block :: javascript
 :linenos:

  require(["dijit/registry"], function(registry){
      var widget = registry.byId(id);
  }

Retrieving a widget from the registry using the widget’s DOM node
-----------------------------------------------------------------

.. code-block :: javascript
 :linenos:

  require(["dijit/registry"], function(registry){
      var widget = registry.byNode(node);
  });

Finding all widgets underneath a DOM node
-----------------------------------------

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

Finding the nearest enclosing widget for a DOM node
---------------------------------------------------

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
