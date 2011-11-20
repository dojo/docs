.. _dojox/secure:

dojox.secure
============

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.2

.. contents::
   :depth: 2

DojoX Secure is a collection of tools for security, in particular for working with
untrusted data and code.

========
Features
========

* :ref:`dojox.secure.sandbox <dojox/secure/sandbox>`

  Provides support for loading web pages, JSON, and scripts from other domains using XHR (and XHR plugins) with a safe subset library and sandboxed access to the DOM. Generally this is the only module that you will need to interact with if you are building secure mashups.

* :ref:`dojox.secure.capability <dojox/secure/capability>`

  Object-capability JavaScript validation. This is a validator to run before eval to ensure that a script can't access or modify any objects outside of those specifically provided to it.

* :ref:`dojox.secure.DOM <dojox/secure/DOM>`

  Provides a DOM facade that restricts access to a specified subtree of the DOM. The DOM facade uses getters/setters and lettables to emulate the DOM API.

========
See Also
========

* DojoX Secure is described in more detail here: http://www.sitepen.com/blog/2008/08/01/secure-mashups-with-dojoxsecure/
