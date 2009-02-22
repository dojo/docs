#format dojo_rst

dojo.data FAQ
=============

.. contents::
  :depth: 3

This section is intended as a point to put answers to the common questions posed by users of dojo.data.

====================================================================================================================
Question 1:  I called fetch() on a datastore and the return value from the fetch function doesn't have my data! Why?
====================================================================================================================

Because the dojo.data API is asynchronous be definition. The return value from fetch will generally not have any data on it. It's intended as a point for stores to store an abort() function for a request and a place for stores to put internal cache details and the like. It is not intended to gand back data items. Data items are always returned through the callbacks to fetch().
 

==========================================================================================================================================
Question 2:  I introspected items from ItemFileReadStore using javascript associative map walking and it has all these '_' variables! Why?
==========================================================================================================================================

Items from a datastore are supposed to be treated as opaque handles. This is by definition of the API, which can be read in the `API section <dojo/data/api>`_. dojo.data.ItemFileReadStore and dojo.data.ItemFileWriteStore store several bits of important internal information on each item, such as what store instance it came form, what its internal index is (for O(1) lookup performance), and internal maps of who has references to the item. This is all critical information needed by the store to make item processing efficient. It is also information that should never be relied on directly, it should only be used by the store itself.

All store access should go through the `dojo.data.api.Read <dojo/data/api/Read>`_ functions. Below is a list of the common functions and what you use them for:

* **store.getAttributes(item):**  Returns an array list of all public attributes of an item. Only attributes returned in this list should ever be used as data.
* **store.getValue(item, attribute):** The function you use to get a single value from an attribute of a data item. For multi-valued attributes, you should use store.getValues(item, attribute);  


==============================================================================================================================
Question 3:  Okay, you say dojo.data items are opaque ... but I would like to convert them to a JSON object. How do I do that?
==============================================================================================================================

This is actually not difficult to do. This is done through usage of the dojo.data.api.Read specification. The code you would use to create a JSON structure from a dojo.data item is the following:

.. code-block :: javascript 

  
  function itemToJSON(store, item) {
    // summary: Function to convert an item into a JSON format.
    // store:
    //    The datastore the item came from.
    // item:
    //    The item in question.
    var json = {};
    if (item && store) {
      //Determine the attributes we need to process.
      var attributes = store.getAttributes(item);
      if (attributes && attributes.length > 0) {
        var i;
        for (i = 0; i < attributes.length; i++) {
          var values = store.getValues(item, attributes[i]);
          if (values) {
            //Handle multivalued and single-valued attributes.
            if (values.length > 1 ) {
              var j;
              json[attributes[i]] = [];
              for (j = 0; j < values.length; j++ ) {
                var value = values[j];
                //Check that the value isn't another item. If it is, process it as an item.
                if (store.isItem(value)) {
                  json[attributes[i]].push(dojo.fromJson(itemToJSON(store, value)));   
                } else {
                  json[attributes[i]].push(value);
                }    
              } 
            } else {
              if (store.isItem(values[0])) { 
                 json[attributes[i]] = dojo.fromJson(itemToJSON(store, values[0]));
              } else {
                 json[attributes[i]] = values[0];
              }
            }
          }
        }
      }
    }
    return dojo.toJson(json);
  }


===========================================================================================================================
Question 4:  Okay, I want to copy items from one store to another, but if I directly pass items I get errors. What do I do?
===========================================================================================================================

By definition, items are unique to their store instance, so you cannot generally pass an item from store A to store B without getting errors. What you must do is copy the data from one store to another. The technique for this is actually very similar to the technique described in question 3. You must iterate over the items attributes, build a JavaScript Object of them, then on the target store, call 'newItem' to create the copy of the item. Psuedocode for this would be like:

.. code-block :: javascript

  var origStore = some.datastore();
  var newStore = null;

  function onComplete(items, request) {
    newStore = some.datastore();
    if (items && items.length > 0) {
      var i;
      for (i = 0; i < items.length; i++) {
        var item = items[i];
        var attributes = origStore.getAttributes(item);
        if (attributes && attributes.length > 0) {
          var j;
          for (j = 0; j < attributes.length; j++) {
            var newItem = {};
            var values = origStore.getValues(item, attributes[j]);

            //Be careful here. If you reference other items then those too have to be cloned over in a similar manner (iterating over the attributes and building up a structure for a newItem call. This pseudocode doesn't really take that into accoumt.
            if (values) {
              if (values.length > 1) {
                //Create a copy.
                newItem[attributes[j]] = values.slice(0, values.length);
              } else { 
                newItem[attributes[j]] = values[0];
              }
          }
        }
        newStore.newItem(newItem);
      }
    }
  }
  origStore.fetch({query:{} , onComplete: onComplete});

===============================================================================================
Question 5:  With ItemFileReadStore and ItemFileWriteStore, how do I reload the store contents?
===============================================================================================

Use the two constructor options added in 1.2, *clearOnClose* and *urlPreventCache*. Then when you want to reload, call close(). It will flush the internal store structures and reload everything from the server or whatnot.

==============================================================
Question 6:  How do I get a count of all items in a datastore?
==============================================================

You do a fetch that queries for all items, then use the onBegin callback function. In the dojo.data.api.Read spec, the onBegin callback function's first parameter is the total size of the match, regardless of what start and count were configured to. This is so you have a way of knowing the total match outside of the returned page so that you can configure your client side display appropriately. The simplest way to get a size back, but no items would be to do something like:

.. code-block :: javascript

  function size(size, request) {
    //Do whatever with the size var.
  }

  store.fetch({query: {}, onBegin: size, start: 0, count: 0});


That should return no items but give you the size of the match.

The reason for this is that not all stores keep every item in memory in the browser. This would be fundamentally impossible if there was an item set of well over one million entries, which is where server backed datastores come in. For server backed datastores, you have no possible way of knowing the size of the data set (which could be changing as operations occur from other clients in a multi-user web app) at any particular moment without a query to the server ... which naturally gets into invoking a fetch.

The data API was designed to hide whether or not all items are in memory, or are stored on some remote service.

========================================================================================
Question 7:  Do all datastores have to use the format of data used by ItemFileReadStore?
========================================================================================

No. A store's internal data format can be whatever is most efficient for that store to work with. For example, dojox.data.XmlStore's input data format is XML, not JSON. The API is intended to adapt over new as well as existing, data services on the web and expose data items on a common fashion, regardless of the actual backing transport format.

==============================================================================================================
Question 8:  I want to save my data with ItemFileWriteStore, but it doesn't send the data to the server. Why?
==============================================================================================================

Because it doesn't know how to send it to your specific server/service implementation. dojo.data.ItemFileWriteStore's default save behavior is to commit data into internal memory structures only. It provides over-ridable hook functions that users must provide in order to send data to an external service. See the `Write Section <dojo/data/ItemFileWriteStore#the-write-api>`_ of the ItemFileWriteStore docs.

=================================================================================================================================================================================
Question 9:  In one of my items in ItemFileReadStore I defined an attribute value as a JavaScript object. When I access it through store.getValue(), it has been modified. Why?
=================================================================================================================================================================================

This is because child objects (non-atomic values such as int, string, etc), are automatically treated as data store items by dojo.data.ItemFileReadStore. So, when it processes that attribute, it updates it into ItemFileReadStore internal format and therefore
attributes on it should also be accessed through store functions, such as getValue(). This is easily detectable by using the ItemFileReadStore's isItem() function.

If you want to prevent ItemFileReadStore from converting Object types into data store items, you will need to use a custom type map, and define your object as a specific type that can be serialized to and from JSON using the custom type formatters. See the `custom types <dojo/data/ItemFileReadStore#items-with-custom-types>`_ documentation for more details.

==================================================================================================================================================================================================================================
Question 10:  In one of my items in ItemFileReadStore I defined an attribute value as a JavaScript object, but I didn't set an identifier. The store blows up with an error about no identifier when fetching. Why does it care? 
==================================================================================================================================================================================================================================

This question is easier to understand with a bit of sample ItemFile*Store input. Consider the following:

.. code-block :: javascript

  {
    "identifier": "myid",
    "label": "name",
    "items": [ 
        { 
          "name": "foo",
          "myid": 0,
          "someObject": {
            "someValue": "bar"
          }
    ]
  }

Note above that the child object nested off someValue doesn't have a *myid* attribute. Why does this cause ItemFile*Store an issue. This is effectively answered by question 9 on this page. This is because child objects (non-atomic values such as int, string, etc), are automatically treated as data store items by dojo.data.ItemFileReadStore.

Because it is treated as a datastore item, it must have an identifier to comply with the needs of the `dojo.data.api.Identity <dojo/data/api/Identity>`_ specification. Identity requires that all items be able to be uniquely looked up by an identifier. It does not state in a hierarchy of items only root items can be looked up by an identifier. Therefore, for ItemFile*Store, if you define the *identifier* option of the data set, you must make sure that all child items have unqiue identifiers as well so the Identity API implementation can be satisfied.

This is also necessary for support for widgets like dijit.Tree, when write support is required. It needs the capability of looking up an item from a store by its identifier, regardless of its position (root item or child of another item). Effectively, if an object in a datastore is identifiable as a datastore item (store.isItem(possibleItem)), and that store implements the Identity API, then that item must return a value for store.getIdentity(possibleItem). In other words, Hierarchy is irrelevant to whether or not an item has an identifier. All data store items in an Identity implementing store must return a value that can then be used to look the item back up later.

You have options with ItemFile*Store in how it handles nested/child objects. They are as follows:

  * Apply identifier attribute that is unique to ALL JavaScript objects in the data you are passing as data store items.

OR:

  * Don't assign an attribute the role of identifier and let the store auto-assign unique ones.

OR:

  * Use a custom type map to make the ItemFile*Store treat the complex object field value as a straight value and not a data store item. 
