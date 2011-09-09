#format dojo_rst

dojo.getStyle
=============

:Available: since V1.2

.. contents::
   :depth: 2

Returns a "computed style" object.


============
Introduction
============

``dojo.getComputedStyle()`` is a companion function for `dojo.style <dojo/style>`_. It gets a "computed style" object which can be used to gather information about the current state of the rendered node.
Note that this may behave differently on different browsers. Values may have different formats and value encodings across browsers.
Note also that this method is expensive.  Wherever possible, reuse the returned object.
Use the dojo.style() method for more consistent (pixelized) return values.

Since 1.7 it is an alias of style.getComputedStyle in dojo/dom-style.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojo.getComputedStyle(node);

node
  A reference to a DOM node. Does NOT support taking an ID string for speed reasons.


========
Examples
========

Dojo 1.7 (AMD)
--------------
In dojo 1.7, dojo.getComputedStyle has been kept in dojo/_base/html as a compatibility of dojo version before, it is an alias of style.getComputedStyle in dojo/dom-style.

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
      dojo.getComputedStyle(dojo.byId('foo')).borderWidth;

      // Reusing the returned object, avoiding multiple lookups:
      var cs = dojo.getComputedStyle(dojo.byId("someNode"));
      var w = cs.width, h = cs.height;
  });

It's recommended to use style.getComputedStyle in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-style", "dojo/dom"], function(style, dom){   
      style.getComputedStyle(dom.byId('foo')).borderWidth;

      // Reusing the returned object, avoiding multiple lookups:
      var cs = style.getComputedStyle(dom.byId("someNode"));
      var w = cs.width, h = cs.height;
  });

Dojo < 1.7
----------

.. code-block :: javascript

    dojo.getComputedStyle(dojo.byId('foo')).borderWidth;

    // Reusing the returned object, avoiding multiple lookups:
    var cs = dojo.getComputedStyle(dojo.byId("someNode"));
    var w = cs.width, h = cs.height;

========
See also
========

DOM operations:

* `dojo.style <dojo/style>`_
* `dojo.getStyle <dojo/getStyle>`_
* `dojo.setStyle <dojo/setStyle>`_
* `dojo.attr <dojo/attr>`_
