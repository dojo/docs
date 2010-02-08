#format dojo_rst

dojo.provide
============

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

dojo.provide is a core part of the dojo module system. It tells the loader that a specific module has been loaded.


============
Introduction
============

Each javascript source file must have at least one dojo.provide() call at the top of the file, corresponding to the file name. For example, `js/dojo/foo.js` must have `dojo.provide("dojo.foo");` before any calls to `dojo.require()` are made.


=====
Usage
=====

dojo.provide is an integral part of Dojo's module system and its loader. dojo.provide() tells the loader that the a module has been provided for the given name. It also creates a JavaScript object for the name.

This code example is for a my/module.js file. Note the convention of placing the dojo.provide call before dojo.require calls.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.provide("my.module");

   dojo.require("dojo.io.script");

   //dojo.provide made sure that my.module was created as a JavaScript object,
   //so properties can be assigned to it:
   my.module.name = "my module";
 </script>

Multiple dojo.provide calls can live in a file, but outside of built layer, it is normal just to see one for the module that matches the file name.

========
See also
========

* `dojo.require <dojo/require>`_
