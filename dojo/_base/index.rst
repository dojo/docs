.. _dojo/_base/index:

==========
dojo/_base
==========

.. contents ::
    :depth: 2

**dojo/_base** contains what formerly constituted the "base" of Dojo when you required in ``dojo/dojo.js`` into your 
project.  Currently, this is not entirely accurate and ``dojo/_base`` contains a mixture of configuration modules, 
limited amounts of functionality that haven't been moved out to the Dojo Core and a lot of "stubs" which add "base" 
functionality to Dojo when it is running in legacy mode.

If you run ``dojo/dojo.js`` in async mode (``async: true``) then the loader will only load the modules as they are 
needed.  Also, if you do a custom build, what modules and when they are loaded are dependent upon how Dojo is built.  
If you run in "legacy" mode, then the APIs that are part of the Dojo Base are automatically loaded and made available.

Modules
=======

* :ref:`dojo/_base/array <dojo/_base/array>`

  Array handling functions

* `dojo/_base/browser`

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

  Defines some key parts of the Dojo API.

* :ref:`dojo/_base/lang <dojo/_base/lang>`

  Contains functions supporting polymorphism and other basic Dojo language features.

* :ref:`dojo/_base/loader <dojo/_base/loader>`

  Module defines deprecated symbols for loading.

* :ref:`dojo/_base/NodeList <dojo/_base/NodeList>`

  Contains the syntactic sugar for chaining, common iteration operations, animation and node manipulation.

* :ref:`dojo/_base/query <dojo/_base/query>`

  *Deprecated* The swiss army knife of DOM node manipulation in Dojo. Moved to :ref:`dojo/query <dojo/query>`.

* :ref:`dojo/_base/sniff <dojo/sniff>`

  Used for browser feature detection, deprecated and moved to :ref:`dojo/sniff`.

* :ref:`dojo/_base/unload <dojo/_base/unload>`

  Defines functions related to dealing with unloading document lifecycle.

* :ref:`dojo/_base/url <dojo/_base/url>`

  Defines the ``dojo/_Url`` object for handling and manipulation of URLs.

* :ref:`dojo/_base/window <dojo/_base/window>`

  Contains functions for dealing with document wide DOM and context related features.

* :ref:`dojo/_base/xhr <dojo/_base/xhr>`

  *Deprecated* The core AJAX I/O transports and utility methods for Dojo.  New code should use 
  :ref:`dojo/request <dojo/request>`.

See Also
========

* :ref:`Dojo Core Overview <dojo/index>`

* :ref:`Dojo Loader <loader/amd>`
