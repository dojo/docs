#format dojo_rst

dojox.data.JsonRestStore
========================

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.data.JsonRestStore** is a lightweight datastore implementation of an HTTP-based (RFC 2616) client with RESTful data interaction capabilities.


============
Introduction
============

JsonRestStore provides full read, write, and notification capabilities through standards based HTTP/REST interaction with the server using GET, PUT, POST, and DELETE commands. This data store allows you to communicate with server side database/persistent data storage using the Dojo Data API with JavaScript and efficiently handles create, read, update, and delete (CRUD) operations. This can greatly simplify client server communication, interacting can be done simply using straightforward JavaScript instead of having to build your communication for CRUD actions. In addition, Dojo data stores can plugin to many Dojo widgets (Dijits).

JsonRestStore supports JSON Referencing so objects can contain cyclic, multiple, cross-message, cross-table, and even cross-site references, which can be used for `lazy loading <quickstart/data/usingdatastores/lazyloading>`_. These references are automatically resolved such that properties are accessed as normal datastore attributes.

JsonRestStore caches objects that have been retrieved from the server locally in memory. This allows object identity to be preserved even if an object is loaded from the server multiple times (the target object will be updated rather than a new object created). Also fetching an item by identity will attempt to look in the local cache first before requesting the item from the server.

JsonRestStore also store objects in a format to ease direct property access for significant performance advantages. 


========
Features
========

1. The datastore implements the following dojo.data APIs:  

   - `dojo.data.api.Read <dojo/data/api/Read>`_, 
   - `dojo.data.api.Identity <dojo/data/api/Identity>`_, 
   - `dojo.data.api.Write <dojo/data/api/Write>`_, 
   - `dojo.data.api.Notification <dojo/data/api/Notification>`_.

2. Client/server interaction follows the HTTP specification for RESTful interaction, using standard HTTP verbs and headers to handle updates, paging, and id assignment.

3. Full JSON Referencing capabilities. Create circular references, multiples references, reference objects from other tables, and even references objects from other domains

4. Flexible modular design allows for easy extension and customization. Multiple subclasses in Dojo already use JsonRestStore, including `CouchDBRestStore <dojox/data/CouchDBRestStore>`_, `PersevereStore <dojox/data/PersevereStore>`_, and `S3Store <dojox/data/S3Store>`_. Custom queries can easily be generated.

5. Integrates with the `dojox.rpc.Service <dojox/rpc/Service>`_ system, any service can be customized to be a REST service for the system.

6. Integrates with `dojox.rpc.OfflineRest <dojox/rpc/OfflineRest>`_ for automatic offline usage. Application built JsonRestStore can almost instantaneously be made offline.

7. Integrates with the RestChannels Comet module to support server sent notifications of data changes. The data store automatically routes these updates as data notifications to widgets.

8. Works directly with all current data bound widgets in dijit, including `dijit.Tree <dijit/Tree>`_, `dijit.form.ComboButton <dijit/form/ComboButton>`_, and as well `dojox.grid <dojox/grid>`_.

=====
Usage
=====

dojox.data.JsonRestStore should be instantiated with a single argument that is an object that can have any of these properties:

schema
  This is a schema object for this store. This should be JSON Schema format.

service
  This is the service object that is used to retrieve lazy data and save results.

  The function should be directly callable with a single parameter of an object id to be loaded. The function should also have the following methods:

  * **put(id,value)**

    puts the value at the given id

  * **post(id,value)**

    posts (appends) the value at the given id

  * **delete(id)**

    deletes the value corresponding to the given id

  Note that it is critical that the service parses responses as JSON. If you are using dojox.rpc.Service, the easiest way to make sure this happens is to make the responses have a content type of application/json. If you are creating your own service, make sure you use handleAs: "json" with your XHR requests.

target
  This is the target URL for this Service store. This may be used in place of a service parameter to connect directly to RESTful URL without using a dojox.rpc.Service object.

idAttribute
  Defaults to 'id'. The name of the attribute that holds an objects id. This can be a preexisting id provided by the server. If an ID isn't already provided when an object is fetched or added to the store, the autoIdentity system will generate an id for it and add it to the index.

syncMode
  Setting this to true will set the store to using synchronous calls by default. Sync calls return their data immediately from the calling function, so callbacks are unnecessary.


========
Examples
========


.. code-block :: javascript

 store = new dojox.data.JsonRestStore({target:"/Table/", idAttribute:"id"});
 ... or ...
 store = new dojox.data.JsonRestStore({service:myService, syncMode: true});

====================
JsonRestStore + Grid
====================

The Dojo Grid is designed to work with the Dojo Data API, so the JsonRestStore can easily be used with it. The grid leverages the read capabilities to populate the grid, the write capabilities for editing data in place in the grid, and the notification capabilities of the JsonRestStore to handle UI updates when data is changed. To use a JsonRestStore as the data provider for the grid, simply set the grid’s store to the JsonRestStore instance. To edit data from the grid, we can define columns as being editable. Nothing needs to be done to received notifications. 

.. code-block :: javascript

 gridLayout = [
        { name: 'Address', field: 'shipToAddress', editable: true},
	{ name: 'Name', field: 'name'},
	{ name: 'Id', field: 'id'}];
 var grid = new dojox.grid.DataGrid({
	store: poStore,
	structure: gridLayout
 }, dojo.byId("gridElement"));
 grid.startup();

Now we have grid that connected to our store and when you edit data in the grid the changes are automatically sent back to the store.

==========================
Implementing a REST Server
==========================
The JsonRestStore follows RFC 2616 (http://www.ietf.org/rfc/rfc2616.txt) whenever possible to define to interaction with server. JsonRestStore uses an HTTP GET request to retrieve data, a PUT request to change items, a DELETE request to delete items, and a POST request to create new items. It is recommended that the server follow a URL structure for resources:

 /{Table}/{id}

This URL will be used to retrieve items by identity and make modifications (PUT and DELETE). It is also recommended that a /{Table}/ URL is used to represent the collection of items for the store. When a query is performed, any query string is appended to the target URL to retrieve the results of the query. The JsonRestStore expects the results to be returned in an array (not in an object with an items property like some stores). The store will also POST to that URL to create new items.

When creating new items, the JsonRestStore will POST to the target URL for the store. If your server wants to assign the URL/location for the newly created item, it can do so by including a Location header in the response:

 Location: http://mysite.com/Table/newid

The server can also assign or change properties of the object (such an id or default values) in the response to a POST (or any other request), by simply returning the updated JSON representation of the item in the body of the response.

Note that in PHP, sometimes setting the Location will erroneously trigger a 302 status code which will cause JsonRestStore to fail. Per RFC 2616, the correct response to a POST that creates a new resource is to return a 201 status code with the Location header. In PHP, you must set the status code as well as the Location header if you want to avoid a 302 response.

======
Paging
======

JsonRestStore uses HTTP's Range header to perform paging. When a request is made for a range of items, JsonRestStore will include a Range header with an items range unit specifying the range:

 Range: items=0-24

On your server, you should look at the Range header in the request to know which items to return. The server should respond with a Content-Range header to indicate how many items are being returned and how many total items exist:

 Content-Range: items 0-24/66


============
Transactions
============

JsonRestStore provides transaction state information so that servers can implement transactions that correspond to the Dojo Data it saves if desired (this is not necessary for a server to implement in order to support REST). Transactions are indicated by a X-Transaction header in the modifications requests. If the X-Transaction header has a value of open, this means that further requests will be delivered that should be included in the current transaction. Once a request is received without an X-Transaction header of open, the server can commit all the changes from the current request and the previous requests that indicated an open transaction. It is recommended that you utilize deterministic request ordering and page sessions if you implement JsonRestStore directed transactions on the server.

JsonRestStore also features a shared repository of transactional data between all JsonRestStore instances. Therefore, if you save a change, all the JsonRestStore data store’s unsaved data will be committed. This means that you don’t have to track which data stores have modified data, and it also means that you transactions can involve modifications across multiple data stores and corresponding server tables.

========
See also
========

* More information about techniques for lazy loading and optimal loading can be found here: http://www.sitepen.com/blog/2008/11/21/effective-use-of-jsonreststore-referencing-lazy-loading-and-more/

* Other aspects of JsonRestStore are described in more detail here: http://www.sitepen.com/blog/2008/06/13/restful-json-dojo-data/

* You can read more about using JSON Referencing here: http://www.sitepen.com/blog/2008/06/17/json-referencing-in-dojo/

* And this article describes more about JsonRestStore and using referencing for lazy loading: http://blog.medryx.org/2008/07/24/jsonreststore-overview/

* In a .NET environment, http://msdn.microsoft.com/en-us/library/bb412170.aspx has useful information about JSON serialization
