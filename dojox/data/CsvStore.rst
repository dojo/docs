#format dojo_rst

dojox.data.CsvStore
===================

:Status: Contributed, Draft
:Version: 1.0
:Author: Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

CsvStore is a simple read-only store provided by Dojo and contained in the DojoX project. CsvStore is a read interface that works with `CSV <http://en.wikipedia.org/wiki/Comma-separated_values>`_ formated data files. The CSV file format is commonly known to folks who work regularly with spread sheet data. Like ItemFileReadStore, CsvStore reads the contents from an http endpoint or a JavaScript Data object that contains CSV formatted data. The following is an example of a CSV data source:

::
  
  Title, Year, Producer
  City of God, 2002, Katia Lund
  Rain,, Christine Jeffs
  2001: A Space Odyssey, , Stanley Kubrick
  "This is a ""fake"" movie title", 1957, Sidney Lumet
  Alien, 1979   , Ridley Scott
  "The Sequel to ""Dances With Wolves.""", 1982, Ridley Scott
  "Caine Mutiny, The", 1954, "Dymtryk ""the King"", Edward"

Note that in the above data, the first row is always assumed to be the column names. Those are what get assigned as the attribute names for the CSV items. Each row in the CSV data is treated as a single item.

The following dojo.data APIs are implemented by CsvStore

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_

==================
Constructor Params
==================

+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| **Parameter**  | **Required** | **Description**                                                                                | **Since** |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| url            | No           |This optional parameter specifies what URL from which to load the Csv data Note                 | 1.0       |
|                |              |that this URL is only loaded one time, as this is an in-memory data store.                      |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| data           | No           |A JavaScript String of Csv formatted data to use to populate the store. This parameter can be   | 1.0       |
|                |              |used instead of *url*. when you wish to load data differently then modify it to fit the expected|           |
|                |              |Csv format.                                                                                     |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| label          | No           |A string that identifies which column to treat as the human-readable label. It must match one of| 1.0       |
|                |              |the column labels in the file for it to be effective.                                           |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| separator      | No           |**New to Dojo Toolkit 1.4** The CsvStore can now take an optional character parameter to        | 1.4       |
|                |              |identify the delimiter of fields.  Comma is not longer required, but merely the default.        |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+

============
Query Syntax
============

The query syntax used by dojox.data.CsvStore is identical to the query syntax used by `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_

=============
Query Options
=============

Dojo.data defines support for a 'queryOptions' modifier object that affects the behavior of the query. The two defined options listed by the API are *ignoreCase* and *deep*. CsvStore supports these options. The affect of these options on a query is defined below.

+------------+------------------------------------------------------------------------------------------------------------------------+
| **Option** | **Result**                                                                                                             |
+------------+------------------------------------------------------------------------------------------------------------------------+
| ignoreCase |The default is **false**. When set to true, the match on attributes is done in a case-insensitive fashion. This means   |
|            |with ignoreCase: true, a query of A* would match *Apple* and *acorn*                                                    |
+------------+------------------------------------------------------------------------------------------------------------------------+
| deep       |Ignored. Csv formatted data does not not support hierarchical data.                                                     |
+------------+------------------------------------------------------------------------------------------------------------------------+


========
Examples
========

Connecting CsvStore to dijit.form.ComboBox
------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.CsvStore");
      dojo.require("dijit.form.ComboBox");

      var storeData =   "firstname,lastname,age\n" +
                        "John, Doe, 21\n" +
                        "Jane, Doe, 22\n" +
                        "Richard, Smith, 43\n" +
                        "Sally, Smith, 49\n" +
                        "Lian, Zu, 23\n" +
                        "Ichiro, Kagetsume, 23\n"+
                        "Umeko, Tsuguri, 18\n" + 
                        "Alptraum, Reisender, 25\n" +
                        "Thomas, Winthrope, 14\n";

      var personStore = new dojox.data.CsvStore({data: storeData});
    </script>

  .. cv :: html 

    <div dojoType="dijit.form.ComboBox" store="personStore" searchAttr="firstname"></div>

    
Connecting CsvStore to dojox.grid.DataGrid
------------------------------------------

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.grid.DataGrid");
      dojo.require("dojox.data.CsvStore");

      var peopleData =  "firstname,lastname,age\n" +
                        "John, Doe, 21\n" +
                        "Jane, Doe, 22\n" +
                        "Richard, Smith, 43\n" +
                        "Sally, Smith, 49\n" +
                        "Lian, Zu, 23\n" +
                        "Ichiro, Kagetsume, 23\n"+
                        "Umeko, Tsuguri, 18\n" + 
                        "Alptraum, Reisender, 25\n" +
                        "Thomas, Winthrope, 14\n";

      var personStoreForGrid= new dojox.data.CsvStore({data: peopleData});

      var layoutPeople = [
        [
          { field: "firstname", name: "First Name", width: 10 },
          { field: "lastname", name: "Last Name", width: 10 },
          { field: "age", name: "Age", width: 'auto' }
        ]
      ];
    </script>

  .. cv :: html

    <div style="width: 400px; height: 300px;">
      <div id="grid" 
        dojoType="dojox.grid.DataGrid" 
        store="personStoreForGrid" 
        structure="layoutPeople" 
        query="{}" 
        rowsPerPage="40">
      </div>
    </div>

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/Grid.css";
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>
