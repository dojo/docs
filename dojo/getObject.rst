.. _dojo/getObject:

===============
dojo.getObject
===============

:since: V?

.. contents ::
   :depth: 2

dojo.getObject returns the property of an object from a dot-separated string such as "A.B.C"


Usage
=====

The simplest way to use dojo.getObject is to pass a dot-separated string as shown below:

.. js ::
 
 // Dojo 1.7+ (AMD)
 // define an object (outside function, in global scope to demonstrate)
 var foo = {
   bar: "some value"
 };
 require(["dojo/_base/lang"], function(lang){
   // get the "foo.bar" property
   lang.getObject("foo.bar");  // returns "some value"
 });

 // Dojo < 1.7
 // define an object
 var foo = {
   bar: "some value"
 };

 // get the "foo.bar" property
 dojo.getObject("foo.bar");  // returns "some value"

dojo.getObject also takes an optional boolean parameter which, if `true`, will create the property if it does not exist. Any other properties along the path will also be created along the way. The default value is `false`.

.. js ::
 
 // Dojo 1.7+ (AMD)
 // define an object (outside function, in global scope to demonstrate)
 var foo = {
   bar: "some value"
 };
 require(["dojo/_base/lang"], function(lang){
    // get the "foo.baz" property, create it if it doesn't exist
    lang.getObject("foo.baz", true); // returns foo.baz - an empty object {}
    /*
      foo == {
        bar: "some value",
        baz: {}
      }
    */
 });

 // Dojo < 1.7
 // define an object
 var foo = {
   bar: "some value"
 };

 // get the "foo.baz" property, create it if it doesn't exist
 dojo.getObject("foo.baz", true); // returns foo.baz - an empty object {}
 /*
   foo == {
     bar: "some value",
     baz: {}
   }
 */

You can also pass an object as the third parameter. This will define the context in which to search for the property. By default, the context is :ref:`dojo.global <dojo/global>`.

.. js ::
 
 // Dojo 1.7+ (AMD)
 require(["dojo/_base/lang"], function(lang){
    // define an object
    var foo = {
       bar: "some value"
    };

    // get the "bar" property of the foo object
    lang.getObject("bar", false, foo); // returns "some value"
 });

 // Dojo < 1.7
 // define an object
 var foo = {
   bar: "some value"
 };

 // get the "bar" property of the foo object
 dojo.getObject("bar", false, foo); // returns "some value"


See also
========

* :ref:`dojo.setObject <dojo/setObject>`
* :ref:`dojo.exists <dojo/exists>`
