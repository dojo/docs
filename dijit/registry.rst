.. _dijit/registry:

==============
dijit/registry
==============

:Author: Colin Snover
:since: 1.7.0

.. contents ::
   :depth: 2

Introduction
============

dijit/registry stores a collection of all the dijit widgets within a page.
It is commonly used to retrieve a reference to a widget from a related piece of data (such as the widget’s DOM node or ID).
It contains functions formerly found on the root ``dijit`` object for looking up widgets, such as ``dijit.byId`` and ``dijit.byNode``.


Usage
=====

Retrieving a widget from the registry using a widget ID
-------------------------------------------------------

``registry.byId`` returns the widget that corresponds to the given ID.
If no such widget exists, it returns undefined.

.. js ::
 
  require(["dijit/registry"], function(registry){
      var widget = registry.byId("myWidgetId");
  });

Retrieving a widget from the registry using the widget’s DOM node
-----------------------------------------------------------------

``registry.byNode`` returns the widget that corresponds to the given DOM node.
If the DOM node does not belong to a widget, it returns undefined.

.. js ::
 
  require(["dijit/registry"], function(registry){
      var widget = registry.byNode(domNode);
  });

Finding all widgets underneath a DOM node
-----------------------------------------

``registry.findWidgets`` returns an array of all non-nested widgets inside the given DOM node.

.. js ::
 
  require(["dojo/_base/array", "dijit/registry", "dijit/form/TextBox"], function(arrayUtil, registry, TextBox){
      var formWidgets = registry.findWidgets(formNode);
  });

Note that ``registry.findWidgets`` will *not* descend into widgets.
That is to say, if you had a DOM like this:

.. html ::
 
  <div id="root" data-dojo-type="dijit/Dialog">
      <form data-dojo-type="dijit/form/Form">
          <input data-dojo-type="dijit/form/TextBox">
      </form>
      <div>
          <form data-dojo-type="dijit/form/Form">
              <input data-dojo-type="dijit/form/TextBox">
          </form>
      </div>
  </div>

Calling ``findWidgets`` on the ``root`` node would **only** return the Form widgets, not the TextBox widgets.

Finding the nearest enclosing widget for a DOM node
---------------------------------------------------

``registry.getEnclosingWidget`` returns the closest widget to the given DOM node.

.. js ::
 
  require(["dijit/registry"], function(registry){
      var parentWidget = registry.getEnclosingWidget(domNode);
  });

Note that ``getEnclosingWidget`` will check for and return the widget corresponding to the given DOM node, if one exists.
For instance, given the following DOM:

.. html ::
 
  <div data-dojo-type="dijit/form/Form">
      <input id="myTextField" data-dojo-type="dijit/form/TextBox">
  </div>

The following will return the TextBox widget, **not** the Form widget:

.. js ::
 
  require(["dojo/dom", "dijit/registry"], function(dom, registry){
      registry.getEnclosingWidget(dom.byId("myTextField")); // returns TextBox
  });

Iterating Over The Registry
---------------------------
If you need to iterate over the entire registry, it is best to call ``registry.toArray``
and use the standard :ref:`dojo array <dojo/_base/array>` functions.

.. js ::

  require(["dojo/_base/array", "dijit/registry"], function(array, registry){
      array.forEach(registry.toArray(), ...);
  });


Note that for backwards compatibility, the dijit.registry global variable (as opposed to the dijit/registry module)
includes array iterator methods (forEach, filter, byClass, map, every, and some).
However, AMD code should not expect these functions to be available in the Object returned from
require(["dijit/registry"]).

See also
========

* :ref:`dijit.WidgetSet <dijit/WidgetSet>`
* :ref:`dojo.NodeList <dojo/NodeList>`
