.. _dojo/getContentBox:

==================
dojo.getContentBox
==================

.. contents ::
   :depth: 2

Returns an object that encodes the width, height, left and top positions of the node's content box, irrespective of the current box model.

Introduction
============

The dojo.getContentBox function is used to obtain an object that encodes the width, height, left and top positions of the node's content box, irrespective of the current box model.

Since Dojo 1.7, ``dojo.getContentBox`` is exposed via the ``getContentBox`` method of the ``dojo/dom-geometry`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
  
 // Dojo 1.7+ (AMD)
 require(["dojo/dom-geometry"], function(domGeom){
   domGeom.getContentBox(node, computedStyle);
 });
 
 // Dojo < 1.7
 dojo.getContentBox(node, computedStyle);

node
  DOMNode

computedStyle
  This parameter accepts computed styles object. If this parameter is omitted, the functions will call dojo.getComputedStyle to get one. It is a better way, calling dojo.computedStyle once, and then pass the reference to this computedStyle parameter. Wherever possible, reuse the returned object of dojo.getComputedStyle.

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``getContentBox`` is accessed from the ``dojo/dom-geometry`` module.

.. js ::
 
  require(["dojo/dom-geometry"], function(domGeom){
     // Get the content-box size of a node
     var contentBox = domGeom.getContentBox(domNode);
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.getContentBox`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
     // Get the content-box size of a node
     var contentBox = dojo.getContentBox(domNode);
  });

Dojo < 1.7
----------

.. js ::
 
    // Get the content-box size of a node
    var contentBox = geom.getContentBox(domNode);
