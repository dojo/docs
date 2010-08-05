#format dojo_rst

dojo.data.ObjectStore
========================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.6

.. contents::
    :depth: 3

**dojo.data.ObjectStore** is an adapter for using the new `Dojo Object Stores <dojo/store>`_ with Dojo Data consumers. This adapter takes an object store and implements the Dojo Data API (Read, Write, Identity, and Notification).


============
Introduction
============

The ObjectStore is very simple to use, you simply provide a object store to the constructor (in the objectProvider property of the first argument) and you can use this data store with any Dojo Data compliant widget or other consumer.

========
Examples
========

.. code-block :: javascript

 var objectStore = new dojo.store.JsonRest({target:"/Table/"});

 var dataStore = new dojo.data.ObjectStore({objectProvider: objectStore});

 // we can now use dataStore with any legacy Dojo Data consumer
 var grid = new dojox.data.DataGrid({
   store: dataStore,
   ...
 });
