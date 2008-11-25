#format dojo_rst

dojo.isArray
============

:Status: Draft
:Version: 1.0
:Available: since 0.9

.. contents::
   :depth: 2

Checks if the passed parameter is an Array.

============
Introduction
============

A simple utility function to check if an object is truly and array.

=====
Usage
=====

isArray returns a Boolean you can use directly in conditionals:

.. code-block :: javascript
 :linenos:

  if(dojo.isArray(someVariable)){
    // do something
  }

Anything that is an Array can be iterated over by using `dojo.forEach <dojo/forEach>`_

.. code-block :: javascript

  if(dojo.isArray(list)){
    dojo.forEach(list, function(item, i){
        // each item in list
    });
  }else{
    // something went wrong? we wanted an array here
  }

========
Examples
========

.. code-block :: javascript
  :linenos:

  console.log( dojo.isArray([1,2,3]) );
  >>> true

  console.log( dojo.isArray(new dojo.NodeList()) );
  >>> true

  console.log( dojo.isArray( { "a":1 } );
  >>> false


========
See also
========

* `dojo.isArrayLike <dojo/isArrayLike>`_
* `dojo.isFunction <dojo/isFunction>`_, `dojo.isString <dojo/isString>`_, `dojo.isObject <dojo/isObject>`_
