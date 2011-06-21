#format dojo_rst

dojox.grid.EnhancedGrid.plugins.Menu
=============================================

:Authors: Evan Huang
:Project owner: Evan Huang
:Available: since V.1.6

.. contents::
   :depth: 2

==============
Introduction
==============

With this feature, users can add context menus either through declarative HTML markup or JavaScript. The following menu types are supported:

* Header menu
* Row menu
* Cell menu
* Selected region menu
  - Selected regions could be selected rows, columns or cells

HTML markup usage sample

.. code-example::
  :toolbar: themes, versions, dir
  :width: 550
  :height: 330

  .. javascript::

    <script type="text/javascript">
        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojox.grid.enhanced.plugins.Menu");
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
		data.items.push(dojo.mixin({ id: i }, data_list[i%l]));
	  }
	  var store = new dojo.data.ItemFileWriteStore({data: data});
	
	  //set up layout
	  var layout = [[
		{name: 'Column 1', field: 'id'},
		{name: 'Column 2', field: 'col2'},
		{name: 'Column 3', field: 'col3', width: "230px"},
		{name: 'Column 4', field: 'col4'}
	  ]];

          // create a new grid:
          var grid = new dojox.grid.EnhancedGrid({
              id: 'grid',
              store: store,              
              structure: layout,
              rowSelector: '20px',
              plugins: {menus:{headerMenu:"headerMenu", rowMenu:"rowMenu", cellMenu:"cellMenu", selectedRegionMenu:"selectedRegionMenu"}}},
            document.createElement('div'));

          // append the new grid to the div
          dojo.byId("gridDiv").appendChild(grid.domNode);

          // Call startup() to render the grid
          grid.startup();
        });
    </script>

  .. html::

	<div id="gridDiv">
		<div dojoType="dijit.Menu" id="headerMenu"  style="display: none;">
			<div dojoType="dijit.MenuItem">Header Menu Item 1</div>
			<div dojoType="dijit.MenuItem">Header Menu Item 2</div>
			<div dojoType="dijit.MenuItem">Header Menu Item 3</div>
			<div dojoType="dijit.MenuItem">Header Menu Item 4</div>
		</div>
		<div dojoType="dijit.Menu" id="rowMenu"  style="display: none;">
			<div dojoType="dijit.MenuItem">Row Menu Item 1</div>
			<div dojoType="dijit.MenuItem">Row Menu Item 2</div>
			<div dojoType="dijit.MenuItem">Row Menu Item 3</div>
			<div dojoType="dijit.MenuItem">Row Menu Item 4</div>
		</div>
		<div dojoType="dijit.Menu" id="cellMenu"  style="display: none;">
			<div dojoType="dijit.MenuItem">Cell Menu Item 1</div>
			<div dojoType="dijit.MenuItem">Cell Menu Item 2</div>
			<div dojoType="dijit.MenuItem">Cell Menu Item 3</div>
			<div dojoType="dijit.MenuItem">Cell Menu Item 4</div>
		</div>
		<div dojoType="dijit.Menu" id="selectedRegionMenu"  style="display: none;">
			<div dojoType="dijit.MenuItem">Action 1 for Selected Region</div>
			<div dojoType="dijit.MenuItem">Action 2 for Selected Region</div>
			<div dojoType="dijit.MenuItem">Action 3 for Selected Region</div>
			<div dojoType="dijit.MenuItem">Action 4 for Selected Region</div>
		</div>	
	</div>


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

Javascript usage sample

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    <script type="text/javascript">
	dojo.require("dojox.grid.EnhancedGrid");
	dojo.require("dojox.grid.enhanced.plugins.Menu");
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

	   //programmatic menus
		var menusObject = {
			headerMenu: new dijit.Menu(),
			rowMenu: new dijit.Menu(),
			cellMenu: new dijit.Menu(),
			selectedRegionMenu: new dijit.Menu()
		};
		menusObject.headerMenu.addChild(new dijit.MenuItem({label: "Header Menu Item 1"}));
		menusObject.headerMenu.addChild(new dijit.MenuItem({label: "Header Menu Item 2"}));
		menusObject.headerMenu.addChild(new dijit.MenuItem({label: "Header Menu Item 3"}));
		menusObject.headerMenu.addChild(new dijit.MenuItem({label: "Header Menu Item 4"}));
		menusObject.headerMenu.startup();
		
		menusObject.rowMenu.addChild(new dijit.MenuItem({label: "Row Menu Item 1"}));
		menusObject.rowMenu.addChild(new dijit.MenuItem({label: "Row Menu Item 2"}));
		menusObject.rowMenu.addChild(new dijit.MenuItem({label: "Row Menu Item 3"}));
		menusObject.rowMenu.addChild(new dijit.MenuItem({label: "Row Menu Item 4"}));
		menusObject.rowMenu.startup();
		
		menusObject.cellMenu.addChild(new dijit.MenuItem({label: "Cell Menu Item 1"}));
		menusObject.cellMenu.addChild(new dijit.MenuItem({label: "Cell Menu Item 2"}));
		menusObject.cellMenu.addChild(new dijit.MenuItem({label: "Cell Menu Item 3"}));
		menusObject.cellMenu.addChild(new dijit.MenuItem({label: "Cell Menu Item 4"}));
		menusObject.cellMenu.startup();
		
		menusObject.selectedRegionMenu.addChild(new dijit.MenuItem({label: "Action 1 for Selected Region"}));
		menusObject.selectedRegionMenu.addChild(new dijit.MenuItem({label: "Action 2 for Selected Region"}));
		menusObject.selectedRegionMenu.addChild(new dijit.MenuItem({label: "Action 3 for Selected Region"}));
		menusObject.selectedRegionMenu.addChild(new dijit.MenuItem({label: "Action 4 for Selected Region"}));
		menusObject.selectedRegionMenu.startup();
		
	      
          // create a new grid:
          var grid = new dojox.grid.EnhancedGrid({
              query: { Title: '*' },
              store: store,
              clientSort: true,
              rowSelector: '20px',
              structure: layout,
              plugins : {menus: menusObject}
          }, document.createElement('div'));

          // append the new grid to the div "gridContainer4":
          dojo.byId("gridDiv").appendChild(grid.domNode);

          // Call startup, in order to render the grid:
          grid.startup();
        });
    </script>

  .. html::

	<div id="gridDiv" style="width: 100%; height: 100%;">

	</div>

  .. css::

    <style type="text/css">
		@import "{{ baseUrl }}dojox/grid/enhanced/resources/{{ theme }}EnhancedGrid.css";
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


Usage
-----

* Declare menu feature plugin

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.Menu");
      ...
  </script>

* Use menu feature

... with HTML markup
    
.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid"
      plugins="{menus:{headerMenu:’headerMenu‘, rowMenu:’rowMenu‘, cellMenu:’cellMenu‘, selectedRegionMenu:’selectedRegionMenu‘}}" ... >
      <div dojoType="dijit.Menu" id="headerMenu" style="display: none;">
          <div dojoType="dijit.MenuItem">Header Menu Item 1</div>
      </div>
      <div dojoType="dijit.Menu" id="rowMenu" style="display: none;">
          <div dojoType="dijit.MenuItem">Row Menu Item 1</div>
      </div>
      <div dojoType="dijit.Menu" id="cellMenu" style="display: none;">
          <div dojoType="dijit.MenuItem">Cell Menu Item 1</div>
      </div>
      <div dojoType="dijit.Menu" id="selectedRegionMenu" style="display: none;">
          <div dojoType="dijit.MenuItem">Action 1 for Selected Region</div>
      </div>
  </div>

... with JavaScript (using a markup menu)
    
.. code-block :: javascript
  :linenos:

  var grid = new dojox.grid.EnhancedGrid({id: "grid",
      plugins: {menus:{headerMenu:’headerMenu‘, rowMenu:’rowMenu‘, cellMenu:’cellMenu‘, selectedRegionMenu:’selectedRegionMenu‘}}, ...},
      dojo.byId('gridDiv'));


Listening to Menu Events
------------------------

There will be four events fired corresponding to the appropriate menu types:

* onRowContextMenu(e)
* onCellContextMenu(e)
* onHeaderCellContextMenu(e)
* onSelectedRegionContextMenu(e)

The Event parameter contains rowIndex and cellIndex, so following is a quick sample shows how to get row/column index when the menu popped up:

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      dojo.connect(grid, 'onRowContextMenu', function(e){
          var rowIndex = e.rowIndex;
          var colIndex = e.cellIndex;
      });
  </script>


Tips
----
* How to get selected rows, columns or even cells when the menu is popped up?

1. Normally, when `Selector <Selector>`_ plugin is off, we can get selected rows by: 

.. code-block :: javascript
  :linenos:

  grid.selection.getSelected()


2. When `Selector <Selector>`_ plugin if turned on, we can get the selected rows/column/cell with the following way:

.. code-block :: javascript
  :linenos:

  grid.plugin('selector').getSelected('row'|'col'|'cell');

More details please refer to `Selector <Selector>`_ plugin


========
See Also
========

* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>`_ - Overview of the plugins of enhanced grid
