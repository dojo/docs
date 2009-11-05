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

The function is usually used with classes and instances produced by `dojo.declare <dojo/declare>`_. It takes two parameters (both objects): target and source of properties.

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

=================
Technical details
=================

While copying properties ``dojo.safeMixin`` (and `dojo.declare <dojo/declare>`_) annotates methods. All other properties are copied unmodified. On any function it adds a single property: ``nom``, which value is a name of the function property.

.. code-block :: javascript
  :linenos:

  var x = {};
  dojo.safeMixin(x, {
    a: 1,
    b: "two",
    c: {
       x: 42
    },
    d: function(){}
  });

  console.log(x.d.nom); // prints: d

This way ``this.inherited()`` knows what superclass method to call. If this property is not there, you have to specify the name as the first argument in ``this.inherited()``.

JavaScript treats functions as objects (not values) and uses them by reference. It means that if you add a function to two (or more) objects, it will be annotated several times leading to wrong annotations in different contexts:

.. code-block :: javascript
  :linenos:

  var fun = function(){
    this.inherited(arguments);
  };

  var x = {}, y = {};

  dojo.safeMixin(x, {doSomething: fun});
  console.log(fun.nom);            // doSomething
  console.log(x.doSomething.nom);  // doSomething

  dojo.safeMixin(y, {anotherName: fun});
  console.log(fun.nom);            // anotherName
  console.log(y. anotherName.nom); // anotherName

  console.log(x.doSomething.nom);  // anotherName

As you can see we reused the same function as a method, and it was annotated twice. It will break ``this.inherited()`` in all objects but the last one.

How to prevent this problem?

* Try to avoid this situations. In most cases it can be done easily because functions are frequently created from literals and not reused in this manner (99% of all cases).
* Use function wrappers. Downside: it introduces an extra function call, which may affect the performance of short fast methods.
* Use a name in calls to ``this.inherited()``. Downside: you have to know the name, and it is not always possible.
