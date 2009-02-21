#format dojo_rst

dojo.data Read API
==================

.. contents::
  :depth: 3

The most fundamental API of dojo.data is the Read API. All stores will implement this API because all stores need the ability to retrieve and process data items. The Read API is designed to be extremely flexible in how items are handled. The Read API provides the ability to:

* Introspect any datastore to determine the APIs the datastore implements through the getFeatures() call.
* Instrospect, On an item by item basis, what attributes each item has in a way that is agnostic to the data format.
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


========
Examples
========

The following examples, guidelines, and complete API documentation provide further information on the Read API:

Listing the APIs supported by a datastore
-----------------------------------------

.. code-block :: javascript

  var store = new some.Datastore();
  var features = store.getFeatures();
  for(var i in features){
    console.log("Store supports feature: " + i);
  }

Testing if an object is a store item
------------------------------------

.. code-block :: javascript

  var store = new some.Datastore();
  if(store.isItem(someObject)){
    console.log("Object was an item.");
  }else{
    console.log("Object was NOT an item.");
  }

Listing the attributes of an item
---------------------------------

.. code-block :: javascript

  var store = new some.Datastore();
  ...//Assume that someItem is an item we got from a load.
  var attributes = store.getAttributes(someItem);
  for(var i = 0; i < attributes.length; i++){
    console.log("Item has attribute; " + attributes[i]);
  }

Testing an item for an attribute
--------------------------------

.. code-block :: javascript

  var store = new some.Datastore();
  ...
  //Assume that someItem is an item we got from a load.
  if(store.hasAttribute(someItem, "foo")){
    console.log("item has attribute foo.");
  }else{
    console.log("item DOES NOT have attribute foo.");
  }

Getting the label of an item
----------------------------

.. code-block :: javascript

  var store = new some.Datastore();
  ...
  //Assume that someItem is an item we got from a load.
  var label = store.getLabel(someItem);
  console.log("item has label: " + label);

Fetching all the items from the store
-------------------------------------

.. code-block :: javascript

  var store = new some.Datastore();
  var gotItems = function(items, request){
    console.log("Number of items located: " + items.length);
  };
  store.fetch({onComplete: gotItems});

Further examples
----------------

Further examples of the API usage are covered in the Using Datastores section. Refer to it for examples on paging, sorting, selecting, and so forth. 


================
The complete API
================

For convenience, the complete Read Feature is defined below.

getValue
--------

.. code-block :: javascript

  getValue: function(/* item */ item, /* attribute-name-string */ attribute, /* value? */ defaultValue)
  // example:
  // var darthVader = store.getValue(lukeSkywalker, "father");

summary:
  Returns a single attribute value.
  Returns defaultValue if and only if *item* does not have a value for *attribute*.
  Returns null if and only if null was explicitly set as the attribute value.
  Returns undefined if and only if the item does not have a value for the given attribute (which is the same as saying the item does not have the attribute). 

description:
  Saying that an "item x does not have a value for an attribute y" is identical to saying that an "item x does not have attribute y". It is an oxymoron to say "that attribute is present but has no values" or "the item has that attribute but does not have any attribute values".
  If store.hasAttribute(item, attribute) returns false, then store.getValue(item, attribute) will return undefined.

parameters:
  ============  ======  ===========
  parameter     type    description
  ============  ======  ===========
  item          object  The item to access values on.
  attribute     string  The attribute to access represented as a string.
  defaultValue          Optional. A default value to use for the getValue return in the attribute does not exist or has no value.
  exceptions            Throws an exception if *item* is not an item, or *attribute* is not a string
  ============  ======  ===========

returns:
  Nothing.

getValues
---------

.. code-block :: javascript

  getValues: function(/* item */ item, /* attribute-name-string */ attribute)
    //    summary:
    //         This getValues() method works just like the getValue() method, but getValues()
    //        always returns an array rather than a single attribute value.  The array
    //        may be empty, may contain a single attribute value, or may contain many
    //        attribute values.
    //        If the item does not have a value for the given attribute, then getValues()
    //        will return an empty array: [].  (So, if store.hasAttribute(item, attribute)
    //        returns false, then store.getValues(item, attribute) will return [].)
    //
    //    item:
    //        The item to access values on.
    //    attribute:
    //        The attribute to access represented as a string.
    //
    //    exceptions:
    //        Throws an exception if *item* is not an item, or *attribute* is not a string


getAttributes
-------------

.. code-block :: javascript

  getAttributes: function(/* item */ item)
    //    summary:
    //        Returns an array with all the attributes that this item has.  This
    //        method will always return an array; if the item has no attributes
    //        at all, getAttributes() will return an empty array: [].
    //
    //    item:
    //        The item to access attributes on.
    //
    //    exceptions:
    //        Throws an exception if *item* is not an item, or *attribute* is not a string

hasAttribute
------------

.. code-block :: javascript

  hasAttribute: function(/* item */ item, /* attribute-name-string */ attribute)
    //    summary:
    //        Returns true if the given *item* has a value for the given *attribute*.
    //
    //    item:
    //        The item to access attributes on.
    //    attribute:
    //        The attribute to access represented as a string.
    //
    //    exceptions:
    //        Throws an exception if *item* is not an item, or *attribute* is not a string

containsValue
-------------

.. code-block :: javascript

  containsValue: function(/* item */ item, /* attribute-name-string */ attribute, /* anything */ value)
    //    summary:
    //        Returns true if the given *value* is one of the values that getValues()
    //        would return.
    //
    //    item:
    //        The item to access values on.
    //    attribute:
    //        The attribute to access represented as a string.
    //    value:
    //        The value to match as a value for the attribute.
    //
    //    exceptions:
    //        Throws an exception if *item* is not an item, or *attribute* is not a string

isItem
------

.. code-block :: javascript

  isItem: function(/* anything */ something)
    //    summary:
    //        Returns true if *something* is an item and came from the store instance.  
    //        Returns false if *something* is a literal, an item from another store instance, 
    //        or is any object other than an item.
    //
    //    something:
    //        Can be anything.
    //

isItemLoaded
------------

.. code-block :: javascript

  isItemLoaded: function(/* anything */ something) 
    //    summary:
    //        Returns false if isItem(something) is false.  Returns false if
    //        if isItem(something) is true but the the item is not yet loaded
    //        in local memory (for example, if the item has not yet been read
    //        from the server).
    //
    //    something:
    //        Can be anything.
    //

loadItem
--------

.. code-block :: javascript

  loadItem: function(/* object */ keywordArgs)
    //    summary:
    //        Given an item, this method loads the item so that a subsequent call
    //        to store.isItemLoaded(item) will return true.  If a call to
    //        isItemLoaded() returns true before loadItem() is even called,
    //        then loadItem() need not do any work at all and will not even invoke
    //        the callback handlers.  So, before invoking this method, check that
    //        the item has not already been loaded.  
    //     keywordArgs:
    //        An anonymous object that defines the item to load and callbacks to invoke when the 
    //        load has completed.  The format of the object is as follows:
    //        {
    //            item: object,
    //            onItem: Function,
    //            onError: Function,
    //            scope: object
    //        }
    //    The *item* parameter.
    //        The item parameter is an object that represents the item in question that should be
    //        contained by the store.  This attribute is required.
    //    The *onItem* parameter.
    //        Function(item)
    //        The onItem parameter is the callback to invoke when the item has been loaded.  It takes only one
    //        parameter, the fully loaded item.
    //
    //    The *onError* parameter.
    //        Function(error)
    //        The onError parameter is the callback to invoke when the item load encountered an error.  It takes only one
    //        parameter, the error object
    //
    //    The *scope* parameter.
    //        If a scope object is provided, all of the callback functions (onItem, 
    //        onError, etc) will be invoked in the context of the scope object.
    //        In the body of the callback function, the value of the "this"
    //        keyword will be the scope object.   If no scope object is provided,
    //        the callback functions will be called in the context of dojo.global().
    //        For example, onItem.call(scope, item, request) vs. 
    //        onItem.call(dojo.global(), item, request)

fetch
-----

.. code-block :: javascript

  fetch: function(/* Object */ keywordArgs)
    //    summary:
    //        Given a query and set of defined options, such as a start and count of items to return,
    //        this method executes the query and makes the results available as data items.
    //        The format and expectations of stores is that they operate in a generally asynchronous 
    //        manner, therefore callbacks are always used to return items located by the fetch parameters.
    //
    //    description:
    //        A Request object will always be returned and is returned immediately.
    //        The basic request is nothing more than the keyword args passed to fetch and 
    //        an additional function attached, abort().  The returned request object may then be used 
    //        to cancel a fetch.  All data items returns are passed through the callbacks defined in the 
    //        fetch parameters and are not present on the 'request' object.
    //
    //        This does not mean that custom stores can not add methods and properties to the request object
    //        returned, only that the API does not require it.  For more info about the Request API, 
    //        see dojo.data.api.Request
    //
    //    keywordArgs:
    //        The keywordArgs parameter may either be an instance of 
    //        conforming to dojo.data.api.Request or may be a simple anonymous object
    //        that may contain any of the following:
    //        { 
    //            query: query-string or query-object,
    //            queryOptions: object,
    //            onBegin: Function,
    //            onItem: Function,
    //            onComplete: Function,
    //            onError: Function,
    //            scope: object,
    //            start: int
    //            count: int
    //            sort: array
    //        }
    //        All implementations should accept keywordArgs objects with any of
    //        the 9 standard properties: query, onBegin, onItem, onComplete, onError 
    //        scope, sort, start, and count.  Some implementations may accept additional 
    //        properties in the keywordArgs object as valid parameters, such as 
    //        {includeOutliers:true}.         
    //
    //        The *query* parameter.
    //        The query may be optional in some data store implementations.
    //        The dojo.data.api.Read API does not specify the syntax or semantics
    //        of the query itself -- each different data store implementation
    //        may have its own notion of what a query should look like.
    //        However, as of dojo 0.9, 1.0, and 1.1, all the provided datastores in dojo.data
    //        and dojox.data support an object structure query, where the object is a set of
    //        name/value parameters such as { attrFoo: valueBar, attrFoo1: valueBar1}.  Most of the
    //        dijit widgets, such as ComboBox assume this to be the case when working with a datastore 
    //        when they dynamically update the query.  Therefore, for maximum compatibility with dijit 
    //        widgets the recommended query parameter is a key/value object.  That does not mean that th
    //        the datastore may not take alternative query forms, such as a simple string, a Date, a number, 
    //        or a mix of such.  Ultimately, The dojo.data.api.Read API is agnostic about what the query 
    //        format.  
    //        Further note:  In general for query objects that accept strings as attribute 
    //        value matches, the store should also support basic filtering capability, such as * 
    //        (match any character) and ? (match single character).  An example query that is a query object
    //        would be like: { attrFoo: "value*"}.  Which generally means match all items where they have 
    //        an attribute named attrFoo, with a value that starts with 'value'.
    //
    //    The *queryOptions* parameter
    //        The queryOptions parameter is an optional parameter used to specify options that may modify
    //        the query in some fashion, such as doing a case insensitive search, or doing a deep search
    //        where all items in a hierarchical representation of data are scanned instead of just the root 
    //        items.  It currently defines two options that all datastores should attempt to honor if possible:
    //        {
    //            ignoreCase: boolean, //Whether or not the query should match case sensitively or not.  Default behaviour is false.
    //            deep: boolean     //Whether or not a fetch should do a deep search of items and all child 
    //                            //items instead of just root-level items in a datastore.  Default is false.
    //        }
    //
    //    The *onBegin* parameter.
    //        function(size, request);
    //        If an onBegin callback function is provided, the callback function
    //        will be called just once, before the first onItem callback is called.
    //        The onBegin callback function will be passed two arguments, the
    //        the total number of items identified and the Request object.  If the total number is
    //        unknown, then size will be -1.  Note that size is not necessarily the size of the 
    //        collection of items returned from the query, as the request may have specified to return only a 
    //        subset of the total set of items through the use of the start and count parameters.
    //
    //    The *onItem* parameter.
    //        function(item, request);
    //        If an onItem callback function is provided, the callback function
    //        will be called as each item in the result is received. The callback 
    //        function will be passed two arguments: the item itself, and the
    //        Request object.
    //
    //    The *onComplete* parameter.
    //        function(items, request);
    //
    //        If an onComplete callback function is provided, the callback function
    //        will be called just once, after the last onItem callback is called.
    //        Note that if the onItem callback is not present, then onComplete will be passed
    //        an array containing all items which matched the query and the request object.  
    //        If the onItem callback is present, then onComplete is called as: 
    //        onComplete(null, request).
    //
    //    The *onError* parameter.
    //        function(errorData, request); 
    //        If an onError callback function is provided, the callback function
    //        will be called if there is any sort of error while attempting to
    //        execute the query.
    //        The onError callback function will be passed two arguments:
    //        an Error object and the Request object.
    //
    //    The *scope* parameter.
    //        If a scope object is provided, all of the callback functions (onItem, 
    //        onComplete, onError, etc) will be invoked in the context of the scope
    //        object.  In the body of the callback function, the value of the "this"
    //        keyword will be the scope object.   If no scope object is provided,
    //        the callback functions will be called in the context of dojo.global().  
    //        For example, onItem.call(scope, item, request) vs. 
    //        onItem.call(dojo.global(), item, request)
    //
    //    The *start* parameter.
    //        If a start parameter is specified, this is a indication to the datastore to 
    //        only start returning items once the start number of items have been located and
    //        skipped.  When this parameter is paired with 'count', the store should be able
    //        to page across queries with millions of hits by only returning subsets of the 
    //        hits for each query
    //
    //    The *count* parameter.
    //        If a count parameter is specified, this is a indication to the datastore to 
    //        only return up to that many items.  This allows a fetch call that may have 
    //        millions of item matches to be paired down to something reasonable.  
    //
    //    The *sort* parameter.
    //        If a sort parameter is specified, this is a indication to the datastore to 
    //        sort the items in some manner before returning the items.  The array is an array of 
    //        javascript objects that must conform to the following format to be applied to the
    //        fetching of items:
    //        {
    //            attribute: attribute || attribute-name-string,
    //            descending: true|false;   // Optional.  Default is false.
    //        }
    //        Note that when comparing attributes, if an item contains no value for the attribute
    //        (undefined), then it the default ascending sort logic should push it to the bottom 
    //        of the list.  In the descending order case, it such items should appear at the top of the list.
    // 
    //    returns:
    //        The fetch() method will return a javascript object conforming to the API
    //        defined in dojo.data.api.Request.  In general, it will be the keywordArgs
    //        object returned with the required functions in Request.js attached.
    //        Its general purpose is to provide a convenient way for a caller to abort an
    //        ongoing fetch.  
    // 
    //        The Request object may also have additional properties when it is returned
    //        such as request.store property, which is a pointer to the datastore object that 
    //        fetch() is a method of.
    //
    //    exceptions:
    //        Throws an exception if the query is not valid, or if the query
    //        is required but was not supplied.

getFeatures
-----------

.. code-block :: javascript

  getFeatures: function()
    //    summary:
    //        The getFeatures() method returns an simple keyword values object 
    //        that specifies what interface features the datastore implements.  
    //        A simple CsvStore may be read-only, and the only feature it 
    //        implements will be the 'dojo.data.api.Read' interface, so the
    //        getFeatures() method will return an object like this one:
    //        {'dojo.data.api.Read': true}.
    //        A more sophisticated datastore might implement a variety of
    //        interface features, like 'dojo.data.api.Read', 'dojo.data.api.Write', 
    //        'dojo.data.api.Identity', and 'dojo.data.api.Attribution'.

close
-----

.. code-block :: javascript

  close: function(/*dojo.data.api.Request || keywordArgs || null */ request)
    //    summary:
    //        The close() method is intended for instructing the store to 'close' out 
    //        any information associated with a particular request.
    //
    //    description:
    //        The close() method is intended for instructing the store to 'close' out 
    //        any information associated with a particular request.  In general, this API
    //        expects to recieve as a parameter a request object returned from a fetch.  
    //        It will then close out anything associated with that request, such as 
    //        clearing any internal datastore caches and closing any 'open' connections.
    //        For some store implementations, this call may be a no-op.
    //
    //    request:
    //        An instance of a request for the store to use to identify what to close out.
    //        If no request is passed, then the store should clear all internal caches (if any)
    //        and close out all 'open' connections.  It does not render the store unusable from
    //        there on, it merely cleans out any current data and resets the store to initial 
    //        state.

getLabel
--------

.. code-block :: javascript

  getLabel: function(/* item */ item)
    //    summary:
    //        Method to inspect the item and return a user-readable 'label' for the item
    //        that provides a general/adequate description of what the item is. 
    //
    //    description:
    //        Method to inspect the item and return a user-readable 'label' for the item
    //        that provides a general/adequate description of what the item is.  In general
    //        most labels will be a specific attribute value or collection of the attribute
    //        values that combine to label the item in some manner.  For example for an item
    //        that represents a person it may return the label as:  "firstname lastlame" where
    //        the firstname and lastname are attributes on the item.  If the store is unable 
    //        to determine an adequate human readable label, it should return undefined.  Users that wish
    //        to customize how a store instance labels items should replace the getLabel() function on 
    //        their instance of the store, or extend the store and replace the function in 
    //        the extension class.
    //
    //    item:
    //        The item to return the label for.
    //
    //    returns: 
    //        A user-readable string representing the item or undefined if no user-readable label can 
    //        be generated.

getLabelAttributes
------------------

.. code-block :: javascript

  getLabelAttributes: function(/* item */ item)
    //    summary:
    //        Method to inspect the item and return an array of what attributes of the item were used 
    //        to generate its label, if any.
    //
    //    description:
    //        Method to inspect the item and return an array of what attributes of the item were used 
    //        to generate its label, if any.  This function is to assist UI developers in knowing what
    //        attributes can be ignored out of the attributes an item has when displaying it, in cases
    //        where the UI is using the label as an overall identifer should they wish to hide 
    //        redundant information.
    //
    //    item:
    //        The item to return the list of label attributes for.
    //
    //    returns: 
    //        An array of attribute names that were used to generate the label, or null if public attributes 
    //        were not used to generate the label.
