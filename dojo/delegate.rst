#format dojo_rst

dojo.delegate
=============

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

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var myNewObject = dojo.delegate(anOldObject, { myNewProperty: "value or text"});
 </script>

dojo.delegate accepts two arguments:

==========  ====================  ==================================================
Parameter   Type                  Description
==========  ====================  ==================================================
obj         object                The object to delegate to for properties not found
                                  directly on the return object or in props.
props       object                An object containing properties to assign to the 
                                  returned object.
==========  ====================  ==================================================

dojo.delegate returns an Object of anonymous type.


========
Examples
========

Programmatic example
--------------------

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var anOldObject = { bar: "baz" };
   var myNewObject = dojo.delegate(anOldObject, { thud: "xyzzy"});
   myNewObject.bar == "baz"; // delegated to anOldObject
   anOldObject.thud == undefined; // by definition
   myNewObject.thud == "xyzzy"; // mixed in from props
   anOldObject.bar = "thonk";
   myNewObject.bar == "thonk"; // still delegated to anOldObject's bar
 </script>
