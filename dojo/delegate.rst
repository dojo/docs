#format dojo_rst

dojo.delegate
=============

:Status: Draft
:Author: ?--
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Returns a new object which "looks" to obj for properties which it does not have a value for. Optionally takes a bag of properties to seed the returned object with initially.


============
Introduction
============

This is a small implementaton of the Boodman/Crockford delegation pattern in JavaScript. An intermediate object constructor mediates the prototype chain for the returned object, using it to delegate down to obj for property lookup when object-local lookup fails. This can be thought of similarly to ES4's "wrap", save that it does not act on types but rather on pure objects.


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
