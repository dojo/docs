#format dojo_rst

dojox.io.xhrPlugins
===================

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.io.xhrPlugins** provides a registry of alternate transports that can be used to provide dojo.xhr functionality with cross-site requests.


============
Introduction
============

Traditionally, XHR can only be used for same-origin requests. Alternate techniques are generally necessary for cross-site requests. dojox.io.xhrPlugins provides a means for registering server support for different transports so dojo.xhr can still be used for cross-site requests to maintain consistent call-site syntax. Please see `this tutorial <http://www.sitepen.com/blog/2008/07/31/cross-site-xhr-plugin-registry/>`_ for a full description of this module.
