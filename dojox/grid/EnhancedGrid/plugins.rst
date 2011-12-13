.. _dojox/grid/EnhancedGrid/plugins:

===============================
dojox.grid.EnhancedGrid.plugins
===============================

:Authors: Oliver Zhu
:Project owner: Evan Huang
:since: V.1.6

EnhancedGrid provides a plugin framework, which can support a rich set of new features as plugins.
The followings are implemented in Dojo 1.6:

Plugin List
===========

These plugins are loaded on demand, so they must be required and declared before being used.

* :ref:`Nested Sorting <dojox/grid/EnhancedGrid/plugins/NestedSorting>` - Multiple column sorting
* :ref:`Indirect Selection <dojox/grid/EnhancedGrid/plugins/IndirectSelection>` - Selecting rows with radio button or check box
* :ref:`Declarative context menus <dojox/grid/EnhancedGrid/plugins/Menus>` - Context menus for row, column, header and selected regions
* :ref:`Filter <dojox/grid/EnhancedGrid/plugins/Filter>` - Support for defining rules to filter grid content with various data types.
* :ref:`Exporter <dojox/grid/EnhancedGrid/plugins/Exporter>` - Exporting grid content to various formats.
* :ref:`Printer <dojox/grid/EnhancedGrid/plugins/Printer>` - Providing convenient ways to print grid.
* :ref:`Selector <dojox/grid/EnhancedGrid/plugins/Selector>` - Unified extended selection support for rows, columns and cells.
* :ref:`DnD <dojox/grid/EnhancedGrid/plugins/DnD>` - Drag-and-drop support for rows/columns/cells, either within grid or out of grid.
* :ref:`Pagination <dojox/grid/EnhancedGrid/plugins/Pagination>` - Pagination approach to work with huge data set besides the default virtual scrolling way
* :ref:`CellMerge <dojox/grid/EnhancedGrid/plugins/CellMerge>` - Merging adjacent cells within a row.
* :ref:`Cookie <dojox/grid/EnhancedGrid/plugins/Cookie>` - Grid preferences persistence e.g column width|order and sorting order.
* :ref:`Search <dojox/grid/EnhancedGrid/plugins/Search>` - Searching grid content by regular expressions or simple wildcard pattern.

See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid
* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>` - Grid with collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure
