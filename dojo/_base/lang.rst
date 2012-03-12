.. _dojo/_base/lang:

===============
dojo/_base/lang
===============

:since: V0.9

.. contents ::
    :depth: 2

**dojo._base.lang** contains functions for supporting Polymorphism.


Features
========

* :ref:`dojo.hitch <dojo/hitch>`

  Function that generates a wrapper function that ensures a function that will only ever execute in a defined scope.

* :ref:`dojo.partial <dojo/partial>`

  Function that generates a wrapper function that ensures a function will only ever execute globally.

* :ref:`dojo.clone <dojo/clone>`

  Clones objects (including DOM nodes) and all children.

* :ref:`dojo.delegate <dojo/delegate>`

  Returns a new object which "looks" to obj for properties which it does not have a value for.

* :ref:`dojo.trim <dojo/trim>`

  Trim whitespace from a String

* :ref:`dojo.replace <dojo/replace>`

  Simple templates with parameterized substitutions.

* :ref:`dojo.mixin <dojo/mixin>`

  Mixes one object into another. Can be used as a shallow copy

* :ref:`dojo.extend <dojo/extend>`

* :ref:`dojo.getObject <dojo/getObject>`

  Get a property from a dot-separated string, such as "A.B.C"

* :ref:`dojo.setObject <dojo/setObject>`

  Set a property from a dot-separated string, such as "A.B.C"


Deprecated
==========
See :ref:`Testing Object Types <releasenotes/migration-2.0#testing-object-types>` for advice on how to
differentiate between different types of objects without using dojo methods.  The methods below are deprecated:

* isString()

  Checks if the parameter is a String

* isArray()

  Checks if the parameter is an Array

* isFunction()

  Checks if the parameter is a Function

* isObject()

  Checks if the parameter is a Object

* isArrayLike()

  Checks if the parameter is like an Array

* isAlien()

  Checks if the parameter is a built-in function



See also
========

* :ref:`dojox.lang <dojox/lang/index>`
