.. _dojo/_base/kernel:

=================
dojo/_base/kernel
=================

:Authors: TODO Author 
:since: 1.?

.. contents ::
    :depth: 2

Introduction
============

Generally not used directly, this defines version and deprecated().


deprecated()
============
This function simply throws a warning message, alerting developers a method or package has been removed, replaced, or otherwise has been changed, and they are using an "older" version of the method.

.. js ::

  require(["dojo/_base/kernel"], function(dojo){
      dojo.deprecated("dijit.layout.SplitContainer", "Use dijit.layout.BorderContainer instead", "2.0");
  });

This means the "SplitContainer" widget still works, but has been replaced by the :ref:`BorderContainer <dijit/layout/BorderContainer>` widget, and will be removed in Dojo 2.0

experimental()
==============
This function simply throws a warning message, alerting developers a method or module is experimental:

.. js ::

  require(["dojo/_base/kernel"], function(kernel){
      kernel.experimental("acme.MyClass");
  });

This means that MyClass's API may change, etc.

global
======

kernel.global is an alias for the global scope.

In a browser environment, global is the window object. You should refer to `global` rather than `window` so that your code will run correctly in other contexts (e.g. Rhino on a server).

.. js ::

   // connect a global "onclick" handler
   require(["dojo/_base/kernel", "dojo/on"], function(kernel, on){
       on(kernel.global, "click", function(e){
           console.log("clicked: ", e.target);
       });
   });

Though this example is clearly targeted at a browser environment, by using `global` over the `window` object we are ensuring the code will run in any other environments with a defined host environment file (hostenv_something).


See also :ref:`dojo/_base/window::withGlobal <dojo/_base/window#withglobal>`.

locale
======
locale contains the locale for loading localized resources, specified according to `RFC 3066 <http://www.ietf.org/rfc/rfc3066.txt>`_. This string can be specified with the help of dojoConfig.locale.

A simple reference of locale:

.. js ::

   require(["dojo/_base/kernel"], function(kernel){
      var currentLocale = kernel.locale;
   });


See also :ref:`Language and Localization Settings in dojoConfig <dojo/config>`.

version
=======
An object describing the current version of dojo.js


.. js ::

  >>> require(["dojo/_base/kernel"], function(kernel){ console.log(kernel.version); });
  0.0.0dev (15278) major=0 minor=0 patch=0 flag=dev revision=15278

0.0.0 indicates a "trunk" release, a non-complied version of Dojo. Typically you will see a real version, such as "1.2.0"

The members of the `version` object are integers, and can be checked individually:

.. js ::

	require(["dojo/_base/kernel"], function(kernel){
	  var v = kernel.version;
	  if(v.major > 1){
		// this is dojo 2.x
	  }else{
		// this id dojo 1.x
		switch(v.minor){
		   case 1: console.log("1.1.x specific code"); break;
		   case 2: console.log("1.2.x specific code"); break;
		   case 9: console.log("this is 0.9, as major is less than 1, but not 1"); break;
		}
	  }
	});

It is important to note the `version` value is easily set as part of the build process (`version=1.2.0`), and should not be relied upon in production code. It is meant as a simple utility for determining which particular version of Dojo is loaded on a page, mostly for debugging purposes.

The `revision` member refers to the SVN revision used to create the version. You can inspect individual changesets at `the Dojo bug tracker <http://bugs.dojotoolkit.org/changeset>`_

.. code-example::

  .. js ::

      require(["dojo/_base/kernel", "dojo/query", "dojo/NodeList-dom", "dojo/domReady!"], function(kernel, query){
          query(".info").attr("innerHTML", kernel.version);
      });

  .. html ::

      <div class="info"></div>



