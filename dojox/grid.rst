## page was renamed from 1.2/dojox/grid
#format dojo_rst

dojox.grid
==========

.. contents::
    :depth: 2

:Status: Contributed, Draft
:Version: beta
:Authors: Scott J. Miles, Steve Orvell, Bryan Forbes

Doj ogrid
Dojogrid
Dojogrid
Dojogrid
Dojogrid
DojogridDoj ogrid
Dojogrid
Dojogrid
Dojogrid
Dojogrid
DojogridDoj ogrid
Dojogrid
Dojogrid
Dojogrid
Dojogrid
Dojogrid

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
        style="width: 400px; height: 200px;">
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

To get the current selection of the grid simply use following code

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
