#format dojo_rst

dojox.data.KeyValueStore
========================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V?

.. contents::
    :depth: 3

This is a dojo.data store implementation. It can take in either a Javascript array, JSON string, or URL as the data source. Data is expected to be in the following format:

.. code-block :: javascript
  :linenos:

  [
    { "key1": "value1" },
    { "key2": "value2" }
  ]

This is to mimic the Java Properties file format. Each 'item' from this store is a JS object representing a key-value pair. If an item in the above array has more than one key/value pair, only the first will be used/accessed.
