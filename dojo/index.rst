.. _dojo/index:

=============
Dojo Overview
=============

.. contents ::
   :depth: 2

The dojo package is the foundation package of the Dojo Toolkit.  It consists of three main areas:

* `dojo.js`_ - the bootstrap

* `dojo/_base`_ - basic functionality historically pulled in as part of dojo.js, and historically existing directly
  under the ``dojo`` namespace

* `Dojo Core`_ - more advanced functionality, with some of the functionality available in sub-packages (e.g.
  ``dojo/dnd`` and ``dojo/store``)

Each of these areas are detailed in the following sections.

dojo.js
=======

This file provides the bootstrap for loading other modules, in particular the ``require()`` function, previously known
as ``dojo.require()``. See the :ref:`loader documentation <loader/index>` for further details of how modules are loaded.

For backwards-compatibility, when ``dojo.js`` is included without the ``async: true`` configuration flag, all the
modules in `dojo/_base`_ are implicitly loaded.

dojo/_base
==========

The dojo/_base directory contains modules with basic functionality, such as array operations. Typically, if a function
or class exists within the dojo namespace directly (e.g. ``dojo.forEach()``) then it is defined in ``dojo/_base``.

However, note that the modules in ``dojo/_base`` are being phased out in favor of top level modules in the ``dojo/``
directory. The ``dojo/_base`` files will be maintained until the 2.0 release. See details below for replacement modules.

* :ref:`dojo/_base <dojo/_base/>` - Overview of all the ``dojo/_base`` modules.

Configuring Dojo (dojo/_base/config)
------------------------------------

* :ref:`dojoConfig (dojo/_base/config) <dojo/_base/config>`

  Possibility to override certain global settings that control how the framework operates

Array Utilities (dojo/_base/array)
----------------------------------

Details on dojo.every, dojo.filter, dojo.forEach, dojo.indexOf, dojo.lastIndexOf, dojo.map, and dojo.some. See the :ref:`Array QuickStart <quickstart/arrays>` for an overview.

* :ref:`dojo/_base/array <dojo/_base/array>`

  **STUB** Overview of the array module

* :ref:`dojo.forEach <dojo/forEach>`

  Invokes a callback function for every item in array

* :ref:`dojo.map <dojo/map>`

  Applies a callback to each element of arr and returns an Array with the results

* :ref:`dojo.some <dojo/some>`

  Iterate over an array, escaping when the callback returns true for some logic check.

* :ref:`dojo.every <dojo/every>`

  Iterate over an array, escaping when the callback returns false for some logic check.

* :ref:`dojo.filter <dojo/filter>`

  Iterate over an array, reducing the array based on the callback return.

* :ref:`dojo.indexOf <dojo/indexOf>`

  Find the index of some element in an Array.

* :ref:`NodeList array methods <dojo/NodeList>`

  * NodeList.indexOf, NodeList.lastIndexOf, NodeList.forEach, NodeList.every, NodeList.some, NodeList.concat, NodeList.map, NodeList.filter, NodeList.at

Language Utilities (dojo/_base/lang)
------------------------------------
* :ref:`dojo.hitch <dojo/hitch>`

  Function that generates a wrapper function that ensures a function that will only ever execute in a defined scope.

* :ref:`dojo.partial <dojo/partial>`

  Function that generates a wrapper function that ensures a function will only ever execute globally.

* :ref:`dojo.clone <dojo/clone>`

  Clones objects (including DOM nodes) and all children.

* :ref:`dojo.delegate <dojo/delegate>`

  Returns a new object which "looks" to obj for properties which it does not have a value for.

* :ref:`dojo.isString <dojo/isString>`

  Checks if the parameter is a String

* :ref:`dojo.isArray <dojo/isArray>`

  Checks if the parameter is an Array

* :ref:`dojo.isFunction <dojo/isFunction>`

  Checks if the parameter is a Function

* :ref:`dojo.isObject <dojo/isObject>`

  Checks if the parameter is an Object

* :ref:`dojo.isArrayLike <dojo/isArrayLike>`

  Checks if the parameter is like an Array

* :ref:`dojo.isAlien <dojo/isAlien>`

  Checks if the parameter is a built-in function

* :ref:`dojo.trim <dojo/trim>`

  Trim whitespace from a String

* :ref:`dojo.replace <dojo/replace>`

  Simple templates with parameterized substitutions.

* :ref:`dojo.mixin <dojo/mixin>`

  Mixes one object into another. Can be used as a shallow copy

* :ref:`dojo.extend <dojo/extend>`

* :ref:`dojo.getObject <dojo/getObject>`

  Get a property from a dot-separated string, such as "A.B.C"

* :ref:`dojo.setObject <dojo/setObject>`

  Set a property from a dot-separated string, such as "A.B.C"

* :ref:`dojo.exists <dojo/exists>`

  Determine if an object supports a given method

HTML Utilities (dojo/_base/html)
--------------------------------
The :ref:`dojo/_base/html <dojo/_base/html>` module contains basic DOM & HTML handling functions for backward compatibility purposes.

New code should use the dojo/dom* modules (see "Dojo core" section below for details).

Deferred Utilities (dojo/_base/Deferred)
----------------------------------------

* :ref:`dojo/_base/Deferred <dojo/_base/Deferred>`

  Communication between asynchronous calls

  * :ref:`dojo.when <dojo/when>`

    Allows a single code path for synchronous and asynchronous code execution.

Kernel (dojo/_base/kernel)
--------------------------

* :ref:`dojo/_base/kernel <dojo/_base/kernel>`

  **STUB** from 1.7+ `dojo/_base/kernel` module contains the following parts of Dojo API:

  * :ref:`dojo.deprecated <dojo/deprecated>`

    Log a debug message to indicate that a behavior has been deprecated

  * :ref:`dojo.eval <dojo/eval>`

    Evaluate some string of JavaScript

  * :ref:`dojo.locale <dojo/locale>`

    A string containing the current locale as defined by Dojo

  * :ref:`dojo.moduleUrl <dojo/moduleUrl>`

    Returns a URL relative to a module

  * :ref:`dojo.version <dojo/version>`

    The current version number of Dojo

Window (dojo/_base/window)
--------------------------

from 1.7 + dojo/_base/window module collects following part of dojo APIs

* :ref:`dojo.doc <dojo/doc>`

  Alias for the current document.

* :ref:`dojo.body <dojo/body>`

  Return the body element of the document

* :ref:`dojo.setContext <dojo/setContext>`

  Changes the behavior of many core Dojo functions that deal with namespace and DOM lookup

* :ref:`dojo.withGlobal <dojo/withGlobal>`

  Call callback with globalObject as dojo.global and globalObject.document as dojo.doc

* :ref:`dojo.withDoc <dojo/withDoc>`

  Call callback with documentObject as dojo.doc

Effects (dojo/_base/fx)
-----------------------

* :ref:`dojo.animateProperty <dojo/animateProperty>`

  The workhorse of most :ref:`dojo.fx <dojo/fx>` animations. Used for animating CSS properties

* :ref:`dojo.Animation <dojo/Animation>`

  **1.4+** previously dojo._Animation, the class behind all dojo.fx

* :ref:`dojo.anim <dojo/anim>`

  Shorthand version of animateProperty using positional arguments

* :ref:`dojo.fadeOut <dojo/fadeOut>`

* :ref:`dojo.fadeIn <dojo/fadeIn>`

Connect (dojo/_base/connect)
----------------------------

This module provides event handling for DOM nodes, and AOP for functions.   However, it is superseded by the :ref:`dojo/on <dojo/on>`, :ref:`dojo/aspect <dojo/aspect>`, and :ref:`dojo/topic <dojo/topic>` modules, which should be used for new code.

The methods defined in this module are:

* :ref:`dojo.connect <dojo/connect>`

  Connects events to methods

* :ref:`dojo.disconnect <dojo/disconnect>`

  Disconnects methods from linked topics

* :ref:`dojo.subscribe <dojo/subscribe>`

  Linked a listener to a named topic

* :ref:`dojo.unsubscribe <dojo/unsubscribe>`

  Remove a topic listener

* :ref:`dojo.publish <dojo/publish>`

  Publish an event to all subscribers of a topic

* :ref:`dojo.connectPublisher <dojo/connectPublisher>`

  Ensure that every time an event is called, a message is published on the topic.

NodeList (dojo/_base/NodeList)
------------------------------
* :ref:`NodeList.connect <dojo/NodeList>`

  Connects events to every node in the list, like dojo.connect

* :ref:`NodeList.events <dojo/NodeList>`

  Common event names mapped as functions on a NodeList - eg: .onclick(function(){})

Event (dojo/_base/event)
------------------------
The :ref:`dojo/_base/event <dojo/_base/event>` module defines dojo DOM event API.   See the dojo/_base/connect section above.


Document Lifecycle - Unload (dojo/_base/unload)
-----------------------------------------------

* :ref:`dojo/_base/unload <dojo/_base/unload>`

  **STUB** functions related to document unloading

* :ref:`dojo.addOnUnload <dojo/addOnUnload>`

  Call functions when the page unloads

* :ref:`dojo.addOnWindowUnload <dojo/addOnWindowUnload>`

  Call functions when window.onunload fires

* :ref:`dojo.windowUnloaded <dojo/windowUnloaded>`

  Signal fired by impending window destruction

AJAX/XHR (dojo/_base/xhr)
-------------------------

* :ref:`IO Pipeline Topics <dojo/ioPipelineTopics>`

* :ref:`dojo.contentHandlers <dojo/contentHandlers>`

  **1.4+** Pre-defined XHR content handlers, and an extension point to add your own custom handling.

* :ref:`dojo/_base/xhr <dojo/_base/xhr>`

  Core for all xhr* verbs, eg: xhrPost, getGet

* :ref:`dojo.xhrDelete <dojo/xhrDelete>`

* :ref:`dojo.xhrGet <dojo/xhrGet>`

* :ref:`dojo.xhrPost <dojo/xhrPost>`

* :ref:`dojo.xhrPut <dojo/xhrPut>`

* :ref:`dojo.rawXhrPost <dojo/rawXhrPost>`

* :ref:`dojo.rawXhrPut <dojo/rawXhrPut>`

Package System (dojo/_base/loader)
----------------------------------

This module is defining deprecated symbols for loading.   See the :ref:`loader documentation <loader/index>` for details on new replacement API's.

* :ref:`dojo/_base/loader <dojo/_base/loader>`

  **STUB** module overview

* :ref:`dojo.registerModulePath <dojo/registerModulePath>`

  Maps module name to a path

* :ref:`dojo.require <dojo/require>`

  Loads a Javascript module from the appropriate URI

* :ref:`dojo.provide <dojo/provide>`

JSON Tools (dojo/_base/json)
----------------------------

* :ref:`dojo.fromJson <dojo/fromJson>`

  Parses a JSON string to return a JavaScript object

* :ref:`dojo.toJson <dojo/toJson>`

  Returns a JSON serialization of an object

Objects / OO Utilities (dojo/_base/declare)
-------------------------------------------

* :ref:`dojo.declare (dojo/_base/declare) <dojo/declare>`

  Creates a constructor using a compact notation for inheritance and prototype extension


Colors (dojo/_base/Color)
-------------------------

* :ref:`dojo._base.Color <dojo/_base/Color>`

  Color object and utility functions to handle colors.  Defines the following API functions:

  * dojo.colorFromArray

  * dojo.colorFromHex

  * dojo.colorFromString

  * dojo.colorFromRgb


Miscellaneous Base
------------------

* :ref:`dojo/browser <dojo/_base/browser>`

  This module causes the browser-only base modules to be loaded.

* :ref:`dojo.global <dojo/global>`

  Alias for the global scope

* :ref:`dojo.keys <dojo/keys>`

  A collection of key constants.

* :ref:`dojo._Url <dojo/_base/url>`

  dojo._Url is used to manage the url object.

* :ref:`dojo/_base/sniff <quickstart/browser-sniffing>`
* :ref:`dojo/sniff <dojo/sniff>` **STUB**

  dojo/_base/sniff is introduced in dojo 1.7 as the browser detection utility.

Dojo Core
=========

While using the legacy API, many of the modules listed here are auto-loaded and made available in the global scope for
Legacy compatibility purposes, it is not advisable. The best practice is to require in only the modules you need to use
within your application. For example, previously, if you need to retrieve a DOM node by its ID, you might have
accomplished this by just accessing the ``dojo`` global scope object like:

.. js::

  var myNode = dojo.byId("myNode");

But to ensure the current best practices from Dojo 1.7 onwards, you should do the following:

.. js::

  require("dojo/dom", function(dom){
    var myNode = dom.byId("myNode");
  });

DOM (dojo/dom*)
---------------

The following modules define the core DOM API for the Dojo Toolkit. For compatibility purposes, aliases to the Legacy
API are defined in :ref:`dojo/_base/html <dojo/_base/html>` and :ref:`dojo/_base/xhr <dojo/_base/xhr>` modules. For new
development it is recommended to require only the individual modules of the parts of the API that are needed and to
reference them via their return variable. See each module for examples of what the common conventions are for doing
this.

* DOM Core (:ref:`dojo/dom <dojo/dom>`)

  This module defines the core dojo DOM API.  The convention for the return variable for this module is ``dom``.

  * :ref:`dojo.byId <dojo/byId>`

    Select a DOM node by 'id'.

  * dojo.isDescendant

  * dojo.setSelectable

* Manipulation (:ref:`dojo/dom-construct <dojo/dom-construct>`)

  This module defines the core dojo DOM construction API. The convention for the return variable for this module is
  ``domConstruct``.

  * :ref:`dojo.toDom <dojo/toDom>`

    Instantiates an HTML fragment returning the corresponding DOM.

  * :ref:`dojo.create <dojo/create>`

    Creates a DOM node with optional values and placement

  * :ref:`dojo.place <dojo/place>`

    Place DOM nodes relative to others

  * :ref:`dojo.destroy <dojo/destroy>`

    Destroy a DOM node

  * :ref:`dojo.empty <dojo/empty>`

    Empty the contents of a DOM node

* Attributes (:ref:`dojo/dom-attr <dojo/dom-attr>`)

  This module defines the core Dojo DOM attributes API. This module will be retired in the future and superseded by
  :ref:`dojo/dom-prop <dojo/dom-prop>`.  The convention for the return variable for this module is ``domAttr``.

  * :ref:`dojo.attr <dojo/attr>`

    Modifying DOM node attributes

  * :ref:`dojo.getAttr <dojo/getAttr>`

    Gets an attribute on an HTML element.

  * :ref:`dojo.setAttr <dojo/setAttr>`

    Sets an attribute on an HTML element.

  * :ref:`dojo.hasAttr <dojo/hasAttr>`

    Returns true if the requested attribute is specified on the given element, and false otherwise.

  * :ref:`dojo.removeAttr <dojo/removeAttr>`

    Removes an attribute from an HTML element.

  * :ref:`dojo.getNodeProp <dojo/getNodeProp>`

    Returns an effective value of a property or an attribute.

* Form (:ref:`dojo/dom-form <dojo/dom-form>`)

  This module defines form-processing functions.  The convention for the return variable for this module is ``domForm``.

  * :ref:`dojo.fieldToObject <dojo/fieldToObject>`

    Serialize a form field to a JavaScript object.

  * :ref:`dojo.formToJson <dojo/formToJson>`

    Create an object from an form node

  * :ref:`dojo.formToObject <dojo/formToObject>`

    Serialize a form node to a JavaScript object.

  * :ref:`dojo.formToQuery <dojo/formToQuery>`

    Returns a URL-encoded string representing the form passed as either a node or string ID identifying the form to
    serialize.

* Styles (:ref:`dojo/dom-style <dojo/dom-style>`)

  This module defines the core dojo DOM style API. The convention for the return variable for this module is
  ``domStyle``.

  * :ref:`dojo.style <dojo/style>`

    A getter/setter for styles on a DOM node

  * :ref:`dojo.getComputedStyle <dojo/getComputedStyle>`

    Return a cacheable object of all computed styles for a node

  * :ref:`dojo.getStyle <dojo/getStyle>`

    Accesses styles on a node.

  * :ref:`dojo.setStyle <dojo/setStyle>`

    Sets styles on a node.

* Class (:ref:`dojo/dom-class <dojo/dom-class>`)

  This module defines the core Dojo DOM class API. The convention for the return variable for this module is
  ``domClass``.

  * :ref:`dojo.hasClass <dojo/hasClass>`

    Returns a boolean depending on whether or not a node has a passed class string.

  * :ref:`dojo.addClass <dojo/addClass>`

    Adds a CSS class to a node.

  * :ref:`dojo.removeClass <dojo/removeClass>`

    Removes a class from a Node.

  * :ref:`dojo.toggleClass <dojo/toggleClass>`

    Toggles a className (or now in 1.4 an array of classNames).

  * :ref:`dojo.replaceClass <dojo/replaceClass>`

    Replaces one or more classes on a node if not present. Operates more quickly than calling ``dojo.removeClass`` and
    ``dojo.addClass``.

* Geometry (:ref:`dojo/dom-geometry <dojo/dom-geometry>`)

  This module defines the core dojo DOM geometry API. The convention for the return variable for this module is
  ``domGeom``.

  * :ref:`dojo.coords <dojo/coords>`

    Getter for the coordinates (relative to parent and absolute) of a DOM node.  Deprecated in Dojo 1.4.

  * :ref:`dojo.position <dojo/position>`

    Getter for the border-box x/y coordinates and size of a DOM node.
  
  * :ref:`dojo.marginBox <dojo/marginBox>`

    Getter/setter for the margin-box of node

  * :ref:`dojo.contentBox <dojo/contentBox>`

    Getter/setter for the content-box of node

  * :ref:`dojo.getMarginBox <dojo/getMarginBox>`

    Get an object that encodes the width, height, left and top positions of the node's margin box.

  * :ref:`dojo.setMarginBox <dojo/setMarginBox>`

    Sets the size of the node's margin box and placement (left/top), irrespective of box model.

  * :ref:`dojo.getContentBox <dojo/getContentBox>`

    Get an object that encodes the width, height, left and top positions of the node's content box, irrespective of the
    current box model.

  * :ref:`dojo.setContentSize <dojo/setContentSize>`

    Sets the size of the node's contents, irrespective of margins, padding, or borders.

* Property (:ref:`dojo/dom-prop <dojo/dom-prop>`)

  This module defines the core dojo DOM properties API. The convention for the return variable for this module is
  ``domProp``.

  * :ref:`dojo.prop <dojo/prop>`

    Gets or sets a property on an HTML element.

  * :ref:`dojo.getProp <dojo/getProp>`

    Gets a property on an HTML element.

  * :ref:`dojo.setProp <dojo/setProp>`

    Sets a property on an HTML element.
    
    
IO-Query (dojo/io-query)
------------------------
* :ref:`dojo.objectToQuery <dojo/objectToQuery>`

  Takes a name/value mapping object and returns a string representing a URL-encoded version of that object.
  
* :ref:`dojo.queryToObject <dojo/queryToObject>`

  Create an object representing a de-serialized query section of a URL. Query keys with multiple values are returned in an array.

Robot (dojo/robot - dojo/robotx)
--------------------------------
* :ref:`dojo/robot <dojo/robot>`

  Users who use doh+dojo get the added convenience of dojo.mouseMoveAt instead of computing the absolute coordinates of
  their elements themselves.
  
* :ref:`dojo/robotx <dojo/robotx>`

Loads an external app into an iframe and points dojo.doc to the iframe document, allowing the robot to control it

Document Lifecycle - Onload (dojo/ready)
----------------------------------------
* :ref:`dojo.ready <dojo/ready>`

  Call functions after the DOM has finished loading and widgets declared in markup have been instantiated. When using
  AMD, in most situations the loader plugin :ref:`dojo/domReady <dojo/domReady>` is preferable.

AJAX I/O transports (dojo/io/\*)
--------------------------------
* :ref:`dojo.io.iframe <dojo/io/iframe>`

  Sends an AJAX I/O call using an IFrame

* :ref:`dojo.io.script <dojo/io/script>`

  Sends a JSONP request using a script tag

AJAX RPC transports (dojo/rpc/\*)
---------------------------------
* :ref:`dojo.rpc <dojo/rpc>`

  Communicate via Remote Procedure Calls (RPC) with Backend Servers

* :ref:`dojo.rpc.JsonpService <dojo/rpc/JsonpService>`

  Generic JSONP service

* :ref:`dojo.rpc.JsonService <dojo/rpc/JsonService>`

  JSON RPC service

* :ref:`dojo.rpc.RpcService <dojo/rpc/RpcService>`

  RPC service class

Query (dojo/query)
------------------
* :ref:`dojo.query <dojo/query>`

  The swiss army knife of DOM node manipulation in Dojo.

Selectors (dojo/selector/\*)
----------------------------

The different selector engines that are available in Dojo.

* :ref:`dojo/selector/_loader <dojo/selector/_loader>` **STUB**

  This module handles loading the appropriate selector engine for the given browser

* :ref:`dojo/selector/acme <dojo/selector/acme>` **STUB**

  This is the default selector engine for Dojo.

* :ref:`dojo/selector/lite <dojo/selector/lite>` **STUB**

  A small lightweight query selector engine that implements CSS2.1 selectors minus pseudo-classes and the sibling
  combinator, plus CSS3 attribute selectors.

NodeList (dojo/NodeList-\*)
---------------------------

Various modules that wrap DOM nodes and provide enhanced functionality and management.

* :ref:`dojo.NodeList <dojo/NodeList>`

  A class to handle a list of DOM nodes. Most commonly returned from a `dojo.query` call.

* :ref:`NodeList.instantiate <dojo/NodeList>`

  Create classes out of each node in the list

* :ref:`dojo.NodeList-data <dojo/NodeList-data>`

  Adds a ``.data()`` and ``.removeData()`` API to :ref:`dojo.query <dojo/query>` operations

* :ref:`dojo.NodeList-fx <dojo/NodeList-fx>`

  Adds ``dojo.fx`` animation support to ``dojo.query()``.

* :ref:`dojo.NodeList-html <dojo/NodeList-html>`

  Adds a chainable html method to dojo.query()

* :ref:`dojo.NodeList-manipulate <dojo/NodeList-manipulate>`

  **1.4+** Method extensions to dojo.NodeList/dojo.query() that manipulate HTML.

* :ref:`dojo.NodeList-traverse <dojo/NodeList-traverse>`

  **1.4+** Method extensions to dojo.NodeList/dojo.query() for traversing the DOM.

Browser History (dojo/back - dojo/hash)
---------------------------------------

* :ref:`dojo.back <dojo/back>` (dojo/back)

  Browser history management resources (Back button functionality)

* :ref:`dojo.hash <dojo/hash>` (dojo/hash)
 
  Normalized onhashchange module

Store (dojo/store)
------------------
* :ref:`dojo.store <dojo/store>`

  Dojo Store is an uniform interface for the access and manipulation of stored data that will eventually replace `dojo/data <#data-dojo-data>`_

  * :ref:`dojo.store.Memory <dojo/store/Memory>`

    A data access interface for in memory storage

  * :ref:`dojo.store.JsonRest <dojo/store/JsonRest>`

    A data access interface for a RESTful service providing JSON data

  * :ref:`dojo.store.Observable <dojo/store/Observable>`

    A wrapper for data stores that are observable

  * :ref:`dojo.store.Cache <dojo/store/Cache>`

    A wrapper for data stores that are cacheable

Data (dojo/data)
----------------
* :ref:`dojo.data <dojo/data>`

  The deprecated uniform data access layer

  * :ref:`dojo.data.api <dojo/data/api>`

  * :ref:`dojo.data.api.Read <dojo/data/api/Read>`

  * :ref:`dojo.data.api.Write <dojo/data/api/Write>`

  * :ref:`dojo.data.api.Identity <dojo/data/api/Identity>`

  * :ref:`dojo.data.api.Notification <dojo/data/api/Notification>`

  * :ref:`dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`

  * :ref:`dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`

Cache (dojo/cache)
------------------
* :ref:`dojo.cache <dojo/cache>`

  A mechanism to cache inline text.  This has been deprecated in 1.7 in lieu of the :ref:`dojo/text <dojo/text>` AMD loader plugin.

Date (dojo/date)
----------------
* :ref:`dojo.date <dojo/date>`

  Date manipulation utilities

  * dojo.date.locale

    Offers a library of localization methods to format and parse dates and times

    * :ref:`dojo.date.locale.addCustomFormats <dojo/date/locale/addCustomFormats>`

      Adds a reference to a bundle containing localized custom formats to be used by date/time formatting and parsing routines.

    * :ref:`dojo.date.locale.format <dojo/date/locale/format>`

      Formats a Date object as a String, using locale-specific settings or custom patterns.

    * :ref:`dojo.date.locale.getNames <dojo/date/locale/getNames>`

      Used to get localized strings from dojo.cldr for day or month names.

    * :ref:`dojo.date.locale.isWeekend <dojo/date/locale/isWeekend>`

      Determines if the date falls on a weekend, according to local custom.

    * :ref:`dojo.date.locale.parse <dojo/date/locale/parse>`

      Converts a properly formatted string to a primitive Date object, using locale-specific settings.

    * :ref:`dojo.date.locale.regexp <dojo/date/locale/regexp>`

      Builds the regular needed to parse a localized date

Drag and Drop (dojo/dnd)
------------------------

* :ref:`dojo.dnd <dojo/dnd>`

  Drag and Drop

  * :ref:`dojo.dnd.Moveable <dojo/dnd/Moveable>`

AMD Loader Plugins
------------------

There are several modules that are plugins for the AMD Loader system. Consult the Loader documentation for more
information on :ref:`AMD Loader Plugins <loader/amd#plugins>`.

* :ref:`dojo/domReady <dojo/domReady>`

  Defers execution of the module's factory function until the DOM is ready.

* :ref:`dojo/text <dojo/text>`

  Loads text resources; it is a superset of RequireJS's text plugin, and subsumes ``dojo.cache``.

* :ref:`dojo/i18n <dojo/i18n>`

  Loads i18n bundles either in legacy or AMD format. It includes the legacy i18n API and is a superset of RequireJS's
  i18n plugin.

* :ref:`dojo/has <dojo/has>`

  Allows has.js expressions to be used to conditionally load modules.

* :ref:`dojo/load <dojo/load>`

  A convenience plugin for loading dependencies computed at runtime.

* :ref:`dojo/require <dojo/require>`

  Downloads a legacy module without loading it. This allows the legacy code path to be guaranteed.

* :ref:`dojo/loadInit <dojo/loadInit>`

  Causes ``dojo.loadInit`` callbacks then other legacy API functions to be executed--in particular those that are
  associated with a module.

Miscellaneous Core
------------------

* :ref:`dojo.AdapterRegistry <dojo/AdapterRegistry>`

  A registry to make contextual calling/searching easier

* :ref:`dojo.behavior <dojo/behavior>`

  Utility for unobtrusive/progressive event binding, DOM traversal, and manipulation

* :ref:`dojo.Stateful <dojo/Stateful>`

  Get and set named properties in conjunction with the ability to monitor these properties for changes

* :ref:`dojo.aspect <dojo/aspect>`

  Provides aspect oriented programming facilities to attach additional functionality to existing methods

* :ref:`dojo.cldr <dojo/cldr>`

  A Common Locale Data Repository (CLDR) implementation

* :ref:`dojo.colors <dojo/colors>`

  CSS color manipulation functions

* :ref:`dojo.cookie <dojo/cookie>`

  Simple HTTP cookie manipulation

* :ref:`dojo.currency <dojo/currency>`

  Localized formatting and parsing routines for currency data

* :ref:`dojo.DeferredList <dojo/DeferredList>`

  Event handling for a group of Deferred objects

* :ref:`dojo.fx <dojo/fx>`

  Effects library on top of Base animations

* :ref:`dojo.gears <dojo/gears>`

  Google Gears

* :ref:`dojo.html <dojo/html>`

  Inserting contents in HTML nodes

* :ref:`dojo.i18n <dojo/i18n>`

  Utility classes to enable loading of resources for internationalization

* :ref:`dojo.number <dojo/number>`

  Localized formatting and parsing methods for number data

* :ref:`dojo.parser <dojo/parser>`

  The DOM/Widget parsing package

* :ref:`dojo.regexp <dojo/regexp>`

  Regular expressions and Builder resources

* :ref:`dojo.string <dojo/string>`

  String utilities for Dojo

* :ref:`dojo.mouse <dojo/mouse>`

  Provides extension events for hovering and mouse button utility functions

* :ref:`dojo/on <dojo/on>`

  Provides normalized event listening and event dispatching functionality

* :ref:`dojo/touch <dojo/touch>`

  Provides standardized touch events

* :ref:`dojo.require <dojo/require>`

  Loads a Dojo module, by name

See also
========

* :ref:`Dijit <dijit/index>`

  The widget system layered on top of Dojo

* :ref:`DojoX <dojox/index>`

  An area for development of extensions to the Dojo toolkit
