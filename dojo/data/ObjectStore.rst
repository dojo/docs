.. _dojo/data/ObjectStore:

========================
dojo.data.ObjectStore
========================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: V1.6

.. contents ::
    :depth: 3

**dojo.data.ObjectStore** is an adapter for using the new :ref:`Dojo Object Stores <dojo/store>` with Dojo Data consumers. This adapter takes an object store and implements the Dojo Data API (Read, Write, Identity, and Notification).


Introduction
============

The ObjectStore is very simple to use, you simply provide a object store to the constructor (in the objectStore property of the first argument) and you can use this data store with any Dojo Data compliant widget or other consumer.

Examples
========

.. js ::

 var objectStore = new dojo.store.JsonRest({target:"/Table/"});

 var dataStore = new dojo.data.ObjectStore({objectStore: objectStore});

 // we can now use dataStore with any legacy Dojo Data consumer
 var grid = new dojox.data.DataGrid({
   store: dataStore,
   ...
 });

Implementation Notes
====================

ObjectStore's logic for the ``fetch`` function assumes that if the given query is an object, it is a map of key/value pairs.  It then proceeds to create regular expressions out of each value in the map, but makes the original value available via the ``toString`` method.  This means that for a dojo.store implementation to operate successfully when run through the ``dojo.data.ObjectStore`` adapter, one of two things must be true of the dojo.store's ``query`` implementation for handling query objects:

* it must be capable of handling values in the object as regular expressions (e.g. ``dojo.store.Memory`` by way of ``dojo.store.util.SimpleQueryEngine``)
* (or) it must call toString (perhaps implicitly) on each value (e.g. ``dojo.store.JsonRest`` by way of ``encodeURIComponent``).
