#format dojo_rst

dojox.gfx.utils.serialize
=========================

:Authors: ?--
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Serialize the passed surface object to JavaScript Object form.

============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>

serialize() returns following objects:

* for a surface it returns an array of shapes.
* for a group it returns an object with a property "children", which contains an array of shapes.
* for a shape it returns an object with a property "shape", which contains a shape definition object.


========
Examples
========

Programmatic example
--------------------

TODO: example


========
See also
========

* `dojox.gfx.utils.deserialize <dojox/gfx/utils/deserialize>`_

  Rebuild the dojox.gfx.Surface object from the provided JS representation.

* `dojox.gfx.utils.toJson <dojox/gfx/utils/toJson>`_

  Serialize the passed surface object to JSON form

* `dojox.gfx.utils.toSvg <dojox/gfx/utils/toSvg>`_ 

  Serialize the passed surface object to SVG text.
