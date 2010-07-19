#format dojo_rst

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

    <span dojoType="dojo.data.ItemFileWriteStore" 
        jsId="store3" url="{{ dataUrl }}dijit/tests/_data/countries.json">
    </span>

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

  .. cv:: css

    <style type="text/css">
        @import "{{ baseUrl }}dojox/grid/resources/Grid.css";
        @import "{{ baseUrl }}dojox/grid/resources/nihiloGrid.css";

        .dojoxGrid table {
            margin: 0;
        }
    </style>
