#format dojo_rst

Filtering data
--------------

The Grid offers a filter() method, to filter data from the current query (client-side filtering).

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <span dojoType="dojox.data.CsvStore" 
        // We use the store from the examples above.
        // Please uncomment this line, if you need your own store:
        // jsId="store2" url="{{dataUrl}}dojox/grid/tests/support/movies.csv">
    </span>

    <div>
        Click on the button "filter movies" to filter the current data (only movies with title "T*" will be visible).
        Click on the button "show all movies" to remove the filter.
    </div>

    <table dojoType="dojox.grid.DataGrid"
        jsId="grid3"
        store="store2"
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

    <div dojoType="dijit.form.Button">
        filter movies
        <script type="dojo/method" event="onClick" args="evt">
            // Filter the movies from the data store:
            grid3.filter({Title: "T*"});
        </script>
    </div>

    <div dojoType="dijit.form.Button">
        show all movies
        <script type="dojo/method" event="onClick" args="evt">
            // reset the filter:
            grid3.filter({Title: "*"});
        </script>
    </div>

  .. cv:: css

    <style type="text/css">
	@import "{{baseUrl}}dijit/themes/nihilo/nihilo.css";
	@import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";
    </style>
