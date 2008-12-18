#format dojo_rst

Geometric properties
====================

:Status: Draft
:Version: 1.3
:Authors: Eugene Lazutkin, Kun Xi, Chris Mitchell
:Available: since 0.4

.. contents::
  :depth: 3

===============================
Coordinates and transformations
===============================

In order to understand transformations you need to be familiar with fundamentals of matrices (matrix multiplication, multiplication of a vector by a matrix, order of multiplications). `dojox.gfx <dojox/gfx>`_ uses a mnemonic way to describe a matrix: ``xx`` scales an ``X`` component of a coordinate, ``yy`` scales a ``Y`` component, ``xy``, and ``yx`` affect both components, ``dx`` moves an ``X`` component, and ``dy`` moves a ``Y`` component. If you want to refresh your memory, read our `Matrix tutorial <dojox/gfx/matrix-tutorial>`_.

Simple examples:

* ``{xx: 2}`` --- stretches the ``X`` dimension by 2.

* ``{yy: 0.5}`` --- ``"stretches"`` the ``Y`` dimension by 0.5 (shrinks by 2).

* ``{dx: 5, dy: 10}`` --- shifts an ``X`` coordinate by 5, a ``Y`` coordinate by 10.

* ``{xx: 0.866, xy: 0.5, yx: −0.5, yy: 0.866}`` --- rotates everything by approximately 30 degrees clockwise (CW) around point ``(0, 0)``.

* ``{xx: 0, xy: 1, yx: −1, yy: 0, dx: 100}`` --- rotates everything by 90 degrees CW around ``(0, 0)``, and moves things right by 100.

Don’t worry, in most cases you don’t need to calculate all members of a transformation matrix directly. As you can see not all members of matrix should be specified --- all skipped members going to be copied from the identity matrix. There is a shortcut for scaling --- if a number N is used instead of a matrix, it is assumed that it represents a uniform scaling matrix ``{xx: N, yy: N}``.

`dojox.gfx.matrix <dojox/gfx/matrix>`_ defines ``Matrix2D`` class, as well as numerous helpers (``Matrix2D`` is propagated to ``dojox.gfx`` namespace for convenience). Most important of them (all in ``dojox.gfx.matrix`` namespace) are listed below. In all signatures ``a``, ``b``, ``c``, and ``e`` are numbers (coordinate components or scaling factors), ``p`` is a 2D coordinate, ``r`` is an angle in radians, ``d`` is an angle in degrees (positive value of an angle is CW), ``m`` is a matrix.

Constants
---------

identity
  an identity matrix. This matrix doesn’t change a picture at all.

flipX
  changes a sign of all ``X`` coordinates. This matrix mirrors the picture around the ``Y`` axis.

flipY
  changes a sign of all ``Y`` coordinates. This matrix mirrors the picture around the ``X`` axis.

flipXY
  changes a sign of all coordinates. This matrix rotates the picture by 180 degrees around ``(0, 0)`` point. Another way to say it: it mirrors all points around ``(0, 0)``.

Matrix creators
---------------

translate(a, b), translate(p)
  shifts everything:

  * by ``{dx: a, dy: b}``

  * by ``{dx: p.x, dy: p.y}``

scale(a, b), scale(a), scale(p)
  scales a picture:

  * by ``{xx: a, yy: b}``

  * by ``{xx: a, yy: a}``

  * by ``{xx: p.x, yy: p.y}``

rotate(r), rotateg(d)
  rotates a picture around ``(0, 0)``:

  * by ``r`` radians

  * by ``d`` degrees

skewX(r), skewXg(d)
  skews a picture around ``(0, 0)`` in the ``X`` dimension:

  * by ``r`` radians

  * by ``d`` degrees

skewY(r), skewYg(d)
  skews a picture around ``(0, 0)`` in the ``Y`` dimension:

  * by ``r`` radians

  * by ``d`` degrees

reflect(a, b), reflect(p)
  reflects points around a line that goes through the origin ``(0, 0)``:

  * around the line ``[(0, 0), (a, b)]``

  * around the line ``[(0, 0), (p.x, p.y)]``

project(a, b), project(p)
  projects points on a line that goes through the origin ``(0, 0)``:

  * on the line ``[(0, 0), (a, b)]``

  * on the line ``[(0, 0), (p.x, p.y)]``
