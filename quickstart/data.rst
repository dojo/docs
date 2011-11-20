.. _quickstart/data:

Datastores and Dojo
===================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz, Nikolai Onken, Craig Riecke

.. contents::
    :depth: 2

==================
What is dojo.data?
==================

Dojo.data is a uniform data access layer that removes the concepts of database drivers and unique data formats. All data is represented as an item or as an attribute of an item. With such a representation, data can be accessed in a standard fashion. Out of the box, dojo.data provides a basic ItemFileReadStore for reading a particular format of JSON data. The DojoX project provides more stores (for example, a simple XmlStore, a CsvStore, and an OpmlStore) for working with servers that can output data in such a format. In addition, dojo.data is an API that other users can write to, so you can write one for a custom data format, a specific subset of all the dojo.data APIs, or any other sort of customized data handling service you want to work with. After you have your custom format accessible using a datastore, widgets that are aware of datastores, and other such code, can then access your data without having to learn new APIs specific to your data.

Ultimately, the goal of dojo.data is to provide a flexible set of APIs as interfaces that datastores can be written to conform to. Stores that conform to the standard interfaces should then be able to be used in a wide variety of applications, widgets, and so on interchangeably. In essence, the API hides the specific structure of the data, be it in JSON, XML, CSV, or some other data format, and provides one way to access items and attributes of items consistently. This also allows optimizations on data access to be placed where they are most appropriate -- the client or the server -- depending on the type, number, and structure the data sets being manipulated.

You can think of dojo.data as one layer above dojo.xhrGet(). Both operate asynchronously, and without refreshing the page. But, xhrGet will get almost any MIME type and return the data in a glob. It's your job to interpret it. With dojo.data, you call one set of APIs to access the data items and the attributes of the items, and it's up to the store to handle the interpretation of the native formats into a common access model. 

**NOTE:** For more information on dojo.data and data stores, refer to the :ref:`reference <dojo/data/api>` on the API.
