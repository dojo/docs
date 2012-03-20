.. _dojo/data/api/Write:

===================
dojo.data Write API
===================

.. contents ::
  :depth: 2

*Deprecated*, :ref:`dojo/store <dojo/store>` will eventually replace the ``dojo/data`` API.

Some datastores provide the ability to create new items and save those items back to a service, in addition to simply
reading items from a service. Stores with this capability will implement the Write API, which provides standard
functions for creating new items, modifying existing items, and deleting existing items. Review the following examples,
guidelines, and complete API documentation for further information on the Write API.

This feature defines the API for implementing:

* Creating a new item
* Deleting an item.
* Updating an item.
* Saving a series creates, deletes, and updates.
* Reverting a series of creates, deletes, and updates.
* Determining if an item has been modified and not yet saved.


Write API requirements
======================

The following list provides the requirements for the Write API that implementers of a datastore must do:

* Datastores that implement the Write interface act as a two-phase intermediary between the client and the ultimate provider 
  or service that handles the data. This allows for the batching of operations, such as creating a set of new items and 
  then saving them all back to the persistent store with one function call.
* The save API is defined as asynchronous. This is because most datastores will be talking to a server and not all I/O 
  methods for server communication can perform synchronous operations.
* Datastores track all newItem, deleteItem, and setAttribute calls on items so that the store can both save the items to the 
  persistent store in one chunk and have the ability to revert out all the current changes and return to a pristine 
  (unmodified) data set.
* Revert should only revert the store items on the client side back to the point the last save was called.
* Datastores, in their Save function, account for any copying of items and generation of save format required by the back 
  end service before it enters into the asynchronous I/O with the server. This is to avoid any contention issues with 
  modifications that are occurring while the datastore is is waiting for the server I/O to complete.
* The parameter to newItem is a keywordArgs object. For ease of interoperability, this parameter should be constructed as a   
  JavaScript object with attribute names and values that match the conceptual structure of the attribute list the item 
  would return. For example, if the source store is an XML backed store, a call to create a new XML Element in that store 
  with attributes foo, bar, and bit, should look like this:

  .. js ::

    // The store will handle constructing the actual DOMElement with the appropriate DOM attributes.
    store.newItem({foo: "fooValue", bar: "barValue", bit: "bitValue"});

* Items returned from store.newItem() are valid items. In other words, store.isItem(item) returns true.
* Items returned from store.newItem() are dirty items until the next save. In other words, store.isDirty(item) returns true.
* Items deleted by store.deleteItem() are no longer valid items. In other words, store.isItem(item) returns false unless store.revert() is called and the delete is undone.



Examples
========

The following sections provide examples of the Read API in use, as described by each example heading:

Simple attribute modification and save
--------------------------------------

.. js ::

  // Instantiate some write implementing store.
  var store = some.DataWriteStore();

  // Set our load completed handler up...
  var onCompleteFetch = function(items, request){
    // Define the save callbacks to use
    var onSave = function(){
      alert("Save done.");
    }
    var onSaveError = function(error){
      alert("Error occurred: " + error)
    }

    // Process the items and update attribute 'foo'
    for(var i = 0; i < items.length; i++){
      var item = items[i];
      store.setValue(item, "foo", ("bar" + 1));
    }
    
    // If the store has modified items (it should), call save with the handlers above.
    if(store.isDirty()){
      store.save({onComplete: onSave, onError: onSaveError});
    }
  }
  // Define a fetch error handler, just in case.
  var onFetchError = function(error, request){
    alert("Fetch failed.  " + error);
  }
  // Fetch some data...  All items with a foo attribute, any value.
  store.fetch({query: {foo:"*"}, onComplete: onCompleteFetch});


Simple emit of all modified items
---------------------------------

This example shows how to get all modified items before a save has been called.

.. js ::

  var store = some.DataWriteStore();
  // Set our load completed hander up...
  var onCompleteFetch = function(items, request){
    // Process the items test for modification
    for(int i = 0; i < items.length(); i++){
      var item = items[i];
      if(store.isDirty(item){
        alert("Item with label: " + store.getLabel(item) + " is dirty.");
      }
    }
  }
  // Define a fetch error handler, just in case.
  var onFetchError = function(error, request){
    alert("Fetch failed.  " + error);
  }
  // Fetch some data...  All items, in fact (no query should return everything)
  store.fetch({onComplete: onCompleteFetch});


Further examples
----------------

Further examples of the API usage are covered in the :ref:`Using Datastores <quickstart/data/usingdatastores>` section. Refer to it for examples on paging, sorting, selecting, and so forth.


API Info
========

.. api-link :: dojo.data.api.Write
