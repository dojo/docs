#format dojo_rst

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

    <span dojoType="dojo.data.ItemFileWriteStore" 
        jsId="store3"
        url="{{ dataUrl }}dijit/tests/_data/countries.json">
    </span>


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
	@import "{{ baseUrl }}dijit/themes/nihilo/nihilo.css";
	@import "{{ baseUrl }}dojox/grid/resources/nihiloGrid.css";
    </style>
