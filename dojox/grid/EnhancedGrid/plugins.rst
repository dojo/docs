#format dojo_rst

dojox.grid.EnhancedGrid.plugins
===============================

:Authors: Oliver Zhu
:Project owner: Evan Huang
:Available: since V.1.6

EnhancedGrid provides a plugin framework, which can support a rich set of new features as plugins.
The followings are implemented in Dojo 1.6:

===========
Plugin List
===========

These plugins are loaded on demand, so they must be required and declared before being used.

* `Nested Sorting <dojox/grid/EnhancedGrid/plugins/NestedSorting>`_ - Multiple column sorting
* `Indirect Selection <dojox/grid/EnhancedGrid/plugins/IndirectSelection>`_ - Selecting rows with radio button or check box
* `Declarative context menus <dojox/grid/EnhancedGrid/plugins/Menus>`_ - Context menus for row, column, header and selected regions
* `Filter <dojox/grid/EnhancedGrid/plugins/Filter>`_ - Support for defining rules to filter grid content with various data types.
* `Exporter <dojox/grid/EnhancedGrid/plugins/Exporter>`_ - Exporting grid content to various formats.
* `Printer <dojox/grid/EnhancedGrid/plugins/Printer>`_ - Providing convenient ways to print grid.
* `Selector <dojox/grid/EnhancedGrid/plugins/Selector>`_ - Unified extended selection support for rows, columns and cells. 
* `DnD <dojox/grid/EnhancedGrid/plugins/DnD>`_ - Drag-and-drop support for rows/columns/cells, either within grid or out of grid.
* `Pagination <dojox/grid/EnhancedGrid/plugins/Pagination>`_ - Pagination approach to work with huge data set besides the default virtual scrolling way
* `CellMerge <dojox/grid/EnhancedGrid/plugins/CellMerge>`_ - Merging adjacent cells within a row.
* `Cookie <dojox/grid/EnhancedGrid/plugins/Cookie>`_ - Grid preferences persistence e.g column width|order and sorting order.
* `Search <dojox/grid/EnhancedGrid/plugins/Search>`_ - Searching grid content by regular expressions or simple wildcard pattern.

========
See Also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_ - The base grid
* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_ - Grid with collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure
