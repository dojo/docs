#format dojo_rst

dojo/data/ItemFileWriteStore
============================

:Status: Contributed, Draft
:Version: 1.2
:Author: Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

Dojo core provides the ItemFileWriteStore store as an extension to ItemFileReadStore that adds on the dojo.data.api.Write and dojo.data.api.Notification API support to ItemFileReadStore. It was specifically created as a separate class so that if you only need read capability, you do not incur the download penalty of the write and notification API support if you won't use it. If your application needs to write to the ItemFileStore instead of just Read, then ItemFileWriteStore is the store you should instantiate. The input data format is identical to `ItemFileReadStore <dojo/data/ItemFileReadStore>`_.


===========
API Support
===========

* dojo.data.api.Read
* dojo.data.api.Write
* dojo.data.api.Identity
* dojo.data.api.Notification

======================
Constructor Parameters
======================

The constructor for ItemFileWriteStore takes the same parameters as `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_ 

============
Custom Types
============

As with dojo.data.ItemFileReadStore, the ItemFileWriteStore supports using custom defined types in the data format.  Since ItemFileWriteStore supports mechanisms for serializing the store contents back out, the custom type support has been extended to allow for custom serializers so that the complex types can be converted back into their necessary encodings.  

--------------------
Custom Type Examples
--------------------

By default, ItemFileWriteStore has registered a custom type handler for JavaScript Date objects.  It uses the general case formatting option for the value, as shown below:

.. code-block :: javascript

  {
    "Date": {
      type: Date,
      deserialize: function (value) {
        return dojo.date.stamp.fromISOString(value);
      },
      serialize: function(obj) {
        return dojo.date.stamp.toISOString(obj, {zulu:true});
      }
    }
  
So, when Date objects are encountered, ItemFileWriteStore automatically serializes it out as a custom type of the following format:

.. code-block :: javascript

  { "_type":"Date", "value":"1993-05-24T00:00:00Z" }
