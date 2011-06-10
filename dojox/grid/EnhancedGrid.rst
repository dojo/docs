#format dojo_rst

dojox.grid.EnhancedGrid
=======================

:Project owner: Evan Huang
:Available: since V.1.4

.. contents::
   :depth: 2

============
Introduction
============

EnhancedGrid (dojox.grid.EnhancedGrid) provides a rich set of features that enhance the capabilities of base DataGrid. All these features are implemented as separate plugins which can be loaded on demand, the required features must be declared before used. 


================================
Run EnhancedGrid without plugins
================================

This is the most simple way to run up an EnhancedGrid, and in this scenario, it's basically the same as a base DataGrid since no plugins are turned on.

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    <script type="text/javascript">
	dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojox.data.CsvStore");
    
        dojo.addOnLoad(function(){
          // our test data store for this example:
          var store = new dojox.data.CsvStore({ url: '{{ dataUrl }}dojox/grid/tests/support/movies.csv' });

          // set the layout structure:
          var layout = [
              { field: 'Title', name: 'Title of Movie', width: '200px' },
              { field: 'Year', name: 'Year', width: '50px' },
              { field: 'Producer', name: 'Producer', width: 'auto' }
          ];

          // create a new grid:
          var grid = new dojox.grid.EnhancedGrid({
              query: { Title: '*' },
              store: store,
              rowSelector: '20px',
              structure: layout}
          , document.createElement('div'));

          // append the new grid to the div "gridContainer4":
          dojo.byId("gridDiv").appendChild(grid.domNode);

          // Call startup, in order to render the grid:
          grid.startup();
        });
    </script>

  .. html::

    <div id="gridDiv" style="width: 100%; height: 100%;"></div>

  .. css::

    <style type="text/css">
        @import "{{ baseUrl }}dojo/resources/dojo.css";
        @import "{{ baseUrl }}dijit/themes/{{ theme }}/{{ theme }}.css";
	@import "{{ baseUrl }}dojox/grid/enhanced/resources/{{ theme }}/EnhancedGrid.css";
	@import "{{ baseUrl }}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

        .dojoxGrid table {
            margin: 0;
        }

        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
        }
    </style>

=====================================
Run EnhancedGrid with various plugins
=====================================

EnhanedGrid can also be run with a flexible combination of the various plugins, a typical usage will look like:


1. Import theme CSS

.. code-block :: javascript
  :linenos:

  <style type="text/css">
      @import "dijit/themes/claro/claro.css";
      @import "dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
      ...
  </style>


2. Declare required feature plugins 

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.DnD"); 
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
      dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");
      ...
  </script>

3. Use feature plugins:

.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
      plugins="{dnd: true, nestedSorting: true, indirectSelection: true, ...}" ...>
  </div>


=============================
EnhancedGrid plugin list
=============================

Following below is a full list of EnahancedGrid plugins, please refer to the separate doc page for more details:

* `Nested Sorting <dojox/grid/EnhancedGrid/plugins/NestedSorting>`_ - Multiple column sorting
* `Indirect Selection <dojox/grid/EnhancedGrid/plugins/IndirectSelection>`_ - Selecting rows with radio buttons or check boxes
* `Declarative context menus <dojox/grid/EnhancedGrid/plugins/Menus>`_ - Context menus for header, row, cell and selected regions
* `Filter <dojox/grid/EnhancedGrid/plugins/Filter>`_ - Support for defining rules to filter grid content in various data types.
* `Exporter <dojox/grid/EnhancedGrid/plugins/Exporter>`_ - Exporting grid content to various formats.
* `Printer <dojox/grid/EnhancedGrid/plugins/Printer>`_ - Providing convenient ways to printing grid.
* `Selector <dojox/grid/EnhancedGrid/plugins/Selector>`_ - Unified extended selection support for rows, columns and cells. 
* `DnD <dojox/grid/EnhancedGrid/plugins/DnD>`_ - Drag-and-drop support for rows/columns/cells, both within grid and out of grid.
* `Pagination <dojox/grid/EnhancedGrid/plugins/Pagination>`_ - Pagination approach to work with huge data set besides the default virtual scrolling way
* `CellMerge <dojox/grid/EnhancedGrid/plugins/CellMerge>`_ - Merging adjacent cells within a row.
* `Cookie <dojox/grid/EnhancedGrid/plugins/Cookie>`_ - Persisting grid preferences, e.g column width|order and sorting order.
* `Search <dojox/grid/EnhancedGrid/plugins/Search>`_ - Searching the grid by regular expressions as well as wildcard pattern.


============
Known Issues
============

* See the `outstanding tickets for the EnhancedGrid <http://bugs.dojotoolkit.org/query?status=assigned&status=new&status=reopened&component=DojoX+Grid&order=priority&owner=Evan&type=defect&col=id&col=summary&col=status&col=type&col=priority&col=milestone&report=93#no2>`_.

========
See also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_ - The base grid

* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_ - Support tree structure data

* `dojox.grid.LazyTreeGrid <dojox/grLazyTreeGridid/>`_ - Provides lazy loading and virtual scrolling for huge children rows
