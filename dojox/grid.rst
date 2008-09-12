## page was renamed from 1.2/dojox/grid
#format dojo_rst

dojox.grid
==========

:Status: Contributed, Draft
:Version: beta
:Authors: Scott J. Miles, Steve Orvell, Bryan Forbes, Cyan Ogilvie

.. contents::
    :depth: 2

Grids are familiar in the client/server development world. Basically a grid is a kind of mini spreadsheet, commonly used to display details on master-detail forms. From HTML terms, a grid is a "super-table" with its own scrollable viewport.

================
Grid 1.2 Changes
================

``TODOC``

========
Examples
========

The following examples are for the new Grid 1.2.

A simple Grid
-------------

This example shows how to create a simple Grid declaratively.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");
    </script>

  .. cv:: html

    <span dojoType="dojox.data.CsvStore" 
        jsId="store1" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/tests/support/movies.csv">
    </span>

    <table dojoType="dojox.grid.DataGrid"
        store="store1"
        query="{ Title: '*' }"
        clientSort="true"
        style="width: 400px; height: 200px;"
        rowSelector="20px">
        <thead>
            <tr>
                <th width="300px" field="Title">Title of Movie</th>
                <th width="50px">Year</th>
            </tr>
            <tr>
                <th colspan="2">Producer</th>
            </tr>
        </thead>
    </table>

  .. cv:: css

    <style type="text/css">
        @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/Grid.css";
        @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";

        .dojoxGrid table {
            margin: 0;
        }
    </style>

Programmatically creating a DataGrid
------------------------------------

This example shows how to create a simple Grid programmatically.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");

        // our test data store for this example:
        var store4 = new dojox.data.CsvStore({ url: '/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/tests/support/movies.csv' });

        dojo.addOnLoad(function(){
            // set the layout structure:
            var layout4 = [
                { field: 'Title', name: 'Title of Movie', width: '200px' },
                { field: 'Year', name: 'Year', width: '50px' },
                { field: 'Producer', name: 'Producer', width: 'auto' }
            ];

            // create a new grid:
            var grid4 = new dojox.grid.DataGrid({
                query: { Title: '*' },
                store: store4,
                clientSort: true,
                rowSelector: '20px',
                structure: layout4
            }, document.createElement('div'));

            // append the new grid to the div "gridContainer4":
            dojo.byId("gridContainer4").appendChild(grid4.domNode);

            // Call startup, in order to render the grid:
            grid4.startup();
        });
    </script>

  .. cv:: html

    <div id="gridContainer4" style="width: 400px; height: 200px;"></div>

  .. cv:: css

    <style type="text/css">
        @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/Grid.css";
        @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";

        .dojoxGrid table {
            margin: 0;
        }
    </style>

Note the grid.startup() command after constructing the DataGrid.  Earlier development
versions of DataGrid didn't require this but as of 1.2.0b1, you must call
startup() as you would with other dijits, or the grid will not render.

Working with selections
-----------------------

To get the current selected rows of the grid, you can use the method yourGrid.selection.getSelected(). You will get an array of the selected items. The following code shows an example:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <span dojoType="dojox.data.CsvStore" 
        jsId="store2" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/tests/support/movies.csv">
    </span>

    <div>
        Select a single row or multiple rows in the Grid (click on the Selector on the left side of each row). 
        After that, a click on the Button "get all Selected Items" will show you each attribute/value of the
        selected rows.
    </div>

    <table dojoType="dojox.grid.DataGrid"
        jsId="grid2"
        store="store2"
        query="{ Title: '*' }"
        clientSort="true"
        style="width: 400px; height: 200px;"
        rowSelector="20px">
        <thead>
            <tr>
                <th width="300px" field="Title">Title of Movie</th>
                <th width="50px">Year</th>
            </tr>
            <tr>
                <th colspan="2">Producer</th>
            </tr> 
        </thead>
    </table>

    <div dojoType="dijit.form.Button">
        get all Selected Items
        <script type="dojo/method" event="onClick" args="evt">
            // Get all selected items from the Grid:
            var items = grid2.selection.getSelected();
            if(items.length){
                // Iterate through the list of selected items.
                // The current item is available in the variable 
                // "selectedItem" within the following function:
                dojo.forEach(items, function(selectedItem) {
                    if(selectedItem !== null) {
                        // Iterate through the list of attributes of each item.
                        // The current attribute is available in the variable
                        // "attribute" within the following function:
                        dojo.forEach(grid2.store.getAttributes(selectedItem), function(attribute) {
                            // Get the value of the current attribute:
                            var value = grid2.store.getValues(selectedItem, attribute);
                            // Now, you can do something with this attribute/value pair.
                            // Our short example shows the attribute together
                            // with the value in an alert box, but we are sure, that
                            // you'll find a more ambitious usage in your own code:
                            alert('attribute: ' + attribute + ', value: ' + value);
                        }); // end forEach
                    } // end if
                }); // end forEach
            } // end if
        </script>
    </div>

Grid 1.2 supports a new parameter "selectionMode" which allows you to control the behaviour of the selection functionality:

'none'
  deactivates the selection functionality
'single'
  let the user select only one item at the same time
'multiple'
  let the user selects more than one item at the same time
'extended' (default) 
  *not sure, what's the difference between "multiple" and "extended"*


==========================
Sorting data at the server
==========================

TODO

==============================
Adding, Editing, Deleting data
==============================

Grid allows you to edit your data easily and send the changed values back to your server

First, you have to set a editor for each cell, you would like to edit:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojo.data.ItemFileWriteStore");
    </script>

  .. cv:: html

    <span dojoType="dojo.data.ItemFileWriteStore" 
        jsId="store3" url="/moin_static163/js/dojo/trunk/release/dojo/dijit/tests/_data/countries.json">
    </span>

    <div>
        This example shows, how to make the column "Type" editable.
        In order to select a new value, you have to double click on the current value in the second column.
    </div>

    <table dojoType="dojox.grid.DataGrid"
        jsId="grid3"
        store="store3"
        query="{ name: '*' }"
        rowsPerPage="20"
        clientSort="true"
        style="width: 400px; height: 200px;"
        rowSelector="20px">
        <thead>
            <tr>
                <th width="200px" 
                    field="name">Country/Continent Name</th>
                <th width="auto" 
                    field="type" 
                    cellType="dojox.grid.cells.Select" 
                    options="country,city,continent" 
                    editable="true">Type</th>
            </tr>
        </thead>
    </table>

  .. cv:: css

    <style type="text/css">
	@import "/moin_static163/js/dojo/trunk/release/dojo/dijit/themes/nihilo/nihilo.css";
	@import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";
    </style>


==============
Large datasets
==============

TODO: How to retrieve large data from the server

==============
Filtering data
==============

TODO

====
Tips
====

Creating a grid in a node with display: none
--------------------------------------------

It is not possible to create a grid as a child of a node which is set to be not displayed (display: none).
If you need to do this though for some reason you can set the grids visibility to "hidden" and its position offscreen 

Hiding the Headers of a Grid
----------------------------

You can hide the columns of a Grid by using normal css:

.. code-block :: html

  .dojoxGrid-header { display:none; }
