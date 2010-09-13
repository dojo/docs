#format dojo_rst

dojo.store.Memory
=================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.6

.. contents::
    :depth: 3

**dojo.store.Memory** is a object store wrapper for JavaScript/JSON available directly with an array. This store implements the new `Dojo Object Store API <dojo/store>`_.


============
Introduction
============

The Memory store provides full read and write capabilities for in memory data. The Memory store is very simple to use, just provide an array of objects. The Memory store is also a synchronous store, which also simplifies its usage. All the functions directly return results, so you don't have to use asynchronous callbacks in your code.

========
Examples
========

.. code-block :: javascript

 var someData = [
   {id:1, name:"One"},
   {id:2, name:"Two"}
 ];
 store = new dojo.store.Memory({data: someData});

 store.get(1) -> Returns the object with an id of 1

 store.query({name:"One"}) -> // Returns query results from the array that match the given query

 store.query(function(object){
   return object.id > 1;
 }) -> // Pass a function to do more complex querying

 store.put({id:3, name:"Three"}); // store the object with the given identity

 store.remove(3); // delete the object

========
See Also
========

You may also wish to use the Watchable store wrapper to add notifications of changes to data:

`dojo/store/Watchable <dojo/store/Watchable>`_
