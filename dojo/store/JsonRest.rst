#format dojo_rst

dojo.store.JsonRest
========================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.6

.. contents::
    :depth: 3

**dojo.store.JsonRest** is a lightweight object store implementation of an HTTP-based (RFC 2616) client with RESTful data interaction capabilities. This store implements the new `Dojo Object Store API <dojo/store>`_.


============
Introduction
============

JsonRest provides full read, write, and notification capabilities through standards based HTTP/REST interaction with the server using GET, PUT, POST, and DELETE commands. This data store allows you to communicate with server side database/persistent data storage using the Dojo Data API with JavaScript and efficiently handles create, read, update, and delete (CRUD) operations. This can greatly simplify client server communication, interacting can be done simply using straightforward JavaScript instead of having to build your communication for CRUD actions.

========
Examples
========

.. code-block :: javascript

 store = new dojo.store.JsonRest({target:"/Table/"});

 store.get(3).then(function(object){
   // use the object with the identity of 3
 });

 store.query("foo=bar").then(function(results){
   // use the query results returned from the server
 });

 store.put({foo:"bar"}, {id:3}); // store the object with the given identity

 store["delete"](3); // delete the object


==========================
Implementing a REST Server
==========================

The JsonRest store follows RFC 2616 (http://www.ietf.org/rfc/rfc2616.txt) whenever possible to define to interaction with server. JsonRest uses an HTTP GET request to retrieve data, a PUT or POST request to change items, a DELETE request to delete items, and a POST or PUT request to create new items. It is recommended that the server follow a URL structure for resources:

 /{Table}/{id}

This URL will be used to retrieve items by identity and make modifications (PUT and DELETE). It is also recommended that a /{Table}/ URL is used to represent the collection of items for the store. When a query is performed, any query string is appended to the target URL to retrieve the results of the query. The JsonRest expects the results to be returned in an array (not in an object with an items property like some stores). The store will also POST to that URL to create new items.

==============
Method Mapping
==============

With the JsonRest store, store methods should intuitively map to HTTP methods:

* get(id) - This will trigger a GET request to {target}{id}.
* query(query, options) - This will trigger a GET request to {target}{query}. If query is an object, it will be serialized using URL encoding. If query is a string it is left alone. If options includes a sort property, it will be serialized as a query parameter as well.
* remove(id) - This will trigger a DELETE request to {target}{id}.
* put(object, options) - If object includes an identity property, or options includes an id, this will trigger a PUT request to {target}{id} with the request body being the provided object serialized as JSON. If no identity is provided, then a POST request is made to the store's target URL (no id appended) with the object as the body. If the options.incremental property is true, then a POST request is made to {target}{id} with the object as the body. You may also include an options.overwrite property. If overwrite is set to true, then an If-Match: * header is included. If overwrite is set to false, then an If-None-Match: * header is included.
* add(object, options) - This behaves exactly like put(object, options), except that options.overwrite is set to false, indicating that a new object must be created.

======
Paging
======

JsonRest store uses HTTP's Range header to perform paging. When a request is made for a range of items, JsonRest will include a Range header with an items range unit specifying the range:

 Range: items=0-24

On your server, you should look at the Range header in the request to know which items to return. The server should respond with a Content-Range header to indicate how many items are being returned and how many total items exist:

 Content-Range: items 0-24/66

====
Misc
====

The dojo.store.JsonRest does not provide all the functionality of dojox.data.JsonRestStore itself. Addtional modules and layers are used to provide schema validation, referencing, caching, and other functionality.
