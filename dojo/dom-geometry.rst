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

Support for *deprecated* legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Features
========

Because ``dom-geometry`` is a large module, the documentation of the features has been broken up into several pages.
Please see the following pages for each of the following features.

* :ref:`dojo/dom-geometry::position() <dojo/dom-geometry/position>`

  Gets the position and size of the passed element relative to the viewport (if ``includeScroll==false``), or relative
  to the document root (if ``includeScroll==true``).

* :ref:`dojo/dom-geometry::getMarginBox() <dojo/dom-geometry/getMarginBox>`

  Returns an object that encodes the width, height, left and top positions of the node's margin box.

* :ref:`dojo/dom-geometry::setMarginBox() <dojo/dom-geometry/setMarginBox>`

  Sets the size of the node's margin box and placement (left/top), irrespective of box model. Think of it as a
  passthrough to setBox that handles box-model vagaries for you.

* :ref:`dojo/dom-geometry::getContentBox() <dojo/dom-geometry/getContentBox>`

  Returns an object that encodes the width, height, left and top positions of the node's content box, irrespective of
  the current box model.

* :ref:`dojo/dom-geometry::setContentSize() <dojo/dom-geometry/setContentSize>`

  Sets the size of the node's contents, irrespective of margins, padding, or borders.

* :ref:`dojo/dom-geometry::getPadExtents() <dojo/dom-geometry/getPadExtents>`

  Returns object with special values specifically useful for node fitting.

* :ref:`dojo/dom-geometry::getBorderExtents() <dojo/dom-geometry/getBorderExtents>`

  Returns an object with properties useful for noting the border dimensions.

* :ref:`dojo/dom-geometry::getPadBorderExtents() <dojo/dom-geometry/getPadBorderExtents>`

  Returns object with properties useful for box fitting with regards to padding.

* :ref:`dojo/dom-geometry::getMarginExtents() <dojo/dom-geometry/getMarginExtents>`

  Returns object with properties useful for box fitting with regards to box margins (i.e., the outer-box).

* :ref:`dojo/dom-geometry::isBodyLtr() <dojo/dom-geometry/isBodyLtr>`

  Returns true if the current language is left-to-right, and false otherwise.

* :ref:`dojo/dom-geometry::normalizeEvent() <dojo/dom-geometry/normalizeEvent>`

  Normalizes the geometry of a DOM event.

* :ref:`dojo/dom-geometry::docScroll() <dojo/dom-geometry/docScroll>`

  Returns an object with {node, x, y} with corresponding offsets.

* :ref:`dojo/dom-geometry::fixIeBiDiScrollLeft() <dojo/dom-geometry/fixIeBiDiScrollLeft>`

  In RTL direction, scrollLeft should be a negative value, but IE returns a positive one. All codes using
  documentElement.scrollLeft must call this function to fix this error, otherwise the position will offset to right when
  there is a horizontal scrollbar.

* :ref:`dojo/dom-geometry::getMarginSize() <dojo/dom-geometry/getMarginSize>`

  Returns an object that encodes the width and height of the node's margin box

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API Library

* :ref:`dojo/dom-construct <dojo/dom-construct>` - Dojo DOM Construction Library
