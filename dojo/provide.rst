.. _dojo/provide:

============
dojo.provide
============

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

dojo.provide is a core part of the legacy dojo module system. It tells the loader that a specific module has been loaded.


Introduction
============

Each JavaScript source file must have at least one dojo.provide() call at the top of the file, corresponding to the file name. For example, `js/dojo/foo.js` must have `dojo.provide("dojo.foo");` before any calls to `dojo.require()` are made.


Usage
=====

dojo.provide is an integral part of Dojo's module system and its loader.
dojo.provide() tells the loader that the module has been provided for the given name.
It also creates a JavaScript object for the name.

This code example is for a my/module.js file. Note the convention of placing the dojo.provide call before dojo.require calls.

Dojo 1.7 (AMD)
--------------

.. js ::

   define(['dojo/_base/kernel', 'dojo/io/script', 'dojo/_base/loader'], function(dojo, ioScript){
     dojo.provide("my.module");

     // dojo.provide made sure that my.module was created as a JavaScript object,
     // so properties can be assigned to it:
     my.module.name = "my module";
   });

Dojo < 1.7
----------

.. js ::

   dojo.provide("my.module");

   dojo.require("dojo.io.script");

   // dojo.provide made sure that my.module was created as a JavaScript object,
   // so properties can be assigned to it:
   my.module.name = "my module";

Multiple dojo.provide calls can live in a file, but outside of built layer, it is normal just to see one for the module that matches the file name.

Prior to Dojo 1.7 the legacy module format was used in combination with dojo.require and dojo.declare like this:

.. js ::

    dojo.provide("my._TemplatedWidget");
    dojo.require("dijit._WidgetBase");
    dojo.require("dijit._TemplatedMixin");
    dojo.declare("my._TemplatedWidget", [ dijit._WidgetBase, dijit._TemplatedMixin ], {});

See also
========

* :ref:`dojo.require <dojo/require>`
