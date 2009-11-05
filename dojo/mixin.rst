#format dojo_rst

dojo.mixin
==========

:Status: Draft
:Version: 1.0
:Available: since 0.9

.. contents::
   :depth: 2

dojo.mixin is a simple utility function for mixing objects together. Mixin combines two objects from right to left, overwriting the left-most object, and returning the newly mixed object for use. Dojo mixin is very similar to `dojo.extend <dojo/extend>`_ but only works on objects, whereas extend explicitly extends an object.prototype.


============
Simple Mixes
============

.. code-block :: javascript
  :linenos:

  var a = { b:"c", d:"e" };
  dojo.mixin(a, { d:"f", g:"h" });
  console.log(a); // b:c, d:f, g:h

This example overwrites the "d" member from the second object, leaving the variable "a" with three members: b, d, and g. To expand on this, we can illustrate how to use mixin to overwrite defaults for some function:

.. code-block :: javascript
  :linenos:

  var generatedProps = { node:"someNode", onEnd:function(){ /* code */ } };
  var defaultProps = { duration:1000 };
  dojo.fadeIn(dojo.mixin(generatedProps, defaultProps)).play();

This will create and play a fadeIn animation passing and onEnd function and node, using a default duration.


====================
Creating new Objects
====================

Mixin modifies the first object in the list, mixing in second object. If you wish to make an entirely new object from the mixed results, you have a couple options. First, clone the existing object with dojo.clone, then mix:

.. code-block :: javascript
  :linenos:

  var newObject = dojo.mixin(dojo.clone(a), b);

Here, the return from `dojo.clone <dojo/clone>`_ is a new object, then b is mixed in.

Alternatly, you can pass an empty object as the first mix, and mix another object into it. You can then repeat this pattern as often as you'd like:

.. code-block :: javascript
  :linenos:

  var newObject = dojo.mixin({}, b);
  dojo.mixin(newObject, c);
  dojo.mixin(newObject, dojo.mixin(e, f));
  // and so on

Just remember the object instance in the first position will always be overwritten, and the right-most object will take precedence in the mix.


===================
Mixins with Classes
===================

A common pattern when creating class objects is to pass an object-hash of properties to the constructor. dojo.mixin provides a technique for easy over-ride of default in you own classes. Consider the follow class declaration:

.. code-block :: javascript
  :linenos:

  dojo.declare("my.Thinger", null, {
      defaultValue: "red",
      constructor: function(args){
          dojo.mixin(this, args);
      }
  });

Now, any time we create a new instance of a my.Thinger, it will have a member variable "defaultValue" set to red. If we provide a new defaultValue, the constructor will immediately overwrite the existing one:

.. code-block :: javascript
  :linenos:

  var thing = new my.Thinger({ defaultValue:"blue" });

=====================
Mixing into instances
=====================

Sometimes is it useful to mix custom variables and members into instances of widgets and other objects. Mixing into an instance allows you to easily add arbitrary references or overwrite functionality after instantiation.

.. code-block :: javascript
  :linenos:

  var cp = new dijit.layout.ContentPane();
  dojo.mixin(cp, { _timeCreated: new Date() });

Now, that instance of the ContentPane as a Date object attached in the _timeCreated member, which is accessible to the widget as 'this._timeCreated'.

==============
Mixing methods
==============

If you want to mix in some methods into an instance using two previous techniques, be aware that `dojo.declare <dojo/declare>`_ decorates them, while ``dojo.mixin`` does not, which may affect how ``this.inherited()`` works, if used in mixed-in methods. Use `dojo.safeMixin <dojo/safeMixin>`_, which correctly handles all properties in ``dojo.declare``-compatible way.
