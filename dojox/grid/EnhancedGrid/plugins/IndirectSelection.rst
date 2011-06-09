#format dojo_rst

dojox.grid.EnhancedGrid.plugins.IndirectSelection
=================================================

:Authors: Evan Huang
:Project owner: Evan Huang
:Available: since V.1.6

.. contents::
   :depth: 2

==============
Introduction
==============

This feature provides indirect row selection support either through

  * Radio buttons - for single row selection, and
  * Check boxes - for multiple row selections

Please note indirect selection is completely dependent on the selection mode of EnhancedGrid so check boxes are used for "extended" and "multiple" selection mode ("extended" is the default mode), and radio buttons are used for "single" selection mode. For more details of Grid selection modes, please refer to the `specification of the base Grid <dojox/grid>`_.

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    <script type="text/javascript">
	dojo.require("dojox.grid.EnhancedGrid");
	dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");
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
              clientSort: true,
              rowSelector: '20px',
              structure: layout,
              plugins : {indirectSelection: {name: "Selection", width:"70px", styles:"text-align: center;"}}
          }, document.createElement('div'));

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

* Declare indirect selection feature plugin

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");
      ...
  </script>

* Use indirect selection feature with check boxes

... with HTML markup
    
.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" plugins="{indirectSelection: true}" >
  </div>

... with JavaScript
    
.. code-block :: javascript
  :linenos:

  <script>
      var grid = new dojox.grid.EnhancedGrid({id: "grid", plugins: {indirectSelection: true}, ...}, dojo.byId('gridDiv'));
  </script>

* Use indirect selection feature with radio buttons

... with HTML markup
    
.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" plugins="{indirectSelection: true}" selectionMode="single" ... >
  </div>

... with JavaScript
    
.. code-block :: javascript
  :linenos:

  <script>
      var grid = new dojox.grid.EnhancedGrid({id: "grid", plugins: {indirectSelection: true}, selectionMode: "single", ...}, dojo.byId('gridDiv'));
  </script>

* It is unlikely that the row headers will be desired when indirect selection is used. The following code removes the row headers from the grid.

.. code-block :: html
  :linenos:

  //with HTML markup
  <div id="grid" dojoType="dojox.grid.EnhancedGrid" plugins="{indirectSelection: true}" rowSelector="0px" ... />
 
  //with Javascript
  <script>
    var grid = new dojox.grid.EnhancedGrid({id: "grid", plugins: {indirectSelection: true}, rowSelector: "0px", ...}, dojo.byId('gridDiv'));
  </script>


Scenario
--------

* Indirect selection by radio buttons


.. image:: indirect1-1.png

* Indirect selection by check boxes

Besides selecting or deselecting rows by clicking on check boxes, the SHIFT key can be held during the 2nd click to select or deselect a range of rows.

* An additional selection technique is to swipe through check boxes (mouse down on the first, drag through the adjacent check boxes and then release on the last).

.. image:: indirect2.png

Accessibility
-------------

Keyboard Support
~~~~~~~~~~~~~~~~

+---------------------------+--------------------------------------------------------------------------------+
| Key                       | Action                                                                         |
+===========================+================================================================================+
| UP/Down arrow keys        | Navigate keyboard focus across cells that contain radio buttons or check boxes |
+---------------------------+--------------------------------------------------------------------------------+
| SPACE key	            | -	Radio button - select a row                                                  |
|                           | -	Check box - select or de-select a row.                                       |
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

.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" plugins="{indirectSelection:{headerSelector:true, ...}}" ...></div>

* Listen to events when the check box/radio button is checked/unchecked

.. code-block :: javascript
  :linenos:

  dojo.connect(grid.selection, 'onSelected'|'onDeselected', function(rowIndex){...})

  //when Select All checkbox is changed
  dojo.connect(grid.rowSelectCell, 'toggleAllSelection', function(newValue){...})

* When the "Indirect Selection" feature is enabled, you could handle row selection programmatically as follows.

.. code-block :: javascript
  :linenos:

  <script>
      for(var i = 0; i < selectedRows.length/*Array of selected row index*/; i++){
         grid.rowSelectCell.toggleRow(selectedRows[i], true);
      }
  </script>

* When in non-‘single’ selection mode, it’s also easy to select or deselect all rows by:

.. code-block :: javascript
  :linenos:

  <script>
      dijit.byId("grid").rowSelectCell.toggleAllSelection(true|false);
  </script>

* Another handy usage is to enable or disable a check box or radio button for a certain row by:

.. code-block :: javascript
  :linenos:

  <script>
      dijit.byId('grid').rowSelectCell.setDisabled(rowIndex, true|false);
  </script>

* You can check whether a certain row is selected with the following code.

.. code-block :: javascript
  :linenos:

  dijit.byId('grid').selection.isSelected(rowIndex) // returns true or false

* It's also possible to make some styling customizations for the indirect selection column.

.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" plugins="{indirectSelection:{name:'Selection',width:'70px',styles:'text-align:right;'}}" ...></div>
    
or 

.. code-block :: javascript
  :linenos:

  <script>
    var grid = new dojox.grid.EnhancedGrid({id:"grid", plugins:{indirectSelection:{name:"Selection",width:"70px",styles:"text-align:center;"}, ...}, dojo.byId('gridDiv'));
  </script>


============
Known Issues
============

* There are known compatibility issues when Indirect Selection is used together with `Selector <Selector>`_ plugin


========
See Also
========

* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>`_ - Overview of the plugins of enhanced grid 
