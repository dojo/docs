.. _dojo/store/Observable:


dojo.store.Observable
=====================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.6

.. contents::
    :depth: 3

**dojo.store.Observable** is an object store wrapper that adds support for notification of data changes to query result sets. The query result sets returned from a Observable store will include a observe function that can be used to monitor for changes. This store follows the new :ref:`Dojo Object Store API <dojo/store>`. The observe function provides indication of the previous and new index values of changed objects to properly update result arrays.


============
Introduction
============

The Observable store wrapper makes it simple for UI components to monitor changes to result sets based on data changes. Because this functionality is centered around result sets, the events specifically are designed to communicate the necessary information for UIs to update visual readouts based on how the data changes affects the currently displayed data.

The result sets returned from store.query() calls from a Observable store will have a observe method. The observe method has the following signature:

.. code-block :: javascript

 resultSet.observe(listener);

The listener function is called with following arguments: 

.. code-block :: javascript

 listener(object, removedFrom, insertedInto);

* The object parameter indicates the object that was create, modified, or deleted. 
* The removedFrom parameter indicates the index in the result array where the object used to be. If the value is -1, then the object is an addition to this result set (due to a new object being created, or changed such that it is a part of the result set).
* The insertedInto parameter indicates the index in the result array where the object should be now. If the value is -1, then the object is a removal from this result set (due to an object being deleted, or changed such that it is not a part of the result set). If the store does not have a queryEngine, it may not be possible to determine the index of a newly created object, and the index will default to the store's defaultIndex property or 0 if the property is not present.

The observe() method returns an object with a cancel() method that can be called to stop observing the given result set.

========
Examples
========

.. code-block :: javascript
 
 // create the initial Observable store
 store = dojo.store.Observable(new dojo.store.Memory({data: someData}));

 // query the store
 var results = store.query({rating:5});

 // do something with the initial result set
 results.forEach(insertRow);
 
 // now listen for any changes
 var observeHandle = results.observe(function(object, removedFrom, insertedInto){
   if(removedFrom > -1){ // existing object removed
     removeRow(removedFrom);
   }
   if(insertedInto > -1){ // new or updated object inserted
     insertRow(insertedInto, object);
   }
 });

 // this will trigger an addition to the result set (the observe listener will be called)
 store.put({rating: 5, id: 3}); 

 // this will *not* trigger a observe event, since the object does not match the query constraint (query was for rating = 5)
 store.put({rating: 3, id: 4}); 
 
 // if this object was in the result set, it will trigger a observe event
 store.remove(2);
 
 // done observing, any further modifications will not trigger our listener
 observeHandle.cancel();


Client Side Query Awareness
---------------------------

In the example above the memory store provides a queryEngine that the Observable store leverages to determine the whether or not an object belongs in a result set, and where in the result set it belongs. If you are using a server side store like the JsonRest store, you will need to provide a queryEngine in order for the update objects to be properly included or excluded from queries. If a queryEngine is not available, observe listener will be called with an undefined index.

Triggering Notification Events
------------------------------

The Observable wrapper also adds a notify() method on the store itself. The notify method can be called if an notification of a data change from an external source is needed. The signature of notify() is:

.. code-block :: javascript

 store.notify(object, existingId);

If the object parameter is omitted, it indicates a deletion. If the existingId parameter is omitted, it indicates a new object. If both parameters are included, it in indicates an updated object.
