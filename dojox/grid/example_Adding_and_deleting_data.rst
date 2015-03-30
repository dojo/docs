.. _dojox/grid/example_Adding_and_deleting_data:

Adding and Deleting data
------------------------

If you want to add (remove) data programmatically, you just have to add (remove) it from the underlying data store.
Since DataGrid is "DataStoreAware", changes made to the store will be reflected automatically in the DataGrid.
 
.. code-example ::

  .. js ::

        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dijit.form.Button");

  .. html ::

    <span data-dojo-type="dojo.data.ItemFileWriteStore"
        data-dojo-id="store3"
        data-dojo-props="url:'{{ dataUrl }}dijit/tests/_data/countries.json'">
    </span>


    <div>
        This example shows, how to add/remove rows
    </div>

    <table data-dojo-type="dojox.grid.DataGrid"
        data-dojo-id="grid5"
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

    <div data-dojo-type="dijit.form.Button">
        Add Row
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // set the properties for the new item:
            var myNewItem = {type: "country", name: "Fill this country name"};
            // Insert the new item into the store:
            // (we use store3 from the example above in this example)
            store3.newItem(myNewItem);
        </script>
    </div>
    
    <div data-dojo-type="dijit.form.Button">
        Remove Selected Rows
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Get all selected items from the Grid:
            var items = grid5.selection.getSelected();
            if(items.length){
                // Iterate through the list of selected items.
                // The current item is available in the variable
                // "selectedItem" within the following function:
                dojo.forEach(items, function(selectedItem){
                    if(selectedItem !== null){
                        // Delete the item from the data store:
                        store3.deleteItem(selectedItem);
                    } // end if
                }); // end forEach
            } // end if
        </script>
    </div>

  .. css ::

    @import "{{ baseUrl }}dijit/themes/nihilo/nihilo.css";
    @import "{{ baseUrl }}dojox/grid/resources/nihiloGrid.css";
