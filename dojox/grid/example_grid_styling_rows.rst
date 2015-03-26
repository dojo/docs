.. _dojox/grid/example_grid_styling_rows:

Grid styling : Rows
-------------------

The DataGrid provides extension points which allows you to apply custom css classes or styles to a row, depending on different parameters.
To use it, you just have to override default behavior by yours.

.. code-example ::

  .. js ::

        require(["dojo/parser", 
            "dojox/grid/DataGrid",
            "dojo/data/ItemFileWriteStore"]);

  .. html ::

    <span data-dojo-type="dojo/data/ItemFileWriteStore"
        data-dojo-id="store3" data-dojo-props="url:'{{ dataUrl }}dijit/tests/_data/countries.json'">
    </span>

    <table data-dojo-type="dojox/grid/DataGrid"
        data-dojo-id="grid6"
        data-dojo-props="store:store3,
        query:{ name: '*' },
        rowsPerPage:20,
        clientSort:true,
        rowSelector:'20px'"
        style="width: 400px; height: 200px;">
        <script type="dojo/method" data-dojo-event="onStyleRow" data-dojo-args="row">
         // The row object has 4 parameters, and you can set two others to provide your own styling
         // These parameters are :
         //    -- index : the row index
         //    -- selected: whether or not the row is selected
         //    -- over : whether or not the mouse is over this row
         //    -- odd : whether or not this row index is odd.
         var item = grid6.getItem(row.index);
         if(item){
        var type = store3.getValue(item, "type", null);
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

  .. css ::

        @import "{{ baseUrl }}dojox/grid/resources/Grid.css";
        @import "{{ baseUrl }}dojox/grid/resources/nihiloGrid.css";

        .dojoxGrid table {
            margin: 0;
        }
