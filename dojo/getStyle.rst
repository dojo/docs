#format dojo_rst

dojo.getStyle
=============

:Available: since V1.2

.. contents::
   :depth: 2

Accesses styles on a node.


============
Introduction
============

``dojo.getStyle()`` is a companion function for `dojo.style <dojo/style>`_. It gets the style value uses the computed style for the node, so the value
will be a calculated value, not just the immediate node.style value. Also when getting values, use specific style names, like "borderBottomWidth" instead of "border" since compound values like "border" are not necessarily reflected as expected. If you want to get node dimensions, use `dojo.marginBox()`, `dojo.contentBox()` or `dojo.position()`..

Since 1.7 it will be replaced by style.get in dojo/dom-style.


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
In dojo 1.7, dojo.getStyle has been moved to dojo/_base/html.

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
      // Passing only an ID or node returns the computed style object of the node:
      dojo.getStyle("thinger");

      // Passing a node and a style property returns the current normalized, computed value for that property:
      dojo.getStyle("thinger", "opacity"); // 1 by default
  });

It's recommend to use style.get in dojo 1.7.

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

* `dojo.style <dojo/style>`_
* `dojo.getComputedStyle <dojo/getComputedStyle>`_
* `dojo.setStyle <dojo/setStyle>`_
* `dojo.attr <dojo/attr>`_
