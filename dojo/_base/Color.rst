#format dojo_rst

dojo._base.Color
================

:Status: Draft
:Version: 1.0
:Authors: Marcus Reimann
:Developers: Eugene Lazutkin, Adam Peller, Alex Russell
:Available: since V?

.. contents::
    :depth: 2


**dojo._base.Color** contains functions for setting Colors.

As with all dojo._base components, this functions are included within Dojo Base. You get this functionality by just including dojo.js or dojo.xd.js in your page.


========
Features
========

* dojo.Color.named

  An array of named Colors.

* dojo.blendColors

  blend colors end and start with weight from 0 to 1, 0.5 being a 50/50 blend, can reuse a previously allocated dojo.Color object for the result

* dojo.colorFromRgb

  get rgb(a) array from css-style color declarations

* dojo.colorFromHex

  converts a hex string with a '#' prefix to a color object. Supports 12-bit #rgb shorthand.

* dojo.colorFromArray

  builds a color from 1, 2, 3, or 4 element array

* dojo.colorFromString

  parses str for a color value
