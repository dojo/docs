.. _dojo/store/Cache:

================
dojo/store/Cache
================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: V1.6

.. contents ::
    :depth: 3

**dojo/store/Cache** is a object store wrapper for caching data from one store in another store. This store follows the :ref:`Dojo Object Store API <dojo/store>`.


Introduction
============

The Cache store provides caching capabilities for stores. The Cache store takes two stores, a master store and caching store. The master store is considered the data authority, all modifications go to the master store, and when data is not available in the cache, it is retrieved from the master store. The caching store is used to record cached data from master store. Doing get() and query() call results are added to the cache (unless they don't meet provided criteria), but only get() uses the cache, whereas query() uses the master store. If you want to a query to come from the cache, directly call query() on the caching store. Data modifications are also mirrored in the caching store. A typical usage of dojo/store/Cache would be to use a JsonRest store as the master store, and a Memory store as the caching store.

Examples
========

.. js ::

  restStore = new JsonRest(...);
  memoryStore = new Memory();
  store = new Cache(restStore, memoryStore);

  store.get(1) -> Returns the object with an id of 1 by making a GET request
  store.get(1) -> Returns the object, using the local memory cache
  store.put({id:2, name:"two"}) -> Stores the object in both master and cache store
  store.get(2) -> Returns the object, using the local memory cache

API
===

A Cache store wrapper is created by calling the dojo.store.Cache constructor with the master store as the first parameter, the caching store as the second parameter, and an optional "options" parameter as a third argument.

The options parameter may be object with the following optional methods:

* isLoaded - If this function is provided, it can return true or false to indicate whether an object from a query is fully loaded and should go in the cache. When a query is performed, this function will be called for each object in the query results. By default, all objects from query results are cached.
