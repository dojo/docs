.. _dojo/data/api/Notification:

Notification API
================

.. contents::
  :depth: 3

When working with data and items, sometimes it is useful to be notified when items are created, deleted, or modified within a given dojo.data datastore. The dojo.data.api.Notification feature is implemented by stores to expose such a capability. This set of functions defines monitoring for the main change events a store can see on an item: create, modify, and delete. Review the following examples, guidelines, and complete API documentation for further information on the Notification API.


================
API Requirements
================

As with all DataStores, not all stores will implement this API. For stores that implement this API, the following assumptions should be made:

* All change events on items (create, set attribute and delete) will trigger a call to the appropriate store notification function.
* Notifications occur at a store level and for all items. The Notifications API does not cover registering to listen for only particular items being modified. That does not mean it cannot be done in a custom store with an extended set of functions, only that such behavior is not defined by the specification. This is because, after careful analysis, it was determined by the dojo community that a per-item registration scheme could get extremely costly in terms of CPU time or object construction and was therefore avoided.
* Most store implementations of Notification should implement these functions as simple no-op bind points for efficiency and performance. This also provides safety, should you want to replace the stub function with a more complex implementation or notification (or both) scheme.


========
Examples
========

There are two general patterns of listening on these functions for change events. The first pattern is to use the dojo.connect() event model to bind to the function on the store and have one of your functions called whenever the store calls the onSet, onNew, and onDelete functions. The second pattern is to replace the implementation of the notification functions on the store with custom logic to do something each time the store calls the function. Example usage of such functions are provided in the following examples.

Basic dojo.connect
------------------

This example shows, how to use dojo.connect to connect the datastores onNew function with one of your own functions:

.. code-block :: javascript 

  var store = some.NotifyWriteStore();
  var alertOnNew = function(item) {
    var label = store.getLabel(item);
    alert("New item was created: [" + label + "]");
  };
  dojo.connect(store, "onNew", alertOnNew);
  //An alert should be thrown when this completes

  var newItem = store.newItem({foo:"bar"});


Replacing the onNew function
----------------------------

This example shows, how to override the onNew function of a datastore with a custom one:

.. code-block :: javascript 

  var store = some.NotifyWriteStore();
  store.onNew = function(item) {
    var label = this.getLabel(item);
    alert("New item was created: [" + label + "]");
  };
  //An alert should be thrown when this completes
  var newItem = store.newItem({foo:"bar"});


====================
The Complete Feature
====================

For convenience, the complete feature from dojo/data/api/Notification.js is defined below:

onSet
-----

.. code-block :: javascript

  onSet: function(item, attribute, oldValue, newValue)

summary:
  This function is called any time an item is modified via setValue, setValues, unsetAttribute, etc.  

description:
  This function is called any time an item is modified via setValue, setValues, unsetAttribute, etc.  
  Its purpose is to provide a hook point for those who wish to monitor actions on items in the store in a simple manner. The general expected usage is to dojo.connect() to the store's implementation and be called after the store function is called.

parameters:
  =========  ===============  ===========
  parameter  type             description
  =========  ===============  ===========
  item       object           The item being modified.
  attribute  string           The attribute being changed represented as a string name.
  oldValue   object or array  The old value of the attribute. In the case of single value calls, such as setValue, unsetAttribute, etc, this value will be generally be an atomic value of some sort (string, int, etc, object). In the case of multi-valued attributes, it will be an array.
  newValue   object or array  The new value of the attribute. In the case of single value calls, such as setValue, this value will be generally be an atomic value of some sort (string, int, etc, object). In the case of multi-valued attributes, it will be an array. In the case of unsetAttribute, the new value will be 'undefined'.
  =========  ===============  ===========

returns:
  Nothing.

onNew
-----

.. code-block :: javascript

  onNew: function(newItem, parentInfo)

summary:
  This function is called any time a new item is created in the store.
  It is called immediately after the store newItem processing has completed.

description:
  This function is called any time a new item is created in the store.
  It is called immediately after the store newItem processing has completed.

parameters:
  ==========  ======  ===========
  parameter   type    description
  ==========  ======  ===========
  newItem     object  The item created.
  parentInfo  object  An optional javascript object that is passed when the item created was placed in the store hierarchy as a value from another item's attribute, instead of a root level item. Note that if this function is invoked with a value for parentInfo, then onSet is not invoked stating the attribute of the parent item was modified. This is to avoid getting two notification events occurring when a new item with a parent is created. 
  ==========  ======  ===========

  The structure of the parameter parentInfo is as follows:

  .. code-block :: javascript

    {
      // The parent item:
      item: someItem,
      // The attribute the new item was assigned to:
      attribute: "attribute-name-string",
      // Whatever was the previous value for the attribute:
      // In the case of single value calls, such as setValue, unsetAttribute, etc, 
      // this value will be generally be an atomic value of some sort (string, int, etc, object). 
      // In the case of multi-valued attributes, it will be an array of all the values minues the new one.
      oldValue: something,
      // The new value of the attribute:
      // In the case of single value calls, such as setValue, this value will be
      // generally be an atomic value of some sort (string, int, etc, object). 
      // In the case of multi-valued attributes, it will be an array.
      newValue: something
    }

returns:
  Nothing.

onDelete
--------

.. code-block :: javascript

  onDelete: function(deletedItem)

summary:
  This function is called any time an item is deleted from the store.
  It is called immediately after the store deleteItem processing has completed.

description:
  This function is called any time an item is deleted from the store.
  It is called immediately after the store deleteItem processing has completed.

parameters:
  ===========  ======  ===========
  parameter    type    description
  ===========  ======  ===========
  deletedItem  object  The item deleted.
  ===========  ======  ===========

returns:
  Nothing.
