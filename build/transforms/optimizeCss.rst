.. _build/transforms/optimizeCss:

===========================
Build Transform optimizeCss
===========================


.. contents ::
   :depth: 2

Summary
=======

Optimizes CSS resources.

Description
===========

"Flattens" CSS resources by expanding all ``import`` directives. This can improve download performance by reducing the number of resources as well as the length of serial chains resulting from nested ``import`` directives.

Profile Knobs
=============


``keepLines`` (default = 0)
  * [falsy] Remove newlines from CSS resources.
  * [truthy] Do not remove newlines from CSS resources.


Source Location
===============

util/build/transforms/optimizeCss.js

