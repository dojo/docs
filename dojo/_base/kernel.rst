.. _dojo/_base/kernel:

=================
dojo/_base/kernel
=================

.. contents ::
  :depth: 2

**dojo/_base/kernel** is a module that contains some of the very basic features that are part of Dojo.
The module us not usually required directly by end developers, unless required for creating additional modules
that are part of the toolkit.

Usage
=====

As with the rest of ``dojo/_base`` modules, if you are running the Dojo loader in legacy mode (``async: false``) this 
module is automatically loaded, also most core modules directly or indirectly depend on this module.  Even if it is 
automatically loaded, you should require it in to have access to its features:

.. js ::

  define(["dojo/_base/kernel"], function(kernel){
    // kernel has the module's features
  });

Features
========

.. _dojo/_base/kernel#deprecated:

deprecated()
------------

This function logs a warning message to the console, alerting developers a method or package has been removed, replaced,
or otherwise has been changed, and they are using an "older" version of the method.
``isDebug`` needs to be set to ``true`` for these messages to appear.

.. js ::

  require(["dojo/_base/kernel"], function(kernel){
    kernel.deprecated("dijit.layout.SplitContainer", "Use dijit.layout.BorderContainer instead", "2.0");
  });

This means the "SplitContainer" widget still works, but has been replaced by the
:ref:`BorderContainer <dijit/layout/BorderContainer>` widget, and will be removed in Dojo 2.0.


.. _dojo/_base/kernel#experimental:

experimental()
--------------

This function logs a warning message to the console, alerting developers a method or module is experimental.   
``isDebug`` needs to be set to ``true`` for these messages to appear.

.. js ::

  require(["dojo/_base/kernel"], function(kernel){
    kernel.experimental("acme.MyClass");
  });

.. _dojo/_base/kernel#global:

global
------

*Deprecated*.  ``global`` is an alias for the global scope that was designed to work both in a browser environment
(where it points to ``window``), and a server environment.

With modern AMD code, hopefully globals are completely unnecessary.
If you do need to create/read a global, then the following pattern is preferred:

.. js ::

   require([...], function(...){
        var global = this;
        ...
        global.myVariable = "hello world";
   });

For strict modules, there's a slightly more complicated syntax:

.. js ::

   "use strict";
   require([...], function(...){
        var global = Function("return this")();
        ...
        global.myVariable = "hello world";
   });

See also :ref:`dojo/_base/window::withGlobal <dojo/_base/window#withglobal>`.

.. _dojo/_base/kernel#locale:

locale
------

``locale`` contains the locale for loading localized resources, specified according to
`RFC 3066 <http://www.ietf.org/rfc/rfc3066.txt>`_.
This string can be specified with the help of :ref:`dojo/_base/config::locale <dojo/_base/config#locale>`.

A simple reference of locale:

.. js ::

  require(["dojo/_base/kernel"], function(kernel){
    var currentLocale = kernel.locale;
  });

.. _dojo/_base/kernel#version:

version
-------

An object describing the current version of ``dojo.js``::

  >>> require(["dojo/_base/kernel"], function(kernel){ console.log(kernel.version); });
  0.0.0dev (15278) major=0 minor=0 patch=0 flag=dev revision=15278

``0.0.0`` indicates a "trunk" release, a non-built version of Dojo. Typically you will see a real version, such as 
``1.8.0``.

The members of the ``version`` object are integers, and can be checked individually:

.. js ::

  require(["dojo/_base/kernel"], function(kernel){
    var v = kernel.version;
    if(v.major > 1){
      // this is Dojo 2.x or greater
    }else if(v.major === 1){
      // this is Dojo 1.x
      switch(v.minor){
       case 1: console.log("1.1.x specific code"); break;
       case 2: console.log("1.2.x specific code"); break;
       case 9: console.log("1.9.x specific code"); break;
      } 
    }
  });

It is important to note the ``version`` value is easily set as part of the build process (``version=1.8.0``), and 
should not be relied upon in production code. It is meant as a simple utility for determining which particular version 
of Dojo is loaded on a page, mostly for debugging purposes.

The ``revision`` member refers to the SVN revision used to create the version. You can inspect individual changesets 
at `the Dojo ticket tracker <http://bugs.dojotoolkit.org/changeset>`_.

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/_base/kernel", "dojo/query", "dojo/NodeList-dom", "dojo/domReady!"], function(kernel, query){
      query(".info").attr("innerHTML", kernel.version);
    });

  .. html ::

    <div class="info"></div>

See Also
========

* :ref:`dojo/_base <dojo/_base/index>` - The "base" of Dojo.

* :ref:`dojo <dojo/index>` - The "core" of Dojo.
