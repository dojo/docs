#format dojo_rst

dojo.data
=========

.. contents::
  :depth: 2


============
Introduction
============

Dojo.data is a uniform data access layer that removes the concepts of database drivers, service endpoints, and unique data formats. All data is represented as an item or as an attribute of an item. With such a representation, data can be accessed in a standard fashion. Items are returned from fetches which search for items with particular properties. Out of the box, dojo.data provides a basic ItemFileReadStore for reading a particular format of JSON data. Many more stores are available in DojoX (for example, a simple XmlStore, a CsvStore, and an OpmlStore) for working with other formats. Some stores provide access to common service endpoint protocols or framework integration points (e.g.: JsonRestStore, FlickrStore, SnapLogicStore, and WikipediaStore). In addition, dojo.data is an API that other users can write to, so you can write one for a custom data format, a specific subset of all the dojo.data APIs, or any other sort of customized data handling service you want to work with. After you have your custom format accessible using a datastore, widgets that are aware of datastores, and other such code, can then access your data without having to learn new APIs specific to your data.

Ultimately, the goal of dojo.data is to provide a flexible set of APIs as interfaces that datastores can be written to conform to. Stores that conform to the standard interfaces should then be able to be used in a wide variety of applications, widgets, and so on interchangeably. In essence, the API hides the specific structure of the data, be it in JSON, XML, CSV, or some other data format, and provides one way to access items and attributes of items consistently. This also allows optimizations on data access to be placed where they are most appropriate -- the client or the server -- depending on the type, number, and structure the data sets being manipulated.

You can think of dojo.data as one layer above dojo.xhrGet(). Both operate asynchronously, and without refreshing the page. But, xhrGet will get almost any MIME type and return the data in a glob. It's your job to interpret it. With dojo.data, you call one set of APIs to access the data items and the attributes of the items, and it's up to the store to handle the interpretation of the native formats into a common access model. 


=====
Usage
=====

Basic store usage consists primarily of creating stores from which items are fetched, registering handlers to deal with the return of data from a ``fetch()`` operation, and fetching attribute values from the returned items. Advanced usage often includes pagination though large data sets, using write and update APIs to provide editing interfaces, and the creation of custom stores. 

* `dojo.data.api <dojo/data/api>`_ 
* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Write <dojo/data/api/Write>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_
* `dojo.data.api.Notification <dojo/data/api/Notification>`_
* `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_
* `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_


========
See also
========

* `Quickstart Tutorial: Using Dojo Data <quickstart/data/usingdatastores>`_
* `Additional available Datastores <dojox/data>`_
