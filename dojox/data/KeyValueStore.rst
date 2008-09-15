#format dojo_rst

dojox.data.KeyValueStore
========================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.1

.. contents::
    :depth: 3

This is a dojo.data store implementation. The KeyValueStore is a store that takes content in a format similar to those used by property files, such as Java, and many other languages were there are unique keys mapping to some value for display.  Think of it as an interface for reading property style files in dojo through the dojo.data interface.   

============
Input Format
============

It can take in either a Javascript array, JSON string, or URL as the data source. Data is expected to be in the following format:

.. code-block :: javascript

  [
    { "key1": "value1" },
    { "key2": "value2" },
    ...
  ]

Each 'item' retrieved from this store from this store is a JS object representing a key-value pair. If an item in the above array has more than one key/value pair, only the first will be used/accessed.


======================
Constructor Parameters
======================

The constructor for the store can take three different parameters as a way to load the data; a URL to a JSON encoded file, a reference to a JavaScript object in key/value pair format, and a JSON encoded string.   The parameters are documented below:

+---------------+------------------------------------------------------------------------------+------------------------------+
|**Parameter**  |**Description**                                                               |**Type**                      |
+---------------+------------------------------------------------------------------------------+------------------------------+
|url            |The URL from which to xhrGet load a JSON encoded file of the data.            |String                        |
+---------------+------------------------------------------------------------------------------+------------------------------+
|data           |A JSON encoded string of the data.                                            |String                        |
+---------------+------------------------------------------------------------------------------+------------------------------+
|dataVar        |A JavaScript Array object of the items.                                       |JavaScript Array              |
+---------------+------------------------------------------------------------------------------+------------------------------+

===============
Item Attributes
===============

Items from the KeyValueStore have two well-defined attribute names 'key' and 'value', as well as the dynamic value of store.getValue(item, "key").  See the table below for further details.

+------------------------+------------------------------------------------------------------------------+------------------------------+
|**Attribute**           |**Description**                                                               |**Type**                      |
+------------------------+------------------------------------------------------------------------------+------------------------------+
|key                     |The value of this attribute is the named key used in the key/value pair.      |String                        |
+------------------------+------------------------------------------------------------------------------+------------------------------+
|value                   |The value of this attribute is the value assigned to be the key of the        |String                        |
|                        |key/value pair.                                                               |                              |
+------------------------+------------------------------------------------------------------------------+------------------------------+
|getValue(item, "key")   |The named key of the key/value pair.                                          |                              |
+------------------------+------------------------------------------------------------------------------+------------------------------+

========
Examples
========

---------------------------------------------------------------------------
Example 1:  List out all the attributes and values of a key/value data set.
---------------------------------------------------------------------------
