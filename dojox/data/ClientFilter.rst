.. _dojox/data/ClientFilter:

=======================
dojox.data.ClientFilter
=======================

:Authors: Marcus Reimann, Kris Zyp
:Developers: Kris Zyp
:since: V1.2

.. contents ::
   :depth: 2

An abstract data store module for adding updateable result set functionality to an existing data store class.


Introduction
============

This is an abstract class that data stores can extend to add updateable result set functionality as well as client side querying capabilities. This enables widgets to be aware of how active results change in response to the modifications/notifications.


Usage
=====

To update a result set after a notification (onNew, onSet, and onDelete), widgets can call the **updateResultSet** method. Widgets can use the updated result sets to determine how to react to notifications, and how to update their displayed results based on changes.

This module will use the best available information to update result sets, using query attribute objects to determine if items are in a result set, and using the sort arrays to maintain sort information. However, queries can be opaque strings, and this module can not update results by itself in this case. In this situations, data stores can provide a **isUpdateable(request)** function and **matchesQuery(item, request)** function. If a data store can handle a query, it can return true from isUpdateable and if an item matches a query, it can return true from matchesQuery.

Here is a definition of isUpdateable and matchesQuery:

isUpdateable(request)
  request is the keywords arguments as is passed to the fetch function.

matchesQuery(item, request)
  item is the item to test, and request is the value arguments object for the fetch function.

You can define a property on this object instance "**cacheByDefault**" to a value of true that will cause all queries to be cached by default unless the cache queryOption is explicitly set to false. This can be defined in the constructor options for ServiceStore/JsonRestStore and subtypes.


Examples
========

Making an updatable-result-set data store
-----------------------------------------

To make a updatable-result-set data store from an existing data store:

.. js ::
 
 dojo.declare("dojox.data.MyUpdatableDataStore",
     dojox.data.MyDataStore,
     // subclass ClientFilter if available:
     dojox.data.ClientFilter],
     {}
 );


Using the ClientFilter with a data store
----------------------------------------

To use the ClientFilter with a data store which offers optional support of ClientFilter (like dojox.data.ServiceStore and dojox.data.JsonRestStore), it's important to observe the correct sequence:

1. include dojox.data.ClientFilter
2. include the data store
3. set queryOptions:{cache:true} in the request

   or use a Widget with a option to cache each request (for example the Grid with the queryOptions attribute:

   <table data-dojo-type="dojox.grid.DataGrid" data-dojo-props="queryOptions:{cache:true}" ...)

The important note is that you must load ClientFilter before you dojo.require a store.

.. js ::

   // first include ClientFilter:
   dojo.require('dojox.data.ClientFilter');
   // now include the data store:
   dojo.require("dojox.data.JsonRestStore");

   // ... later:
   // set queryOptions:{cache:true} in the request:


See also
========

* `#7743 <http://bugs.dojotoolkit.org/ticket/7743>`_

  Some further explanations which should be included into this documentation page
