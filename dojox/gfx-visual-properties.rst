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

=============
Fill property
=============

A fill property is an object that defines how to fill a shape. It is not supported by an image and a group shapes.

By default all shapes are created with ``null`` fill meaning "no fill is performed". Complex shapes with self intersections (e.g., polygons), or disjoint parts (e.g. paths) are filled using the even-odd rule.

Four types of fills can be used.

Solid color fill
----------------

It is in effect when a color was specified as a fill property.

Linear gradient
---------------

Linear gradient defines a smooth transition between a set of colors (so-called "stops") on a line. Following properties are recognized:

type
  always ``"linear"``.

x1
  defines the ``X`` component of a start point of a linear gradient. Default: 0.

y1
  defines the ``Y`` component of a start point of a linear gradient. Default: 0.

x2
  defines the ``X`` component of an end point of a linear gradient. Default: 100.

y2
  defines the ``Y`` component of an end point of a linear gradient. Default: 100.

colors
  defines an array of stop objects, which have following structure:

    offset
      a number from 0 to 1, which defines a position of a color on our line. 0 corresponds to ``(x1, y1)`` point. 1 corresponds to ``(x2, y2)`` point. 0.5 will be directly in the middle of a line.

    color
      a color for this stop.

The colors member has a following default value: ``[{offset: 0, color: "black"}, {offset: 1, color: "white"}]``.

Radial gradient
---------------

Radial gradient defines a smooth transition between stops on a circle. Following properties are recognized:

type
  always ``"radial"``.

cx
  defines the ``X`` component of a center of a radial gradient. Default: 0.

cy
  defines the ``Y`` component of a center of a radial gradient. Default: 0.

r
  defines a radius of a radial gradient.

colors
  defines an array of stops in the same way as a linear gradient object. 0 corresponds to the center. 1 corresponds to the circle’s border. Defaults: ``[{offset: 0, color: "black"}, {offset: 1, color: "white"}]``.

Pattern
-------

Pattern defines an infinite tiling of an image. Following properties are recognized:

type
  always ``"pattern"``.

x
  defines the ``X`` component of an offset of a reference rectangle for an image. Default: 0.

y
  defines the ``Y`` component of an offset of a reference rectangle for an image. Default: 0.

width
  defines the width of a reference rectangle. Default: 0 --- *don’t forget to set it to the real value!*

height
  defines the height of a reference rectangle. Default: 0 --- *don’t forget to set it to the real value!*

src
  defines a URL of an image to be tiled.

An image will be fit into the defined reference rectangle using scaling.

Implementation details
----------------------

VML
~~~

VML renderer has following restrictions:

* Linear gradient should start and stop on a border of a shape. All other line definitions will be visually incompatible with the SVG implementation of the linear gradient.

* Radial gradient repeats the shape of an object. It means that the only way to define a compatible radial gradient for SVG and VML renderers is to define it from a center of a circle shape.

* Transparency (the alpha channel) is not supported for gradient fills.

SVG
~~~

SVG on Firefox 1.5-2.0 doesn’t support the pattern fill.

Canvas
~~~~~~

Canvas renderer doesn’t support the even-odd rule.
