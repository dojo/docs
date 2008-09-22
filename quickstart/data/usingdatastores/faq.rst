#format dojo_rst

dojo.data FAQ
=============

.. contents::
  :depth: 3

This section is intended as a point to put answers to the common questions posed by users of dojo.data.  

========================================================================================================
I called fetch() on a datastore and the return value from the fetch function doesn't have my data!  Why?
========================================================================================================

Because the dojo.data API is asynchronous be definition.  The return value from fetch will generally not have any data on it.  It's intended as a point for stores to store an abort() function for a request and a place for stores to put internal cache details and the like.  It is not intended to gand back data items.  Data items are always returned through the callbacks to fetch().
 

===========================================================================================================================
I introspected using javascript associative map walking items from ItemFileReadStore and it has all these _variables!  Why?
===========================================================================================================================

Items from a datastore are supposed to be treated as opaque handles.  This is by definition of the API, which can be read in the `API section <dojo/data/api>`_.  dojo.data.ItemFileReadStore and dojo.data.ItemFileWriteStore store several bits of important internal information on each item, such as what store instance it came form, what its internal index is (for O(1) lookup performance), and internal maps of who has references to the item.  This is all critical information needed by the store to make item processing efficient.  It is also information that should never be relied on directly, it should only be used by the store itself.  

All store access should go through the `dojo.data.api.Read <dojo/data/api/Read>`_ functions.  Below is a list of the common functions and what you use them for:

* **store.getAttributes(item):**  Returns an array list of all public attributes of an item.  Only attributes returned in this list should ever be used as data.
* **store.getValue(item, attribute):** The function you use to get a single value from an attribute of a data item.  For multi-valued attributes, you should use store.getValues(item, attribute);  


=============================================================================================================
Okay, you say dojo.data items are opaque ... but I' like to convert them to a JSON object.  How do I do that?
=============================================================================================================

This is actually not difficult to do.  This is done through usage of the dojo.data.api.Read specification.  The code you would use to create a JSON structure from a dojo.data item is the following:

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
      var attributes = store.getAttributes();
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
                //Check that the value isn't another item.  If it is, process it as an item.
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
