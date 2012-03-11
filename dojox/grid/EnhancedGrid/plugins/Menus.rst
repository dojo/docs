.. _dojox/grid/EnhancedGrid/plugins/Menus:

=============================================
dojox.grid.EnhancedGrid.plugins.Menu
=============================================

:Authors: Evan Huang
:Project owner: Evan Huang
:since: V.1.6

.. contents ::
   :depth: 2

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

  .. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.Menu");
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
            {name: 'Column 1', field: 'id'},
            {name: 'Column 2', field: 'col2'},
            {name: 'Column 3', field: 'col3', width: "230px"},
            {name: 'Column 4', field: 'col4'}
          ]];

          /* create a new grid:*/
          var grid = new dojox.grid.EnhancedGrid({
              id: 'grid',
              store: store,
              structure: layout,
              rowSelector: '20px',
              plugins: {menus:{headerMenu:"headerMenu", rowMenu:"rowMenu", cellMenu:"cellMenu", selectedRegionMenu:"selectedRegionMenu"}}},
            document.createElement('div'));

          /* append the new grid to the div */
          dojo.byId("gridDiv").appendChild(grid.domNode);

          /* Call startup() to render the grid*/
          grid.startup();
      });

  .. html ::

    <div id="gridDiv">
        <div data-dojo-type="dijit.Menu" id="headerMenu" style="display: none;">
            <div data-dojo-type="dijit.MenuItem">Header Menu Item 1</div>
            <div data-dojo-type="dijit.MenuItem">Header Menu Item 2</div>
            <div data-dojo-type="dijit.MenuItem">Header Menu Item 3</div>
            <div data-dojo-type="dijit.MenuItem">Header Menu Item 4</div>
        </div>
        <div data-dojo-type="dijit.Menu" id="rowMenu"  style="display: none;">
            <div data-dojo-type="dijit.MenuItem">Row Menu Item 1</div>
            <div data-dojo-type="dijit.MenuItem">Row Menu Item 2</div>
            <div data-dojo-type="dijit.MenuItem">Row Menu Item 3</div>
            <div data-dojo-type="dijit.MenuItem">Row Menu Item 4</div>
        </div>
        <div data-dojo-type="dijit.Menu" id="cellMenu"  style="display: none;">
            <div data-dojo-type="dijit.MenuItem">Cell Menu Item 1</div>
            <div data-dojo-type="dijit.MenuItem">Cell Menu Item 2</div>
            <div data-dojo-type="dijit.MenuItem">Cell Menu Item 3</div>
            <div data-dojo-type="dijit.MenuItem">Cell Menu Item 4</div>
        </div>
        <div data-dojo-type="dijit.Menu" id="selectedRegionMenu"  style="display: none;">
            <div data-dojo-type="dijit.MenuItem">Action 1 for Selected Region</div>
            <div data-dojo-type="dijit.MenuItem">Action 2 for Selected Region</div>
            <div data-dojo-type="dijit.MenuItem">Action 3 for Selected Region</div>
            <div data-dojo-type="dijit.MenuItem">Action 4 for Selected Region</div>
        </div>
    </div>


  .. css ::

    @import "{{baseUrl}}dojo/resources/dojo.css";
    @import "{{baseUrl}}dijit/themes/claro/claro.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

    /*Grid need a explicit width/height by default*/
    #grid {
        width: 43em;
        height: 20em;
    }

JavaScript usage sample

.. code-example::
  :toolbar: themes, versions, dir
  :width: 550
  :height: 330

  .. js ::

       dojo.require("dojox.grid.EnhancedGrid");
       dojo.require("dojox.grid.enhanced.plugins.Menu");
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
             {name: 'Column 1', field: 'id'},
             {name: 'Column 2', field: 'col2'},
             {name: 'Column 3', field: 'col3', width: "230px"},
             {name: 'Column 4', field: 'col4'}
           ]];

           /*programmatic menus*/
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


            /* create a new grid:*/
            var grid = new dojox.grid.EnhancedGrid({
                  id: 'grid',
                  store: store,
                  structure: layout,
                  rowSelector: '20px',
                  plugins : {menus: menusObject}},
            document.createElement('div'));
    
            /* append the new grid to the div*/
            dojo.byId("gridDiv").appendChild(grid.domNode);
    
            /* Call startup() to render the grid*/
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
        width: 43em;
        height: 20em;
    }

Usage
-----

* Declare menu feature plugin

.. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.Menu");
      ...

* Use menu feature

with HTML markup
    
.. js ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid"
      data-dojo-props="plugins:{menus:{headerMenu:’headerMenu‘, rowMenu:’rowMenu‘, cellMenu:’cellMenu‘, selectedRegionMenu:’selectedRegionMenu‘}}" ... >
      <div data-dojo-type="dijit.Menu" id="headerMenu" style="display: none;">
          <div data-dojo-type="dijit.MenuItem">Header Menu Item 1</div>
      </div>
      <div data-dojo-type="dijit.Menu" id="rowMenu" style="display: none;">
          <div data-dojo-type="dijit.MenuItem">Row Menu Item 1</div>
      </div>
      <div data-dojo-type="dijit.Menu" id="cellMenu" style="display: none;">
          <div data-dojo-type="dijit.MenuItem">Cell Menu Item 1</div>
      </div>
      <div data-dojo-type="dijit.Menu" id="selectedRegionMenu" style="display: none;">
          <div data-dojo-type="dijit.MenuItem">Action 1 for Selected Region</div>
      </div>
  </div>

with JavaScript (using a markup menu)
    
.. js ::
  
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

.. js ::

      dojo.connect(grid, 'onRowContextMenu', function(e){
          var rowIndex = e.rowIndex;
          var colIndex = e.cellIndex;
      });


Tips
----
* How to get selected rows, columns or even cells when the menu is popped up?

1. Normally, when the :ref:`Selector <dojox/grid/EnhancedGrid/plugins/Selector>` plugin is off, we can get selected rows by:

.. js ::
  
  grid.selection.getSelected()


2. When the :ref:`Selector <dojox/grid/EnhancedGrid/plugins/Selector>` plugin is turned on, we can get the selected rows/column/cell with the following way:

.. js ::
  
  grid.plugin('selector').getSelected('row'|'col'|'cell');

More details please refer to the :ref:`Selector <dojox/grid/EnhancedGrid/plugins/Selector>` plugin


See Also
========

* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
