#format dojo_rst

dojox.gfx.utils
===============

:Available: since V1.0

.. contents::
  :depth: 2

The *dojox.gfx.utils* module is a set of utility functions for working with dojox.gfx.Surface objects.  They mainly consist of serialization functions to allow you to serialize a dojox.gfx.Surface in to a variety of forms, from GFX Objects, to JSON, to even SVG text across all browsers.


==================
Provided functions
==================

* `dojox.gfx.utils.toJson <dojox/gfx/utils/toJson>`_

  Serialize the passed surface object to JSON form

* `dojox.gfx.utils.fromJson <dojox/gfx/utils/fromJson>`_

  Rebuild the dojox.gfx.Surface object from the provided JSON

* `dojox.gfx.utils.serialize <dojox/gfx/utils/serialize>`_

  Serialize the passed surface object to JavaScript Object form

* `dojox.gfx.utils.deserialize <dojox/gfx/utils/deserialize>`_

  Rebuild the dojox.gfx.Surface object from the provided JS representation.

* `dojox.gfx.utils.toSvg <dojox/gfx/utils/toSvg>`_ 

  Serialize the passed surface object to SVG text.

  **Note:** This function call is async on some browsers and returns a deferred object.
