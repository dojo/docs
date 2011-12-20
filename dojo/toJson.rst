.. _dojo/toJson:

===========
dojo.toJson
===========

:since: V0.9

.. contents ::
   :depth: 2

Returns a JSON serialization of an object.

Introduction
============

This function takes an object and converts it to a String serialization of that object.

Examples
========

Dojo 1.7 (AMD)
--------------

.. js ::
 
  require(['dojo/_base/json'], function(dojo){
    // require on dojo/_base/json will return the actual object of dojo
    
    // a simple object
    var obj = { a:"one", b:3, c:true };

    // convert it to a string:
    var data = dojo.toJson(obj);
    console.log(data, typeof data);
  });
  >>> {"a":"one", "b":3, "c":true} string

Dojo < 1.7
----------

.. js ::
 
  // a simple object
  var obj = { a:"one", b:3, c:true };

  // convert it to a string:
  var data = dojo.toJson(obj);
  console.log(data, typeof data);
  >>> {"a":"one", "b":3, "c":true} string

TODOC: Date objects in objects

See Also
========

* :ref:`dojo.fromJson <dojo/fromJson>`
* :ref:`dojo.objectToQuery <dojo/objectToQuery>`
