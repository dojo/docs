.. _dojox/grid/EnhancedGrid:

=======================
dojox.grid.EnhancedGrid
=======================

:Project owner: Evan Huang
:since: V.1.4

.. contents ::
   :depth: 2

Introduction
============

EnhancedGrid (dojox.grid.EnhancedGrid) provides a rich set of features that enhance the capabilities of base DataGrid. All these features are implemented as separate plugins which can be loaded on demand, the required features must be declared before used.


Run EnhancedGrid without plugins
================================

This is the most simple way to run up an EnhancedGrid, it's basically the same as a base DataGrid since no plugins are turned on.

.. code-example ::

  .. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojo.data.ItemFileWriteStore");
    
      dojo.ready(function(){
          /*set up data store*/
          var data = {
            identifier: 'id',
            items: []
          };
          var data_list = [
            { col1: "normal", col2: false, col3: 'But are not followed by two hexadecimal', col4: 29.91},
            { col1: "important", col2: false, col3: 'Because a % sign always indicates', col4: 9.33},
            { col1: "important", col2: false, col3: 'Signs can be selectively', col4: 19.34}
          ];
          var rows = 60;
          for(var i=0, l=data_list.length; i<rows; i++){
            data.items.push(dojo.mixin({ id: i+1 }, data_list[i%l]));
          }
          var store = new dojo.data.ItemFileWriteStore({data: data});

          /*set up layout*/
          var layout = [[
            {'name': 'Column 1', 'field': 'id'},
            {'name': 'Column 2', 'field': 'col2'},
            {'name': 'Column 3', 'field': 'col3', 'width': '230px'},
            {'name': 'Column 4', 'field': 'col4', 'width': '230px'}
          ]];

          /*create a new grid:*/
          var grid = new dojox.grid.EnhancedGrid({
              id: 'grid',
              store: store,
              structure: layout,
              rowSelector: '20px'},
            document.createElement('div'));

          /*append the new grid to the div*/
          dojo.byId("gridDiv").appendChild(grid.domNode);

          /*Call startup() to render the grid*/
          grid.startup();
      });

  .. html ::

    <div id="gridDiv"></div>

  .. css ::

    @import "{{baseUrl}}dojo/resources/dojo.css";
    @import "{{baseUrl}}dijit/themes/claro/claro.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

    /*Grid need a explicit width/height by default*/
    #grid {
        width: 45em;
        height: 20em;
    }

Run EnhancedGrid with various plugins
=====================================

EnhancedGrid can also be run with a flexible combination of various plugins, a typical usage will look like:


1. Import theme CSS

.. css ::
  
      @import "dijit/themes/claro/claro.css";
      @import "dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
      ...


2. Declare required feature plugins

.. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.DnD");
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
      dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");
      ...

3. Use feature plugins:

.. js ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid"
      data-dojo-props="plugins:{dnd: true, nestedSorting: true, indirectSelection: true, ...}" ...>
  </div>


EnhancedGrid plugin list
=============================

Following is a complete list of EnhancedGrid plugins, please refer to the separate page for detail usages:

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

Accessibility
=============

EnhancedGrid provides the same a11y support level as :ref:`DataGrid <dojox/grid/DataGrid>` , or see the above plugin pages for more details.

And summary attribute can be added in a similar way as `DataGrid <http://livedocs.dojotoolkit.org/dojox/grid/DataGrid#add-summary-attribute>`_.


Known Issues
============

* See the `outstanding tickets for the EnhancedGrid <http://bugs.dojotoolkit.org/query?owner=Evan&status=accepted&status=assigned&status=new&status=reopened&type=defect&summary=~enhanced&col=id&col=summary&col=status&col=type&col=priority&col=milestone&col=component&order=priority>`_.


See also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid

* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>` - Support tree structure data

* :ref:`dojox.grid.LazyTreeGrid <dojox/grid/LazyTreeGrid>` - Provides lazy loading and virtual scrolling for nested levels of huge children rows
