#format dojo_rst

dojo.store.Watchable
====================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.6

.. contents::
    :depth: 3

**dojo.store.Watchable** is a object store wrapper that adds support for notification of data changes to query result sets. The query result sets returned from a watchable store will include a watch function that can be used to monitor for changes. This store follows the new `Dojo Object Store API <dojo/store>`_.


============
Introduction
============

The watchable store wrapper makes it simple for UI components to monitor changes to result sets based on data changes. Because this functionality is centered around result sets, the events specifically are designed to communicate the necessary information for UIs to update visual readouts based on how the data changes affects the currently displayed data.

The result sets from a watchable store will have a watch method. The watch method has the following signature:

.. code-block :: javascript

 resultSet.watch(listener);

The listener function is called with following arguments: 

.. code-block :: javascript

 listener(index, existingObjectId, newObject);

* The index value indicates the position in the result set that changed. If this value is undefined, it indicates that the store was unable to determine where in the result set the change took place. 
* The existingObjectId indicates the object id of the object that formerly existed at the index position. If this value is undefined it indicates the object was inserted into the position. 
* The newObject indicates the new object that fills the given index position. If this is undefined it indicates that the previous object was (indicated by the existingObjectId) was removed from the result set.

========
Examples
========

.. code-block :: javascript
 
 // create the initial watchable store
 store = dojo.store.Watchable(new dojo.store.Memory({data: someData}));

 // query the store
 var results = store.query({rating:5});

 // do something with the initial result set
 results.forEach(insertRow);
 
 // now listen for any changes
 results.watch(function(index, existingObjectId, newObject){
   if(existingObjectId){ // existing object removed
     removeRow(index);
   }
   if(newObject){ // new or updated object inserted
     insertRow(index, newObject);
   }
 });

 // this will trigger an addition to the result set (the watch listener will be called)
 store.put({rating: 5, id: 3}); 

 // this will *not* trigger a watch event, since the object does not match the query constraint (query was for rating = 5)
 store.put({rating: 3, id: 4}); 
 
 // if this object was in the result set, it will trigger a watch event
 store.remove(2);
