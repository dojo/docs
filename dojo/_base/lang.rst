#format dojo_rst

dojo/_base/lang
===============

:Available: since V0.9

.. contents::
    :depth: 2

**dojo._base.lang** contains functions for supporting Polymorphism.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including dojo.js or dojo.xd.js in your page.


========
Features
========

* `dojo.hitch <dojo/hitch>`_

  Function that generates a wrapper function that ensures a function that will only ever execute in a defined scope.

* `dojo.partial <dojo/partial>`_

  Function that generates a wrapper function that ensures a function will only ever execute globally.

* `dojo.delegate <dojo/delegate>`_

  Returns a new object which "looks" to obj for properties which it does not have a value for.

* `dojo.isString <dojo/isString>`_

  Checks if the parameter is a String

* `dojo.isArray <dojo/isArray>`_

  Checks if the parameter is an Array

* `dojo.isFunction <dojo/isFunction>`_

  Checks if the parameter is a Function

* `dojo.isObject <dojo/isObject>`_

  Checks if the parameter is a Object

* `dojo.isArrayLike <dojo/isArrayLike>`_

  Checks if the parameter is like an Array

* `dojo.isAlien <dojo/isAlien>`_

  Checks if the parameter is a built-in function

* `dojo.trim <dojo/trim>`_

  Trim whitespace from a String

* `dojo.replace <dojo/replace>`_

  Simple templates with parameterized substitutions.

* `dojo.mixin <dojo/mixin>`_

  Mixes one object into another. Can be used as a shallow copy

* `dojo.extend <dojo/extend>`_

* `dojo.delegate <dojo/delegate>`_

  Delegate an Object (beget)

* `dojo.getObject <dojo/getObject>`_

  Get a property from a dot-separated string, such as "A.B.C"

* `dojo.setObject <dojo/setObject>`_

  Set a property from a dot-separated string, such as "A.B.C"



========
See also
========

* `dojox.lang <dojox/lang/index>`_
