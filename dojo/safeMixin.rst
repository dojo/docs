#format dojo_rst

dojo.safeMixin
==============

:Status: Draft
:Version: 1.4
:Available: since 1.4
:Author: Eugene Lazutkin

.. contents::
   :depth: 2

``dojo.safeMixin`` is a companion function for `dojo.declare <dojo/declare>`_. It has the same functionality as `dojo.mixin <dojo/mixin>`_, but additionally it annotates all copied methods compatibly with `dojo.declare <dojo/declare>`_. This decoration can affect how ``this.inherited()`` works in mixed-in methods.

===========
Basic Usage
===========

The function is usually used with classes and instances produced by `dojo.declare <dojo/declare>`_.

.. code-block :: javascript
  :linenos:

  var A = dojo.declare(null, {
    m1: function(){ /*...*/ },
    m2: function(){ /*...*/ },
    m3: function(){ /*...*/ },
    m4: function(){ /*...*/ },
    m5: function(){ /*...*/ }
  });

  var B = dojo.declare(A, {
    m1: function(){
      // we can do that because m1 is annotated by dojo.declare()
      return this.inherited(arguments); // calls A.m1
    }
  });

  B.extend({
    m2: function(){
      // we can do that because m2 is annotated by class.extend()
      return this.inherited(arguments); // calls A.m2
    }
  });

  dojo.extend(B, {
    m3: function(){
      // we have to specify the name because
      // this method is not annotated properly
      return this.inherited("m3", arguments); // calls A.m3
  });

  var x = new B();

  dojo.safeMixin(x, {
    m4: function(){
      // we can do that because m4 is annotated by dojo.safeMixin()
      return this.inherited(arguments); // calls A.m4
    }
  });

  dojo.mixin(x, {
    m5: function(){
      // we have to specify the name because
      // this method is not annotated properly
      return this.inherited("m5", arguments); // calls A.m5
  });
