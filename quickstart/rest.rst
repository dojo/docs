#format dojo_rst

Implementing a RESTful Service Server-Side
==========================================
:Status: Contributed
:Version: 1.6+
:Authors: Kitson Kelly

.. contents::
	:depth: 3

You find yourself banging your head against the wall, because you hear all the "cool kids" are using REST and you see there is quite an extensive implementation of RESTful clients in dojo, and your boss says "I want some of that".  Well, hopefully this tutorial can help you out.

First you have to accept what REST is and isn't.  Then you have to understand how Dojo uses REST and then finally you can consider what you need to do to implement REST on the server side.  While this tutorial will try to be generic, my current service side language of choice is PHP, so most of my server side explanations will likely be in the context of PHP.

==========================
Basics of RESTful Services
==========================

A lot of people stumble across RESTful services and expect to find a well fleshed out standard with some hard and fast rules.  That is the first thing you have to get over when it comes to REST.  REST is a convention or pattern.  It is basically leveraging the HTTP protocol and methodology to provide hierarchal data services.  The fates of the provider and consumer are inexplicably linked.

Personal commentary, is that standards like SOAP and XML-RPC and XML, which have driven technology for the past decade, have given us this false sense that any provider can talk to any other consumer without knowing an iota about each other.  This is simply silly.  Very few people implement a provider or consumer without some level of conversation or dialogue.  The technology community has heaped and layer upon layer of structure to protect providers from consumers and in my opinion, REST gets back to basics of implementing basic CRUD functions in a simple and logical way.

The side affect of this simplicity, is that the provider and consumer need to know each other very well and they need to trust each other to a certain degree.  But this really was the way it was before, but other standards just pretended to save us from that, but were never fully realised.

What is a RESTful Service?
--------------------------

REST stands for Representational State Transfer.  It basically leverages the HTTP protocol and model to provide data services.  What REST should be is follow a client/server model, be stateless, cacheable, allow for a layered model and provide a uniform interface.

All resources are identified by the use of a URI, and there are two types of URIs used, collection URIs and element URIs.  For example, let's assume we have a server that is providing data about users.  The following URI would refer to the users:

.. code-block:: html

	http://example.com/users/

Now if we wanted to refer to just a specific user, we would add the specific resource identifier to the URI.  For example:

.. code-block:: html

	http://example.com/users/1/

This would refer to the user who has an identity of ``1``.

Building on the resource identification, all the Create, Read, Update and Delete (CRUD) functions are available via the use of the HTTP protocol verbs.  The main ones being ``GET``, ``POST``, ``PUT`` and ``DELETE``.  Different parts of a collection can be specified by adding another collection identifier after an element identifier in the URI.  Also, a provider could provide access to data in different ways in a fashion that is most logical.  For example, users might have a set of groups they belong to.  A provider could provide the groups the user belongs to by using the following URI:

.. code-block:: html

	http://example.com/users/1/groups/

And provide all the possible groups via the URI:

.. code-block:: html

	http://example.com/groups/

And even provide all the users that are part of a specific group:

.. code-block:: html

	http://example.com/groups/1/users/

REST provides a fair amount of flexibility up to the provider to determine what and how they provide.

One important thing to note is that REST is independent from the data that transports it.  It is expected that the server and the client will negotiate on how the data is represented.  The most common (especially in Dojo) way to return data is JSON, although XML, Text or any other data format could easily be used.  It will just be assumed here that JSON will be used without further explanation.

HTTP Verbs
----------

The HTTP protocol verbs in REST allow for traditional CRUD functions to happen.  Each of the verbs and how they are used are detailed below.

GET
~~~

The HTTP verb ``GET`` is used to list or retrieve resources.  For collections, the service should return an array of items that are members of the collection.  These can be the full details, or just information on where to find the additional data about each resource.  So the following:

.. code-block:: html

	GET http://example.com/users/

Would retrieve something like:

.. code-block:: javascript

	[
          {"id": 1, "userName": "jsmith", "firstName": "John", "lastName": "Smith"},
          {"id": 2, "userName": "jdoe", "firstName": "Jane", "lastName": "Doe"},
          {"id": 3, "userName": "bill", "firstName": "Bill", "lastName": "Keese"}
        ]          

While requesting a specific resource like:

.. code-block:: html

	GET http://example.com/users/1/

Would return just the object:

.. code-block:: javascript

        {"id": 1, "userName": "jsmith", "firstName": "John", "lastName": "Smith"}


POST
~~~~

The HTTP verb ``POST`` is used to create new resources.  Again, REST does not specify how the data is sent, it could be traditional form encoded data, but both the Dojo implementations of REST will ``POST`` new records, and expect the server to provide the appropriate location URI for the new resource.  The server should respond with a ``Location:`` response header like:

.. code-block:: html

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

=============
Dojo and REST
=============

The Dojo RESTful consumers are fairly straight forward when it comes to REST, and there is essentially feature parity between both the `dojo.store.JsonRest`_ and the `dojox.data.JsonRestStore`_.  As Dojo moves away from the DataStore API to the new Store API, developers can expect that dojo.store.JsonRest will become the main focus of RESTful implementation in Dojo.  Currently though, most data aware widgets only consume the DataStore API, although "wrapping" the dojo.store.JsonRest with the `dojo.data.ObjectStore <dojo/data/ObjectStore>`_ is possible.

dojo.store.JsonRest
-------------------

Introduced in Dojo 1.6, the dojo.store.JsonRest is a good an efficient implementation of a RESTful consumer.  To make it have feature parity with the `dojox.data.JsonRestStore`_, the developer should wrap the store in `dojo.store.Observable <dojo/store/Observable>`_ and `dojo.store.Cache <dojo/store/Cache>`_.

The `dojo.store.JsonRest`_ defaults to assuming the identifier property of each element is ``id``, therefore if your provider returns an elements identifier in that field, most developers simply need to specify the target URI for the collection.

An example of programatically creating a full featured store would be:

.. code-block:: javascript

	var userMemoryStore = new dojo.store.Memory();
	var userJsonRestStore = new dojo.store.JsonRest({target: "/users/"});
	var userStore = new dojo.store.Cache(userJsonRestStore, userMemeoryStore);

More details can be found in their respective Dojo documentation pages.

dojox.data.JsonRestStore
------------------------

Introduced in Dojo 1.2, the `dojox.data.JsonRestStore`_ has been the "workhorse" of Dojo DataStores.  It provides the `Read <dojo/data/api/Read>`_, `Identity <dojo/data/api/Identity>`_, `Write <dojo/data/api/Write>`_ and `Notification <dojo/data/api/Notification>`_ dojo.data APIs.

An example programmatic declaration would be:

.. code-block:: javascript

	var userDataStore = new dojox.data.JsonRestStore({
	  target: "/users/",
	  idAttribute: "id"
	});

An example of declarative would be:

.. code-block:: html

	<div data-dojo-type="dojox.data.JsonRestStore" data-dojo-id="userDataStore" 
	    data-dojo-params="target: '/users/', idAttribute: 'id'"></div>

*Note* it is necessary to use ``data-dojo-id`` with non-Widget (dijit) declarative objects, like DataStores in order to make available a JavaScript variable that can be passed to other declarative objects.  Also it should be noted that these objects do not get destroyed if their containing widget is destroyed and the variable is declared in a global scope.

RESTful Conventions the Dojo Way
--------------------------------

The interaction with the provider by both the Store and the DataStore

JSON the Dojo Way
-----------------


==========================
Server-Side Implementation
==========================

General Structure
-----------------

HTTP Response Codes
~~~~~~~~~~~~~~~~~~~

HTTP Headers Received
~~~~~~~~~~~~~~~~~~~~~

HTTP Headers Sent
~~~~~~~~~~~~~~~~~

Converting between SQL and REST
-------------------------------

=====================================
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
