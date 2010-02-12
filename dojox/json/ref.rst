#format dojo_rst

dojox.json.ref
==============

:Author: Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.json.ref** implements JSON Referencing to provide serialization, deserialization, and indexing of complex object graphs with circular, multiple, cross-message, cross-store, and cross-site referencing.


============
Introduction
============

JSON Referencing provides for id-based, path-based, and combined referencing. With id-based referencing, JSON objects self-identify themselves with an identity property ("id" by default). Objects can then be referred to by id. A JSON references is a JSON object with a property $ref with a value indicating the target. This is an example of id-based JSON referencing:

.. code-block :: javascript

 {
   "name":"Kris Zyp",
   "id":"kriszyp",
   "children":[{"id":"jennikazyp","name":"Jennika Zyp"}],
   "spouse":{
       "name":"Nicole Zyp",
       "spouse":{"$ref":"kriszyp"},
       "children":[{"$ref":"jennikazyp"}]
   }
 }

Path-based referencing works by specifying a JSON value by it's location within the object structure. With path-based referencing the # symbol should be used to denote the root of the current object structure and to separate. A path reference consists of dot delimited property names or array index numbers. dojox.json.ref also supports $ and *this* to reference the root. With path-based referencing, any JSON value may be referenced, not just objects. For example:

.. code-block :: javascript

 {
   "name":"Kris Zyp",
   "children":[{"name":"Jennika Zyp"},{"name":"Korban Zyp"}],
   "spouse":{
       "name":"Nicole Zyp",
       "spouse":{"$ref":"#"},
       "children":{"$ref":"#children"}
   },
   "oldestChild":{"$ref":"#children.0"}
 }

Id and path-based referencing can also be combined; a path can be postpended to an id reference. The # separates the id from the path portion and the path operates on the object referred by the id. For example:

.. code-block :: javascript

 {
   "name":"Kris Zyp",
   "id":"kriszyp",
   "children":[{"name":"Jennika Zyp"}],
   "friends":[{"$ref":"jesse#spouse"}]
 }

`This tutorial <http://www.sitepen.com/blog/2008/06/17/json-referencing-in-dojo/>`_ provides more in-depth overview of dojox.json.ref. dojox.json.ref is used by the JsonRestStore for reference resolution and indexing.


========
Features
========

1. Circular referencing, multiple referencing, cross-message referencing, and cross-site referencing in JSON.

2. Utilizes the standard relative URL scheme as the basis for referencing.

3. Id-based, path-based, and combined referencing is supported

4. Useful exceptions when parsing fails


=====
Usage
=====

The basic usage of dojox.json.ref to serialize an object is:

.. code-block :: javascript

 myJsonString = dojox.json.ref.toJson(myObject);

To deserialize an object:

.. code-block :: javascript

 myObject = dojox.json.ref.fromJson(myJsonString);
