.. _dojo/setContentSize:

===================
dojo.setContentSize
===================

.. contents ::
   :depth: 2

Sets the size of the node's contents, irrespective of margins, padding, or borders.

Introduction
============

The dojo.setContentSize function is used to set the size of the node's contents, irrespective of margins, padding, or borders.

Since Dojo 1.7, ``dojo.setContentSize`` is exposed via the ``setContentSize`` method of the ``dojo/dom-geometry`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
  
 // Dojo 1.7+ (AMD)
 require(["dojo/dom-geometry"], function(domGeom){
   domGeom.setContentSize(node, box, computedStyle);
 });
 
 // Dojo < 1.7
 dojo.setContentSize(node, box, computedStyle);

node
  DOMNode

box
  hash with optional "w", and "h" properties for "width", and "height" respectively. All specified properties should have numeric values in whole pixels.

computedStyle
  This parameter accepts computed styles object. If this parameter is omitted, the functions will call dojo.getComputedStyle to get one. It is a better way, calling dojo.computedStyle once, and then pass the reference to this computedStyle parameter. Wherever possible, reuse the returned object of dojo.getComputedStyle.

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``setContentSize`` is accessed from the ``dojo/dom-geometry`` module.

.. js ::
 
  require(["dojo/dom-geometry"], function(domGeom){
     // Set domNode content-box to 300px x 150px
     domGeom.setContentSize(domNode, {w: 300, h: 400});
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.setContentSize`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
     // Set domNode content-box to 300px x 150px
     dojo.setContentSize(domNode, {w: 300, h: 400});
  });

Dojo < 1.7
----------

.. js ::
 
    // Set domNode content-box to 300px x 150px
    dojo.setContentSize(domNode, {w: 300, h: 400});
