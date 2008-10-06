#format dojo_rst

dojox.json.schema
=================

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.json.schema** implements [[JSON Schema|http://json-schema.org]] to provide data validation against JSON Schemas.

============
Introduction
============

JSON Schema can used to define the structure of data, constraints, and structural information using JSON. JSON Schema is used for type definitions in Service Mapping Description (SMD) used by the web services. JSON Schema is also supported in the JsonRestStore. Current development of JSON Schema is taking place in the [[JSON Schema Discussion Group|http://groups.google.com/group/json-schema?pli=1]].

=====
Usage
=====

The basic usage of dojox.json.schema validate data is:

.. code-block :: javascript

 obj = {foo:"bar"};
 schema = {properties:{foo:{type:"string"}}};
 results = dojox.json.schema.validate(obj,schema);
 if (results.valid){
   // indicates that the instance is valid by the schema
 }
