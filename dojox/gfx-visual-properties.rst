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

===============
Stroke property
===============

A stroke property is an object that defines how to draw an outline of a shape. It is not supported by an image and a group shapes. Following properties are recognized:

color
  defines a color of an outline. Default: ``"black"``.

style
  defines a dash pattern. Accepted values: ``"Solid"``, ``"ShortDash"``, ``"Short-Dot"``, ``"ShortDashDot"``, ``"ShortDashDotDot"``, ``"Dot"``, ``"Dash"``, ``"Long-Dash"``, ``"DashDot"``, ``"LongDashDot"``, ``"LongDashDotDot"``, and ``"none"`` (the same as ``"Solid"``). These values have been modeled after VML’s ``dashStyle`` parameter, and behave similarly (dash pattern is specified in terms of line width).

width
  defines a width of a stroke in pixels. It should be a positive number. Default: 1.

cap
  defines a shape of opening and closing of a line. Accepted values: ``"butt"``, ``"round"``, ``"square"`` (see the definition of ``stroke-linecap`` in `SVG 1.1 stroke properties <http://www.w3.org/TR/SVG/painting.html#StrokeProperties>`_ for details). Default: ``"butt"``.

join
  defines a shape of joints. Accepted values: ``"round"``, ``"bevel"``, or a positive number. In case of a number a ``"miter"`` style is used with the number defining a miter limit (see the definitions of ``stroke-linejoin`` and ``stroke-miterlimit`` in `SVG 1.1 stroke properties <http://www.w3.org/TR/SVG/painting.html#StrokeProperties>`_ for details). Default: 4.

By default all shapes are created with null stroke meaning “no stroke is performed”.

Stroke can be defined by specifying a color as a string: ``shape.setStroke("black")`` is equivalent to ``shape.setStroke({color: "black"})``.

Implementation details
----------------------

Canvas ignores the line style. All lines are drawn solid.
