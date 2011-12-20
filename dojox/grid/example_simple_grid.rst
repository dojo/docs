.. _dojox/grid/example_simple_grid:

A simple Grid
-------------

This example shows how to create a simple Grid declaratively.

.. code-example ::

  .. js ::

        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");

  .. html ::

    <span data-dojo-type="dojox.data.CsvStore"
        data-dojo-id="store1" data-dojo-props="url:'{{dataUrl}}dojox/grid/tests/support/movies.csv'">
    </span>

    <table data-dojo-type="dojox.grid.DataGrid"
        data-dojo-props="store:store1,
        query:{ Title: '*' },
        clientSort:true, rowSelector:'20px'"
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

  .. css ::

        @import "{{baseUrl}}dojox/grid/resources/Grid.css";
        @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

        .dojoxGrid table {
            margin: 0;
        }
