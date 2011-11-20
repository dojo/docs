.. _dojo/data/api:

dojo.data.api
=============

.. contents::
  :depth: 3


Before diving directly into the APIs of dojo.data, the basic concepts behind the APIs need to be explored because some design descisions that were made might seem odd without an explanation as to why they were chosen. Therefore, read this page in its entirety before moving onto the individual APIs.

========================================================
Concept 1: Data access is broken down into separate APIs
========================================================

Data access is broken down into separate APIs because not every service or data backend is able to provide complete access and functions. So not all datastores could possibly implement functions such as read, write, identify, or notifications. To make it simple to see what features a store provides, each store must provide the 'getFeatures()' function. This function reports which APIs the store implements. The following list of basic APIs are defined:

**dojo.data.api.Read** (:ref:`Read API Reference <dojo/data/api/Read>`)

  The ability to read data items and attributes of those data items. This also includes the ability to search, sort, and filter data items.

**dojo.data.api.Write** (:ref:`Write API Reference <dojo/data/api/Write>`)

  The ability to create, delete, and update data items and attributes of those data items. Not all back end services allow for modification of data items. In fact, most public services like Flikr, Delicious, GoogleMaps, for example are primarily read-based data providers.

**dojo.data.api.Identity** (:ref:`Identity API Reference <dojo/data/api/Identity>`)
  The ability to locate and look up an item based on its unique identifier, if it has one. Not all data formats have unique identifiers that can be used to look up data items.

**dojo.data.api.Notification** (:ref:`Notification API Reference <dojo/data/api/Notification>`)

  The ability to notify listeners for change events on data items in a store. The basic change events for an item are create, delete, and update. These are particularly useful for cases such as a datastore that periodically polls a back end service for data refresh.

Future Features
---------------

There are further functions that the Dojo development community would like to define as additional features stores which might be implemented. However, they have not been completely specified yet and are a work in progress. As such, they are not currently provided in the Dojo Toolkit. Note that the list can change at any time as decisions evolve about what capabilities the dojo.data APIs should provide. The following features are functions that the Dojo development community would like to define as additional features stores to implement:

**dojo.data.api.Schema**

**dojo.data.api.Attribution**

  Creation and modification of timestamps, author, and other functions of data items.

**dojo.data.api.Versioning**

  Tracking and accessing old versions of data items.

**dojo.data.api.Derivation**
  Attributes derived from other attributes and calculated values

============================================================
Concept 2: All items are operated on through store functions
============================================================

**Note:** Attributes are never directly accessed from the item object.

This concept is likely one of the aspects of dojo.data that might seem confusing at first. The following code snippet shows this concept:

Correct access
--------------

.. code-block :: javascript 

  var store = new some.data.Store();
  var items;
  ... //Assume in this time items is now an array populated by a call to store.fetch();
  //To iterate over the items and print out the value of a 'foo' attribute, you would do the following:
  for (var i = 0; i < items.length; i++){
      var item = items[i];
      console.log("For attribute 'foo' value was: [" + store.getValue(item, "foo") + "]");
  }


This example might make you wonder why attributes are not accessed as shown in one of the following examples:

Incorrect access
----------------

* var value = item["foo"]; 
* var value = item.foo;
* var value = item.getValue("foo");

Why is it a requirement to use a store accessor function in dojo.data?  The reasons are many:

* Efficiency in accessing the values on the items: By requiring access to go through store functions, the store can hide the internal structure of the item. This allows the item to remain in a format that is most efficient for representing the datatype for a particular situation. For example, the items could be XML DOM elements and, in that case, the store would access the values using DOM APIs when store.getValue() is called.

  As a second example, the item might be a simple JavaScript structure and the store can then access the values through normal JavaScript accessor notation. From the end-users perspective, the access is exactly the same: store.getValue(item, "attribute"). This provides a consistent look and feel to accessing a variety of data types. This also provides efficiency in accessing items by reducing item load times by avoiding conversion to a defined internal format that all stores would have to use.

* The store could use a very compact internal structure: This lessens the amount of memory required by a particular store to represent some item and its attribute values.

* Going through store accessor function provides the possibility of lazy-loading in of values as well as lazy reference resolution.
* Requiring items to be objects with accessor functions on the object for the value would be very expensive to construct, particularly for large data sets. Therefore, it is not a requirement.
