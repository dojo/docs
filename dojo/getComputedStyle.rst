.. _dojo/getComputedStyle:

=====================
dojo.getComputedStyle
=====================

.. contents ::
   :depth: 2

Returns a "computed style" object.

Introduction
============

``dojo.getComputedStyle()`` is a companion function for :ref:`dojo.style <dojo/style>`. It gets a "computed style" object which can be used to gather information about the current state of the rendered node.
Note that this may behave differently on different browsers. Values may have different formats and value encodings across browsers.
Note also that this method is expensive.  Wherever possible, reuse the returned object.
Use the dojo.style() method for more consistent (pixelized) return values.

Since Dojo 1.7, ``dojo.getComputedStyle`` is exposed via the ``getComputedStyle`` method of the ``dojo/dom-style`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.


Usage
=====

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-style"], function(domStyle){
    domStyle.getComputedStyle(node);
  });
  
  // Dojo < 1.7
  dojo.getComputedStyle(node);

node
  A reference to a DOM node. Does NOT support taking an ID string for speed reasons.

Examples
========

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``getComputedStyle`` is accessed from the ``dojo/dom-style`` module.

.. js ::

  require(["dojo/dom-style", "dojo/dom"], function(domStyle, dom){
    domStyle.getComputedStyle(dom.byId("foo")).borderWidth;

    // Reusing the returned object, avoiding multiple lookups:
    var cs = domStyle.getComputedStyle(dom.byId("someNode"));
    var w = cs.width, h = cs.height;
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.getComputedStyle`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      dojo.getComputedStyle(dojo.byId("foo")).borderWidth;

      // Reusing the returned object, avoiding multiple lookups:
      var cs = dojo.getComputedStyle(dojo.byId("someNode"));
      var w = cs.width, h = cs.height;
  });

Dojo < 1.7
----------

.. js ::

    dojo.getComputedStyle(dojo.byId("foo")).borderWidth;

    // Reusing the returned object, avoiding multiple lookups:
    var cs = dojo.getComputedStyle(dojo.byId("someNode"));
    var w = cs.width, h = cs.height;

See also
========

DOM operations:

* :ref:`dojo.style <dojo/style>`
* :ref:`dojo.getStyle <dojo/getStyle>`
* :ref:`dojo.setStyle <dojo/setStyle>`
* :ref:`dojo.attr <dojo/attr>`
