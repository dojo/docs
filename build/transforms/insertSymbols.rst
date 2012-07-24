.. _build/transforms/insertSymbols:

=============================
Build Transform insertSymbols
=============================


.. contents ::
   :depth: 2

Summary
=======

Inserts debug symbols.

Description
===========

This transform inserts synthetic names for anonymous functions and outputs a symbol table for these names. This can be useful for some debugging situations.

Profile Knobs
=============


``symbol`` (default = 0)
  * [falsy] The transform does nothing.
  * ["short"] A short symbol format is used.
  * ["truthy"] A longer, more-sematic symbol format is used.


Source Location
===============

util/build/transforms/insertSymbols.js

