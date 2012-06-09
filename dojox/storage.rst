.. _dojox/storage:

=============
dojox.storage
=============

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

**NOTE**: dojox/storage has not yet been converted to the new AMD format. Loading it asynchronously is not advised.

Introduction
============

dojox/storage provides persistent client-side storage. It unifies HTML5 local databases with emulators for older browsers under a common API.

There are three parts to dojox/storage:
 - **Implementations**: HTML5, Flash, even cookies
 - **Provider**: API that abstracts implementations
 - **dojox.storage.manager**: automatically selects the best implementation available and provides its corresponding Provider

Usage
=====

To use dojox/storage, load dojox/storage and get a provider like so:

.. code-example ::
  .. js ::

    dojo.require("dojox.storage");
    var storageProvider=null;
    dojo.addOnLoad(function(){
    	dojox.storage.manager.initialize();
    	storageProvider=dojox.storage.manager.getProvider();
    });

This will load everything that is needed to use the best available stock dojox/storage implementation.


Examples
========

The dojox.storage Provider API is like a persistent version of a Java HashMap: you 'put' values into storage by assigning them a key, then 'get' them later by supplying the same key.

Putting a value
---------------

.. code-example ::

  .. js ::

    dojo.require("dojox.storage");
    var storageProvider=null;
    dojo.addOnLoad(function(){
    	dojox.storage.manager.initialize();
    	storageProvider=dojox.storage.manager.getProvider();
    	storageProvider.initialize();
        var myObject={key1:true};
        storageProvider.put("myValue", myObject, function(status, keyName){
        	alert("value put in "+keyName);
        });
    });

Getting a value
---------------

.. code-example ::

  .. js ::

    dojo.require("dojox.storage");
    var storageProvider=null;
    dojo.addOnLoad(function(){
    	dojox.storage.manager.initialize();
    	storageProvider=dojox.storage.manager.getProvider();
    	storageProvider.initialize();
        var myObject = storageProvider.get("myValue");
        alert(myObject.key1);
    });


