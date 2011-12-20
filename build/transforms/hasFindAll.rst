.. _build/transforms/hasFindAll:

==========================
Build Transform hasFindAll
==========================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Finds all has.js tests and optionally reports feature test usage as part of the build report.

Description
===========

This transform scans a resource for has.js feature tests of the form

  ``has("`` *feature-name* ``")``

A regular expression is used to effect the scanning. The expression ignores spaces around the parenthesis and accepts
either single- or double-quotes. The character preceding the "has" function name must not be in ``[\w\.]``.

As feature tests are discovered, the module in which they reside is memorized. If the profile property ``hasReport`` is
truthy, then a map from has feature test to the list of modules that use each test is written to the build report.

Profile Knobs
=============

``hasReport`` (default = ``undefined``)
  * [*truthy*] A report of all has tests and their locations is written in the build report.

  * [*falsy*] No has location report is written.

Source Location
===============

util/build/transforms/hasFindAll.js
