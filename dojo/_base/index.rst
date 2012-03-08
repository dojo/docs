.. _dojo/_base/index:

==========
dojo/_base
==========

.. contents ::
    :depth: 2

**dojo/_base** contains a number of modules that provide basic functionality, such as array operations and AJAX functionality.  Typically, if a function or class exists within the dojo namespace directly (e.g. ``dojo.forEach()``) then it is defined in dojo/_base.

However, the modules in ``dojo/_base`` are being phased out in favor of top level modules in the ``dojo/`` directory.  The ``dojo/_base`` files will be maintained until the 2.0 release.

Modules
-------

* :ref:`dojo/_base/array <dojo/_base/array>`

  Array handling functions

* :ref:`dojo/_base/browser <dojo/_base/browser>`

  This module causes the browser-only base modules to be loaded.

* :ref:`dojo/_base/Color <dojo/_base/Color>`

  Functions for setting colors.

* :ref:`dojo/_base/config <dojo/_base/config>`

  Allows developers to override certain global settings that control how the toolkit operates.

* :ref:`dojo/_base/connect <dojo/_base/connect>`

  Contains functions for connecting methods to events

* :ref:`dojo/_base/declare <dojo/_base/declare>`

  Contains functions to define classes

* :ref:`dojo/_base/Deferred <dojo/_base/Deferred>`

  Functions and classes for managing communication between asynchronous threads (callbacks).

* :ref:`dojo/_base/event <dojo/_base/event>`

  Functions to handle DOM events.

* :ref:`dojo/_base/fx <dojo/_base/fx>`

  Basic animation functions.

* :ref:`dojo/_base/html <dojo/_base/html>`

  Module defines aliases to basic DOM and HTML functions, designed for backwards compatibility.

* :ref:`dojo/_base/json <dojo/_base/json>`

  Contains functions for dealing with JSON data.

* :ref:`dojo/_base/kernel <dojo/_base/kernel>`

  Defines some key parts of the Dojo API

* :ref:`dojo/_base/lang <dojo/_base/lang>`

  Contains functions supporting polymorphism and other basic Dojo language features.

* :ref:`dojo/_base/loader <dojo/_base/loader>`

  Module defines deprecated symbols for loading.

* :ref:`dojo/_base/NodeList <dojo/_base/NodeList>`

  Contains the syntactic sugar for chaining, common iteration operations, animation and node manipulation.

* :ref:`dojo/_base/query <dojo/_base/query>`

  The swiss army knife of DOM node manipulation in Dojo.

* :ref:`dojo/_base/sniff <dojo/sniff>`

  Used for browser feature detection, deprecated and moved to ``dojo/sniff``.

* :ref:`dojo/_base/unload <dojo/_base/unload>`

  Defines functions related to dealing with unloading document lifecycle.

* :ref:`dojo/_base/url <dojo/_base/url>`

  Defines the ``dojo/_Url`` object for handling and manipulation of URLs.

* :ref:`dojo/_base/window <dojo/_base/window>`

  Contains functions for dealing with document wide DOM and context related features.

* :ref:`dojo/_base/xhr <dojo/_base/xhr>`

  The core AJAX I/O transports and utility methods for Dojo.

See also
--------
