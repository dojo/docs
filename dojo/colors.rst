.. _dojo/colors:

===========
dojo.colors
===========

.. contents ::
    :depth: 2

A module which augments the base :ref:`dojo/_base/Color <dojo/_base/Color>` class with additional methods and named
colors. This is not included in base Dojo by default for size reasons.

Methods
=======

New methods are provided by this module.

:dojo.colors.makeGrey:
  creates a greyscale color with an optional alpha

:dojo.colorFromRgb:
  get the rgb(a) array from css-style color declarations

Mixins
======

In addition to providing some color-specific functionality, the dojo.colors module mixes all named css3 colors and SVG 
1.0 variant spellings into dojo.Colors.named, such as `aliceblue`, `azure` and so on.

The module also adds a `sanitize` method to dojo.Color.prototype. This method ensures the Color object has the correct 
attributes, and are valid.

See Also
========

* :ref:`dojo/_base/Color <dojo/_base/Color>`
