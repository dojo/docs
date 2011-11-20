.. _dojox/gfx-geometric-properties:

dojox.gfx.matrix
================

:Status: Draft
:Version: 1.3
:Authors: Eugene Lazutkin, Kun Xi, Chris Mitchell
:Available: since 0.4

.. contents::
  :depth: 3

===============================
Coordinates and transformations
===============================

In order to understand transformations you need to be familiar with fundamentals of matrices (matrix multiplication, multiplication of a vector by a matrix, order of multiplications). :ref:`dojox.gfx <dojox/gfx>` uses a mnemonic way to describe a matrix: ``xx`` scales an ``X`` component of a coordinate, ``yy`` scales a ``Y`` component, ``xy``, and ``yx`` affect both components, ``dx`` moves an ``X`` component, and ``dy`` moves a ``Y`` component. If you want to refresh your memory, read our :ref:`Matrix tutorial <dojox/gfx/matrix-tutorial>`.

Simple examples:

* ``{xx: 2}`` --- stretches the ``X`` dimension by 2.

* ``{yy: 0.5}`` --- ``"stretches"`` the ``Y`` dimension by 0.5 (shrinks by 2).

* ``{dx: 5, dy: 10}`` --- shifts an ``X`` coordinate by 5, a ``Y`` coordinate by 10.

* ``{xx: 0.866, xy: 0.5, yx: −0.5, yy: 0.866}`` --- rotates everything by approximately 30 degrees clockwise (CW) around point ``(0, 0)``.

* ``{xx: 0, xy: 1, yx: −1, yy: 0, dx: 100}`` --- rotates everything by 90 degrees CW around ``(0, 0)``, and moves things right by 100.

Don’t worry, in most cases you don’t need to calculate all members of a transformation matrix directly. As you can see not all members of matrix should be specified --- all skipped members going to be copied from the identity matrix.

There is a shortcut for scaling --- if a number N is used instead of a matrix, it is assumed that it represents a uniform scaling matrix ``{xx: N, yy: N}``.

There is a shortcut for multiplication (see multiply_ for details) --- is an array is used it is treated as an array of matrices, and all matrices will be multiplied to produce the final matrix.

:ref:`dojox.gfx.matrix <dojox/gfx/matrix>` defines ``Matrix2D`` class, as well as numerous helpers (``Matrix2D`` is propagated to ``dojox.gfx`` namespace for convenience). Most important of them (all in ``dojox.gfx.matrix`` namespace) are listed below.

==========================
Matrix2D and normalization
==========================

As you can see developers can specify matrices in a variety of ways. But for performance reasons internally it is always converted to ``Matrix2D``, which has all proper attributes defined. You can achieve this normalization by instantiating Matrix2D_ object or by invoking a creator function called normalize_.

Matrix2D
--------

Matrix2D is the class for our 2 by 3 matrix. You can always use it to normalize your matrix expression to the canonical representation. It is available in both namespaces: ``dojox.gfx`` and ``dojox.gfx.matrix``.

Examples:

.. code-block :: javascript

  // identity {xx: 1, xy: 0, dx: 0, yx: 0, yy: 1, dy: 0}
  var m1 = new dojox.gfx.Matrix2D();

  // shift down {xx: 1, xy: 0, dx: 0, yx: 0, yy: 1, dy: 10}
  var m2 = new dojox.gfx.Matrix2D({dy: 10});

  // scale by 2 {xx: 2, xy: 0, dx: 0, yx: 0, yy: 2, dy: 0}
  var m3 = new dojox.gfx.Matrix2D(2);

  // scale by 2 and shift down {xx: 2, xy: 0, dx: 0, yx: 0, yy: 2, dy: 10}
  var m3 = new dojox.gfx.Matrix2D([{dy: 10}, 2]);

normalize
---------

There is one more useful function: ``normalize(m)``, which returns Matrix2D_:

.. code-block :: javascript

  var m1 = normalize(2);        // => {xx: 2, xy: 0, yx: 0, yy: 2, dx: 0, dy: 0}
  
  var m2 = normalize({dy: 10}); // => {xx: 1, xy: 0, yx: 0, yy: 1, dx: 0, dy: 5}
  
  var m3 = normalize([scale(2), translate(100, 200)]);
                                // => {xx: 2, xy: 0, yx: 0, yy: 2, dx: 200, dy: 400}

The same normalization effect can be achieved with creating a matrix directly.

=========
Constants
=========

Some operations do not require any parameters and implemented as predefined constants.

identity
--------

The identity matrix. This matrix doesn’t change a picture at all.

flipX
-----

Changes the sign of all ``X`` coordinates. This matrix mirrors the picture around the ``Y`` axis.

flipY
-----

Changes the sign of all ``Y`` coordinates. This matrix mirrors the picture around the ``X`` axis.

flipXY
------

Changes the sign of all coordinates. This matrix rotates the picture by 180 degrees around ``(0, 0)`` point. Another way to say it: it mirrors all points around ``(0, 0)``.

===============
Matrix creators
===============

Matrices can be used to express any linear transformation of coordinates. To simplify the task of creating matrices for common operations numerous matrix creators are provided.

In all signatures ``a``, ``b``, ``c``, and ``e`` are numbers (coordinate components or scaling factors), ``p`` is a 2D coordinate, ``r`` is an angle in radians, ``d`` is an angle in degrees (positive value of an angle is CW), ``m`` is a matrix.

If a function accepts an angle value, there are two versions of this function: with radians, and with degrees. The latter will be denoted with ``g`` suffix. Example: ``rotate(r)`` accepts radians, while ``rotateg(d)`` accepts degrees.

translate
---------

Signatures: ``translate(a, b)``, ``translate(p)``. Shifts everything:

  * by ``{dx: a, dy: b}``

  * by ``{dx: p.x, dy: p.y}``

scale
-----

Signatures: ``scale(a, b)``, ``scale(a)``, ``scale(p)``. Scales a picture:

  * by ``{xx: a, yy: b}``

  * by ``{xx: a, yy: a}``

  * by ``{xx: p.x, yy: p.y}``

rotate
------

Signatures: ``rotate(r)``, ``rotateg(d)``. Rotates a picture around ``(0, 0)``:

  * by ``r`` radians

  * by ``d`` degrees

skewX
-----

Signatures: ``skewX(r)``, ``skewXg(d)``. Skews a picture around ``(0, 0)`` in the ``X`` dimension:

  * by ``r`` radians

  * by ``d`` degrees

skewY
-----

Signatures: ``skewY(r)``, ``skewYg(d)``. Skews a picture around ``(0, 0)`` in the ``Y`` dimension:

  * by ``r`` radians

  * by ``d`` degrees

reflect
-------

Signatures: ``reflect(a, b)``, ``reflect(p)``. Reflects points around a line that goes through the origin ``(0, 0)``:

  * around the line ``[(0, 0), (a, b)]``

  * around the line ``[(0, 0), (p.x, p.y)]``

project
-------

Signatures: ``project(a, b)``, ``project(p)``. Projects points on a line that goes through the origin ``(0, 0)``:

  * on the line ``[(0, 0), (a, b)]``

  * on the line ``[(0, 0), (p.x, p.y)]``

==================
General operations
==================

In all signatures ``a``, ``b``, ``c``, and ``e`` are numbers (coordinate components or scaling factors), ``p`` is a 2D coordinate, ``r`` is an angle in radians, ``d`` is an angle in degrees (positive value of an angle is CW), ``m`` is a matrix.

invert
------

Signatures: ``invert(m)``. Inverts a matrix. This useful function calculates a matrix, which will do the opposite transformation to the m matrix effectively undoing it. For example, ``scale(2)`` produces a matrix to scale uniformly a picture by 2. The opposite matrix is going to be ``scale(0.5)``. We can produce the same result with ``invert(scale(2))``. While it seems complicated for this simple case, frequently it is the only way to calculate an inverted matrix for complex transformation, especially when we don’t know how it was produced initially.

clone
-----

Signatures: ``clone(m)``. Creates a copy of the ``m`` matrix.

multiplyPoint
-------------

Signatures: ``multiplyPoint(m, a, b)``, ``multiplyPoint(m, p)``. Applies a transformation to a coordinate.

multiply
--------

Signatures: ``multiply(m1, m2, ...)``. Multiplies all its parameters to create a single matrix.

This function is extremely useful and there is a shortcut for it: anywhere a matrix is expected, an array of matrices can be specified as well. Examples:

* ``[2, rotateg(45)]`` --- rotates everything 45 degrees CW around ``(0, 0)`` and scales everything by 2 after that.

* ``[{dy: 10}, scale(2, 1)]`` --- scales all ``X`` coordinates by 2, and moves the result down by 10.

More complex example: imagine you have a surface 500 by 500 pixels, and you want everything in it to be magnified around its center by 2, and rotated (around the center as well) by 30 degrees CW. It is easy: ``[translate(250, 250), rotateg(−30), scale(2), translate(-250, -250)]``. Explanations:

1. All scaling, rotating, and skewing operations work around ``(0, 0)`` point. Let’s move the center of our picture to ``(0, 0)``: ``translate(−250, −250)``.

2. Now we can scale it: ``scale(2)``.

3. Now we can rotate it: ``rotateg(−30)``.

4. Now let’s move our center back: ``translate(250, 250)``.

You can see that this kind of transformations follow a ``"sandwich"`` pattern, where the first and the last transformation move an immutable point to/from the origin of coordinates before performing other origin-based operations. The first operation is usually a translation to the origin, and the last is the inverse of the same translation.

==================
"Sandwich" helpers
==================

These "around the point" operations are so important that ``dojox.gfx`` provides several helpers for common transformations. Usually they are named like their middle "meaty" part with the suffix ``At``. Example: ``scale(a)`` => ``scaleAt(a, p)``.

In all signatures ``a``, ``b``, ``c``, and ``e`` are numbers (coordinate components or scaling factors), ``p`` is a 2D coordinate, ``r`` is an angle in radians, ``d`` is an angle in degrees (positive value of an angle is CW), ``m`` is a matrix.

If a function accepts an angle value, there are two versions of this function: with radians, and with degrees. The latter will be denoted with ``g`` suffix. Example: ``rotate(r)`` accepts radians, while ``rotateg(d)`` accepts degrees.

scaleAt
-------

Applies scale_ with the center at the given point.

Signatures:

* ``scaleAt(a, p)``
    ``scale(a)`` around ``(p.x, p.y)``

* ``scaleAt(a, b, c)``
    ``scale(a)`` around ``(b, c)``

* ``scaleAt(a, b, p)``
    ``scale(a, b)`` around ``(p.x, p.y)``

* ``scaleAt(a, b, c, e)``
    ``scale(a, b)`` around ``(c, e)``

rotateAt
--------

Applies rotate_ with the center at the given point.

Signatures:

* ``rotateAt(r, p)``
    ``rotate(r)`` at ``(p.x, p.y)``

* ``rotateAt(r, a, b)``
    ``rotate(r)`` at ``(a, b)``

* ``rotategAt(d, p)``
    ``rotateg(d)`` at ``(p.x, p.y)``

* ``rotategAt(d, a, b)``
    ``rotateg(d)`` at ``(a, b)``

skewXAt
-------

Applies skewX_ with the center at the given point.

Signatures:

* ``skewXAt(r, p)``
    ``skewX(r)`` at ``(p.x, p.y)``

* ``skewXAt(r, a, b)``
    ``skewX(r)`` at ``(a, b)``

* ``skewXgAt(d, p)``
    ``skewXg(d)`` at ``(p.x, p.y)``

* ``skewXgAt(d, a, b)``
    ``skewXg(d)`` at ``(a, b)``

skewYAt
-------

Applies skewY_ with the center at the given point.

Signatures:

* ``skewYAt(r, p)``
    ``skewY(r)`` at ``(p.x, p.y)``

* ``skewYAt(r, a, b)``
    ``skewY(r)`` at ``(a, b)``

* ``skewYgAt(d, p)``
    ``skewYg(d)`` at ``(p.x, p.y)``

* ``skewYgAt(d, a, b)``
    ``skewYg(d)`` at ``(a, b)``
