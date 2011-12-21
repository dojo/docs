.. _quickstart/rest:

==========================================
Implementing a RESTful Service Server-Side
==========================================
:Authors: Kitson Kelly

.. contents ::
    :depth: 3

You find yourself banging your head against the wall, because you hear all the "cool kids" are using REST and you see there is quite an extensive implementation of RESTful clients in dojo, and your boss says "I want some of that".  Well, hopefully this tutorial can help you out.

First you have to accept what REST is and isn't.  Then you have to understand how Dojo uses REST and then finally you can consider what you need to do to implement REST on the server side.  While this tutorial will try to be generic, my current service side language of choice is PHP, so most of my server side explanations will likely be in the context of PHP.

Basics of RESTful Services
==========================

A lot of people stumble across RESTful services and expect to find a well fleshed out standard with some hard and fast rules.  That is the first thing you have to get over when it comes to REST.  REST is a convention or pattern.  It is basically leveraging the HTTP protocol and methodology to provide hierarchical data services.  The fates of the provider and consumer are inexplicably linked.

Personal commentary, is that standards like SOAP and XML-RPC and XML, which have driven technology for the past decade, have given us this false sense that any provider can talk to any other consumer without knowing an iota about each other.  This is simply silly.  Very few people implement a provider or consumer without some level of conversation or dialogue.  The technology community has heaped and layer upon layer of structure to protect providers from consumers and in my opinion, REST gets back to basics of implementing basic CRUD functions in a simple and logical way.

The side affect of this simplicity, is that the provider and consumer need to know each other very well and they need to trust each other to a certain degree.  But this really was the way it was before, but other standards just pretended to save us from that, but were never fully realised.

What is a RESTful Service?
--------------------------

REST stands for Representational State Transfer.  It basically leverages the HTTP protocol and model to provide data services.  What REST should be is follow a client/server model, be stateless, cacheable, allow for a layered model and provide a uniform interface.

All resources are identified by the use of a URI, and there are two types of URIs used, collection URIs and element URIs.
For example, let's assume we have a server that is providing data about users.  The following URI would refer to the users:

.. html ::

    http://example.com/users/

Now if we wanted to refer to just a specific user, we would add the specific resource identifier to the URI.  For example:

.. html ::

    http://example.com/users/1/

This would refer to the user who has an identity of ``1``.

Building on the resource identification, all the Create, Read, Update and Delete (CRUD) functions are available via the use of the HTTP protocol verbs.  The main ones being ``GET``, ``POST``, ``PUT`` and ``DELETE``.  Different parts of a collection can be specified by adding another collection identifier after an element identifier in the URI.  Also, a provider could provide access to data in different ways in a fashion that is most logical.  For example, users might have a set of groups they belong to.  A provider could provide the groups the user belongs to by using the following URI:

.. html ::

    http://example.com/users/1/groups/

And provide all the possible groups via the URI:

.. html ::

    http://example.com/groups/

And even provide all the users that are part of a specific group:

.. html ::

    http://example.com/groups/1/users/

REST provides a fair amount of flexibility up to the provider to determine what and how they provide.

One important thing to note is that REST is independent from the data that transports it.  It is expected that the server and the client will negotiate on how the data is represented.  The most common (especially in Dojo) way to return data is JSON, although XML, Text or any other data format could easily be used.  It will just be assumed here that JSON will be used without further explanation.

HTTP Verbs
----------

The HTTP protocol verbs in REST allow for traditional CRUD functions to happen.  Each of the verbs and how they are used are detailed below.

GET
~~~

The HTTP verb ``GET`` is used to list or retrieve resources.  For collections, the service should return an array of items that are members of the collection.  These can be the full details, or just information on where to find the additional data about each resource.  So the following:

.. html ::

    GET http://example.com/users/

Would retrieve something like:

.. js ::

    [
          {"id": 1, "userName": "jsmith", "firstName": "John", "lastName": "Smith"},
          {"id": 2, "userName": "jdoe", "firstName": "Jane", "lastName": "Doe"},
          {"id": 3, "userName": "bill", "firstName": "Bill", "lastName": "Keese"}
    ]

While requesting a specific resource like:

.. html ::

    GET http://example.com/users/1/

Would return just the object:

.. js ::

        {"id": 1, "userName": "jsmith", "firstName": "John", "lastName": "Smith"}


POST
~~~~

The HTTP verb ``POST`` is used to create new resources.  Again, REST does not specify how the data is sent, it could be traditional form encoded data, but both the Dojo implementations of REST will ``POST`` new records, and expect the server to provide the appropriate location URI for the new resource.  The server should respond with a ``Location:`` response header like:

.. html ::

    Location: http://www.example.com/users/4/

PUT
~~~

The HTTP verb ``PUT`` is used to "replace" the content of an existing object with the provided content.  If a collection URI is specified, the entire data set should be replaced with the provided one, where as an element URI would replace that specific element.

DELETE
~~~~~~

The HTTP verb ``DELETE`` is used to delete resources.  If a collection URI is specified, the whole collection should be deleted.  If an element URI is specified, just that specific item should be deleted.

OPTIONS
~~~~~~~

While not currently implemented in either of the JSON REST consumers in Dojo, some RESTful implementations use the HTTP verb ``OPTIONS`` to provide information about what verbs can be supplied for a specific URI.  This would allow a consumer to determine if a resource could be added, updated or deleted.

Dojo and REST
=============

The Dojo RESTful consumers are fairly straight forward when it comes to REST, and there is essentially feature parity between both the :ref:`dojo.store.JsonRest <dojo/store/JsonRest>` and the :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>`.  As Dojo moves away from the DataStore API to the new Store API, developers can expect that dojo.store.JsonRest will become the main focus of RESTful implementation in Dojo.  Currently though, most data aware widgets only consume the DataStore API, although "wrapping" the dojo.store.JsonRest with the :ref:`dojo.data.ObjectStore <dojo/data/ObjectStore>` is possible.

dojo.store.JsonRest
-------------------

Introduced in Dojo 1.6, the dojo.store.JsonRest is a good an efficient implementation of a RESTful consumer.  To make it have feature parity with the :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>`, the developer should wrap the store in :ref:`dojo.store.Observable <dojo/store/Observable>` and :ref:`dojo.store.Cache <dojo/store/Cache>`.

The :ref:`dojo.store.JsonRest <dojo/store/JsonRest>` defaults to assuming the identifier property of each element is ``id``, therefore if your provider returns an elements identifier in that field, most developers simply need to specify the target URI for the collection.

An example of programmatically creating a full featured store would be:

.. js ::

    var userMemoryStore = new dojo.store.Memory();
    var userJsonRestStore = new dojo.store.JsonRest({target: "/users/"});
    var userStore = new dojo.store.Cache(userJsonRestStore, userMemoryStore);

More details can be found in their respective Dojo documentation pages.

dojox.data.JsonRestStore
------------------------

Introduced in Dojo 1.2, the :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>` has been the "workhorse" of Dojo DataStores.  It provides the :ref:`Read <dojo/data/api/Read>`, :ref:`Identity <dojo/data/api/Identity>`, :ref:`Write <dojo/data/api/Write>` and :ref:`Notification <dojo/data/api/Notification>` dojo.data APIs.

An example programmatic declaration would be:

.. js ::

    var userDataStore = new dojox.data.JsonRestStore({
      target: "/users/",
      idAttribute: "id"
    });

An example of declarative would be:

.. html ::

    <div data-dojo-type="dojox.data.JsonRestStore" data-dojo-id="userDataStore"
        data-dojo-params="target: '/users/', idAttribute: 'id'"></div>

*Note* it is necessary to use ``data-dojo-id`` with non-Widget (dijit) declarative objects, like DataStores in order to make available a JavaScript variable that can be passed to other declarative objects.  Also it should be noted that these objects do not get destroyed if their containing widget is destroyed and the variable is declared in a global scope.

RESTful Conventions the Dojo Way
--------------------------------

Both the :ref:`dojo.store.JsonRest <dojo/store/JsonRest>` and :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>` provide some enhancements to the basic RESTful functionality.

Query
~~~~~

Sorting
~~~~~~~

Widgets can specify sorting and those are passed as part of the query string of the URI on the ``GET``.  The sort is specified by the `sort` attribute in either the ``store.get()`` or ``datastore.fetch()`` function.  This gets converted into a query attribute named ``sort`` with a comma separated list of attributes with a ``+`` or ``-`` indicating if the attributes should be sorted ascending or descending.  For example, the following sort value:

.. js ::

    {sort: [
      {attribute: "id"},
      {attribute: "userName", descending: true}
    ]}

Would translate into the following:

.. html ::

    GET http://example.com/users/?sort(+id,-userName)

Ranges
~~~~~~

Widgets can (and do) specify a ``start`` and ``count`` attributes when accessing data.  These get translated by the Store or DataStore specifying the ``Range`` HTTP header.

For example, the following:

.. js ::

    {
      start: 5,
      count: 10
    }

Would result in the following HTTP request header being sent:

.. html ::

    Range: items=5-15

Any server should respond by setting the ``Content-Range`` header with the value of the range of items being returned and a total counts of all of the items that could be returned based on the query.  Because the total possible items is returned, the downstream widgets will "know" there are more items which they can retrieve.  Also the provider should respond with the amount of items they are returning, even if more items are being requested.

So, if a request was for a count of 10 items starting at 5, but there are only 10 items in total, the following HTTP response header should be set:

.. html ::

    Content-Range: items 5-9/10

`Note` ``start`` is 0 based, so starting at ``5`` means the 6th item.

JSON the Dojo Way
-----------------

While JSON is a great way of describing arbitrary objects, it doesn't have a standard for referencing.  The good news is that Dojo solves that via :ref:`dojox.json.ref <dojox/json/ref>` which provides everything you need.  It is also generally used by the rest of the framework, including the JSON REST datastores and stores.  This gives you quite a bit of flexibility in how you provide data.

Mainly, it focuses on the attribute name ``$ref`` which provides a "pointer" to the rest of the data.  In a REST services, this is a URI.  When a client requests the data from the store, and the store doesn't have it, it will attempt to fetch the data at the supplied URI.  The typical way this is used is on collection URIs to provide references to the full resource, when you only want to provide a portion of the data up front.
For example, let's assume you want to provide information about pages of a book and you have the following collection URI:

.. html ::

    GET http://example.com/book/1/page/

Which returns an array that provides some basic information, but not the content of the page, but a reference to the item:

.. js ::

    [
      {"id": "page/1", "chapter": "1", "$ref": "page/1"},
      {"id": "page/2", "chapter": "1", "$ref": "page/2"},
      {"id": "page/3", "chapter": "1", "$ref": "page/3"}
    ]

And then something tries to attempt to access an attribute of a page that isn't loaded (like ``text``) the store will attempt to do the following:

.. html ::

    GET http://example.com/book/1/page/1/

Which could result in you returning the whole object, that would have been inefficient until the consumer needed the data:

.. js ::

    {
      "id": "1",
      "chapter": "1",
      "text": "..."
    }

The other main way to use ``$ref`` in a REST environment is to specify children.  Again, speaking about a book, we could provide a reference back when a request is made to a collection or resource URI:

.. html ::

    GET http://example.com/book/1/

Would return something like:

.. js ::

    {
      "id": "1",
      "title": "My Little Book of Dojo",
      "author": "Kitson Kelly",
      "children": {"$ref":"1/page"}
    }

There is a lot more you can do with referencing, but viewing the :ref:`dojox.json.ref <dojox/json/ref>` page is the best way to get a complete picture.  Just remember that your references should contain a relative URI to the appropriate information.

Server-Side Implementation
==========================

As stated before, a lot of the structure of a provider's data is based on its application and how it will be consumed.  Some Widgets have specific expectations of how data is structured than can drive the need of how it is provided.  There are however some general concepts of how a JSON REST store expects things to be handled and some general good practices.

General Structure
-----------------

However you implement your RESTful service, you need to provide some basic functionality:

 * Handle HTTP requests
 * Provide HTTP responses
 * Encode return data in JSON
 * Decode POSTed and PUTed data from JSON
 * Handle ranges, sorting and querying/filtering as almost every Widget expects one or all of these to be supported

Other things you might want to consider:

 * Support compression, since you are returning data and most browsers support it, you can save a lot of bandwidth by supporting it.
 * Support other content types other than JSON, so that other data can be retrieved from your RESTful service.
 * Provide method invocation to perform a server side service.
 * Error handling and logging

HTTP Response Codes
~~~~~~~~~~~~~~~~~~~

HTTP Headers Received
~~~~~~~~~~~~~~~~~~~~~

HTTP Headers Sent
~~~~~~~~~~~~~~~~~

Converting between SQL and REST
-------------------------------

Combining It and Other Considerations
=====================================

Examples
--------

"Array" Type Widgets
--------------------

"Tree" Type Widgets
-------------------

.. _dojox.data.JsonRestStore: dojox/data/JsonRestStore
.. _dojo.store.JsonRest: dojo/store/JsonRest
.. _dojox.json.ref: dojox/json/ref
