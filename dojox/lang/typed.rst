#format dojo_rst

dojox.lang.typed
================

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.3

.. contents::
    :depth: 3

**dojox.lang.typed** provides type checking on JavaScript classes for properties and methods.

============
Introduction
============

**dojox.lang.typed** enforces type checking using the JSON schema structure for defining types on classes. JSON schema property and method definitions can be directly added to typed classes to enforce typing.

=====
Usage
=====

Property types and method signatures for classes follows the JSON Schema (http://json-schema.org) structure, where the class/constructor is the root object of the schema. Note, that you can use primitive constructors as property definitions (String instead {type:"string"}).

.. code-block :: javascript

 dojo.require("dojox.lang.typed");
 
 TypedClass = dojox.lang.typed(
 	dojo.declare("TypedClass", null, {
 		constructor: function(makeDefaults){
 			if(makeDefaults){
 				this.aString = "start";
 			}
 		},
 		add: function(a, b){
 			return a + b;
 		}
 	}));
 TypedClass.properties = {
 	aString:String, // this is the same aString:{type:"string"}
 };
 TypedClass.methods = {
 	add: {
 		parameters:[
 			Number,
 			Number
 		],
 		returns: {type:"number", description: "The sum"}
 	}
 }

 typedInstance = new TypedClass(); // this will throw a TypeError, since there is no value for the aString property.
 typedInstance = new TypedClass(true); // this will run without error
 typedInstance.aString = 44; // this will throw a TypeError, only strings can be assigned to this property
 typedInstance.aString = "hi"; // this will run without error
 typedInstance.add("hi",33); // this will throw a TypeError, both parameters must be numbers
 typedInstance.add(33,22); // this will run without error

Note, that property type checking is not available on Internet Explorer. This intent of the type checking module is to use it for development purposes, and remove it for production use. Like Firebug this is for development, and can be useful with partial browser support.

You can also run dojox.lang.typed.typeCheckAllClasses() to add type checking to all future classes defined with dojo.declare. Consequently, we could alternately define the class above like:

.. code-block :: javascript

 dojox.lang.typed.typeCheckAllClasses();
 dojo.declare("TypedClass", null, {
 	constructor: function(makeDefaults){
 		...

All classes declared with dojo.declare from this point on can have schema definitions for typing purposes.
