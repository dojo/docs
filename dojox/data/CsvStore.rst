#format dojo_rst

dojox.data.CsvStore
===================

.. contents::
  :depth: 3

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
| data           | No           |A JavaScript String of Csv formatted data to use to populate the store.  This parameter can be  | 1.0       |
|                |              |used instead of *url*. when you wish to load data differently then modify it to fit the expected|           |
|                |              |Csv format.                                                                                     |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| label          | No           |A string that identifies which column to treat as the human-readable label. It must match one of| 1.0       |
|                |              |the column labels in the file for it to be effective.                                           |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+

========
Examples
========

------------------------------------------------------
Example 1:  Connecting CsvStore to dijit.form.ComboBox
------------------------------------------------------
