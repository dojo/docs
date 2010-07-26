#format dojo_rst

Programmatically creating a DataGrid
------------------------------------

This example shows how to create a simple Grid programmatically.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");

        dojo.addOnLoad(function(){
 
            // our test data store for this example:
            var store4 = new dojox.data.CsvStore({ url: '{{dataUrl}}dojox/grid/tests/support/movies.csv' });

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
        @import "{{baseUrl}}dojox/grid/resources/Grid.css";
        @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

        .dojoxGrid table {
            margin: 0;
        }
    </style>

Note the grid.startup() command after constructing the DataGrid.  Earlier development
versions of DataGrid didn't require this but as of 1.2.0b1, you must call
startup() as you would with other dijits, or the grid will not render.
