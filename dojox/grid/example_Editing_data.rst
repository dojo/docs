.. _dojox/grid/example_Editing_data:

Editing data
------------

Grid allows you to edit your data easily and send the changed values back to your server

First, you have to set a editor for each cell, you would like to edit:

.. code-example ::

  .. js ::

        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojo.data.ItemFileWriteStore");

  .. html ::

    <span data-dojo-type="dojo.data.ItemFileWriteStore"
        data-dojo-id="store3" data-dojo-props="url:'{{ dataUrl }}dijit/tests/_data/countries.json'">
    </span>

    <div>
        This example shows, how to make the column "Type" editable.
        In order to select a new value, you have to double click on the current value in the second column.
    </div>

    <table data-dojo-type="dojox.grid.DataGrid"
        data-dojo-id="grid3"
        data-dojo-props="store:store3,
        query:{ name: '*' },
        rowsPerPage:20,
        clientSort:true,
        rowSelector:'20px'"
        style="width: 400px; height: 200px;">
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

    @import "{{ baseUrl }}dijit/themes/nihilo/nihilo.css";
    @import "{{ baseUrl }}dojox/grid/resources/nihiloGrid.css";
