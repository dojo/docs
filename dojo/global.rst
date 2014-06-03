.. _dojo/global:

===========
dojo.global
===========

*Deprecated*.

Dojo.global was originally created to either:

   - access the global scope in a device independent way
     (i.e for code to run on browsers and server side), see :ref:`dojo/_base/kernel::global <dojo/_base/kernel#global>`

   - (for browser only code) access the window object such that other code could redirect the window object to point
     to a different frame (see :ref:`dojo/_base/kernel::global <dojo/_base/kernel#global>` and
     :ref:`dojo/_base/window::setContext <dojo/_base/window#setContext>`).


Regarding the first usage, modern AMD modules probably should not be trying to set or read global variables at all.
If they do, a syntax like:

.. js ::

   require([...], function(...){
        var global = this;
        ...
        global.myVariable = "hello world";
   });

is preferable to using :ref:`dojo/_base/kernel::global <dojo/_base/kernel#global>`.
For strict modules, a slightly more complicated syntax is required:

.. js ::

   "use strict";
   require([...], function(...){
        var global = Function("return this")();
        ...
        global.myVariable = "hello world";
   });

As for accessing the window object (to control scrolling, setup handlers, etc.), most application code can simply
access the ``window`` global, rather than accessing :ref:`dojo/_base/kernel::global <dojo/_base/kernel#global>`.