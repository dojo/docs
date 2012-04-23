.. _dojo/dom-geometry:

=================
dojo/dom-geometry
=================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core dojo DOM geometry API. The convention for the return variable for this module is
``domGeom``.

Features
========

AMD Features
------------

* `domGeom.getPadExtents`

  Returns object with special values specifically useful for node fitting.

* `domGeom.getBorderExtents`

  Returns an object with properties useful for noting the border dimensions.

* `domGeom.getPadBorderExtents`

  Returns object with properties useful for box fitting with regards to padding.

* `domGeom.getMarginExtents`

  Returns object with properties useful for box fitting with regards to box margins (i.e., the outer-box).

* :ref:`domGeom.getMarginBox <dojo/getMarginBox>`

  Returns an object that encodes the width, height, left and top positions of the node's margin box.

* :ref:`domGeom.setMarginBox <dojo/setMarginBox>`

  Sets the size of the node's margin box and placement (left/top), irrespective of box model. Think of it as a
  passthrough to setBox that handles box-model vagaries for you.

* :ref:`domGeom.getContentBox <dojo/getContentBox>`

  Returns an object that encodes the width, height, left and top positions of the node's content box, irrespective of
  the current box model.

* :ref:`domGeom.setContentBox <dojo/setContentBox>`

  Sets the size of the node's margin box and placement (left/top), irrespective of box model. Think of it as a
  passthrough to setBox that handles box-model vagaries for you.

* :ref:`domGeom.setContentSize <dojo/setContentSize>`

  Sets the size of the node's contents, irrespective of margins, padding, or borders.

* `domGeom.isBodyLtr`

  Returns true if the current language is left-to-right, and false otherwise.

* `domGeom.docScroll`

  Returns an object with {node, x, y} with corresponding offsets.

* `domGeom.fixIeBiDiScrollLeft`

  In RTL direction, scrollLeft should be a negative value, but IE returns a positive one. All codes using
  documentElement.scrollLeft must call this function to fix this error, otherwise the position will offset to right when
  there is a horizontal scrollbar.

* :ref:`domGeom.position <dojo/position>`

  Gets the position and size of the passed element relative to the viewport (if includeScroll==false), or relative to
  the document root (if includeScroll==true).

* `domGeom.getMarginSize`

  returns an object that encodes the width and height of the node's margin box

* `domGeom.normalizeEvent`

  Normalizes the geometry of a DOM event, normalizing the pageX, pageY, offsetX, offsetY, layerX, and layerX properties

Supported legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Examples
========

The following example would return the margin box for a node:

.. js::

  require(["dojo/dom", "dojo/dom-geometry", "dojo/dom-style"], function(dom, domGeom, domStyle){
    var myNode = dom.byId("myNode");
    var computedStyle = domStyle.getComputedStyle(myNode);
    var marginBox = domGeom.getMarginBox(node, computedStyle);
  });

See also
========

.. api-link :: dojo.dom-geometry

