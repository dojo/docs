.. _dojo/getMarginBox:

=================
dojo.getMarginBox
=================

.. contents ::
   :depth: 2

Returns an object that encodes the width, height, left and top positions of the node's margin box.

Introduction
============

The dojo.getMarginBox function is used to obtain an object that encodes the width, height, left and top positions of the node's margin box.

Since Dojo 1.7, ``dojo.getMarginBox`` is exposed via the ``getMarginBox`` method of the ``dojo/dom-geometry`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
 
 // Dojo 1.7+ (AMD)
 require(["dojo/dom-geometry"], function(domGeom){
   domGeom.getMarginBox(node, computedStyle);
 })
 
 // Dojo < 1.7
 dojo.getMarginBox(node, computedStyle);

node
  DOMNode

computedStyle
  This parameter accepts computed styles object. If this parameter is omitted, the functions will call dojo.getComputedStyle to get one. It is a better way, calling dojo.computedStyle once, and then pass the reference to this computedStyle parameter. Wherever possible, reuse the returned object of dojo.getComputedStyle.

Dojo 1.7 (AMD)
--------------

When using AMD format in a fully baseless application, ``getMarginBox`` is accessed from the ``dojo/dom-geometry`` module.

.. js ::
 
  require(["dojo/dom-geometry"], function(domGeom){
     // Get the margin-box size of a node
     var marginBox = domGeom.getMarginBox(domNode);
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.getMarginBox`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
     // Get the margin-box size of a node
     var marginBox = dojo.getMarginBox(domNode);
  });

Dojo < 1.7
----------

.. js ::
 
    // Get the margin-box size of a node
    var marginBox = geom.getMarginBox(domNode);
