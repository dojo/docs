.. _dojo/exists:

===========
dojo.exists
===========

:since: V0.9

.. contents ::
   :depth: 2

Check if all objects in a dot-separated string object path exist, such as ``"A.B.C"``.


Introduction
============

``dojo.exists`` is a convenience function, particularly useful for testing long object paths. It accepts a string as its first parameter, and walks down the path it represents. You can optionally provide a root for the path as a second parameter, otherwise it will use a default value of the global object. Each portion of the '.' delimited string is tested for defined-ness, returning true only if each object exists as defined in the strong.


Usage
=====

dojo.exists accepts a string as its first parameter, and the root object as its second parameter, and returns true/false.

.. js ::
 
 // Dojo 1.7+ (AMD)
   require(["dojo/_base/lang"], function(lang){
     if( lang.exists("myns.widget.Foo") ){
       console.log("myns.widget.Foo exists");
     }
   });

 // Dojo < 1.7
   if( dojo.exists("myns.widget.Foo") ){
     console.log("myns.widget.Foo exists");
   }


The second ``root`` parameter is optional, ``dojo.exists`` will use the value of ``dojo.global`` by default (which is usually the current ``window``). You can use it to root the path in a different window object, or a particular namespace:

.. js ::
 
 // Dojo 1.7+ (AMD)
 require(["dojo/_base/lang", "dijit/dijit"], function(lang, dijit){
   var widgetType = "form.Button";
   var myNamespace = docs;

   if( lang.exists(widgetType, myNamespace) ){
     console.log( "There's a docs.form.Button available");
   }else if( lang.exists(widgetType, dijit) ){
     console.log( "Dijits form.Button class is available");
   }else{
     console.log( "No form.Button classes are available");
   }
 });
   
 // Dojo < 1.7
 var widgetType = "form.Button";
 var myNamespace = docs;

 if( dojo.exists(widgetType, myNamespace) ){
   console.log( "There's a docs.form.Button available");
 }else if( dojo.exists(widgetType, dijit) ){
   console.log( "Dijits form.Button class is available");
 }else{
   console.log( "No form.Button classes are available");
 }


See also
========

* :ref:`dojo.getObject <dojo/getObject>`
* :ref:`dojo.setObject <dojo/setObject>`
