.. _dojox/gfx-visual-properties:

Shape properties
================

:Status: Draft
:Version: 1.3
:Authors: Eugene Lazutkin, Kun Xi, Chris Mitchell
:Available: since 0.4

.. contents::
  :depth: 3

============
Introduction
============

In general ``dojox.gfx`` is built on using duck-typing to specify any visual or geometric properties. You don't need to create objects of a special class, you just use objects with the right set of properties. If some properties are missing they will be copied from the predefined default object for this property.

For example, this is the default stroke object:

.. code-block :: javascript

  dojox.gfx.defaultStroke = {type: "stroke", color: "black", style: "solid", width: 1, cap: "butt", join: 4};

If you supply an object as the stroke, and some of its properties are missing, the missing properties will be copied from ``defaultStroke``. Example:

.. code-block :: javascript

  shape.setStroke({color: "#ff0", width: 3});

The effect will be the same as if we specified it like this:

.. code-block :: javascript

  shape.setStroke({type: "stroke", color: "#ff0", style: "solid", width: 3, cap: "butt", join: 4});

This rule works for strokes, linear and radial gradients, patterns and fonts.

If we want to use the default, we can do it like that:

.. code-block :: javascript

  shape.setStroke({});

But the most efficient way to do that is to pass ``null`` as a property value:

.. code-block :: javascript

  shape.setStroke(null);

Newly created shapes use ``null`` for all their visual and geometric properties effectively using all default property objects.

=====
Color
=====

Color is the fundamental property in HTML and graphics. Dojo handles colors as a part of the base. See details in :ref:`dojo.Color <dojo/Color>`. The additional module of :ref:`dojo.colors <dojo/colors>` adds CSS3 color goodies: a huge list of named colors, HSL color space, a grayscale helper.

Anywhere color is accepted following objects can be used to define it:

* A valid color name, like: ``"white"``, ``"black"``, ``"red"``, ``"green"``, ``"lime"``, ``"blue"``, ``"navy"``, ``"gray"``, ``"silver"``.

  If you want to support all CSS3 color names, don’t forget to require :ref:`dojo.colors <dojo/colors>` module.

* A valid CSS color code, e.g., ``"#FF0000"`` or ``"#f00"``.

* An array of RGB or RGBA values, e.g, ``[255, 0, 0]`` or ``[255, 0, 0, 1.0]``.

* A valid :ref:`dojo.Color <dojo/Color>` object. Internally all other color definitions are converted to this object.

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

This is the definition of the default stroke from ``/dojox/gfx/_base.js``:

.. code-block :: javascript

  dojox.gfx.defaultStroke = {type: "stroke", color: "black", style: "solid", width: 1, cap: "butt", join: 4};

As a convenience a stroke can be defined by specifying a color as a string:

.. code-block :: javascript

  shape.setStroke("black");

It is equivalent to:

.. code-block :: javascript

  shape.setStroke({color: "black"});

Implementation details
----------------------

Canvas
~~~~~~

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

=============
Font property
=============

Text shapes (Text and TextPath) require a font in order to be rendered. A font description follows familiar CSS conventions. Following properties of font are recognized:

style
  the same as the CSS ``font-style`` property: ``"normal"``, ``"italic"``, ``"oblique"``. Default: ``"normal"``.

variant
  the same as the CSS ``font-variant`` property: ``"normal"``, ``"small-caps"``. Default: ``"normal"``.

weight
  the same as the CSS ``font-weight`` property: ``"normal"``, ``"bold"``, ``"bolder"``, ``"lighter"``, 100, 200, 300, 400, 500, 600, 700, 800, 900. Default: ``"normal"``.

size
  the same as the CSS ``font-size`` property. Default: ``"10pt"``.

family
  a string which defines a font family. Default: ``"serif"``.

There is a useful shortcut: you can specify a font using a string similar to the CSS font property.

Implementation notes
--------------------

VML
~~~

IE7 broke a lot of VML stuff. The family property doesn’t work in IE7 at the moment but does work in IE6. IE7 uses Arial always. Unfortunately there is no workaround for that.

Silverlight
~~~~~~~~~~~

Silverlight has following restrictions:

* ``style``: only ``"normal"`` and ``"italic"`` are supported, all other values are interpreted as ``"normal"``.

* ``variant``: ignored.

* ``weight``: ``"normal"`` is implemented as 400, ``"bold"`` is 700, ``"bolder"`` and ``"lighter"`` are not supported.

* ``size``: fully supported.

* ``family``: ``"serif"`` and ``"times"`` are substituted by ``"Times New Roman"``, ``"sans-serif"`` and ``"helvetica"`` are substituted by ``"Arial"``, ``"monotone"`` and ``"courier"`` are substituted by ``"Courier New"``, the rest is passed unchanged and will be interpreted by the underlying Silverlight renderer.

Canvas
~~~~~~

Canvas doesn’t implement text and, consequently, font definitions.
