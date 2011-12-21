.. _dojox/grid/example_Filtering_data:

Filtering data
--------------

The Grid offers a filter() method, to filter data from the current query (client-side filtering).

.. code-example ::

  .. js ::

        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.data.CsvStore");
        dojo.require("dijit.form.Button");

  .. html ::

    <span data-dojo-type="dojox.data.CsvStore"
        // We use the store from the examples above.
        // Please uncomment this line, if you need your own store:
        // data-dojo-id="store2" url="{{dataUrl}}dojox/grid/tests/support/movies.csv">
    </span>

    <div>
        Click on the button "filter movies" to filter the current data (only movies with title "T*" will be visible).
        Click on the button "show all movies" to remove the filter.
    </div>

    <table data-dojo-type="dojox.grid.DataGrid"
        data-dojo-id="grid3"
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
        filter movies
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Filter the movies from the data store:
            grid3.filter({Title: "T*"});
        </script>
    </div>

    <div data-dojo-type="dijit.form.Button">
        show all movies
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // reset the filter:
            grid3.filter({Title: "*"});
        </script>
    </div>

  .. css ::

    @import "{{baseUrl}}dijit/themes/nihilo/nihilo.css";
    @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";
