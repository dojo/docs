#format dojo_rst

dojo.colors
===========

A module which augments the base `dojo.Color <dojo/Color>`_ class with additional methods and named colors. This is not included in base ``dojo.js`` by default for size reasons. 

methods
=======

New methods are provided by this module.

:dojo.colors.makeGrey:
  creates a greyscale color with an optional alpha

:dojo.colorFromRgb:
  get the rgb(a) array from css-style color declarations

mixins
======

In addition to providing some color-specific functionality, the dojo.colors module mixes all named css3 colors and SVG 1.0 variant spellings into dojo.Colors.named, such as `aliceblue`, `azure` and so on.

See Also:
=========

* `dojo.Color <dojo/Color>`_
