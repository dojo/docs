#format dojo_rst

Visual properties
=================

:Status: Draft
:Version: 1.3
:Authors: Eugene Lazutkin, Kun Xi, Chris Mitchell
:Available: since 0.4

.. contents::
  :depth: 3

=====
Color
=====

Anywhere color is accepted following objects can be used to define it:

* A valid color name, like: ``"white"``, ``"black"``, ``"red"``, ``"green"``, ``"lime"``, ``"blue"``, ``"navy"``, ``"gray"``, ``"silver"``.

  If you want to support all CSS3 color names, don’t forget to require `dojo.colors <dojo/colors>`_ module, which provides all necessary CSS3 compatibility.

* A valid CSS color code, e.g., ``"#FF0000"`` or ``"#f00"``.

* An array of RGB or RGBA values, e.g, ``[255, 0, 0]`` or ``[255, 0, 0, 1.0]``.

* A valid `dojo.Color <dojo/Color>`_ object. Internally all other color definitions are converted to this object.
