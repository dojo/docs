.. _dojox/grid/example_Working_with_selections:

Working with selections
-----------------------

To get the current selected rows of the grid, you can use the method yourGrid.selection.getSelected(). You will get an array of the selected items. The following code shows an example:

.. code-example ::

  .. js ::

        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");
        dojo.require("dijit.form.Button");

  .. html ::

    <span data-dojo-type="dojox.data.CsvStore"
        data-dojo-id="store2" data-dojo-props="url:'{{dataUrl}}dojox/grid/tests/support/movies.csv'">
    </span>

    <div>
        Select a single row or multiple rows in the Grid (click on the Selector on the left side of each row).
        After that, a click on the Button "get all Selected Items" will show you each attribute/value of the
        selected rows.
    </div>

    <table data-dojo-type="dojox.grid.DataGrid"
        data-dojo-id="grid2"
        data-dojo-props="store:store2,
        query:{ Title: '*' },
        clientSort:true,
        rowSelector:'20px'"
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

    <div data-dojo-type="dijit.form.Button">
        get all Selected Items
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Get all selected items from the Grid:
            var items = grid2.selection.getSelected();
            if(items.length){
                // Iterate through the list of selected items.
                // The current item is available in the variable
                // "selectedItem" within the following function:
                dojo.forEach(items, function(selectedItem){
                    if(selectedItem !== null){
                        // Iterate through the list of attributes of each item.
                        // The current attribute is available in the variable
                        // "attribute" within the following function:
                        dojo.forEach(grid2.store.getAttributes(selectedItem), function(attribute){
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

  .. css ::

        @import "{{baseUrl}}dojox/grid/resources/Grid.css";
        @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

        .dojoxGrid table {
            margin: 0;
        }


Grid 1.2 supports a new parameter "selectionMode" which allows you to control the behavior of the selection functionality:

'none'
  deactivates the selection functionality
'single'
  let the user select only one item at the same time
'multiple'
  let the user selects more than one item at the same time
'extended' (default)
  *not sure, what's the difference between "multiple" and "extended"*
