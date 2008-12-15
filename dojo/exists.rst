#format dojo_rst

dojo.exists
===========

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2

Check if all objects in a dot-seperated string object path exist, such as ``"A.B.C"``.


============
Introduction
============

``dojo.exists`` is a convenience function, particularly useful for testing long object paths. It accepts a string as its first parameter, and walks down the path it represents. You can optionally provide a root for the path as a second parameter, otherwise it will use a default value of the global object. Each portion of the '.' delimited string is tested for defined-ness, returning true only if each object exists as defined in the strong.


=====
Usage
=====

dojo.exists accepts a string as its first parameter, and the root object as its second parameter, and returns true/false. 

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   if( dojo.exists("myns.widget.Foo") ){
     console.log("myns.widget.Foo exists");
   }
 </script>


The second ``root`` parameter is optional, ``dojo.exists`` will use the value of ``dojo.global`` by default (which is usually the current ``window``). You can use it to root the path in a different window object, or a particular namespace: 

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // check if a widget class is available

   var widgetType = "form.Button";
   var myNamespace = docs; 

   if( dojo.exists(widgetType, myNamespace) ){
     console.log( "There's a docs.form.Button available");
   } else if( dojo.exists(widgetType, dijit) ){
     console.log( "Dijits form.Button class is available");
   } else {
     console.log( "No form.Button classes are available");
   }
   
 </script>


========
See also
========

* `dojo.getObject <dojo/getObject>_`
* `dojo.setObject <dojo/setObject>_`
