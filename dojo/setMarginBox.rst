.. _dojo/setMarginBox:

=================
dojo.setMarginBox
=================

.. contents ::
   :depth: 2

Sets the size of the node's margin box and placement (left/top), irrespective of box model. Think of it as a passthrough to setBox that handles box-model vagaries for you.

Introduction
============

The dojo.setMarginBox function is used to set the size of the node's margin box and placement (left/top), irrespective of box model.

Since Dojo 1.7, ``dojo.setMarginBox`` is exposed via the ``setMarginBox`` method of the ``dojo/dom-geometry`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
  
 // Dojo 1.7+ (AMD)
 require(["dojo/dom-geometry"], function(domGeom){
   domGeom.setMarginBox(node, box, computedStyle);
 });
 
 // Dojo < 1.7
 dojo.setMarginBox(node, box, computedStyle);

node
  DOMNode

box
  hash with optional "l", "t", "w", and "h" properties for "left", "right", "width", and "height" respectively. All specified properties should have numeric values in whole pixels.

computedStyle
  This parameter accepts computed styles object. If this parameter is omitted, the functions will call dojo.getComputedStyle to get one. It is a better way, calling dojo.computedStyle once, and then pass the reference to this computedStyle parameter. Wherever possible, reuse the returned object of dojo.getComputedStyle.

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``setMarginBox`` is accessed from the ``dojo/dom-geometry`` module.

.. js ::
 
  require(["dojo/dom-geometry"], function(domGeom){
    // Set domNode margin-box to 300px x 150px
    domGeom.setMarginBox(domNode, {w: 300, h: 400});
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.setMarginBox`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
    // Set domNode margin-box to 300px x 150px
    dojo.setMarginBox(domNode, {w: 300, h: 400});
  });

Dojo < 1.7
----------

.. js ::
 
    // Set domNode margin-box to 300px x 150px
    dojo.setMarginBox(domNode, {w: 300, h: 400});
