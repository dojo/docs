.. _dojo/data/api/Notification:

==========================
dojo.data Notification API
==========================

.. contents ::
  :depth: 3

*Deprecated*, :ref:`dojo/store <dojo/store>` will eventually replace the ``dojo/data`` API.

When working with data and items, sometimes it is useful to be notified when items are created, deleted, or modified
within a given dojo.data datastore. The dojo.data.api.Notification feature is implemented by stores to expose such a
capability. This set of functions defines monitoring for the main change events a store can see on an item: create,
modify, and delete. Review the following examples, guidelines, and complete API documentation for further information on
the Notification API.


API Requirements
================

As with all DataStores, not all stores will implement this API. For stores that implement this API, the following 
assumptions should be made:

* All change events on items (create, set attribute and delete) will trigger a call to the appropriate store notification 
  function.
* Notifications occur at a store level and for all items. The Notifications API does not cover registering to listen for 
  only particular items being modified. That does not mean it cannot be done in a custom store with an extended set of  
  functions, only that such behavior is not defined by the specification. This is because, after careful analysis, it was 
  determined by the dojo community that a per-item registration scheme could get extremely costly in terms of CPU time or 
  object construction and was therefore avoided.
* Most store implementations of Notification should implement these functions as simple no-op bind points for efficiency and 
  performance. This also provides safety, should you want to replace the stub function with a more complex implementation or 
  notification (or both) scheme.

Examples
========

There are two general patterns of listening on these functions for change events. The first pattern is to use the 
dojo.connect() event model to bind to the function on the store and have one of your functions called whenever the store 
calls the onSet, onNew, and onDelete functions. The second pattern is to replace the implementation of the notification 
functions on the store with custom logic to do something each time the store calls the function. Example usage of such 
functions are provided in the following examples.

Basic dojo.connect
------------------

This example shows, how to use dojo.connect to connect the datastores onNew function with one of your own functions:

.. js ::

  var store = some.NotifyWriteStore();
  var alertOnNew = function(item){
    var label = store.getLabel(item);
    alert("New item was created: [" + label + "]");
  };
  dojo.connect(store, "onNew", alertOnNew);
  // An alert should be thrown when this completes

  var newItem = store.newItem({foo:"bar"});


Replacing the onNew function
----------------------------

This example shows, how to override the onNew function of a datastore with a custom one:

.. js ::

  var store = some.NotifyWriteStore();
  store.onNew = function(item){
    var label = this.getLabel(item);
    alert("New item was created: [" + label + "]");
  };
  // An alert should be thrown when this completes
  var newItem = store.newItem({foo:"bar"});
