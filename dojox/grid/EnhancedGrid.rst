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

testing...


.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojo.data.ItemFileWriteStore");

        dojo.addOnLoad(function(){
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
          
          var layout = [[{'name': 'Column 1'}]];

            var grid = new dojox.grid.EnhancedGrid({
              'id': 'grid',
              'store': store,              
              'structure': layout,
              'rowSelector': '20px'},
            document.createElement('div'));

          /*append the new grid to the div*/
          dojo.byId("gridDiv").appendChild(grid.domNode);


          grid.startup();

        });
    </script>

  .. cv:: html

    <div id="gridDiv"></div>

  .. cv:: css

    <style type="text/css">
        @import "{{baseUrl}}dojo/resources/dojo.css";
        @import "{{baseUrl}}dijit/themes/claro/claro.css";
	@import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
	@import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

        /*Grid need a explicit width/height by default*/
        #grid {
            width: 43em;
            height: 20em;
        }
    </style>

























This is the most simple way to run up an EnhancedGrid, it's basically the same as a base DataGrid since no plugins are turned on.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 550
  :height: 330

  .. javascript::

    <script type="text/javascript">
        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojo.data.ItemFileWriteStore");
    
        dojo.addOnLoad(function(){
	  //set up data store
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
	
	  //set up layout
	  var layout = [[
		{'name': 'Column 1', 'field': 'id'},
		{'name': 'Column 2', 'field': 'col2'},
		{'name': 'Column 3', 'field': 'col3', 'width': '230px'},
		{'name': 'Column 4', 'field': 'col4'}
	  ]];

          // create a new grid:
          var grid = new dojox.grid.EnhancedGrid({
              id: 'grid',
              store: store,              
              structure: layout,
              rowSelector: '20px'},
            document.createElement('div'));

          //append the new grid to the div
          dojo.byId("gridDiv").appendChild(grid.domNode);

          // Call startup() to render the grid
          grid.startup();
        });
    </script>

  .. html::

    <div id="gridDiv"></div>

  .. css::

    <style type="text/css">
        @import "{{baseUrl}}dojo/resources/dojo.css";
        @import "{{baseUrl}}dijit/themes/claro/claro.css";
	@import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
	@import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

        /*Grid need a explicit width/height by default*/
        #grid {
            width: 43em;
            height: 20em;
        }
    </style>

=====================================
Run EnhancedGrid with various plugins
=====================================

EnhanedGrid can also be run with a flexible combination of various plugins, a typical usage will look like:


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

Following is a complete list of EnahancedGrid plugins, please refer to the separate page for detail usages:

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
