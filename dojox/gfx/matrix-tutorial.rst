#format dojo_rst

Matrix tutorial
===============

:Status: Draft
:Project owner: Eugene Lazutkin

Linear transformations are very important part of any graphics library. We deal
with 2D graphics, it means we operate with 3 by 3 matrices:

Because the third row is always constant we use an abbreviated way to write it:
``{xx: 1, xy: 0, yx: 0, yy: 1, dx: 0, dy: 0}`` --- this is an identity matrix. The same
simplification goes for coordinates:

Because the third element is always 1 we “add” it virtually: ``{x: 12, y: 33}``.
The way to apply a matrix to a coordinate (to multiply a coordinate by a
matrix):

* ``o = M * i`` --- where, ``i`` is an input vector (e.g., ``{x: 1, y: 2}``), ``M`` is a transformation matrix, ``o`` is a resulting vector, and ``*`` denotes a multiplication operation:
