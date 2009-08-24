#format dojo_rst

dojox.gfx.utils
===============

:Status: Contributed, Draft
:Version: 1.4
:Author: Eugene Lazukin, Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

The "dojox.gfx.utils" module is a set of utility functions for working with dojox.gfx.Surface objects.  They mainly consist of serialization functions to allow you to serialize adojox.gfx.Surface in to a variety of forms, from GFX Objects, to JSON, to even SVG text across all browsers.

Provided functions
==================

* dojox.gfx.utils.toJson(surface)
  * Serialize the passed surface object to JSON form
* dojox.gfx.utils.fromJson(surface, json)
  * Rebuild the dojox.gfx.Surface object from the provided JSON
* dojox.gfx.utils.serialize(surface)
  * Serialize the passed surface object to JavaScript Object form
* dojox.gfx.utils.deserialize(surface, jsGfx)
  * Rebuild the dojox.gfx.Surface object from the provided JS representation.
* dojox.gfx.utils.toSvg(surface)
  * Serialize the passed surface object to SVG text.  **Note:** This function call returns a deferred as serialization is async on some browsers.
