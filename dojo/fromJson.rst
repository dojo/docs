#format dojo_rst

dojo.fromJson
=============

:Available: since v0.9

.. contents::
   :depth: 2

Parses a JSON string to return a JavaScript object.

============
Introduction
============

This function creates a JavaScript object from a passed JSON string, such as one created by `dojo.toJson <dojo/toJson>`_ or the response data from an `Ajax <quickstart/ajax>`_ call with ``handleAs:"json"`` enabled.

.. code-block :: javascript
  :linenos:

  //Dojo 1.7 (AMD)
  require(['dojo/_base/xhr'],function(xhr){
    xhr.get({
      url:"foo.php", handleAs:"json",
      load: function(data){
        // data is a JavaScript object. The content of foo.php
        // was passed through dojo.fromJson
      }
    });
  });

  //Dojo < 1.7
  dojo.xhrGet({ 
    url:"foo.php", handleAs:"json",
    load: function(data){
        // data is a JavaScript object. The content of foo.php
        // was passed through dojo.fromJson
    }
  });

=====
Usage
=====

Dojo 1.7 (AMD)
--------------

.. code-block :: javascript
  :linenos:
  
  require(['dojo/_base/json'],function(dojo){ 
    //require on dojo/_base/json will return the actual object of dojo
    var json = '{"a":"one","b":3,"c":true}'; 
    var obj = dojo.fromJson(json);
    console.log(obj.a, obj.b, obj.c);
  });
  
  >>> one 3 true
  
Dojo < 1.7
----------

.. code-block :: javascript
  :linenos:

  var json = '{"a":"one","b":3,"c":true}';
  var obj = dojo.fromJson(json);
  console.log(obj.a, obj.b, obj.c);
  >>> one 3 true

========
See also
========

* `dojo.toJson <dojo/toJson>`_ 
* `dojo.queryToObject <dojo/queryToObject>`_ 
