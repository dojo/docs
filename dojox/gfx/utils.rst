.. _dojox/gfx/utils:

===============
dojox.gfx.utils
===============

:since: V1.0

.. contents ::
  :depth: 2

The *dojox.gfx.utils* module is a set of utility functions for working with dojox.gfx.Surface objects.  They mainly consist of serialization functions to allow you to serialize a dojox.gfx.Surface into a variety of forms, from GFX Objects, to JSON, to even SVG text across all browsers.


Provided functions
==================

* :ref:`dojox.gfx.utils.toJson <dojox/gfx/utils/toJson>`

  Serialize the passed surface object to JSON form

* :ref:`dojox.gfx.utils.fromJson <dojox/gfx/utils/fromJson>`

  Rebuild the dojox.gfx.Surface object from the provided JSON

* :ref:`dojox.gfx.utils.serialize <dojox/gfx/utils/serialize>`

  Serialize the passed surface object to JavaScript Object form

* `dojox.gfx.utils.deserialize`

  Rebuild the dojox.gfx.Surface object from the provided JS representation.

* :ref:`dojox.gfx.utils.toSvg <dojox/gfx/utils/toSvg>`

  Serialize the passed surface object to SVG text.

  **Note:** This function call is async on some browsers and returns a deferred object.
