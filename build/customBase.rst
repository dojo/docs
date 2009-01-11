#format dojo_rst

build customBase
================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

THIS IS JUST PLACEHOLDER NOTES BASED ON CONVERSATION WITH PHIGGINS

Custom base makes really really small dojo.js



============
Introduction
============

Normally, when the builder system creates ``dojo.js`` it includes the entire base set of Dojo APIs (almost everything that can be accessed directly in the ``dojo`` namespace).  This provides a robust and usable core functionality in a file that is approximately 76.7 KB uncompressed and 26.5K gzipped as of Dojo 1.2.3.

However, in some cases, such as creating web applications intended for use on smart phones, you may desire to create an even smaller ``dojo.js``.  Using ``customBase`` you can achieve minimal Dojo versions as small as approximately 6k (including the stubs described below).

This is a very advanced feature, and if you think you need to use it, you should think carefully first. If after careful consideration, you still want to use this feature, be very, very careful and document it thoroughly for your own understanding.

=================
Function Stubbing
=================

When you use the ``customBase`` option, some base Dojo functions are not copied into your ``dojo.js`` file, in order to reduce the file size.

Instead, a stub is put into the file so that if a function that was not included is called, it can be `lazily loaded <http://en.wikipedia.org/wiki/Lazy_initialization>`_, essentially by a synchronous call to the server with ``dojo.require``.  

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
