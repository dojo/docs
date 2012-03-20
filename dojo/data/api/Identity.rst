.. _dojo/data/api/Identity:

======================
dojo.data Identity API
======================

.. contents ::
  :depth: 2

*Deprecated*, :ref:`dojo/store <dojo/store>` will eventually replace the ``dojo/data`` API.

The dojo.data.api.Identity interface defines the set of APIs that are implemented by a datastore if a data source provides a method by which to uniquely identify each item. This API then allows users of that datastore to request a specific item without searching for an item that matches specific attributes. Review the following examples, guidelines, and complete API documentation for further information on the Identity API.

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

Examples
========

For all of the examples in the following sections, assume that there is a simple ItemFileReadStore instantiation from the following data in the countries.json file:

.. js ::

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

.. js ::

  var itemStore = new dojo.data.ItemFileReadStore({url: 'countries.json'});

  function failed(error){
    // Do something with the provided error.
  }

  function gotItem(item){
    if(itemStore.isItem(item)){
      if(!(itemStore.getValue(item, "name") === "El Salvador")){
        failed(new Error("The item loaded does not have the attribute value for attribute [name] expected."));
      }else{
        // Do something with it.
      }
    }else{
      // This should never occur.
      console.log("Unable to locate the item with identity [sv]");
    }
  }

  // Invoke the lookup. This is an async call as it may have to call back to a server to get data.
  itemStore.fetchItemByIdentity({identity: "sv", onItem: gotItem, onError: failed});


Obtaining the value of an item's identity
-----------------------------------------

.. js ::

  var itemStore = new dojo.data.ItemFileReadStore({url: 'countries.json'});

  function onError(error, request){
    // Do something with the provided error.
  }

  function onComplete(items, request){
    if(items.length === 1){
      var identifier = itemStore.getIdentity(items[0]);
      if(identifier !== null && identifier === "er"){
        // Do something with the located identity.
      }else{
        onError(new Error("The identifier returned does not match what was expected."), request);
      }
    }else{
      onError(new Error("Too many matches found."), request);
    }
  }

  // Search the store and find the item with the name Eritrea
  itemStore.fetch({query: {name:"Eritrea"}, onComplete: onComplete, onError: onError});


Obtaining the list of attributes that comprise the identity of an item
----------------------------------------------------------------------

.. js ::

  var itemStore = new dojo.data.ItemFileReadStore({url: 'countries.json'});

  function failed(error){
    // Do something with the provided error.
  }

  function gotItem(item){
    if(itemStore.isItem(item)){
      if(!(itemStore .getValue(item, "name") === "El Salvador")){
        failed(new Error("The item loaded does not have the attribute value for attribute [name] expected."));
      }else{
        var identityAttributes = itemStore.getIdentityAttributes(item);
        if(identityAttributes !== null){
          for(var i = 0; i < identityAttributes.length; i++){
            var identifier = identityAttributes[i];
            // Do something with 'identifier'.
          }
        }else{
          failed(new Error("Unable to locate the list of attributes comprising the identity."));
        }
      }
    }else{
      // This should never occur.
      throw new Error("Unable to locate the item with identity [sv]");
    }
  }

  // Invoke the lookup. This is an async call as it may have to call back to a server to get data.
  itemStore.fetchItemByIdentity({identity: "sv", onItem: gotItem, onError: failed});

API Info
========

.. api-link :: dojo.data.api.Identity
