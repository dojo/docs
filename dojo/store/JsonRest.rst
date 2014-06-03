.. _dojo/store/JsonRest:

===================
dojo/store/JsonRest
===================

:Authors: Kris Zyp, Colin Snover
:Project owner: Kris Zyp
:since: V1.6

.. contents ::
    :depth: 3

**dojo/store/JsonRest** is a lightweight object store implementation of an HTTP-based (RFC 2616) client with RESTful 
data interaction capabilities. This store implements the :ref:`dojo/store <dojo/store>`.

Introduction
============

``dojo/store/JsonRest`` provides full read, write, and notification capabilities through standards based HTTP/REST 
interaction with the server using GET, PUT, POST, and DELETE commands. This data store allows you to communicate with 
server side database/persistent data storage using the Dojo Store API with JavaScript and efficiently handles create, 
read, update, and delete (CRUD) operations. This can greatly simplify client server communication, interacting can be 
done simply using straightforward JavaScript instead of having to build your communication for CRUD actions.

Usage
=====

To utilize the module, require in the module, create a new instance, pointing it at your RESTful service, and then 
perform your operations:

.. js ::

  require(["dojo/store/JsonRest"], function(JsonRest){
    var store = new JsonRest({
      target: "/some/resource"
    });

    // Get an object by identity
    store.get(id).then(function(item){
      // item will be the DB item
    });

    // Query for objects with options
    store.query("foo=bar", {
      start: 10,
      count: 10,
      sort: [
        { attribute: "baz", descending: true }
      ]
    }).then(function(results){
      // results should contain up to 10 items, sorted by "baz" in descending fashion
    });

    // Store an object identified by identity
    store.put({
      foo: "bar"
    }, {
      id: 3
    });

    // Remove an object by ID
    store.remove(3);
  });

``dojo/store/JsonRest`` implements the following standard Store API methods:

================================================  =====================================================================
Method                                            Description
================================================  =====================================================================
get(id)                                           Retrieves an object by its identifier, returning the object.

query(query, *options*)                           Queries the store using the provided query.

                                                  The returned value should be an array or a promise with ``forEach()``
                                                  , ``map()``, ``filter()``, ``reduce()``, ``subscribe()``, and 
                                                  optional ``close()`` and ``watch()`` methods, and a ``total`` 
                                                  property (the ``total`` may be a promise). The ``options`` parameter 
                                                  may include the following properties (all are optional):

                                                  * ``start`` - Starting offset
                                                  
                                                  * ``count`` - Number of objects to return
                                                  
                                                  * ``sort`` - This is an array of sort definitions, where each 
                                                    definition contains an ``attribute`` property indicating which 
                                                    property to sort on and a ``descending`` property indicating the 
                                                    direction of sort. 

                                                    For example: ``[{attribute:"price, descending: true}]``. If the 
                                                    sort parameter is omitted, then the natural order of the store may 
                                                    be applied if there is a natural order.

put(object, *options*)                            Saves the given object. The (optional) ``options`` argument may be 
                                                  an object with the following properties (each of these is optional 
                                                  and advisory, stores are not required to implement or respond to 
                                                  each property):

                                                  * ``id`` - Indicates the identity of the object if a new object is 
                                                    created.
                                                  
                                                  * ``before`` - If the collection of objects in the store has a 
                                                    natural ordering, this indicates that the created or updated 
                                                    object should be placed before the object specified by the value 
                                                    of this property. A value of null indicates that the object should 
                                                    be last.
                                                  
                                                  * ``parent`` - If the store is hierarchical (with single parenting) 
                                                    this property indicates the new parent of the created or updated 
                                                    object.
                                                  
                                                  * ``overwrite`` - If this is provided as a boolean it indicates that 
                                                    the object should or should not overwrite an existing object. A 
                                                    value of ``true`` indicates that a new object should not be 
                                                    created, the operation should update an existing object. A value 
                                                    of ``false`` indicates that an existing object should not be 
                                                    updated, a new object should be created (which is the same as an 
                                                    ``add()`` operation). When this property is not provided, either 
                                                    an update or creation is acceptable.

add(object, *options*)                            Create a new object. The (optional) ``options`` argument is defined 
                                                  the same as ``put()`` (except ``overwrite`` is assumed to be 
                                                  ``false``).

remove(id)                                        Delete the object by ``id``.

getIdentity(object)                               Returns an ``object``'s identity
================================================  =====================================================================

It also has the following properties:

=========== ====== ====================================================================================================
Property    Type   Description
=========== ====== ====================================================================================================
headers     Object Additional headers to pass in all requests to the server. These can be overridden by passing
                   additional headers to calls to the store.
target      String The target base URL to use for all requests to the server. This string will be prepended to the 
                   ``id`` to generate the URL (relative or absolute) for requests sent to the server.
idProperty  String Indicates the property to use as the identity property. The values of this property should be 
                   unique.
sortParam   String The query parameter to be used for holding sort information. If this is omitted, then the sort 
                   information is included in a functional query token to avoid colliding with the set of name/value 
                   pairs.
accepts     String Defines the Accept header to use on HTTP requests
=========== ====== ====================================================================================================

Implementing a REST Server
==========================

``dojo/store/JsonRest`` follows `RFC 2616 <http://www.ietf.org/rfc/rfc2616.txt>`_ whenever possible to define the 
interaction with the server. It uses an HTTP GET request to retrieve data, a PUT or POST request to change items, a 
DELETE request to delete items, and a POST or PUT request to create new items. It is recommended that the server 
follow a URL structure for resources as follows::

  /{Table}/{id}

This URL will be used to retrieve items by identity and make modifications (PUT and DELETE). It is also recommended 
that a ``/{Table}/`` URL is used to represent the entire collection of items for the store. When a query is performed, 
any query string is appended to the target URL to retrieve the results of the query. The store expects the results to 
be returned in an array. The store will also POST to that URL to create new items.

Method and RESTful Mapping
--------------------------

With ``dojo/store/JsonRest`` the methods map logically to the appropriate HTTP verbs:

========================= =============================================================================================
Method                    Result
========================= =============================================================================================
``get(id)``               This will trigger a GET request to ``{target}/{id}``.  The service should return a JSON
                          object if the id exists or ``404`` if it does not.
``query(query, options)`` This will trigger a GET request to ``{target}?{query}``. If ``query`` is an object, it will 
                          be serialized using :ref:`dojo/io-query::objectToQuery() <dojo/io-query#objecttoquery>`. If 
                          ``query`` is a string, it is appended to the URL as-is. If ``options`` includes a ``sort`` 
                          property, it will be serialized as a query parameter as well; see `Sorting`_ for more 
                          information.  The service should return a JSON array of objects.  If no matches are found, 
                          it should return an empty array.
``remove(id)``            This will trigger a DELETE request to ``{target}/{id}``.  The service should respond with a
                          ``204`` if successful, a ``404`` if not found or another appropriate HTTP status code.
``put(object, options)``  If object includes an identity property, or ``options`` includes an ``id``, this will 
                          trigger a PUT request to ``{target}/{id}`` with the request body being the provided object 
                          serialized as JSON. If no identity is provided, then a POST request is made to ``{target}`` 
                          with the object as the body. If the ``options.incremental`` property is ``true``, then a 
                          POST request is made to ``{target}/{id}`` with the object as the body. You may also include 
                          an ``options.overwrite`` property. If ``options.overwrite`` is set to ``true``, then an ``If-
                          Match: *`` header is included. If ``options.overwrite`` is set to ``false``, then an ``If-
                          None-Match: *`` header is included.
``add(object, options)``  This behaves exactly like ``put(object, options)``, except that ``options.overwrite`` is set 
                          to ``false``, indicating that a new object must be created.
========================= =============================================================================================

Paging
------

The store uses HTTP's ``Range:`` header to perform paging. When a request is made for a range of items, the store will 
include a ``Range:`` header with an items range unit specifying the range.  For example::

  Range: items=0-24

On your server, you should look at the header in the request to know which items to return. The server should respond 
with a ``Content-Range:`` header to indicate how many items are being returned and how many total items exist.  For 
example::

  Content-Range: items 0-24/66

The returned ``total`` is available as a further promise on the returned promise of data which returns the total 
number of available rows indicated in the ``Content-Range:`` header as a number, so you can retrieve it like this:

.. js ::

  require(["dojo/store/JsonRest"], function(JsonRest){
    var store = new JsonRest({
      target: "/Table"
    });

    var self = this;

    var results = store.query("foo=bar").then(function(data){
      results.total.then(function(total){
        console.log("total results: ", total);
        console.log("go on and use data ", data, " with this ", self);
      });
    });
  });

Sorting
-------

When a query request is made that includes a ``sort`` option in the ``options`` object, an additional sort field is 
added to the query string. If the store’s ``sortParam`` property is set, it will use that value as the key for the 
field in the query string.

For example, given the following store and request:

.. js ::

  require(["dojo/store/JsonRest"], function(JsonRest){
 
    var store = new JsonRest({
      target: "/FooObject/",
      sortParam: "sortBy"
    });

    store.query({ foo: "value1" }, {
      sort: [
        { attribute: "foo" },
        { attribute: "bar", descending: true }
      ]
    });
  });

The resulting request to the server would be::

  /FooObject/?foo=value1&sortBy=+foo,-bar

If ``sortParam`` is not set, the sort value is appended without a key-value pair, surrounded by "sort()"::

  /FooObject/?foo=value1&sort(+foo,-bar)


Headers
-------

Starting in Dojo 1.8, it is possible to send headers along with all requests made using the JsonRest store. This can 
either be done by setting the ``headers`` property of the store itself, in which case all requests will include the 
provided headers, or on a per-call basis by setting the ``headers`` property of the associated ``options`` object for 
calls to ``get``, ``add``, ``put``, ``remove``, or ``query``.

If header is provided on the ``options`` object passed to a call, it will override any similarly-named headers given 
directly on the store:

.. js ::
 
  var store = new JsonRest({
    target: "/FooObject/",
    headers: { "X-Custom-Header": "Foo" } // All calls to server will include X-Custom-Header: Foo
  });

  store.query({ foo: "value1" }, {
    headers: { "X-Custom-Header": "Bar" } // This call will include X-Custom-Header: Bar instead
  });

Notes
=====

*Note*: ``dojo/store/JsonRest`` does not provide all the functionality of 
:ref:`dojox/data/JsonRestStore <dojox/data/JsonRestStore>` itself. Additional modules and layers are used to provide 
schema validation, referencing, caching, and other functionality.  See :ref:`dojo/store <dojo/store>` for the other 
modules that can be composed with this module to add these features.

See Also
========

* :ref:`dojo/store <dojo/store>` - The Dojo Store API.

* :ref:`dojo/data <dojo/data>` - The legacy Dojo Data Store API.

* :ref:`dojox/data/JsonRestStore <dojox/data/JsonRestStore>` - The deprecated JSON RESTful client store.
