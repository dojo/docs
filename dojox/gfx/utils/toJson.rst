#format dojo_rst

dojox.gfx.utils.toJson
======================

:Status: Contributed, Draft
:Version: 1.4
:Author: Eugene Lazukin, Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

The *dojox.gfx.utils.toJson* is a helper function designed to serialize a dojox.gfx.Surface object into a JSON representation for sa variety of scenarios, such as sending it across the wire to save, using it to copy a surface, and so on.  The function itself is simple to use.  

=====
Usage
=====

If you wish to use this function, then your code must do a *dojo.require("dojox.gfx.utils");* to load it.  

The function signature is:
   *dojox.gfx.utils.toJson(/*dojox.gfx.Surface*/ surface);

So basic usage is:

.. code-block :: javascript

  var json = dojox.gfx.utils.toJson(mySurface);





* `dojox.gfx.utils.toJson <dojox/gfx/utils/toJson>`_
  -- Serialize the passed surface object to JSON form
* **dojox.gfx.utils.fromJson**
  -- Rebuild the dojox.gfx.Surface object from the provided JSON
* **dojox.gfx.utils.serialize**
  -- Serialize the passed surface object to JavaScript Object form
* **dojox.gfx.utils.deserialize**
  -- Rebuild the dojox.gfx.Surface object from the provided JS representation.
* `dojox.gfx.utils.toSvg <dojox/gfx/utils/toSvg>`_ 
  -- Serialize the passed surface object to SVG text.  **Note:** This function call returns a deferred as serialization is async on some browsers.
