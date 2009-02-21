#format dojo_rst

dojo.data.api.Identity
======================

.. contents::
  :depth: 3

The dojo.data.api.Identity interface defines the set of APIs that are implemented by a datastore if a data source provides a method by which to uniquely identify each item. This API then allows users of that datastore to request a specific item without searching for an item that matches specific attributes. Review the following examples, guidelines, and complete API documentation for futher information on the Identity API.

=========================
Identity API Requirements
=========================

The following list provides the requirements for the Identity API:

* The identifiers must always be an object that can be converted to a string using the toString() JavaScript API.
  Note: This does not keep identities from being compound keys; they just must be able to be represented in a string fashion.
* Stores that implement the Identity API may expose the identity as a publicly accessible attribute on the item, or they may implement the identity as a private attribute.
* Stores that expose the identity of the store as a public attribute (or set of attributes), must return the attribute(s) identifier(s) from the getIdentityAttributes() method. If they are not exposed as public attributes, then the getIdentityAttributes() method must return a null value.
* All identifier values must be unique and address only one item within the store.
* The store's getFeatures() function will return, as part of its associative map, a property with the key name of dojo.data.api.Identity. The value of the property can be anything reasonable, such as the boolean value true, the name of the attribute that represents the identity, an array of attributes, or even an object. By the mere presence of this key in the map, the store declares that it implements this API.
* Identities should be treated as immutable. Many widgets use the identity for caching purposes, so changing its value will break those widgets.

========
Examples
========

For all of the examples in the following sections, assume that there is a simple ItemFileReadStore instantiation from the following data in the countries.json file:

.. code-block :: javascript

  { identifier: 'abbr', 
    label: 'name',
    items: [
      { abbr:'ec', name:'Ecuador',           capital:'Quito' },
      { abbr:'eg', name:'Egypt',             capital:'Cairo' },
      { abbr:'sv', name:'El Salvador',       capital:'San Salvador' },
      { abbr:'gq', name:'Equatorial Guinea', capital:'Malabo' },
      { abbr:'er', name:'Eritrea',           capital:'Asmara' },
      { abbr:'ee', name:'Estonia',           capital:'Tallinn' },
      { abbr:'et', name:'Ethiopia',          capital:'Addis Ababa' }
  ]}

Basic lookup of an item by identity
-----------------------------------

.. code-block :: javascript

  var itemStore = new dojo.data.ItemFileReadStore({url: 'countries.json'});

  function failed(error) {
    //Do something with the provided error.
  }

  function gotItem(item) {
    if (itemStore.isItem(item)){
      if(!(itemStore.getValue(item,"name") === "El Salvador")){
        failed(new Error("The item loaded does not have the attribute value for attribute [name] expected."));
      }else{
        //Do something with it.
      }
    }else{
      //This should never occur.
      console.log("Unable to locate the item with identity [sv]");
    }
  }

  //Invoke the lookup. This is an async call as it may have to call back to a server to get data.
  itemStore.fetchItemByIdentity({identity: "sv", onItem: gotItem, onError: failed});


Obtaining the value of an item's identity
-----------------------------------------

.. code-block :: javascript

  var itemStore = new dojo.data.ItemFileReadStore({url: 'countries.json'});

  function onError(error, request){
    //Do something with the provided error.
  }

  function onComplete(items, request) {
    if(items.length === 1){
      var identifier = itemStore.getIdentity(items[0]);
      if(identifier !== null && identifier === "er"){
        //Do something with the located identity.
      }else{
        onError(new Error("The identifier returned does not match what was expected."), request);
      }
    }else{
      onError(new Error("Too many matches found."), request);
    }
  }

  //Search the store and find the item with the name Eritrea
  itemStore.fetch({query: {name:"Eritrea"}, onComplete: onComplete, onError: onError});


Obtaining the list of attributes that comprise the identity of an item
----------------------------------------------------------------------

.. code-block :: javascript

  var itemStore = new dojo.data.ItemFileReadStore({url: 'countries.json'});

  function failed(error) {
    //Do something with the provided error.
  }

  function gotItem(item) {
    if (itemStore.isItem(item)){
      if(!(itemStore .getValue(item,"name") === "El Salvador")){{
        failed(new Error("The item loaded does not have the attribute value for attribute [name] expected."));
      }else{
        var identityAttributes = itemStore.getIdentityAttributes(item);
        if(identityAttributes !== null){
          for(var i = 0; i < identityAttributes.length; i++){
            var identifier = identityAttributes[i];
            ... //Do something with 'identifier'.
          }
        }else{
          failed(new Error("Unable to locate the list of attributes comprising the identity."));
        }
      }
    }else{
      //This should never occur.
      throw new Error("Unable to locate the item with identity [sv]");
    }
  }

  //Invoke the lookup. This is an async call as it may have to call back to a server to get data.
  itemStore.fetchItemByIdentity({identity: "sv", onItem: gotItem, onError: failed});

=========================
The Complete Identity API
=========================

For convenience, the following Identity API was taken directly from dojo/data/api/Identity.js and provided below: 

getIdentity
-----------

.. code-block :: javascript

  getIdentity: function(/* item */ item)
    //    summary:
    //        Returns a unique identifier for an item. The return value will be
    //        either a string or something that has a toString() method.
    //    item:
    //        The item from the store from which to obtain its identifier.
    //    exceptions:
    //        Conforming implementations may throw an exception or return null if
    //        item is not an item.

getIdentityAttributes
---------------------

.. code-block :: javascript

  getIdentityAttributes: function(/* item */ item)
    //    summary:
    //        Returns an array of attribute names that are used to generate the identity. 
    //        For most stores, this is a single attribute, but for some complex stores
    //        such as RDB backed stores that use compound (multi-attribute) identifiers
    //        it can be more than one. If the identity is not composed of attributes
    //        on the item, it will return null. This function is intended to identify
    //        the attributes that comprise the identity so that so that during a render
    //        of all attributes, the UI can hide the the identity information if it 
    //        chooses.
    //    item:
    //        The item from the store from which to obtain the array of public attributes that 
    //        compose the identifier, if any.

fetchItemByIdentity
-------------------

.. code-block :: javascript

  fetchItemByIdentity: function(/* object */ keywordArgs){
    //    summary:
    //        Given the identity of an item, this method returns the item that has 
    //        that identity through the onItem callback. Conforming implementations 
    //        should return null if there is no item with the given identity.  
    //        Implementations of fetchItemByIdentity() may sometimes return an item 
    //        from a local cache and may sometimes fetch an item from a remote server, 
    //
    //    keywordArgs:
    //        An anonymous object that defines the item to locate and callbacks to invoke when the 
    //        item has been located and load has completed. The format of the object is as follows:
    //        {
    //            identity: string|object,
    //            onItem: Function,
    //            onError: Function,
    //            scope: object
    //        }
    //    The *identity* parameter.
    //        The identity parameter is the identity of the item you wish to locate and load
    //        This attribute is required. It should be a string or an object that toString() 
    //        can be called on.
    //        
    //    The *onItem* parameter.
    //        Function(item)
    //        The onItem parameter is the callback to invoke when the item has been loaded. It takes only one
    //        parameter, the item located, or null if none found.
    //
    //    The *onError* parameter.
    //        Function(error)
    //        The onError parameter is the callback to invoke when the item load encountered an error. It takes only one
    //        parameter, the error object
    //
    //    The *scope* parameter.
    //        If a scope object is provided, all of the callback functions (onItem, 
    //        onError, etc) will be invoked in the context of the scope object.
    //        In the body of the callback function, the value of the "this"
    //        keyword will be the scope object. If no scope object is provided,
    //        the callback functions will be called in the context of dojo.global.
    //        For example, onItem.call(scope, item, request) vs. 
    //        onItem.call(dojo.global, item, request)
