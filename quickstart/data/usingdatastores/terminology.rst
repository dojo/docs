#format dojo_rst

Terminology
===========

.. contents::
  :depth: 3

+---------------+------------------------------+------------------------------------------------------------------------------------------------+
+ **Term**      | **Equivalent Database Term** | **Description**                                                                                | 
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| datastore     | cursor                       |A JavaScript object that reads data from a data source and makes that data available as data    |     
|               |                              items using the dojo.data APIs.                                                                                                                                                                                          |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| data source   | database                     |The place that the raw data comes from. For example, in a CsvStore, the data source would be the|
|               |                              |.csv formatted file that the store loaded. In general, the data source could be a file, a       |
|               |                              |databaseserver, a Web service, or something else completely. They can be as simple as flat,     |
|               |                              |table-like rows, or as complex as a full hierarchical database with nested details.             |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| item          | row                          |A data item that has attributes with attribute values.                                          |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
