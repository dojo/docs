.. _dojo/data/api/Read:

==================
dojo.data Read API
==================

.. contents ::
  :depth: 3

*Deprecated*, :ref:`dojo/store <dojo/store>` will eventually replace the ``dojo/data`` API.

The most fundamental API of dojo.data is the Read API. All stores will implement this API because all stores need the ability to retrieve and process data items. The Read API is designed to be extremely flexible in how items are handled. The Read API provides the ability to:

* Introspect any datastore to determine the APIs the datastore implements through the getFeatures() call.
* Introspect, On an item by item basis, what attributes each item has in a way that is agnostic to the data format.
* Get values of attributes in a way that is agnostic to the data format.
* Test attributes of items to see if they contain a specific value.
* Test any JavaScript object to see if it is an item from the store.
* Test to see if an item has been fully loaded from its source or if it is just the stub of an item that needs to be fully loaded.
* Load stub items (lazy-loading).
* Search for items that match a query.
* Sort items in a search.
* Page across items in a search.
* Filter items by the query and wildcard matching.
* Obtain a human-readable label of the item if possible.


Examples
========

The following examples, guidelines, and complete API documentation provide further information on the Read API:

Listing the APIs supported by a datastore
-----------------------------------------

.. js ::

  var store = new some.Datastore();
  var features = store.getFeatures();
  for(var i in features){
    console.log("Store supports feature: " + i);
  }

Testing if an object is a store item
------------------------------------

.. js ::

  var store = new some.Datastore();
  if(store.isItem(someObject)){
    console.log("Object was an item.");
  }else{
    console.log("Object was NOT an item.");
  }

Listing the attributes of an item
---------------------------------

.. js ::

  var store = new some.Datastore();
  ... // Assume that someItem is an item we got from a load.
  var attributes = store.getAttributes(someItem);
  for(var i = 0; i < attributes.length; i++){
    console.log("Item has attribute: " + attributes[i]);
  }

Testing an item for an attribute
--------------------------------

.. js ::

  var store = new some.Datastore();
  ...
  // Assume that someItem is an item we got from a load.
  if(store.hasAttribute(someItem, "foo")){
    console.log("item has attribute foo.");
  }else{
    console.log("item DOES NOT have attribute foo.");
  }

Getting the label of an item
----------------------------

.. js ::

  var store = new some.Datastore();
  ...
  // Assume that someItem is an item we got from a load.
  var label = store.getLabel(someItem);
  console.log("item has label: " + label);

Fetching all the items from the store
-------------------------------------

.. js ::

  var store = new some.Datastore();
  var gotItems = function(items, request){
    console.log("Number of items located: " + items.length);
  };
  store.fetch({onComplete: gotItems});

Further examples
----------------

Further examples of the API usage are covered in the :ref:`Using Datastores <quickstart/data/usingdatastores>` section. Refer to it for examples on paging, sorting, selecting, and so forth.
