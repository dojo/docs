.. _dojo/_base/lang:

===============
dojo/_base/lang
===============

:since: V0.9

.. contents ::
    :depth: 2

**dojo._base.lang** contains functions for supporting Polymorphism.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including ``dojo.js`` in your page.


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

* :ref:`dojo.isString <dojo/isString>`

  Checks if the parameter is a String

* :ref:`dojo.isArray <dojo/isArray>`

  Checks if the parameter is an Array

* :ref:`dojo.isFunction <dojo/isFunction>`

  Checks if the parameter is a Function

* :ref:`dojo.isObject <dojo/isObject>`

  Checks if the parameter is a Object

* :ref:`dojo.isArrayLike <dojo/isArrayLike>`

  Checks if the parameter is like an Array

* :ref:`dojo.isAlien <dojo/isAlien>`

  Checks if the parameter is a built-in function

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



See also
========

* :ref:`dojox.lang <dojox/lang/index>`
