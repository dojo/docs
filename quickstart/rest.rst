#format dojo_rst

Implementing a RESTful Service Server-Side
==========================================
:Status: Contributed
:Version: 1.0
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

Building on the resource identification, all the Create, Read, Update and Delete (CRUD) functions are available via the use of the HTTP protocol verbs.

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
          {"id": 1, "userName": "jsmith", "firstName": "John", "lastName": "Smith"}
        ]          

POST
~~~~

PUT
~~~

DELETE
~~~~~~

OPTIONS
~~~~~~~

=============
Dojo and REST
=============

dojo.store.JsonRest
-------------------

dojox.data.JsonRestStore
------------------------

RESTful Conventions the Dojo Way
--------------------------------

JSON the Dojo Way
-----------------


==========================
Server-Side Implementation
==========================

General Structure
-----------------

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
