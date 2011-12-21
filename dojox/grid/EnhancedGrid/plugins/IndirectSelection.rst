.. _dojox/grid/EnhancedGrid/plugins/IndirectSelection:

=================================================
dojox.grid.EnhancedGrid.plugins.IndirectSelection
=================================================

:Authors: Evan Huang
:Project owner: Evan Huang
:since: V.1.6

.. contents ::
   :depth: 2

Introduction
==============

This feature provides indirect row selection support either through

  * Radio buttons - for single row selection, and
  * Check boxes - for multiple row selections

Please note indirect selection is completely dependent on the selection mode of EnhancedGrid so check boxes are used for "extended" and "multiple" selection mode ("extended" is the default mode), and radio buttons are used for "single" selection mode. For more details of Grid selection modes, please refer to the :ref:`specification of the base Grid <dojox/grid/index>`.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 550
  :height: 330

  .. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojo.data.ItemFileWriteStore");
      dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");
    
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
              plugins: {indirectSelection: {headerSelector:true, width:"40px", styles:"text-align: center;"}}},
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

* Declare indirect selection feature plugin

.. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");
      ...

* Use indirect selection feature with check boxes

with HTML markup
    
.. js ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid" data-dojo-props="plugins:{indirectSelection: true}" >
  </div>

with JavaScript
    
.. js ::

      var grid = new dojox.grid.EnhancedGrid({id: "grid", plugins: {indirectSelection: true}, ...}, dojo.byId('gridDiv'));

* Use indirect selection feature with radio buttons

with HTML markup
    
.. js ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid" data-dojo-props="plugins:{indirectSelection: true}, selectionMode:'single'" ... >
  </div>

with JavaScript:
    
.. js ::

      var grid = new dojox.grid.EnhancedGrid({id: "grid", plugins: {indirectSelection: true}, selectionMode: "single", ...}, dojo.byId('gridDiv'));

* It is unlikely that the row headers will be desired when indirect selection is used. The following code removes the row headers from the grid.

With HTML markup:

.. html ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid" data-dojo-props="plugins:{indirectSelection: true}, rowSelector:'0px'" ... />

With JavaScript:

.. js ::

    var grid = new dojox.grid.EnhancedGrid({id: "grid", plugins: {indirectSelection: true}, rowSelector: "0px", ...}, dojo.byId('gridDiv'));


Scenario
--------

* Indirect selection by radio buttons


.. image :: indirect1-1.png

* Indirect selection by check boxes

Besides selecting or deselecting rows by clicking on check boxes, the SHIFT key can be held during the 2nd click to select or deselect a range of rows.

* An additional selection technique is to swipe through check boxes (mouse down on the first, drag through the adjacent check boxes and then release on the last).

.. image :: indirect2.png

Accessibility
-------------

Keyboard Support
~~~~~~~~~~~~~~~~

+---------------------------+--------------------------------------------------------------------------------+
| Key                       | Action                                                                         |
+===========================+================================================================================+
| UP/Down arrow keys        | Navigate keyboard focus across cells that contain radio buttons or check boxes |
+---------------------------+--------------------------------------------------------------------------------+
| SPACE key                 | - Radio button - select a row                                                  |
|                           | - Check box - select or de-select a row.                                       |
+---------------------------+--------------------------------------------------------------------------------+
| SHIFT + Click             | Select or de-select a range of rows                                            |
| SHIFT + SPACE key         |                                                                                |
+---------------------------+--------------------------------------------------------------------------------+
| SHIFT+ UP/Down arrow keys | Extend the selection or de-selection - only for check boxes .                  |
+---------------------------+--------------------------------------------------------------------------------+

  * The above keys are only effective when keyboard focus is in the first column that contains radio buttons or check boxes.

Note that extended selection is also enabled through the row headers as well.

Usages
------
* Turn on Select All checkbox in the column header

.. js ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid" data-dojo-props="plugins:{indirectSelection:{headerSelector:true, ...}}" ...></div>

* Listen to events when the check box/radio button is checked/unchecked

.. js ::
  
  dojo.connect(grid.selection, 'onSelected'|'onDeselected', function(rowIndex){...})

  // when Select All checkbox is changed
  dojo.connect(grid.rowSelectCell, 'toggleAllSelection', function(newValue){...})

* When the "Indirect Selection" feature is enabled, you could handle row selection programmatically as follows.

.. js ::

      for(var i = 0; i < selectedRows.length/*Array of selected row index*/; i++){
         grid.rowSelectCell.toggleRow(selectedRows[i], true);
      }

* When in non-‘single’ selection mode, it’s also easy to select or deselect all rows by:

.. js ::

      dijit.byId("grid").rowSelectCell.toggleAllSelection(true|false);

* Another handy usage is to enable or disable a check box or radio button for a certain row by:

.. js ::

      dijit.byId('grid').rowSelectCell.setDisabled(rowIndex, true|false);

* You can check whether a certain row is selected with the following code.

.. js ::
  
  dijit.byId('grid').selection.isSelected(rowIndex) // returns true or false

* It's also possible to make some styling customizations for the indirect selection column.

.. js ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid" data-dojo-props="plugins:{indirectSelection:{name:'Selection',width:'70px',styles:'text-align:right;'}}" ...></div>
    
or

.. js ::

    var grid = new dojox.grid.EnhancedGrid({id:"grid", plugins:{indirectSelection:{name:"Selection",width:"70px",styles:"text-align:center;"}, ...}, dojo.byId('gridDiv'));


Known Issues
============

* There are known compatibility issues when Indirect Selection is used together with :ref:`Selector <dojox/grid/EnhancedGrid/plugins/Selector>` plugin


See Also
========

* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
