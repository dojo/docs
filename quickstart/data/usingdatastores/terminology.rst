#format dojo_rst

Terminology
===========

.. contents::
  :depth: 3

+---------------+------------------------------+------------------------------------------------------------------------------------------------+
+ **Term**      | **Equivalent Database Term** | **Description**                                                                                | 
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| data store    | cursor                       | A JavaScript object that reads data from a data source and makes that data available as data   |
|               |                              | items through dojo.data APIs.                                                                  |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| data source   | database                     |The place that the raw data comes from. For example, in a CsvStore, the data source would be the|
|               |                              |.csv formatted file that the store loaded. In general, the data source could be a file, a       |
|               |                              |databaseserver, a Web service, or something else completely. They can be as simple as flat,     |
|               |                              |table-like rows, or as complex as a full hierarchical database with nested details.             |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| item          | row                          |A data item that has attributes with attribute values.                                          |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| attribute     | column                       |One of the fields or properties of an item.                                                     |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| value         | -                            |The contents of an attribute for a given item.                                                  |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| reference     | -                            |A value that points to another data item                                                        |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| identity      | primary key                  |An identifier that can be used to uniquely identify an item within the context of a single      |
|               |                              |datastore.  Note that identifiers should be immutable.                                          |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
| query         | WHERE clause of the SQL      | A specification or request that asks a datastore for some subset of the items it knows about. A|  
|               | select.                      |query is often an object with a set of attribute/value pairs that define what attributes should |
|               |                              |be matched. It is possible, however, that the query could be a string or a number.              |
|               |                              |**Note:** It is highly recommended that all stores use an object structure of attribute         |
|               |                              |name/value pairs as thequery format for consistency between stores.                             |
+---------------+------------------------------+------------------------------------------------------------------------------------------------+
