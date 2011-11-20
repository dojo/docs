.. _dojo/getStyle:

dojo.getStyle
=============

.. contents::
   :depth: 2

Accesses styles on a node.


============
Introduction
============

``dojo.getStyle()`` is a companion function for :ref:`dojo.style <dojo/style>`. It gets the style value uses the computed style for the node, so the value
will be a calculated value, not just the immediate node.style value. Also when getting values, use specific style names, like "borderBottomWidth" instead of "border" since compound values like "border" are not necessarily reflected as expected. If you want to get node dimensions, use `dojo.marginBox()`, `dojo.contentBox()` or `dojo.position()`..

Since dojo 1.7, dojo.getStyle has been kept in dojo/_base/html as a compatibility of dojo version before, it is an alias of style.get in dojo/dom-style.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojo.getStyle(node, name);

node
  id or reference to node to get style for

name
  the style property to get


========
Examples
========

Dojo 1.7 (AMD)
--------------

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
      // Passing only an ID or node returns the computed style object of the node:
      dojo.getStyle("thinger");

      // Passing a node and a style property returns the current normalized, computed value for that property:
      dojo.getStyle("thinger", "opacity"); // 1 by default
  });

It's recommended to use style.get in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-style"], function(style){   
      // Passing only an ID or node returns the computed style object of the node:
      style.get("thinger");

      // Passing a node and a style property returns the current normalized, computed value for that property:
      style.get("thinger", "opacity"); // 1 by default
  });

Dojo < 1.7
----------

.. code-block :: javascript

    // Passing only an ID or node returns the computed style object of the node:
    dojo.getStyle("thinger");

    // Passing a node and a style property returns the current normalized, computed value for that property:
    dojo.getStyle("thinger", "opacity"); // 1 by default

========
See also
========

DOM operations:

* :ref:`dojo.style <dojo/style>`
* :ref:`dojo.getComputedStyle <dojo/getComputedStyle>`
* :ref:`dojo.setStyle <dojo/setStyle>`
* :ref:`dojo.attr <dojo/attr>`
