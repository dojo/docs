#format dojo_rst

dojox.grid.EnhancedGrid.plugins
===============================

:Authors: Zhu Xiao Wen
:Project owner: Nathan Toone
:Available: since V.1.6

EnhancedGrid provides a plugin framework, which can support a rich set of new features as plugins.
The followings are implemented in Dojo 1.6:

===========
Plugin List
===========

These plugins are loaded on demand, so they must be required and declared before being used.

* `Filter <dojox/grid/EnhancedGrid/plugins/Filter>`_ - Support for defining rules to filter grid data for various data types.
* `Exporter <dojox/grid/EnhancedGrid/plugins/Exporter>`_ - With an export framework, exporting grid to various formats are possible.
* `Printer <dojox/grid/EnhancedGrid/plugins/Printer>`_ - Some convenient functions to print grid.
* `Selector <dojox/grid/EnhancedGrid/plugins/Selector>`_ - Uniformed extended selection support for rows, columns and even cells. 
* `DnD <dojox/grid/EnhancedGrid/plugins/DnD>`_ - Drag-and-drop support for rows/columns/cells, both within grid and out of grid.
* `Pagination <dojox/grid/EnhancedGrid/plugins/Pagination>`_ - A different approach to demonstrate huge data store other than virtual scrolling.
* `CellMerge <dojox/grid/EnhancedGrid/plugins/CellMerge>`_ - Support for merging adjacent cells within a row.
* `Cookie <dojox/grid/EnhancedGrid/plugins/Cookie>`_ - Persistence of grid features, like column width, column order, and sorting order.
* `Search <dojox/grid/EnhancedGrid/plugins/Search>`_ - Support of searching the grid by regular expressions as well as wildcard patterns.

========
See Also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_ - The base grid
* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_ - Grid with collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure
