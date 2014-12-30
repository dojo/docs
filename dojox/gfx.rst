.. _dojox/gfx:

=========
dojox.gfx
=========

:Authors: Eugene Lazutkin, Kun Xi, Chris Mitchell, Patrick Ruzand

.. contents ::
  :depth: 3

Overview
========

dojox.gfx (GFX) is a cross-platform vector graphics API. It loosely follows SVG as the underlying model. GFX helps to isolate your application from the many native vector graphics implementation differences across all modern Browsers. It does this by detecting the best graphics engine implementation for the Browser that the application is running on, and providing api's that are the same across the various implementations. By using the GFX api's, your application can use a set of api's that don't lock you into any one particular browser (or plugin's) implementation of vector graphics.

Renderer Options
----------------

As of Dojo 1.8, the following native vector graphics engine adaptations are implemented:

* SVG (Firefox 1.5-3.0, Safari(Webkit) 3+, Opera 9+, Chrome 1.0+, iPhone Safari 2.1+
* VML (IE 6-7-8)
* Silverlight (wherever it is supported by Microsoft)
* Canvas (Firefox 3.0+, Safari 3.0+ including iOS Safari 1.0+), Opera 9.0+, Chrome, IE9+

Development of a new experimental renderer which uses `SVGWeb <http://code.google.com/p/svgweb/>`_ is also `underway <http://trac.dojotoolkit.org/ticket/9948>`_.

Other renderer adaptations could be implemented as well underneath these api's. For example, a Flash player implementation can be built that plugs in under the GFX api's (perhaps using dojox.flash as it's bridge interface). If you're interested in contributing other implementations, please let us know.

Note that SVG & VML are "live" DOM scene graphs; whereas Canvas is an immediate mode procedural API. When Canvas is used under gfx, you gain the benefits that come with having a live scene graph (plus you can still drop down and access pixel data from the Canvas if you need to). These benefits include being able to move groups of objects around a picture and responding to events on Shapes.

Core Concepts
-------------

On a conceptual level dojox.gfx has a simple declarative model.


Every visual presentation created with Dojo GFX begins by creating a **Surface** object which will serve as the visual rectangular container for shapes.  Because Surface contains the shapes that will be drawn, it also has in common the capabilities of **Group** nodes (see below).

**IMPORTANT:** Under the covers, Surface objects are associated with a particular rendering implementation that's in use in the current environment to perform all the graphics operations.  Some kinds of graphics renderer implementations require additional time for them to be initialized, and they may not be immediately ready after they are created.  For this reason, Surface provides an important callback registration function that must ALWAYS be used for registering all your graphics manipulation code, **whenLoaded(your callback function here)**.  When a Surface implementation is ready to allow drawing on its surface (asynchronously), it will execute the functions registered via whenLoaded().  Think of this working similar to dojo.ready(), but instead of the Document being initialized asynchronously, it's the Surface object in this case.  There are several interesting characteristics of Surface objects, including:

* A web page can have several surfaces defined.

* Each surface has its own local coordinate system:

  * (0, 0) point is in the left-top corner, where the X axis is horizontal pointing right, and the Y axis is vertical pointing down.

  * Positive direction of rotation is defined as clockwise (CW).

* All shapes are clipped on the surface boundaries.

* By default the background of a surface is transparent.

In order to draw on a **Surface**, you'll need to create **Shape** objects and attach the shapes to a **Surface**, at which time they will be rendered.  This style of graphics api is known as a "retained mode" graphics system.  Shapes that you've attached into a surface create a graph of objects forming the scene to be rendered.  You can manipulate the shapes in the scene graph at any time later, in addition to being notified when a user interacts with the shapes in the scene via Events.  **Shape** objects encapsulate a simple description of geometry and stylistic properties of a given shape, and there are several predefined shape types supported by dojox.gfx to get you started drawing quickly:

* Rectangle (optionally with rounded corners)

* Circle

* Ellipse

* Line

* Polyline/polygon

* Path (the most versatile shape) Path implements the full SVG path language.

* Image

* Text

* TextPath (experimental)

Shapes support two types of properties:

  *Geometric* properties:

  * Shape description (shape-specific).

  * Linear transformation specified by 3 x 3 2D matrix.

  * Font (only for text shapes).

  *Visual* properties (not supported by the Image shape):

  * Stroke (outline of a shape).

  * Fill (interior of a shape).

Shapes are stacked from bottom to top in the order they are added. This z-order can be changed dynamically after a shape has been added using functions on Shape such as moveToFront().

In addition, all the basic graphics primitives required for 2D graphics are provided, including:

* 2D coordinates
* 2D linear transformation matrices
* Colors

Note that Dojo GFX operates as a high-level "retained mode" graphics system, even when running on top of lower-level rendering implementations that may not operate in retained mode, such as Canvas, which is an immediate mode graphics api.  This allows scenes to be manipulated and for your application code to be easily notified of user interactions via events in the same way as when working with retained mode graphics implementations (although at the cost of having to keep the scene graph objects around).

Groups
------

Gfx also has the concept of a **Group**, which is a pseudo-shape. Groups combine other shapes (which can include other groups), and can be used to apply transformation to a group.

All group members share a single z-order, but can be re-arranged within a group.
In order to draw a picture a programmer constructs a pseudo-DOM from a surface object, shapes, and groups, sets appropriate attributes, and a picture is drawn automatically by a browser. Modifications of shapes change picture automatically.

Conventions
-----------

The following conventions are used:

While a **Path** is the most universal geometric shape which can emulate almost all other shapes (exceptions: Image, and Text shapes), all frequently-used shapes are provided as a convenience: Rectangle (with optional round corners), Circle, Ellipse, Line, Polyline/Polygon.
All shape description properties are defined using a duck-typing technique, and incomplete shape description definitions are supported. All missing members will be taken from the corresponding default shape definition listed in common.js or from the current shape description object.

Example:

.. js ::

  rect.setShape({width: 200})

In the above example, all missing members will be taken from dojox.gfx.defaultRect object making it equivalent to:

.. js ::

  rect.setShape({x: 0, y: 0, width: 200, height: 100, r: 0}).

All shape description objects and visual property objects have a member called "type", which uniquely identifies a property type. This is a provision for a serialization.

All methods without an apparent return type return their object itself. It is used for chaining multiple operations.

Example:

.. js ::

  surface.createRect({x: 100, y: 50}).setFill("red").setStroke("blue");

Shape Properties: Colors, Strokes, Fills & Fonts
================================================

Color
-----

Anywhere color is accepted following objects can be used to define it:

* A valid color name, like: "white", "black", "red", "green", "lime", "blue", "navy", "gray", "silver".
  If you want to support all CSS3 color names, don't forget to require dojo.colors module, which provides all necessary CSS3 compatibility.

* A valid CSS color code, e.g., "#FF0000" or "#f00".

* An array of RGB or RGBA values, e.g, [255, 0, 0] or [255, 0, 0, 1.0].

* A valid dojo.Color object. Internally all other color definitions are converted to this object.

Stroke property
---------------

A stroke property is an object that defines how to draw an outline of a shape. It is not supported by an image and a group shapes. Following properties are recognized:

+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| **Attribute**  | **Expected Value**                      | **Description**                                                               | **Since** |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| color          | SVG color value (string)                |Defines a color of an outline. Default: "black".                               | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| style          | "Solid"                                 | Defines a dash pattern.                                                       | 1.0       |
|                | "ShortDash"                             | These values have been modeled after VML's dashStyle parameter,               |           |
|                | "ShortDot"                              | and behave similarly (dash pattern is specified in terms of line width).      |           |
|                | "ShortDashDot"                          | "none" is the same as "Solid"                                                 |           |
|                | "ShortDashDotDot"                       |                                                                               |           |
|                | "Dot"                                   |                                                                               |           |
|                | "Dash"                                  |                                                                               |           |
|                | "LongDash"                              |                                                                               |           |
|                | "DashDot"                               |                                                                               |           |
|                | "LongDashDot"                           |                                                                               |           |
|                | "LongDashDotDot"                        |                                                                               |           |
|                | "none"                                  |                                                                               |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| width          | positive number                         |Defines a width of a stroke in pixels. Default: 1                              | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| cap            | "butt"                                  | Defines a shape of opening and closing of a line.                             | 1.0       |
|                | "round"                                 | see SVG 1.1 'stroke-linecap' definition for details.                          |           |
|                | "square"                                | Default: "butt"                                                               |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| join           | "round"                                 | Defines a shape of joints.                                                    | 1.0       |
|                | "bevel"                                 | see SVG 1.1 'stroke-linejoin' definition and SVG 1.1 'stroke-miterlimit'      |           |
|                | positive number                         | When number, a "miter" style is used with the number defining a miter limit   |           |
|                |                                         | Default: 4                                                                    |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+

By default all shapes are created with "null" stroke meaning "no stroke is performed".

Stroke can be defined by specifying a color as a string:

.. js ::

  shape.setStroke("black")

is equivalent to

.. js ::

  shape.setStroke({color: "black"}).

Implementation note: From 1.9, Canvas supports the line style property using either the new HTML5 setLineDash() method if the browser implements it, or via a gfx custom implementation. In the latter case, the join and cap properties are ignored.

Fill property
-------------

A fill property is an object that defines how to fill a shape. It is not supported by an image and a group shapes.

Four types of fills can be used:

Solid color fill
  A single color has been specified as a fill property.

Linear gradient
  Defines a smooth transition between a set of colors (so-called "stops") on a line. Following properties are recognized:

+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| **Attribute**  | **Expected Value**                      | **Description**                                                               | **Since** |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| type           | "linear"                                |Always "linear"                                                                | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| x1             | number                                  |Define x start point of linear gradient. Defaults: 0                           | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| y1             | number                                  |Define y start point of linear gradient. Defaults: 0                           | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| x2             | number                                  |Define x end point of linear gradient. Defaults: 100                           | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| y2             | number                                  |Define y end point of linear gradient. Defaults: 100                           | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| colors         | array[Object]                           |Defines an array of stop objects.  See stop object properties below.           | 1.0       |
|                |                                         |Default: [{offset: 0, color: "black"}, {offset: 1, color: "white"}]            |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+

These are the properties of Stop objects (for LinearGradient.colors property array entries)

+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| **Attribute**  | **Expected Value**                      | **Description**                                                               | **Since** |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| offset         | number [0..1]                           |A number from 0 to 1 which defines a position of color on our line.            | 1.0       |
|                |                                         |0 corresponds to x1, y1 point                                                  |           |
|                |                                         |1 corresponds to x2, y2 point                                                  |           |
|                |                                         |0.5 corresponds to midpoint                                                    |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| color          | string (SVG color value)                |A color for this stop.                                                         | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+

Radial gradient
  Defines a smooth transition between stops on a circle. The following properties are recognized:

+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| **Attribute**  | **Expected Value**                      | **Description**                                                               | **Since** |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| type           | "radial"                                |Always "radial"                                                                | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| cx             | number                                  |Define x of center point. Defaults: 0                                          | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| cy             | number                                  |Define y of center point. Defaults: 0                                          | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| r              | positive number                         |Defines a radius of a radial gradient.                                         | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| colors         | array[Object]                           |Defines an array of stop objects.  See stop object properties above.           | 1.0       |
|                |                                         |Default: [{offset: 0, color: "black"}, {offset: 1, color: "white"}].           |           |
|                |                                         |offset of 0 corresponds to center of the circle.                               |           |
|                |                                         |offset of 1 corresponds to border of the circle.                               |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+

Pattern
  Defines an infinite tiling of an image. The following properties are recognized:

+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| **Attribute**  | **Expected Value**                      | **Description**                                                               | **Since** |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| type           | "pattern"                               |Always "pattern"                                                               | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| x              | number                                  |Define x of offset of a reference rectangle for an image. Defaults: 0          | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| y              | number                                  |Define y of offset of a reference rectangle for an image. Defaults: 0          | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| width          | positive number                         |Defines width of the reference rectangle that the image will be scaled to.     | 1.0       |
|                |                                         |Defaults: 0                                                                    |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| height         | positive number                         |Defines height of the reference rectangle that the image will be scaled to.    | 1.0       |
|                |                                         |Defaults: 0                                                                    |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| src            | string (url)                            |Defines a URL of the image to be tiled.                                        | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+

By default all shapes are created with "null" fill meaning "no fill is performed".
Complex shapes with self intersections (e.g., polygons), or disjoint parts (e.g. paths) are filled using the even-odd rule.

Implementation details
~~~~~~~~~~~~~~~~~~~~~~

The VML renderer has following restrictions:

  Linear gradient
    Should start and stop on a border of a shape.

    All other line definitions will be visually incompatible with the SVG implementation of the linear gradient.

  Radial gradient
    Repeats the shape of an object.

    It means that the only way to define a compatible radial gradient for SVG and VML renderers is to define it from a center of a circle shape.

  Transparency (the alpha channel)
    Is not supported for gradient fills.

SVG (Firefox 1.5-2.0)
  Doesn't support the pattern fill.

Canvas
  Doesn't support the even-odd rule.

Font property
-------------

Text shapes (Text and TextPath) require a font in order to be rendered. A font description follows familiar CSS conventions.
The following properties of Font are recognized:

+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| **Attribute**  | **Expected Value**                      | **Description**                                                               | **Since** |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| style          | "normal","italic","oblique"             |Same as the CSS font-style property.   Default: "normal"                       | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| variant        | "normal","small-caps"                   |Same as the CSS font-variant property.   Default: "normal"                     | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| weight         | "normal","bold","bolder","lighter",     |Same as the CSS font-weight property.   Default: "normal"                      | 1.0       |
|                | 100,200,300,400,500,600,700,800,900     |                                                                               |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| size           | css font size value                     |A numeric CSS length constant with a unit abbreviation. Default: "10pt"        | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| family         | css font family value                   |Same as the CSS font-family property.   Default: "serif"                       | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+

There is also a useful shortcut: you can specify a font using a string similar to the CSS font property.

Implementation notes
~~~~~~~~~~~~~~~~~~~~

IE7
  Broke many VML features.

  For example, the family property doesn't work in IE7 at the moment but does work in IE6.

  IE7 uses Arial always. Unfortunately there is no workaround for that.

Silverlight has the following restrictions:
  style
    Only "normal" and "italic" are supported, all other values are interpreted as "normal".
  variant
    Ignored
  weight
    "normal" is implemented as 400, "bold" is 700.
  size
    fully supported.
  family
    "serif" and "times" are substituted by "Times New Roman",

    "sans-serif" and "helvetica" are substituted by "Arial",

    "monotone" and "courier" are substituted by "Courier New",

  The rest is passed unchanged and will be interpreted by the underlying Silverlight renderer.

By default all shapes are created with "null" font meaning "the default".

Coordinates and Transformations
===============================

Linear transformations are a very important part of any graphics library. We deal with 2D graphics, and we operate with 3 by 3 matrices:

::

  xx xy dx
  yx yy dy
  0  0  1

Because the third row is always constant we use an abbreviated way to write it: {xx: 1, xy: 0, yx: 0, yy: 1, dx: 0, dy: 0} - this is an identity matrix. The same simplification goes for coordinates:

::

  x
  y
  1

Because the third element is always 1 we "add" it virtually: {x: 12, y: 33}. The result of application of a matrix to a vector is predictable:

::

  xx * x + xy * y + dx
  yx * x + yy * y + dy

(The dummy third "coordinate" is skipped in the above example).

In order to understand transformations you need to be familiar with fundamentals of matrices (matrix multiplication, multiplication of a vector by a matrix, order of multiplications). dojox.gfx uses a mnemonic way to describe a matrix: xx scales an X component of a coordinate, yy scales a Y component, xy, and yx affect both components, dx moves an X component, and dy moves a Y component.

Simple examples
---------------

Stretch the X dimension by 2:

.. js ::

  {xx: 2}

Stretch the Y dimension by 0.5 (reduces by 2):

.. js ::

  {yy: 0.5}

Shift an X coordinate by 5, a Y coordinate by 10:

.. js ::

  {dx: 5, dy: 10}

More complex examples
---------------------

Rotate everything by 30 degrees clockwise (CW) around point (0, 0):

.. js ::

  {xx: 0.866, xy: 0.5, yx: -0.5, yy: 0.866}

Rotate everything by 90 degrees CW around (0, 0), and moves things right by 100:

.. js ::

  {xx: 0, xy: 1, yx: -1, yy: 0, dx: 100}

Don't worry, in most cases you don't need to calculate all members of a transformation matrix directly. As you can see not all members of matrix should be specified - all skipped members going to be copied from the identity matrix. There is a shortcut for scaling - if a number N is used instead of a matrix, it is assumed that it represents a uniform scaling matrix {xx: N, yy: N}.

The way to apply a matrix to a coordinate:

::

  o = M * i

Where, i is an input vector (e.g., {x: 1, y: 2}), M is a transformation matrix, o is a resulting vector, and * denotes a multiplication operation.

Combining Transformation Matrices
---------------------------------

Transformations can be combined together as follows:

::

  A * B * C * p == (A * B) * C * p == A * (B * C) * p == (A * B * C) * p == A * B * (C * p), ...

Where A, B, and C are transformation matrices, p is a coordinate vector, and * is a multiplication operation.
The result of all these calculations is the same final coordinate.
Effectively all transformations are always applied from right to left sequentially, and they can be combined producing a matrix,
which defines a complex transformation.
dojox.gfx.matrix defines Matrix2D class, as well as numerous helpers (Matrix2D is propagated to dojox.gfx namespace for convenience).
Most important of them (all in dojox.gfx.matrix namespace) are listed below.
In all signatures a, b, c, and e are numbers (coordinate components or scaling factors),
p is a 2D coordinate, r is an angle in radians, d is an angle in degrees (positive value of an angle is CW), m is a matrix.

Transformation Constants
------------------------

identity
  A constant, which defines an identity matrix. This matrix doesn't change a picture at all.

flipX
  A constant matrix, which changes a sign of all X coordinates. This matrix mirrors the picture around the Y axis.

flipY
  A constant matrix, which changes a sign of all Y coordinates. This matrix mirrors the picture around the X axis.

flipXY
  A constant matrix, which changes a sign of all coordinates.

  This matrix rotates the picture by 180 degrees around (0, 0) point.

  In other words, it mirrors all points around (0, 0).

Matrix Creation
---------------

translate(a, b), translate(p)
  Translates its child shapes:

  by {dx: a, dy: b}

  by {dx: p.x, dy: p.y}

scale(a, b), scale(a), scale(p)
  Scales its child shapes:

  by {xx: a, yy: b}

  by {xx: a, yy: a}

  by {xx: p.x, yy: p.y}

rotate(r), rotateg(d)
  Rotates the child shapes around (0, 0):

  by **r** radians

  by **d** degrees

skewX(r), skewXg(d)
  Skews the child shapes around (0, 0) in the X dimension:

  by **r** radians

  by **d** degrees

skewY(r), skewYg(d)
  Skews a picture around (0, 0) in the Y dimension:

  by **r** radians

  by **d** degrees

Useful Matrix Operations
------------------------

invert(m)
  Inverts a matrix. This useful function calculates a matrix, which will do the opposite transformation to the m matrix effectively undoing it.
  For example, scale(2) produces a matrix to scale uniformly a picture by 2. The opposite matrix is going to be scale(0.5).
  Note that we can produce the same result with invert(scale(2)).
  While it seems complicated for such a simple case, frequently it is the only way to calculate an inverted matrix
  for complex transformation, especially when we don't know how it was produced initially.

clone(m)
  Create a copy of the m matrix.

multiplyPoint(m, a, b), multiplyPoint(m, p)
  Apply a transformation to a coordinate.

multiplyRectangle(m, rect)
  Applies a matrix to a rectangle and returns the smallest rectangle enclosing the 4 transformed points.

multiply(m1, m2, ...)
  Multiply all parameters to create a single matrix.
  This function is extremely useful and there is a shortcut for it:
  anywhere a matrix is expected, an array of matrices can be specified as well.

Examples
~~~~~~~~

Rotate everything 45 degrees CW around (0, 0) and scales everything by 2 after that:

.. js ::

  [2, rotateg(45)]

Scale all X coordinates by 2, and moves the result down by 10:

.. js ::

  [{dy: 10}, scale(2, 1)]

More complex example
~~~~~~~~~~~~~~~~~~~~

Imagine you have a surface 500 by 500 pixels, and you want everything in it to be magnified around its center by 2, and rotated (around the center as well) by 30 degrees CW.

It is easy:

.. js ::

  [translate(250, 250), rotateg(-30), scale(2), translate(-250, -250)]

All scaling, rotating, and skewing operations work around (0, 0) point.
Let's begin by moving the center of our picture to (0, 0):

.. js ::

  translate(-250, -250).

Now we can scale it:

.. js ::

  scale(2)

Now we can rotate it:

.. js ::

  rotateg(-30)

Now let's move our center back:

.. js ::

  translate(250, 250)

You can see that this kind of transformations follow a "sandwich" pattern, where the first and the last transformation
move an immutable point to/from the origin of coordinates. These "around the point" operations are so important that
there are several helpers for common transformations.

Transformations Around a Point
------------------------------

scaleAt(a, p), scaleAt(a, b, c), scaleAt(a, b, p), scaleAt(a, b, c, e)
  scale(a) around (p.x, p.y)

  scale(a) around (b, c)

  scale(a, b) around (p.x, p.y)

  scale(a, b) around (c, e)

rotateAt(r, p), rotateAt(r, a, b), rotategAt(d, p), rotategAt(d, a, b)
  rotate(r) at (p.x, p.y)

  rotate(r) at (a, b)

  rotateg(d) at (p.x, p.y)

  rotateg(d) at (a, b)

skewXAt(r, p), skewXAt(r, a, b), skewXgAt(d, p), skewXgAt(d, a, b), skewYAt(r, p), skewYAt(r, a, b), skewYgAt(d, p), skewYgAt(d, a, b)
  skewX(r) at (p.x, p.y)

  skewX(r) at (a, b)

  skewXg(d) at (p.x, p.y)

  skewXg(d) at (a, b)

  skewY(r) at (p.x, p.y)

  skewY(r) at (a, b)

  skewYg(d) at (p.x, p.y)

  skewYg(d) at (a, b)

normalize(m)
  Returns a matrix in its canonical representation:

  normalize(2)

  normalize({dy: 5})

  normalize([scale(2), translate(100, 200)])

  The same effect can be achieved with creating a matrix directly:

  .. js ::

    new dojox.gfx.Matrix2D(m).

  By default all shapes are created with "null" matrix meaning "the identity transformation".

Common Shape Methods
====================

All shape objects support following methods:

getShape()/setShape(shape)
  Accesses an underlying shape description object. A group shape ignores this property.

getStroke()/setStroke(stroke)
  Accesses a stroke applied to a shape. Value of "null" means "do not stroke this shape". Image and group shapes ignore this property.

getFill()/setFill(fill)
  Accesses a fill applied to a shape. Value of "null" means "do not fill this shape". Image and group shapes ignore this property.

getTransform()/setTransform(matrix)
  Accesses a transformation matrix applied to a shape. Value of "null" means "the identity transformation".

applyRightTransform(matrix)/applyLeftTransform(matrix)
  Combines the existing matrix with new matrix. See "Transformation matrix" for details.

applyTransform(matrix)
  An alias for applyRightTransform(matrix). It is defined for convenience.

moveToFront()/moveToBack()
  Changes a z-order of a shape. It moves an object to the front or to the back respectively of its parent container (a surface or a group).

removeShape()
  Removes a shape from its parent container.

getParent()
  Accesses shape's parent container.

getBoundingBox()
  Returns a bounding box of a shape. A text shape is a point-based object, so it doesn't define a bounding box.

getTransformedBoundingBox()
  Returns four point array, which represents four corners of the bounding box transformed by all applicable transformations.

destroy()
  Clean up the internal resources used by this shape. This method must be called when the shape is not used anymore and should be removed from the gfx **scene** (not just its container). Once this method has been invoked, the shape must not be accessed anymore. See the "Destructors API" section for more information.

getUID()
  Returns the shape internal id.

Event processing
----------------

From 1.9, shapes and surface objects implement an on() method that matches the new dojo/on API. The previous connect() and disconnect() methods are deprecated. 

on(type, listener)
  Connects a listener to the specified event type on this shape/surface, and returns a token that can be used to remove the event listener from the event (see dojo/on for more information). The type parameter can either be a string (the event name, like "mousemove"), or function (aka an extension event type like dojo/touch.press).

connect(name, object, method)
  Deprecated. Connects an event processor to the event named "name" on this shape/surface, and returns a token for this connection.

disconnect(token)
  Deprecated. Disconnects the event processing.

See the api documentation of dojo/on for more details.

From 1.7, the gfx shape targeted by a mouse event can be retrieved from the event received in the handler via the event.gfxTarget property. For example:

  .. js ::

    group.on(“click”, function(e){ var s = e.gfxTarget; s.setFill(“red”); });

Implementation notes
~~~~~~~~~~~~~~~~~~~~

Shape-specific methods are used to hide the complexity of event handling for non-HTML DOM based renderers (e.g., Silverlight).

The 1.7 release introduces a new experimental canvas renderer with input event support. It is enabled by default when the gfxRenderer is set to ‘canvas’. In case you don’t want to use this new implementation but the legacy one, set the ‘canvasEvents’ property to false in the dojo config. For example:

  .. js ::

    dojoConfig: { canvasEvents:false, forceGfxRenderer:’canvas’ } will select the legacy canvas renderer implementation.

The new canvas renderer supports the following events: oncontextmenu, onclick, ondblclick, onmouseenter, onmouseleave, onmouseout, onmousedown, touchstart, mouseup, touchend, onmouseover, onmousemove, touchmove, keydown, keyup.

The implementation has the following limitations:

* because the canvas API does not have a DOM representation (like SVG), shape.getEventSource() returns the surface rawNode.
* events do not bubble beyond the surface node.
* the current hit testing implementation may have a performance cost depending on the number of shapes in the scene.

Silverlight supports following events: onclick, onmouseenter, onmouseleave, onmousedown, onmouseup, onmousemove, onkeydown, onkeyup.
If you want to target the broadest range of renderers, you are advised to restrict yourself to this list of events.

Clipping
--------

The 1.8 release introduces clipping support at shape level. A clipping area defines the shape area that will be effectively visible. Everything that would be drawn outside of the clipping area will not be rendered. The possible clipping area types are rectangle, ellipse, polyline and path (see below for renderer-specific limitations). 

The clip parameter defines the clipping area geometry, and should be an object with the following properties:
   * {x:Number, y:Number, width:Number, height:Number} for rectangular clip
   * {cx:Number, cy:Number, rx:Number, ry:Number} for ellipse clip
   * {points:Array} for polyline clip
   * {d:String} for a path clip.

The clip geometry coordinates are expressed in the coordinate system used to draw the shape. 	

The following example shows how to clip a gfx image with all the possible clip geometry: 

The image not clipped:

.. image :: ./gfx/noclip.PNG

Clipped by a rectangle: 

.. js ::

  surface.createImage({x:100,y:100, width:96, height:96, src:"html5.png"}).setClip({x:120, y:120, width:50,height:50});


.. image :: ./gfx/rectclip.PNG

Clipped by an ellipse:

.. js ::

  surface.createImage({x:100,y:100, width:96, height:96, src:"html5.png"}).setClip({cx:148, cy:148, rx:20, ry:50});

.. image :: ./gfx/ellipseclip.PNG

Clipped by a circle (using the ellipse geometry):

.. js ::

  surface.createImage({x:100,y:100, width:96, height:96, src:"html5.png"}).setClip({cx:148, cy:148, rx:30, ry:30});

.. image :: ./gfx/circleclip.PNG

Clipped by a polyline:

.. js ::

  surface.createImage({x:100,y:100, width:96, height:96, src:"html5.png"}).setClip({points:[150,110,180,145,120,185,150,110]});

.. image :: ./gfx/plineclip.PNG

Clipped by a path:

.. js ::

  surface.createImage({src:img, x:300,y:350,width:200,height:200}).setClip({d:"M 110,105 C104,194 117,167 173,110.0000 z"});

.. image :: ./gfx/pathclip.PNG

Implementation details
~~~~~~~~~~~~~~~~~~~~~~

vml only supports rectangle clipping, while the gfx silverlight renderer does not support path clipping geometry.

Destructors API
----------------

In 1.8, the Surface.destroy() api has been extended to the Shape hierarchy, allowing to clean up resources used by a shape when it is destroyed from the gfx scene. Note that it is different from the Shape.removeParent() method, which only removes the shape from its container. Such a shape can still be added to an another container later, and therefore is still considered part of the scene. The destroy() method, on its side, applies to shape that should not live in the gfx scene anymore. 

Note that Shape.destroy() does not remove the shape from its parent container, this operation must be performed explicitly before the destructor is called, or when clearing a Group passing a truthy value to the Group.clear() method which cause the children destructor to be called.

Helper Methods
--------------

In general the described generic methods together with shape-specific methods are enough to do everything with your shape,
but for convenience shape defines a helper method:

_getRealMatrix()
  Returns a combined matrix for this shape applying all parent matrices.
  The resulting matrix can be used to transform from "shape" coordinates to "surface" coordinates and back helping to process
  mouse events, or coordinating other objects outside of the surface.

Individual graphics objects
===========================

This is a list of all important graphics objects and geometric shapes.

Surface
-------
  A surface is the main object, which represents a collection of shapes. No shapes can be drawn or created without a surface.
  The following functions can be used to create a surface object:

  dojox.gfx.createSurface(parentNode, width, height)
    Returns a newly created surface object.

  dojox.gfx.attachSurface(node)
    Returns a re-created surface object built from an existing node.
    The node argument is assumed to be created by createSurface() function (rawNode member).

  A surface supports following methods:

  getDimensions()/setDimensions(width, height)
    Accesses sizes set on the surface.

  createShape(shape)
    Creates a shape out of shape description object relying on the "type" member, returns a shape object.

    Useful for deserialization of shapes from an external source.

  createPath(path), createRect(rect), createCircle(circle), createEllipse(ellipse), createLine(line), createPolyline(polyline), createImage(image), createText(text), createTextPath(textpath)
    Create a corresponding shape returning a shape object.

    Note: the "type" member of a shape is implied and not required.

  createGroup()
    Creates a Group object.

  add(shape)
    Adds a **Shape** to a **Surface** returning the surface itself. Used to move shapes between groups and a surface.

  remove(shape)
    Removes a shape from a surface returning the surface itself.
    The shape can be added later to the same surface or a group.

  clear()
    Removes all shapes from a surface returning the surface itself.

  getBoundingBox()
    Returns the content bounding box.

  on()
    See the discussion of this method in the Event processing section above.

  whenLoaded(callbackFunction)
    Executes the user-specified callbackFunction as soon as the Surface is ready for drawing.

Surface supports the following events:

  onLoaded
    This event is fired when a Surface is initialized and ready for use.

Group
-----
  A group is a pseudo-shape, which represents a collection of shapes.
  Transformations applied to a group applied to all shapes of that group.
  It is used to aggregate shapes constructing a more complex shape, or to manage sub-pictures.
  The other way to use a group is to aggregate an event processing.
  It is planned to implement setting a (default) visual parameters to group's children including fill, stroke, and font properties.
  A group combines features of a shape and a surface. It shares following methods with a shape:

  getBoundingBox()
    Returns the Group children bounding box

  getTransform()/setTransform(matrix)
    Accesses a transformation matrix applied to a group.

  applyRightTransform(matrix)/applyLeftTransform(matrix)
    Combines the existing matrix with new matrix.
    See "Transformation matrix" for details.

  applyTransform(matrix)
    Is an alias for applyRightTransform(matrix). This function is defined for convenience.

  moveToFront()/moveToBack()
    Changes a z-order of a group. It moves an object to the front or to the back respectively
    of its parent container (a surface or a group).

  removeShape()
    Removes a group from its parent container.

  getParent()
    Accesses group's parent container.

  on()
    Implement the event processing.

  Group also shares the following methods with a Surface:

  createShape(shape)
    Creates a shape out of shape description object relying on the "type" member, returns a shape object.

    Useful for deserialization of shapes from an external source.

  createPath(path), createRect(rect), createCircle(circle), createEllipse(ellipse), createLine(line), createPolyline(polyline), createImage(image), createText(text), createTextPath(textpath)
    Create a corresponding shape returning a shape object.

    Note: the "type" member of a shape is implied and not required.

  createGroup()
    Creates a group object.

  add(shape)
    Adds a shape to a group returning the group itself. It is used to move shapes between groups and a surface.

  remove(shape)
    Removes a shape from a group returning the group itself. The shape can be added later to the same group or a surface.

  clear()
    Removes all shapes from a group returning the group itself.

Rectangle
---------
  A rectangle is a basic rectangular shape with optionally rounded corners.
  It can be created by the createRect() method of a surface or a group.
  The default shape description for rectangle is defined as the dojox.gfx.defaultRect object.
  Here is a list of all properties and their defaults:

  type
    is always "rect".

  x, y
    Coordinates of a top-left corner in pixels. Defaults: 0, 0.

  width, height
    Dimensions in pixels. Defaults: 100, 100.

  r
    A radius of rounded corners. Default: 0 (no rounded corners).

Circle
------
  A circle is a basic shape. It can be created by the createCircle() method of a surface or a group.
  The default shape description for circle is defined as the dojox.gfx.defaultCircle object.
  Here is a list of all properties and their defaults:

  type
    Is always "circle"

  cx, cy
    Coordinates of a center in pixels. Defaults: 0, 0

  r
    Is a radius in pixels. Default: 100

Ellipse
-------
  An Ellipse is a basic shape. It can be created by the createEllipse() method of a surface or a group.
  The default shape description for ellipse is defined as the dojox.gfx.defaultEllipse object.
  An ellipse can be used to emulate a circle.
  Here is a list of all properties and their defaults:

  type
    Always "ellipse"

  cx, cy
    Coordinates of a center in pixels. Defaults: 0, 0

  rx, ry
    Horizontal and vertical radii (respectively) in pixels. Defaults: 200, 100

Line
----
  A Line is a basic shape that connects two points. It can be created by the createLine() method of a surface or a group.
  The default shape description for line is defined as the dojox.gfx.defaultLine object.
  Here is a list of all properties and their defaults:

  type
    Always "line"
  x1, y1
    Coordinates of a start point in pixels. Defaults: 0, 0
  x2, y2
    Coordinates of an end point in pixels. Defaults: 100, 100

Polyline
--------
  A Polyline is a basic shape, which can be used to represent polylines and polygons.
  It can be created by the createPolyline() method of a surface or a group.
  The default shape description for polyline is defined as the dojox.gfx.defaultPolyline object.
  Typically a polyline is an unfilled polygon. A polyline can be "open" and "closed".
  The latter means that the first and the last points are the same.
  When filling open polylines, an edge connecting the first and the last points is assumed.
  Polylines/polygons can be defined as an array of points:

  .. js ::

    poly.setShape([{x: 0, y: 0}, {x: 100, y: 100}]) and poly.setShape([0, 0, 100, 100])

  are both equivalent to

  .. js ::

    poly.setShape({points: [{x: 0, y: 0}, {x: 100, y: 100}]}).

  A polyline can be used to emulate a line.
  Here is a list of all properties and their defaults:

  type
    Always "polyline".

  points
    An array of 2D coordinates in pixels. Default: [].


Path
----
  A Path is the most versatile geometric shape, which can emulate all other geometric shapes.
  It can be created by the createPath() method of a surface or a group.

  The default shape description for path is defined as the dojox.gfx.defaultPath object.

  Here is a list of all properties and their defaults:

  type
    Always "path".

  path
    A string , which represents a path encoded in the SVG path language. Default: "".

  A path can be open or closed. The latter means that the first and the last points are the same.

  When filling open paths, a straight line connecting the first and the last points is assumed.

  Path supports following methods for building path segments programmatically:

  moveTo(x, y)
    Starts new segment abandoning the previous segment, if any. It takes a coordinate as a parameter.

  lineTo(x, y)
    Draws a straight line from the last point to the argument (coordinate).

  hLineTo(x)
    Draws a straight horizontal line from the last point using the argument (a number) as X position.

  vLineTo(y)
    Draws a straight vertical line from the last point using the argument (a number) as Y position.

  curveTo(x1, y1, x2, y2, x, y)
    Draws a cubic Bézier curve from the last point using arguments (two control points, and a final coordinate).

  smoothCurveTo(x2, y2, x, y)
    Draws a cubic Bézier curve from the last point using arguments. The difference between this method and curveTo()
    is that it accepts only one control point, which serves as the second control point. The first control is assumed
    to be a reflection of the second control point of the previous curve command.

  qCurveTo(x1, y1, x, y)
    Draws a quadratic Bézier curve from the last point using arguments (a control point, and a final point).

  qSmoothCurveTo(x, y)
    Draws a quadratic Bézier curve from the last point using arguments. The difference between this method and qCurveTo()
    is that it uses the reflected control point of the previous curve command.

  arcTo(rx, ry, x_axis_rotation, large_arc_flag, sweep_flag, x, y)
    Draws an elliptic arc from the last point using arguments (please see the above link for details).

  closePath()
    Closes the segment.

  setAbsoluteMode(mode)
    Sets an absolute or relative mode for coordinates. In the absolute mode all coordinates are assumed to be literal.
    In the relative mode all coordinates are offsets from the last point.

  getAbsoluteMode()
    Returns true, if the current mode is absolute.

  getLastPosition()
    Returns the last point, if there is one.

Examples
~~~~~~~~

All parameters can be repeated, if it makes sense.

Example:

  .. js ::

    path.lineTo(1, 1, 2, 2, 3, 3)

  is equivalent to

  .. js ::

    path.lineTo(1, 1).lineTo(2, 2).lineTo(3, 3).

A pair of coordinates can be replaced by a single coordinate object.

Example:
  .. js ::

    path.curveTo({x: 0.5, y: 0}, {x: 0.5, y: 1}, 1, 1)

  is equivalent to

  .. js ::

    path.curveTo(0.5, 0, 0.5, 1, 1, 1).

All arrays are unrolled.

Example:
  .. js ::

    path.curveTo([0.5, 0, [0.5, 1]], [{x: 1, y: 1}])

  is equivalent to

  .. js ::

    path.curveTo(0.5, 0, 0.5, 1, 1, 1).

You can specify a well-formed path string as an argument to setShape() method of the path:

  .. js ::

    path.setShape("m 0,0 l 100, 100 e")

  is equivalent to

  .. js ::

    path.setShape({path: "m 0,0 l 100, 100 e"})

Image
-----
  An Image is a shape that represents a resolution-independent color bitmap data.
  It can be created by the createImage() method of a Surface or a Group.

  The default shape description for image is defined as the dojox.gfx.defaultImage object.

  Here is a list of all properties and their defaults:

  type
    Always "image".

  x, y
    Coordinates of a top-left corner in pixels. Defaults: 0, 0.

  width, height
    Dimensions in pixels. Defaults: 0, 0 - don't forget to set them to real values.

  src
    A URL of an image data pointing to a GIF, JPG, or PNG file. Default: "".

  Changing width and height parameters you can stretch/shrink an image anisotropically.

Text
----
  Text is a shape that anchors a text string to a point. It can be created by the createText() method of a Surface or a Group.
  It implements these additional text-specific methods:

  setFont(font)
    Sets a font object.

  getFont()
    Returns the current font, or "null" to indicate that the default font is used.

  The default shape description for text shape is defined as the dojox.gfx.defaultText object.
  Here is a list of all properties and their defaults:

  type
    Always "text".

  x, y
    Coordinates of a text anchor. Defaults: 0, 0.

  text
    A string of characters you want to show aligned to the anchor position. Default: "".

  align
    An alignment of a text in regards to the anchor position:

    "start"
      A text's baseline starts at the anchor. This is the default value of the align attribute.

    "middle"
      A text's baseline is centered on the anchor point.

    "end"
      A text's baseline ends at the anchor point.

  decoration
    A hint on how to render optional elements of a text:

    "none"
      Text is not decorated. This is the default value.

    "underline"
      Text is underlined.

    "overline"
      Text has a line above it.

    "line-through"
      Text has a line through the middle.

  rotated
    A Boolean value, which indicates:

    false
      All glyphs are unrotated. The is the default value.

    true
      All glyphs are rotated 90 degrees counter-clock-wise. This mode is useful for vertically arranged text.

  kerning
    A Boolean value, which indicates:

    true
      Kerning is on. This is the default value.

    false
      Kerning is off.

Implementation notes
~~~~~~~~~~~~~~~~~~~~

Text properties are loosely based on properties of the SVG text element.

IE7
  Broke a lot of VML features.

  The following things work in IE6 but don't work in IE7 (and there is no workaround for them):

    decoration
      Always "none".

    rotated
      Always false.

FF2 and Opera9
  Do not support following properties:

  decoration
    Always "none".

  rotated
    Always false.

Silverlight
  Has following restrictions:

  stroke
    Not supported - all setStroke() calls are ignored.

  decoration
    Only "underline" and "none" are supported, the rest is interpreted as "none".

  rotated and kerning properties
    Not supported.

Canvas
  Same as Silverlight

TextPath
--------
  A TextPath is a shape that flows text along an arbitrary path. TextPath properties are based on the text shape properties.

  It can be created by the createTextPath() method of a surface or a group.

  The TextPath shape object implements all methods of a Path shape object, and two additional methods:

  setFont(font)
    Sets a font object.

  getFont()
    Returns the current font, or "null" to indicate that the default font is used.

  setText(text)
    Sets a text path shape description.

  The default shape description for text path shape is defined as the dojox.gfx.defaultTextPath object.

  It resembles the text description object.

  Here is a list of all properties and their defaults:

  type
    Always "textpath".

  text
    A string of characters you want to show on a path. Default: "".

  align
    An alignment of a text in regards to the anchor position:

    "start"
      Text starts at the beginning of the path. This is the default value of the align attribute.

    "middle"
      Text is centered on the middle of the path.

    "end"
      Text ends at the end of the path.

  decoration
    A hint on how to render optional elements of a text:

    "none"
      Text is not decorated. This is the default value.

    "underline"
      Text is underlined.

    "overline"
      Text has a line above it.

    "line-through"
      Text has a line through the middle.

  rotated
    A Boolean value, which indicates:

    false
      All glyphs are unrotated. The is the default value.

    true
      All glyphs are rotated 90 degrees counter-clockwise. This mode is useful for vertically arranged text.

  kerning
    A Boolean value, which indicates:

    true
      Kerning is on. This is the default value.

    false
      Kerning is off.

Implementation notes
~~~~~~~~~~~~~~~~~~~~

This is an experimental shape, which is not recommended to be used in production unless you know what you are doing.

TextPath shape properties mirror properties of a Text shape.
When TextPath object is created its path is set to dojox.gfx.defaultPath.

IE7
  Broke a lot of VML features.

  The following things work in IE6 but don't work in IE7 (and there is no workaround for them):

  decoration
    Always "none"

  rotated
    Always false

FF2 and Opera9
  Do not support the following properties:

  decoration
    Always "none"

  rotated
    Always false

Alignment
~~~~~~~~~
IE always aligns the vertical middle of the text with a path.

FF and Opera both align the baseline with a path.

  Unfortunately they seem to ignore any other vertical alignment, which leads to a visual discrepancy between SVG and VML implementations.

The final version of the TextPath object will have the IE/VML behavior (as the greater common denominator):

  The text's middle line follows a path.

Silverlight and Canvas
  don't support this shape.

Renderer-specific extensions
============================

From 1.8, new optional modules have been introduced enabling to leverage the capabilities of the underlying rendering technology that are not exposed in the standard gfx API because of their specific nature.

Canvas extension (module: dojox/gfx/canvasext)
----------------------------------------------

The dojox/gfx/canvasext module adds the following new APIs:

Surface
~~~~~~~

  getContext()
    Returns the surface CanvasRenderingContext2D.

  getImageData(rect)
    Returns an ImageData object containing the image data for the given rectangle of the Surface canvas.

Coupled with the new Surface.render() method and dojo/aspect, these new methods allow to implement post- or pre- image processing. For example, the following example draws a text before the gfx scene is drawn, and processes the gfx scene image buffer to apply a color effect:
 
.. js ::

  // wire a pre render callback to draw a text.
  aspect.before(surface,"render", function(context){
    context.save();
    context.fillStyle    = "black"; 
    context.font         = "italic 30px sans-serif";
    context.textBaseline = "top";
    context.fillText("Canvas pixel-based manipulation with dojox.gfx", 0, 0);
    context.restore();
  }, true);
  // wire a post render callback to apply a "negate color" filter.
  aspect.after(surface,"render", function(context){
    input = context.getImageData(0,100,width,height);
    var inputData = input.data;
    // negate colors
    for(var i=0, n=inputData.length; i<n; i+=4){
      inputData[i  ] = 255 - inputData[i  ]; // red
      inputData[i+1] = 255 - inputData[i+1]; // green
      inputData[i+2] = 255 - inputData[i+2]; // blue
    }
    context.putImageData(input, 0, 100);
  }, true);

SVG extension (module: dojox/gfx/svgext)
----------------------------------------------

The dojox/gfx/svgext module adds the following APIs:

Shape
~~~~~
  addRenderingOption(option, value)
    Adds the specified SVG rendering option on this shape. The value of the option and value parameters should conform to the SVG specification (http://www.w3.org/TR/SVG/painting.html#RenderingProperties). Note that these rendering options are considered only as hints by the browser svg engine (so the option may have no effect), and the result can be different depending on the browser. 

For example, the following code specifies that the line should be drawn using the "crispEdges" option:

.. js ::

  surface.createLine({
    x1 : 10,
    y1 : 10,
    x2 : 490,
    y2 : 100
  }).setStroke("blue").addRenderingOption("shape-rendering", "crispEdges);

From 1.9, SVG Filters are supported on any shapes through the new:

  setFilter(filter)
    Sets the specified SVG Filter on this shape, where the parameter is an object that defines the filter properties.

For example, the following code creates a simple blur effect:

.. js ::

	var blur = {
		"id": "myBlur",
		"x": -0.2,
		"y": -0.2,
		"width": 1.4,
		"height": 1.4,
		"filterUnits":"objectBoundingBox",
		"primitives": [{
			"tag":"feConvolveMatrix",
			"in":"SourceGraphic",
			"order":3,
			"divisor":9,
			"kernelMatrix":"1,1,1,1,1,1,1,1,1"
		}]
	};
	myShape.setFilter(blur);

Note that in order to make the creation of such filter easier, the dojox/gfx/filters module defines both a simple API to easily create filter objects and
also a set of predefined filters. For more information, see the Filters section below.

SVG Filters
-----------

From 1.9, SVG Filters are supported on any shapes through the new Shape.setFilter(filterArg) method (defined when the dojox/gfx/shapeext module is required), where the filterArg
parameter is an object that defines the filter properties. In addition to this new method, a convenient API is provided in the dojox/gfx/filters module that makes writing filters easier. Note that the dojox/gfx/filters module must be required **in addition to** the dojox/gfx/svgext module.

A filter defines a graphic effect applied on a shape (Group included), as specified by the SVG specification (http://www.w3.org/TR/SVG/filters.html).
It is the result of the combination of one or multiple pixel operations (called filter primitives). By combining primitives, a developer can build complex visual effects that are then applied on the rendering of a shape (the shape geometry is not impacted by a filter).

Using the predefined filters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Because writing such filter effect can be tedious, the dojox/gfx/filters module comes with a set of predefined, ready-to-use filters, organized by category : convolutions, shadows, blurs, colors, miscs, reliefs and texture. Each category is defined by a corresponding property on the filters module (e.g. filters.convolutions) and filters by a corresponding property (in fact, a function) on the category (e.g filters.convolutions.verticalEdges).

The following picture shows the result of the predefined filters.miscs.fuzzy filter applied on the parent shape (a Group) of a gfx drawing:

.. image :: ./gfx/fuzzy.png

Please refer to the dojox/gfx/filters API documentation for the full list of available filters or the dojox/gfx/tests/test_filters.html test and the dojox/gfx/demos/filters.html demo to see them in action.

Predefined filters are exported as functions that take an optional configuration parameter which allows to change the filter default settings (for example, you may set your own id, or change the filter coordinates).
The following code sets a predefined bumpOut filter on a shape, with a custom configuration:

.. js ::

  require(["dojox/gfx/svgext", "dojox/gfx/filters", ...], function(svg, filters) {
    var shape = ...;
    var filter = filters.shadows.bumpOut({x:-200, y:-150, width:550, height:600, filterUnits:"userSpaceOnUse"});
    shape.setFilter(filter);
  });


.. image :: ./gfx/bumpout.png

Writing custom filters with the dojox/gfx/filters API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The dojox/gfx/filters module defines a simple API that allow to write custom filter following the same terminology as the SVG specification.
As wrote previously, a filter is made of filter primitives that can be combined and/or chained together to build complex visual effects, each of the primitives performing a specific operation. For example, the feGaussianBlur primitive performs a Gaussian blur on the image data. In term of API, the filters module provides:

  * a set of functions used to create the corresponding SVG filter primitives objects, based on the same naming as the specification (e.g. filters.feGaussianBlur()).
  * the filters.createFilter(args, primitives) function, where *args* is a configuration object for the filter and *primitives* an optional array of filter primitives objects.

The available primitives functions are: filters.feBlend(), filters.feColorMatrix(), filters.feComponentTransfer(), filters.feComposite(), filters.feConvolveMatrix(), filters.feDiffuseLighting(),
feDisplacementMap(), filters.feFlood(), filters.feGaussianBlur(), filters.feImage(), filters.feMorphology(), filters.feOffset(), filters.feSpecularLighting(), filters.feTile(), filters.feTurbulence(),
feDistantLight(), filters.fePointLight(), filters.feSpotLight(), filters.feMergeNode(), filters.feFuncA(), filters.feFuncR(), filters.feFuncG(), filters.feFuncB().

These primitives factory functions follow the following signature:

.. js ::

   * filters.a_primitive(/*Object*/properties, /*Array?*/children)
   * filters.a_primitive(/*Array?*/children)

where:

  * the *properties* parameter must define the primitive attributes as defined by the specification.
  * the optional *children* array parameter is an array of children primitives.

The exception to this rule is the feMerge() factory function, which also accepts the feMerge(string, string)  signature, a shortcut to specify the children feMergeNode *in* parameters.

For example, a drop shadow effect could be written as the combination of a Gaussian blur with an offset in both x and y axis, merged with the original data. In term of code, it gives:

.. js ::

  filters.createFilter({x:"-10%", y:"-10%", width:"120%", height:"120%"}, [
    filters.feGaussianBlur({"in":"SourceAlpha","stdDeviation":4}),
    filters.feOffset({"dx":5,"dy":5,"result":"offsetBlur"}),
    filters.feMerge("offsetBlur","SourceGraphic")
  ]),

and the result is:

.. image :: ./gfx/dropshadow.png

SVG Masks (module: dojox/gfx/svg_mask)
--------------------------------------

The dojox/gfx/svg_mask module adds SVG mask support via the following APIs:

Surface
~~~~~~~
  createMask(mask)
    Creates an SVG mask based on an argument defining the properties of the mask.

Shape
~~~~~
  getMask()
    Returns the mask applied to the shape or "null" if the shape has no mask.

  setMask(mask)
    Sets the specified SVG mask on the shape. If "null" is specified, the current mask is removed from the shape.

Using masks
~~~~~~~~~~~
SVG masks are used in compositing to determine which parts of a shape should be visible and with what transparency.
In dojox/gfx/svg_mask, masks are Group-like objects defined by the structure and color of their child shapes.
Shapes can be added and removed from a mask the same way they are for a Group.

The following example applies a mask to a group of shapes:

.. js ::

  require(["dojox/gfx", "dojox/gfx/svg_mask", ...], function(gfx){
    var group = ...;

    var mask = surface.createMask({ maskContentUnits: "objectBoundingBox" });
    var linearGradient = {
      type: "linear", x1: 0, y1: 0, x2: 1, y2: 1, colors: [
        { offset: 0, color: "#fff" },
        { offset: 0.75, color: "#000" }
      ]
    };
    mask.createRect({ x: 0, y: 0, width: 1, height: 1 }).setFill(linearGradient);

    group.setMask(mask);
  });


.. image :: ./gfx/maskgradient.png

Utilities
=========

dojox.gfx implements several generally useful algorithms described in this section.

move.js
-------

This file implements dojox.gfx.Mover and dojox.gfx.Moveable which are similar to dojo.dndMover and dojo.dnd.Moveable specifically targeting moving shapes.

You can find examples in dojox/gfx/demos/circles.html, and dojox/gfx/demos/inspector.html.

utils.js
--------

This file implements serialization helpers:

forEach(shape, f, o)
  Takes a shape or a surface and applies a function "f" to in the context of "o" (or global, if missing). If "shape" was a surface or a group, it applies the same function to all children recursively effectively visiting all shapes of the underlying scene graph. This function is available since Dojo 1.3.1.

serialize(shape)
  Takes a shape or a surface and returns a DOM object, which describes underlying shapes.

deserialize(parent, object)
  Takes a surface or a shape and populates it with an object produced by serialize().

toJson(shape, prettyPrint)
  Works just like serialize() but returns a JSON string. If prettyPrint is true, the string is pretty-printed to make it more human-readable.

fromJson(parent, json)
  Works just like deserialize() but takes a JSON representation of the object.

serialize()
  Returns following objects:

  for a surface it returns an array of shapes.

  for a group it returns an object with a property "children", which contains an array of shapes.

  for a shape it returns an object with a property "shape", which contains a shape definition object.

Both a Shape and a Group may contain following member variables:

  transform
    Contains a transformation matrix.

  stroke
    Contains a stroke definition object.

  fill
    Contains a fill definition object.

  font
    Contains a font definition for text-based objects.

Serialization helpers can be used to implement a persistent storage of vector-based images, generation of them on the server, conversion of dojox.gfx-based pictures in other formats (e.g., to PDF), and conversion of other formats (e.g., raw SVG) to dojox.gfx.

You can find examples in dojox/gfx/demos/creator.html and dojox/gfx/demos/inspector.html. Many serialized examples can be found in
::

  dojox/gfx/demos/data/*.json.

decompose.js
------------

Some graphics libraries/renderers do not implement generic linear 2D transformations. They patronize developers with a "simple" subset, which typically include translation, rotation, and scaling operations. It makes next to impossible implementing compound transformations using the "sandwich" technique described above, storing transformations externally, or pre-calculating complex transformation ahead of time to improve the performance.

At present time only Canvas is on this dishonorable list. While the latest Canvas specification finally defined the transform() method, which essentially operates on 2D matrices, nobody implemented it yet, so we are left to implement the general 2D matrix algebra on top of childish primitives. Is it possible? You bet! Of course at comes at a price of reduced performance, which is O.K. in most cases.

dojox.gfx implements a decomposition of any reasonable linear 2D transformation into four-component "primitive" transformations applied in succession. It is done using the singular value decomposition and the eigendecomposition, so you don't have to do it yourself.

This algorithm is used internally in the Canvas renderer, but you are welcomed to use it for your own needs.

decompose(matrix)
  Takes a matrix in any suitable form and returns an object with 6 member variables:

dx, dy
  Define the translation component.

sx, sy
  Define the scaling/mirroring component.

angle1
  Defines the first rotation.

angle2
  Defines the second rotation.

Using these values the input matrix can be represented as a superposition of "primitive" transformations: [translate(dx, dy), rotate(angle2), scale(sx, sy), rotate(angle1)].

arc.js
------

Some graphics libraries/renderers do not implement generic elliptic arcs or even ellipses (variant: they do but transforming them reveals multiple bugs in the underlying implementation). Both VML and Canvas are on this dishonorable list. The simplest way to deal with it is to approximate them with simple cubic Bézier curves - the Swiss-army knife of vector geometric shapes.
This algorithm is used internally, but you are welcomed to use it for you own needs.

unitArcAsBezier(alpha)
  Returns an arc approximation as an object of 4 coordinates:

  s
    The start coordinate of the curve.

  c1
    The first control point of the curve.

  c2
    The second control point of the curve.

  e
    The end coordinate of the curve.

The resulting curve approximates an arc of 2 * angle size with radius of 1 symmetric around the x axis.
It is important to keep the angle value reasonably low to improve the precision of the approximation.
Angles less than PI/2 (45 degrees) are virtually indistinguishable from true arcs for typical screen sizes.

curvePI4
  A pre-calculated curve for the arc of PI/4 size. Essentially curvePI4 = unitArcAsBezier(PI/8).

arcAsBezier(last, rx, ry, xRotg, large, sweep, x, y)
  Takes all parameters of the SVG elliptic arc and returns an array of cubic Bézier curves necessary to represent the arc.

Each cubic arc is represented as an array of six numeric values: [c1.x, c1.y, c2.x, c2.y, e.x, e.y],
where c1 is the first control point, c2 is the second control point, and e is the end point. All values are absolute.

Considerations and Caveats
==========================

The GFX system uses a series of underlying renderers for whichever browser loads the API. The renderer is determined at load time, and defines the entire API using whatever the browser is capable of: Silverlight or VML in IE, SVG in iPhone, Firefox and Safari, and a light-weight canvas variant are available.

To define specifically which renderers can be used, and their relative priority, set the 'gfxRenderer' value in dojoConfig as a comma delimited string value, e.g. to specify that only SVG, Silverlight and VML should be used, and not Canvas, use:

.. html ::

  <script type="text/javascript" src="dojo/dojo.js" data-dojo-config="parseOnLoad:true,gfxRenderer:'svg,silverlight,vml'"></script>

In the example above SVG will be tried first, if it fails Silverlight will be tried, and the last one will be VML.

**It is important to note:** there isn't currently a way to include all the required renderers in a single file (such as a layer created by a custom Dojo Build). Not only would the size be prohibitive, each of the renderers re-defining the API would cause severe errors.

DOCTYPE
=======

Not all doctypes will work with VML because VML was invented before the doctype, and has for the most part not been updated since.

The following doctype has been shown to work in a majority of cases (and may be required for IE8). The additional styles also help with display problems of some shape types.

.. html ::

  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:v="urn:schemas-microsoft-com:vml"
    xmlns:xlink="http://www.w3.org/1999/xlink">
 
  <style>
    v\:rect, v\:roundrect, v\:line, v\:polyline, v\:curve, v\:arc, v\:oval, v\:image, v\:shape, v\:group, v\:skew,
    v\:stroke, v\:fill {behavior:url(#default#VML); display:inline-block }
  </style>

 
TODO: To be certain of this doctype fix, it would be good to list a few doctypes that are known to *not* work.

Demos
=====

Demos are relatively complex examples located in the demos/ sub-directory. They are used to make sure that all parts of dojox.gfx work together well, to assess the performance, and to give realistic examples to users:

demos/butterfly.html, demos/lion.html, demos/tiger.html
  Show classic SVG pictures converted from the original SVG to dojox.gfx calls. You can rotate and scale them.

demos/circles.html
  Shows 100 translucent draggable circles. It is a good example of dojox.gfx.move in action.

demos/clock.html, demos/clock_black.html
  Show an animated analog clock. You can grab its hands and set your own time.
  It is a good example on simple animation and an interaction with user's actions.

demos/creator.html, demos/inspector.html, demos/beautify.html
  Implement simple persistence mechanism using dojox.gfx.utils, and simple interaction using dojox.gfx.move.

Tests
=====

All tests are located in the tests/ sub-directory.
They are used by developers to test the conformance, and can be used by users to see how different objects and algorithms can be used.
The following tests are available:

runTests.html
  Runs automated tests for the matrix (defined in tests/matrix.js) and the matrix decomposition (defined in tests/decompose.js).

test_arc.html
  Tests elliptic arcs component in the path shape.

test_bezier.html
  Tests the approximation of the elliptic arc with Bézier curves helping to find potential problems with both arcs and curves.

test_decompose.html
  A testbed for manual verification of the matrix decomposition.

test_fill.html
  Tests the even-odd rule for fills.

test_gfx.html
  A complex test, which tries to tests many things at once.

test_gradient.html
  Tests gradients with transparency.

test_group.html
  Tests how moving a shape between groups with different transformations affect the visual.

test_image1.html
  Tests transformations applied to an image.

test_image2.html
  Tests the particular case of transformation when an image is a part of a group.

test_linearGradient.html
  Tests complex liner gradient fills.

test_linestyle.html
  Tests all line styles.

test_pattern.html
  Tests the pattern fill.

test_poly.html
  Tests the line shape and the polyline shape by animating them using a rotation matrix and a timer.

test_resize.html
  Tests the dynamic surface resizing.

test_setPath.html
  Tests relative/absolute coordinates in the path definition using cubic and quadratic curves.

test_tbbox.html
  Tests the getTransformBoundingBox() method.

test_text.html
  Tests the text shape with various settings.

test_textpath.html
  Tests the text path shape.

test_transform.html
  Tests the transformation applied to groups and individual shapes.

TODO
====

Temporary list of new subpages:

* :ref:`Matrix tutorial <dojox/gfx/matrix-tutorial>`
* :ref:`Visual properties <dojox/gfx-visual-properties>`
* :ref:`Geometric properties <dojox/gfx-geometric-properties>`