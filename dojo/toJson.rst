#format dojo_rst

dojo.toJson
===========

:Status: Draft
:Version: 1.0
:Available: since 0.9

.. contents::
   :depth: 2

Returns a JSON serialization of an object.

============
Introduction
============

This function takes an object and converts it to a String serialization of that object.

========
Examples
========

.. code-block :: javascript
 :linenos:

  // a simple object
  var obj = { a:"one", b:3, c:true };

  // convert it to a string:
  var data = dojo.toJson(obj);
  console.log(data, typeof data);
  >>> {"a":"one","b":3,"c":true} string

TODOC: Date objects in objects

See Also: `dojo.objectToQuery <dojo.objectToQuery>`_, `dojo.fromJson <dojo.fromJson>`_ 
