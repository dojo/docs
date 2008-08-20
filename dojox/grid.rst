## page was renamed from 1.2/dojox/grid
#format dojo_rst

dojox.grid
==========

.. contents::
    :depth: 2

:Status: Contributed, Draft
:Version: beta
:Authors: Scott J. Miles, Steve Orvell, Bryan Forbes

Grids are familiar in the client/server development world. Basically a grid is a kind of mini spreadsheet, commonly used to display details on master-detail forms. From HTML terms, a grid is a "super-table" with its own scrollable viewport.

Examples
--------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojox.grid.DataGrid");
      dojo.require("dojox.data.CsvStore");
    </script>

  .. cv:: html

    <span dojoType="dojox.data.CsvStore" 
      jsId="csvStore" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/tests/support/movies.csv">
    </span>

    <table dojoType="dojox.grid.DataGrid"
        store="csvStore"
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

Selecting data
--------------

To get the current selection of the grid you can use the method yourGrid.selection.getSelected(). You will get an array of the selected items. The following code shows an example:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojox.grid.DataGrid");
      dojo.require("dojox.data.CsvStore");
      dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <span dojoType="dojox.data.CsvStore" 
      jsId="csvStore2" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/tests/support/movies.csv">
    </span>

    <div>
      Select a single row or multiple rows in the Grid (click on the Selector on the left side of each row). 
      After that, a click on the Button "get all Selected Items" will show you each attribute/value of the
      selected rows.
    </div>

    <table dojoType="dojox.grid.DataGrid"
        store="csvStore2"
        query="{ Title: '*' }"
        clientSort="true"
        style="width: 400px; height: 200px;"
        rowSelector="20px"
        jsId="grid2">
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
        var items = grid2.selection.getSelected();
        if(items.length){
          dojo.forEach(items, function(selectedItem) {
            if(selectedItem !== null) {
              dojo.forEach(grid2.store.getAttributes(selectedItem), function(attribute) {
                var value = grid2.store.getValues(selectedItem, attribute);
                alert('attribute: ' + attribute + ', value: ' + value);
              }); // end forEach
            } // end if
          }); // end forEach
        } // end if
      </script>
    </div>


Sorting data at the server
--------------------------

Adding, Editing, Deleting data
------------------------------

Grid allows you to edit your data easily and send the changed values back to your server

Large datasets
--------------

How to retrieve large data from the server

Filtering data
--------------
