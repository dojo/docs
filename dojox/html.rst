#format dojo_rst

dojox.html
==========

:Status: Draft
:Version: 1.0
:Authors: Marcus Reimann
:Developers: ?-
:Available: since V1.2

.. contents::
    :depth: 2

**dojox.html** offers additional HTML helper functions.


========
Features
========

* dojox.html

  A generic content setter, including adding new stylesheets and evaluating scripts (was part of ContentPane loaders, now separated for generic usage)

* dojox.html.metrics

  * Formerly private to dojox.gfx, now available in dojox.html
  * Includes translation of relative CSS values (such as medium, small, x-small, etc.) to actual pixel values
  * Translate other CSS units (such as em, pt) to pixel values
  * Scrollbar sizes (width and height)
  * Ability to detect font resizing

* dojox.html.styles

  * Insert and remove CSS rules.
  * Search document for style sheets.
  * Toggle sheets on and off (based on the W3C spec).
