## page was renamed from 1.2/dojox/grid
#format dojo_rst

dojox.grid
==========

:Status: Draft
:Version: 1.0
:Project owners: Scott J. Miles, Steve Orvell, Bryan Forbes
:Available: since V1.2

.. contents::
   :depth: 2

Grids are familiar in the client/server development world. Basically a grid is a kind of mini spreadsheet, commonly used to display details on master-detail forms. From HTML terms, a grid is a "super-table" with its own scrollable viewport.


============
Introduction
============

TODO: introduce the component/class/method
A structure is an array of views and a view is an array of cells.

This Widget inherits from dojo.grid._Grid and hence all methods and properties pertaining to that Widget also apply here.

Grid 1.2 Changes
----------------

``TODOC``


=====
Usage
=====

TODO: how to use the component/class/method


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
        jsId="store1" url="/moin_static163/js/dojo/trunk/dojox/grid/tests/support/movies.csv">
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
        var store4 = new dojox.data.CsvStore({ url: '/moin_static163/js/dojo/trunk/dojox/grid/tests/support/movies.csv' });

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
        jsId="store2" url="/moin_static163/js/dojo/trunk/dojox/grid/tests/support/movies.csv">
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

Sorting data at the server
--------------------------

TODO

Editing data
------------

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


Adding and Deleting data
------------------------

If you want to add (remove) data programatically, you just have to add (remove) it from the underlying data store.
Since DataGrid is "DataStoreAware", changes made to the store will be reflected automatically in the DataGrid.
 
.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <!-- We use store3 from the example above as data store.
    See the HTML code above, in order to learn how to define a data store. -->

    <div>
        This example shows, how to add/remove rows
    </div>

    <table dojoType="dojox.grid.DataGrid"
        jsId="grid5"
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

    <div dojoType="dijit.form.Button">
        Add Row
        <script type="dojo/method" event="onClick" args="evt">
            // set the properties for the new item:
            var myNewItem = {type: "country", name: "Fill this country name"}; 
            // Insert the new item into the store:
            // (we use store3 from the example above in this example)
            store3.newItem(myNewItem);
        </script>
    </div>
    
    <div dojoType="dijit.form.Button">
        Remove Selected Rows
        <script type="dojo/method" event="onClick" args="evt">
            // Get all selected items from the Grid:
            var items = grid5.selection.getSelected();
            if(items.length){
                // Iterate through the list of selected items.
                // The current item is available in the variable 
                // "selectedItem" within the following function:
                dojo.forEach(items, function(selectedItem) {
                    if(selectedItem !== null) {
                        // Delete the item from the data store:
                        store3.deleteItem(selectedItem);
                    } // end if
                }); // end forEach
            } // end if
        </script>
    </div>

  .. cv:: css

    <style type="text/css">
	@import "/moin_static163/js/dojo/trunk/release/dojo/dijit/themes/nihilo/nihilo.css";
	@import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";
    </style>

Large datasets
--------------

TODO: How to retrieve large data from the server

Filtering data
--------------

The Grid offers a filter() method, to filter data from the current query (client-side filtering).

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <span dojoType="dojox.data.CsvStore" 
        // We use the store from the examples above.
        // Please uncomment this line, if you need your own store:
        // jsId="store2" url="/moin_static163/js/dojo/trunk/dojox/grid/tests/support/movies.csv">
    </span>

    <div>
        Click on the button "filter movies" to filter the current data (only movies with title "T*" will be visible).
        Click on the button "show all movies" to remove the filter.
    </div>

    <table dojoType="dojox.grid.DataGrid"
        jsId="grid3"
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
        filter movies
        <script type="dojo/method" event="onClick" args="evt">
            // Filter the movies from the data store:
            grid3.filter({Title: "T*"});
        </script>
    </div>

    <div dojoType="dijit.form.Button">
        show all movies
        <script type="dojo/method" event="onClick" args="evt">
            // reset the filter:
            grid3.filter({Title: "*"});
        </script>
    </div>

Grid styling : Rows 
-------------------

The DataGrid provides extension points which allows you to apply custom css classes or styles to a row, depending on different parameters.
To use it, you just have to override default behavior by yours.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojo.data.ItemFileWriteStore");
    </script>

  .. cv:: html

    <table dojoType="dojox.grid.DataGrid"
        jsId="grid6"
        store="store3"
        query="{ name: '*' }"
        rowsPerPage="20"
        clientSort="true"
        style="width: 400px; height: 200px;"
        rowSelector="20px">
        <script type="dojo/method" event="onStyleRow" args="row">
	     //The row object has 4 parameters, and you can set two others to provide your own styling
	     //These parameters are :
	     //	-- index : the row index
	     //	-- selected: wether the row is selected
	     //	-- over : wether the mouse is over this row
	     //	-- odd : wether this row index is odd.
	     var item = grid6.getItem(row.index);
	     if(item){
		var type = store3.getValue(item,"type",null);
		if(type == "continent"){
		    row.customStyles += "color:red;";
	        }
	     }
	     grid6.focus.styleRow(row);
	     grid6.edit.styleRow(row);
	</script>
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


Refreshing the content of a grid
--------------------------------
There are times when you may wish to update the content of the grid.  For example, a button on the screen may cause an xhrGet to retrieve a new set of information that you want to display in the table.  The following code snippet can be used to update the grid:

.. code-block :: javascript

  var newStore = new dojo.data.ItemFileReadStore({data: {... some data ...});
  var grid = dijit.byId("gridId");
  newStore.fetch();
  grid.setStore(newStore);

========
See also
========
Here are a related links to other Dojo Grid pages on the Web:

* `Introducing the 1.2 DataGrid <http://www.sitepen.com/blog/2008/07/14/dojo-12-grid/>`_
* `New Features in Dojo Grid 1.2 <http://www.sitepen.com/blog/2008/10/22/new-features-in-dojo-grid-12/>`_
* `Dojo Grids: Diving Deeper <http://www.sitepen.com/blog/2007/11/13/dojo-grids-diving-deeper/>`_
* `Simple Dojo Grids <http://www.sitepen.com/blog/2007/11/06/simple-dojo-grids/>`_
