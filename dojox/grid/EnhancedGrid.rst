#format dojo_rst

dojo.modulename
===============

:Status: Draft
:Version: 1.0
:Project owner: Nathan Toone
:Available: since V1.4

.. contents::
   :depth: 2

Enhanced DataGrid adds numerous useful features to dojox.grid.


============
Introduction
============

EnhancedGrid (dojox.grid.EnhancedGrid) provides a rich set of features that enhance the capabilities of base DataGrid. The following enhancements are implemented in Dojo 1.4:

* Nested Sorting
* Built-in support for Indirect Selection (radio buttons and check boxes)
* Declarative context menu
* Selecting rows or columns by swiping
* Moving multiple rows or columns with drag-n-drop

There is currently a project to implement a [[/dojox/grid/pluginAPI|Grid plugin architecture]]. To be compatible with this work, EnhancedGrid features are implemented as plugins which can be loaded on demand. As a result, the required features must first declared before they can be used.

=====
Usage
=====

The following steps show a typical usage of EnhancedGrid:

.. code-block :: javascript
 :linenos:

<style type="text/css">
     @import "../../../../dijit/themes/tundra/tundra.css";
     @import "../../enhanced/resources/tundraEnhancedGrid.css";
         ...
</style>

========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
