#format dojo_rst

build customBase
================

:Status: Draft
:Version: 1.0
:Project owner: (docs) Scott Jenkins
:Available: since V?

.. contents::
   :depth: 2

Custom base is used to make an extremely small file size version of dojo.js.



============
Introduction
============

Normally, when the builder system creates ``dojo.js`` it includes the entire base set of Dojo APIs (almost everything that can be accessed directly in the ``dojo`` namespace).  This provides a robust and usable core functionality in a file that is approximately 76.7 KB uncompressed and 26.5K gzipped as of Dojo 1.2.3.

However, in some cases, such as creating web applications intended for use on smart phones, you may desire to create an even smaller ``dojo.js``.  Using ``customBase`` you can achieve minimal Dojo versions as small as approximately 6k (including the stubs described below).

This is a very advanced feature, and if you think you need to use it, you should think carefully first. If after careful consideration, you still want to use this feature, be very, very careful and document it thoroughly for your own understanding.

===============================
dojo.require for base functions
===============================

When you use the ``customBase`` option, some base Dojo functions are not copied into your ``dojo.js`` file, in order to reduce the file size.

Instead, a ``dojo.require`` statement is generated for each base resource that the builder identifies as being used in your module.  This identification is done with regular expression matching, and is by design somewhat lax to ensure it catches all resources that are needed.

This allows you to still use the entire base API, but at the cost of additional an additional round trip to the server *at the time a function not in base is first called*.


=====
Usage
=====

In the profile for your build, specify the following for your dojo layer (note the ``customBase`` property):

.. code-block :: javascript
 :linenos:

 layers: [
   {
	name: "dojo.js",
	customBase: true,
	dependencies: [
        ]
   },

  // ... remainder of profile

  ]

If, as shown in this example, you specify ``customBase: true``, but do not specify any dependencies
for the ``dojo.js`` layer, then then *none* of ``dojo._base`` gets added to
``dojo.js``. 

You just end up with the following from ``dojo/_base/_loader``, basically, just bare utilities for browser detection:

   * ``dojo.addOnLoad``
   * ``addOnUnload``
   * ``dojo.require``
   * ``dojo.provide``
   * ``bootstrap.js``
   * ``hostenv_browser.js``
   * ``loader.js``



============================
Including Specific Resources
============================

To include specific dojo base resources in your minimal build, use the dependencies list for the dojo.js layer.  

For example, if you specify ``customBase: true``, but want a particular ``dojo/_base``
module, say just the array help functions and ``dojo.Deferred``, your profile ``dojo.js`` layer would
look like this:

.. code-block :: javascript
 :linenos:

   {
          name: "dojo.js",
          customBase: true
          dependencies: [
                  "dojo._base.Deferred",
                  "dojo._base.array"
          ]
   }


===================
Caveats
===================

If you use ``customBase: true``, then the build system will use
regular expressions to see if any of the modules in the build (dojo, dijit, dojox,
your custom namespaces) use any ``dojo._base methods``, and if they detect
a usage, it will inject ``dojo.require`` calls into the built modules. 

This helps avoid issues where you use a module that needs a ``dojo._base``
module that you did not include in your ``dojo.js``. However since it is
using regular expressions, you may get more ``dojo.require`` calls for ``dojo._base``
modules than necessary. The idea was to have the detection be very lax
in what it matches to avoid run time errors. 

Example: if the build
finds "indexOf" in the module, it will add in a
``dojo.require("dojo._base.array")``, but that ``indexOf`` in the module could
have been a String method call.

================
Known Bugs
================
``customBase: true`` should not be used with ``djConfig.require``. There is a
bug where the ``djConfig.require`` will not be included correctly
depending on if you leave out ``dojo._base.browser``:
http://bugs.dojotoolkit.org/ticket/7756
