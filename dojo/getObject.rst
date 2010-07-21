#format dojo_rst

dojo.getObject
===============

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

dojo.getObject returns the property of an object from a dot-separated string such as "A.B.C"


=====
Usage
=====

The simplest way to use dojo.getObject is to pass a dot-separated string as shown below:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // define an object
   var foo = {
     bar: "some value"
   };

   // get the "foo.bar" property
   dojo.getObject("foo.bar");  // returns "some value"
 </script>

dojo.getObject also takes an optional boolean parameter which, if `true`, will create the property if it does not exist. Any other properties along the path will also be created along the way. The default value is `false`.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // define an object
   var foo = {
     bar: "some value"
   };

   // get the "foo.baz" property, create it if it doesn't exist
   dojo.getObject("foo.baz", true); // returns foo.baz - an empty object {}
   /*
     foo == {
       bar: "some value",
       baz: {}
     }
   */
 </script>

You can also pass an object as the third parameter. This will define the context in which to search for the property. By default, the context is `dojo.global <dojo/global>`_.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // define an object
   var foo = {
     bar: "some value"
   };

   // get the "bar" property of the foo object
   dojo.getObject("bar", false, foo); // returns "some value"
 </script>


========
See also
========

* `dojo.setObject <dojo/setObject>`_
* `dojo.exists <dojo/exists>`_
