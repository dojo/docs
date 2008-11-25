#format dojo_rst

dojo.isFunction
===============

:Status: Draft
:Version: 1.0
:Available: since 0.9

.. contents::
   :depth: 2

Checks if the parameter is a Function.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

  var ref = function(a,b){ return a };
  if(dojo.isFunction(ref)){
    ref();
  }

This also works with classes created by `dojo.declare <dojo/declare>`_

.. code-block :: javascript
  :linenos:

  dojo.declare("Thing", null, { constructor: function(){ });
  var ref = Thing;
  if(dojo.isFunction(ref)){
     var mine = new ref();
  }

A common pattern is to have a a string version of a fully declared class. You can use dojo.isFunction to tell if you need to convert it to a function or not:

.. code-block :: javascript
  :linenos:

  // some dynamic class to use:
  var thing = "dijit.Dialog";
  // check it out first:
  if(!dojo.isFunction(thing)){
    thing = dojo.getObject(thing);
  }
  var dialog = new thing({ title:"bar" });

One could use `dojo.isString <dojo/isString>`_ for a similar check.

========
See also
========

* `dojo.getObject <dojo/getObject>`_
