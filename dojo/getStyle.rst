.. _dojo/getStyle:

=============
dojo.getStyle
=============

.. contents ::
   :depth: 2

Accesses styles on a node.


Introduction
============

``dojo.getStyle()`` is a companion function for :ref:`dojo.style <dojo/style>`. It gets the style value uses the computed style for the node, so the value
will be a calculated value, not just the immediate node.style value. Also when getting values, use specific style names, like "borderBottomWidth" instead of "border" since compound values like "border" are not necessarily reflected as expected. If you want to get node dimensions, use `dojo.marginBox()`, `dojo.contentBox()` or `dojo.position()`.

Since Dojo 1.7, ``dojo.getStyle`` is exposed via the ``get`` method of the ``dojo/dom-style`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::

  // Dojo 1.7+ (AMD)
  require(["dojo/dom-style"], function(domStyle){
    domStyle.get(node, name);
  });
  
  // Dojo < 1.7
  dojo.getStyle(node, name);

node
  id or reference to node to get style for

name
  the style property to get


Examples
========

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``get`` is accessed from the ``dojo/dom-style`` module.

.. js ::
  
  require(["dojo/dom-style"], function(domStyle){
    // Passing only an ID or node returns the computed style object of the node:
    domStyle.get("thinger");

    // Passing a node and a style property returns the current normalized, computed value for that property:
    domStyle.get("thinger", "opacity"); // 1 by default
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.getStyle`` in the ``define`` or ``require`` callback:

.. js ::
  
  require(["dojo"], function(dojo){
    // Passing only an ID or node returns the computed style object of the node:
    dojo.getStyle("thinger");

    // Passing a node and a style property returns the current normalized, computed value for that property:
    dojo.getStyle("thinger", "opacity"); // 1 by default
  });

Dojo < 1.7
----------

.. js ::
  
  // Passing only an ID or node returns the computed style object of the node:
  dojo.getStyle("thinger");

  // Passing a node and a style property returns the current normalized, computed value for that property:
  dojo.getStyle("thinger", "opacity"); // 1 by default

See also
========

DOM operations:

* :ref:`dojo.style <dojo/style>`
* :ref:`dojo.getComputedStyle <dojo/getComputedStyle>`
* :ref:`dojo.setStyle <dojo/setStyle>`
* :ref:`dojo.attr <dojo/attr>`
