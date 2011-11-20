.. _dojo/data/api/Write:

dojo.data.api.Write
===================

.. contents::
  :depth: 3

Some datastores provide the ability to create new items and save those items back to a service, in addition to simply reading items from a service. Stores with this capability will implement the Write API, which provides standard functions for creating new items, modifing existing items, and deleting existing items. Review the following examples, guidelines, and complete API documentation for further information on the Write API.

This feature defines the API for implementing:

* Creating a new item
* Deleting an item.
* Updating an item.
* Saving a series creates, deletes, and updates.
* Reverting a series of creates, deletes, and updates.
* Determining if an item has been modified and not yet saved.

======================
Write API requirements
======================

The following list provides the requirements for the Write API that implementors of a datastore must do:

* Datastores that implement the Write interface act as a two-phase intermediary between the client and the ultimate provider or service that handles the data. This allows for the batching of operations, such as creating a set of new items and then saving them all back to the persistent store with one function call.
* The save API is defined as asynchronous. This is because most datastores will be talking to a server and not all I/O methods for server communication can perform synchronous operations.
* Datastores track all newItem, deleteItem, and setAttribute calls on items so that the store can both save the items to the persistent store in one chunk and have the ability to revert out all the current changes and return to a pristine (unmodified) data set.
* Revert should only revert the store items on the client side back to the point the last save was called.
* Datastores, in their Save function, account for any copying of items and generation of save format required by the back end service before it enters into the asynchronous I/O with the server. This is to avoid any contention issues with modifications that are occurring while the datastore is is waiting for the server I/O to complete.
* The parameter to newItem is a keywordArgs object. For ease of interoperability, this parameter should be constructed as a JavaScrpt object with attribute names and values that match the conceptual structure of the attribute list the item would return. For example, if the source store is an XML backed store, a call to create a new XML Element in that store with attributes foo, bar, and bit, should look like this: 

  .. code-block :: javascript 

    //The store will handle constructing the actual DOMElement with the appropriate DOM attributes.
    store.newItem({foo: "fooValue", bar: "barValue", bit: "bitValue"});

* Items returned from store.newItem() are valid items. In other words, store.isItem(item) returns true.
* Items returned from store.newItem() are dirty items until the next save. In other words, store.isDirty(item) returns true.
* Items deleted by store.deleteItem() are no longer valid items. In other words, store.isItem(item) returns false unless store.revert() is called and the delete is undone.


========
Examples
========

The following sections provide examples of the Read API in use, as described by each example heading:

Simple attribute modification and save
--------------------------------------

.. code-block :: javascript

  //Instantiate some write implementing store.
  var store = some.DataWriteStore();

  //Set our load completed hander up...
  var onCompleteFetch = function(items, request) {
    //Define the save callbacks to use 
    var onSave = function(){
      alert("Save done.");
    }
    var onSaveError = function(error) {
      alert("Error occurred: " + error)
    }

    // Process the items and update attribute 'foo'
    for (var i = 0; i < items.length; i++){
      var item = items[i];
      store.setValue(item, "foo", ("bar" + 1));
    }
    
    // If the store has modified items (it should), call save with the handlers above.
    if (store.isDirty()){
      store.save({onComplete: onSave, onError: onSaveError});
    }
  }
  //Define a fetch error handler, just in case.
  var onFetchError = function(error, request){
    alert("Fetch failed.  " + error);
  }
  // Fetch some data...  All items with a foo attribute, any value.
  store.fetch({query: {foo:"*"}, onComplete: onCompleteFetch});


Simple emit of all modified items
---------------------------------

This example shows how to get all modified items before a save has been called.

.. code-block :: javascript

  var store = some.DataWriteStore();
  //Set our load completed hander up...
  var onCompleteFetch = function(items, request) {
    // Process the items test for modification
    for (int i = 0; i < items.length(); i++){
      var item = items[i];
      if (store.isDirty(item){
        alert("Item with label: " + store.getLabel(item) + " is dirty.");
      }
    }
  }
  //Define a fetch error handler, just in case.
  var onFetchError = function(error, request){
    alert("Fetch failed.  " + error);
  }
  // Fetch some data...  All items, in fact (no query should return everything)
  store.fetch({onComplete: onCompleteFetch});


Further examples
----------------

Further examples of the API usage are covered in the Using Datastores section. Refer to it for examples on paging, sorting, selecting, and so forth. 

================
The complete API
================

For convenience, the complete Write Feature is defined below.

newItem
-------

.. code-block :: javascript

  newItem: function(/* Object? */ keywordArgs, /*Object?*/ parentInfo){
    //   summary:
    //        Returns a newly created item.  Sets the attributes of the new
    //        item based on the *keywordArgs* provided.  In general, the attribute
    //        names in the keywords become the attributes in the new item and as for
    //        the attribute values in keywordArgs, they become the values of the attributes
    //        in the new item.  In addition, for stores that support hierarchical item 
    //        creation, an optional second parameter is accepted that defines what item is the parent
    //        of the new item and what attribute of that item should the new item be assigned to.
    //        In general, this will assume that the attribute targetted is multi-valued and a new item
    //        is appended onto the list of values for that attribute.  
    //        
    //    keywordArgs:
    //        A javascript object defining the initial content of the item as a set of JavaScript 'property name: value' pairs.
    //    parentInfo:
    //        An optional javascript object defining what item is the parent of this item (in a hierarchical store.  Not all stores do hierarchical items), 
    //        and what attribute of that parent to assign the new item to.  If this is present, and the attribute specified
    //        is a multi-valued attribute, it will append this item into the array of values for that attribute.  The structure
    //        of the object is as follows:
    //        {
    //            parent: someItem,
    //            attribute: "attribute-name-string"
    //        }
    //        
    //    exceptions:
    //        Throws an exception if *keywordArgs* is a string or a number or
    //        anything other than a simple anonymous object.  
    //        Throws an exception if the item in parentInfo is not an item from the store
    //        or if the attribute isn't an attribute name string.
    //    examples:
    //        var kermit = store.newItem({name: "Kermit", color:[blue, green]});

deleteItem
----------

.. code-block :: javascript

  deleteItem: function(/* item */ item)
    //    summary:
    //        Deletes an item from the store.
    //
    //    item: 
    //        The item to delete.
    //
    //    exceptions:
    //        Throws an exception if the argument *item* is not an item 
    //        (if store.isItem(item) returns false).
    //    examples:
    //        var success = store.deleteItem(kermit);

setValue
--------

.. code-block :: javascript

  setValue: function(/* item */ item, /* string */ attribute, /* almost anything */ value)
    //    summary:
    //        Sets the value of an attribute on an item.
    //        Replaces any previous value or values.
    //
    //    item:
    //        The item to modify.
    //    attribute:
    //        The attribute of the item to change represented as a string name.
    //    value:
    //        The value to assign to the item.
    //
    //    exceptions:
    //        Throws an exception if *item* is not an item, or if *attribute*
    //        is neither an attribute object or a string.
    //        Throws an exception if *value* is undefined.
    //    examples:
    //        var success = store.set(kermit, "color", "green");

setValues
---------

.. code-block :: javascript

  setValues: function(/* item */ item, /* string */ attribute, /* array */ values)
    //    summary:
    //        Adds each value in the *values* array as a value of the given
    //        attribute on the given item.
    //        Replaces any previous value or values.
    //        Calling store.setValues(x, y, []) (with *values* as an empty array) has
    //        the same effect as calling store.unsetAttribute(x, y).
    //
    //    item:
    //        The item to modify.
    //    attribute:
    //        The attribute of the item to change represented as a string name.
    //    values:
    //        An array of values to assign to the attribute..
    //
    //    exceptions:
    //        Throws an exception if *values* is not an array, if *item* is not an
    //        item, or if *attribute* is neither an attribute object or a string.
    //    examples:
    //        var success = store.setValues(kermit, "color", ["green", "aqua"]);
    //        success = store.setValues(kermit, "color", []);
    //        if (success) {assert(!store.hasAttribute(kermit, "color"));}

unsetAttribute
--------------

.. code-block :: javascript

  unsetAttribute: function(    /* item */ item, /* string */ attribute)
    //    summary:
    //        Deletes all the values of an attribute on an item.
    //
    //    item:
    //        The item to modify.
    //    attribute:
    //        The attribute of the item to unset represented as a string.
    //
    //    exceptions:
    //        Throws an exception if *item* is not an item, or if *attribute*
    //        is neither an attribute object or a string.
    //    examples:
    //        var success = store.unsetAttribute(kermit, "color");
    //        if (success) {assert(!store.hasAttribute(kermit, "color"));}

save
----

.. code-block :: javascript

  save: function(/* object */ keywordArgs)
    //    summary:
    //        Saves to the server all the changes that have been made locally.
    //        The save operation may take some time and is generally performed
    //        in an asynchronous fashion.  The outcome of the save action is 
    //        is passed into the set of supported callbacks for the save.
    //   
    //    keywordArgs:
    //        {
    //            onComplete: function
    //            onError: function
    //            scope: object
    //        }
    //
    //    The *onComplete* parameter.
    //        function();
    //
    //        If an onComplete callback function is provided, the callback function
    //        will be called just once, after the save has completed.  No parameters
    //        are generally passed to the onComplete.
    //
    //    The *onError* parameter.
    //        function(errorData); 
    //
    //        If an onError callback function is provided, the callback function
    //        will be called if there is any sort of error while attempting to
    //        execute the save.  The onError function will be based one parameter, the
    //        error.
    //
    //    The *scope* parameter.
    //        If a scope object is provided, all of the callback function (
    //        onComplete, onError, etc) will be invoked in the context of the scope
    //        object.  In the body of the callback function, the value of the "this"
    //        keyword will be the scope object.   If no scope object is provided,
    //        the callback functions will be called in the context of dojo.global.  
    //        For example, onComplete.call(scope) vs. 
    //        onComplete.call(dojo.global)
    //
    //    returns:
    //        Nothing.  Since the saves are generally asynchronous, there is 
    //        no need to return anything.  All results are passed via callbacks.
    //    examples:
    //        store.save({onComplete: onSave});
    //        store.save({scope: fooObj, onComplete: onSave, onError: saveFailed});

revert
------

.. code-block :: javascript

  revert: function()
    //    summary:
    //        Discards any unsaved changes.
    //    description:
    //        Discards any unsaved changes.
    //
    //    examples:
    //        var success = store.revert();

isDirty
-------

.. code-block :: javascript

  isDirty: function(/* item? */ item)
    //    summary:
    //        Given an item, isDirty() returns true if the item has been modified 
    //        since the last save().  If isDirty() is called with no *item* argument,  
    //        then this method returns true if any item has been modified since
    //        the last save().
    //
    //    item:
    //        The item to check.
    //
    //    exceptions:
    //        Throws an exception if isDirty() is passed an argument and the
    //        argument is not an item.
    //    examples:
    //        var trueOrFalse = store.isDirty(kermit); // true if kermit is dirty
    //        var trueOrFalse = store.isDirty();       // true if any item is dirty
