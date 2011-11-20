.. _dojo/index:

Dojo
====

.. contents::
   :depth: 2

The dojo directory contains three categories of modules:

   * dojo.js - the bootstrap
   * dojo/_base - basic functionality historically pulled in as part of dojo.js, and historically existing directly under the ``dojo`` namespace
   * "dojo core" - more advanced functionality under a sub-namespace under dojo like ``dojo.dnd``

Each category is described in detail below.

=======
dojo.js
=======

This file provides the bootstrap for loading other modules, in particular the ``require()`` function, previously known as ``dojo.require()``.

See the :ref:`loader documentation <loader/index>` for details.

For backwards-compatibility, when dojo.js is included without the async:false configuration flag, all the symbols in dojo/_base
are implicitly loaded.

==========
dojo/_base
==========

The dojo/_base directory contains modules with basic functionality, such as array operations.
Typically, if a function or class exists within the dojo namespace directly (eg: ``dojo.forEach()``) then it is defined in dojo/_base.

However, note that the modules in dojo/_base are being phased out in favor of top level modules in the dojo/ directory.
The dojo/_base files will be maintained until the 2.0 release.   See details below for replacement modules.
 

Configuring Dojo (dojo/_base/config)
------------------------------------

* :ref:`dojoConfig (dojo/_base/config) <dojo/config>`

  Possibility to override certain global settings that control how the framework operates

Array utilities (dojo/_base/array)
----------------------------------

Details on dojo.every, dojo.filter, dojo.forEach, dojo.indexOf, dojo.lastIndexOf, dojo.map, and dojo.some. See the :ref:`Array QuickStart <quickstart/arrays>` for an overview.

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

HTML Utility (dojo/_base/html)
------------------------------
The :ref:`dojo/_base/html <dojo/_base/html>` module contains basic DOM & HTML handling functions for backward compatibility purpose.

New code should use the dojo/dom* modules (see "Dojo core" section below for details).

Deferred Utility (dojo/_base/Deferred)
--------------------------------------
* :ref:`dojo.Deferred <dojo/Deferred>`

  Communication between asynchronous calls

Kernel (dojo/_base/kernel)
--------------------------

from 1.7 + dojo/_base/kernel module collects following part of dojo APIs

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

This module provides event handling for DOM nodes, and AOP for functions.   However, it is superceded by the :ref:`dojo/on <dojo/on>`, :ref:`dojo/aspect <dojo/aspect>`, and :ref:`dojo/topic <dojo/topic>` modules, which should be used for new code.

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

  Ensure that everytime an event is called, a message is published on the topic.

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

* :ref:`dojo.addOnUnload <dojo/addOnUnload>`

  Call functions when the page unloads

* :ref:`dojo.addOnWindowUnload <dojo/addOnWindowUnload>`

  Call functions when window.onunload fires

* :ref:`dojo.windowUnloaded <dojo/windowUnloaded>`

  Signal fired by impending window destruction

Ajax / XHR (dojo/_base/xhr)
---------------------------

* :ref:`IO Pipeline Topics <dojo/ioPipelineTopics>`

* :ref:`dojo.contentHandlers <dojo/contentHandlers>`

  **1.4+** Pre-defined XHR content handlers, and an extension point to add your own custom handling.

* :ref:`dojo.xhr <dojo/xhr>`

  Core for all xhr* verbs, eg: xhrPost, getGet

* :ref:`dojo.xhrDelete <dojo/xhrDelete>`

* :ref:`dojo.xhrGet <dojo/xhrGet>`

* :ref:`dojo.xhrPost <dojo/xhrPost>`

* :ref:`dojo.xhrPut <dojo/xhrPut>`

* :ref:`dojo.rawXhrPost <dojo/rawXhrPost>`

* :ref:`dojo.rawXhrPut <dojo/rawXhrPut>`

Package System (defined in dojo/_base/loader)
---------------------------------------------

This module is defining deprecated symbols for loading.   See the :ref:`loader documentation <loader/index>` for details on new replacement API's.

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

Objects / OO Tool (dojo/_base/declare)
--------------------------------------

* :ref:`dojo.declare (dojo/_base/declare) <dojo/declare>`

  Creates a constructor using a compact notation for inheritance and prototype extension


Colors
------

* :ref:`dojo._base.Color <dojo/_base/Color>`

  Color object and utility functions to handle colors.
  Details on

* dojo.colorFromArray

* dojo.colorFromHex

* dojo.colorFromString

* dojo.colorFromRgb.


Miscellaneous Base
------------------

* :ref:`dojo.global <dojo/global>`

  Alias for the global scope

* :ref:`dojo.keys <dojo/keys>`

  A collection of key constants.

* :ref:`dojo._Url <dojo/Url>`

  dojo._Url is used to manage the url object.

* :ref:`dojo/_base/sniff <quickstart/browser-sniffing>`

  dojo/_base/sniff is introduced in dojo 1.7 as the browser detection utility.

=========
Dojo Core
=========

If the function or class exists beneath the dojo namespace (eg: ``dojo.dnd.Mover``), it is defined in "dojo core" and you will need to require the appropriate module (eg: ``dojo.require("dojo.dnd.Mover");``) to use it.

DOM (dojo/dom*)
---------------
from 1.7 + dojo/dom module collects following part of dojo APIs

* :ref:`dojo.byId <dojo/byId>`

  Select a DOM node by 'id'.

* dojo.isDescendant

* dojo.setSelectable

* Manipulation (dojo/dom-construct)

  * dojo.toDom

    Instantiates an HTML fragment returning the corresponding DOM.

  * :ref:`dojo.create <dojo/create>`

    Creates a dom node with optional values and placement

  * :ref:`dojo.place <dojo/place>`

    Place DOM nodes relative to others

  * :ref:`dojo.destroy <dojo/destroy>`

    Destroy a DOM element

  * :ref:`dojo.empty <dojo/empty>`

    Empty the contents of a DOM element


* Attributes (dojo/dom-attr)

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

* Form (dojo/dom-form)

  * :ref:`dojo.fieldToObject <dojo/fieldToObject>`

    Serialize a form field to a JavaScript object.

  * :ref:`dojo.formToJson <dojo/formToJson>`

    Create an object from an form node

  * :ref:`dojo.formToObject <dojo/formToObject>`

    Serialize a form node to a JavaScript object.

  * :ref:`dojo.formToQuery <dojo/formToQuery>`

    Returns a URL-encoded string representing the form passed as either a node or string ID identifying the form to serialize

* Styles (dojo/dom-style)

  * :ref:`dojo.style <dojo/style>`

    A getter/setter for styles on a DOM node

  * :ref:`dojo.getComputedStyle <dojo/getComputedStyle>`

    Return a cachable object of all computed styles for a node

  * :ref:`dojo.getStyle <dojo/getStyle>`

    Accesses styles on a node.

  * :ref:`dojo.setStyle <dojo/setStyle>`

    Sets styles on a node.

* Class (dojo/dom-class)

  * :ref:`dojo.hasClass <dojo/hasClass>`

    Returns a boolean depending on whether or not a node has a passed class string.

  * :ref:`dojo.addClass <dojo/addClass>`

    Adds a CSS class to a node.

  * :ref:`dojo.removeClass <dojo/removeClass>`

    Removes a class from a Node.

  * :ref:`dojo.toggleClass <dojo/toggleClass>`

    Toggles a className (or now in 1.4 an array of classNames).

  * :ref:`dojo.replaceClass <dojo/replaceClass>`

    Replaces one or more classes on a node if not present. Operates more quickly than calling dojo.removeClass and dojo.addClass

* Geometry (dojo/dom-geometry)

  * :ref:`dojo.coords <dojo/coords>`

    Getter for the coordinates (relative to parent and absolute) of a DOM node.  Deprecated in Dojo 1.4.

  * :ref:`dojo.position <dojo/position>`

    Getter for the border-box x/y coordinates and size of a DOM node.
  
  * :ref:`dojo.marginBox <dojo/marginBox>`

    Getter/setter for the margin-box of node

  * :ref:`dojo.contentBox <dojo/contentBox>`

    Getter/setter for the content-box of node

  * :ref:`dojo.getMarginBox <dojo.getMarginBox>`

    Get an object that encodes the width, height, left and top positions of the node's margin box.

  * :ref:`dojo.setMarginBox <dojo.setMarginBox>`

    Sets the size of the node's margin box and placement (left/top), irrespective of box model.

  * :ref:`dojo.getContentBox <dojo.getContentBox>`

    Get an object that encodes the width, height, left and top positions of the node's content box, irrespective of the current box model.

  * :ref:`dojo.setContentSize <dojo.setContentSize>`

    Sets the size of the node's contents, irrespective of margins, padding, or borders.

* Property (dojo/dom-prop)

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
  
Robot (dojo/robot & dojo/robotx)
--------------------------------
* :ref:`dojo/robot <dojo/robot>`

  Users who use doh+dojo get the added convenience of dojo.mouseMoveAt instead of computing the absolute coordinates of their
  elements themselves
  
* :ref:`dojo/robotx <dojo/robotx>`

  Loads an external app into an iframe and points dojo.doc to the iframe document, allowing the robot to control it

Document Lifecycle - Onload (dojo/ready)
----------------------------------------
* :ref:`dojo.addOnLoad <dojo/addOnLoad>`

  Call functions after the DOM has finished loading and widgets declared in markup have been instantiated

* :ref:`dojo.ready <dojo/ready>`

  **1.4+** Alias for :ref:`dojo.addOnLoad <dojo/addOnLoad>`

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

NodeList (dojo/NodeList-\*)
---------------------------
* :ref:`dojo.NodeList <dojo/NodeList>`

  A class to handle a list of DOM nodes. Most commonly returned from a `dojo.query` call.

* :ref:`NodeList.instantiate <dojo/NodeList>`

  Create classes out of each node in the list

* :ref:`dojo.NodeList-data <dojo/NodeList-data>`

  Adds a .data() and .removeData() API to :ref:`dojo.query <dojo/query>` operations

* :ref:`dojo.NodeList-fx <dojo/NodeList-fx>`

  Adds dojo.fx animation support to dojo.query()

* :ref:`dojo.NodeList-html <dojo/NodeList-html>`

  Adds a chainable html method to dojo.query()

* :ref:`dojo.NodeList-manipulate <dojo/NodeList-manipulate>`

  **1.4+** Method extensions to dojo.NodeList/dojo.query() that manipulate HTML.

* :ref:`dojo.NodeList-traverse <dojo/NodeList-traverse>`

  **1.4+** Method extensions to dojo.NodeList/dojo.query() for traversing the DOM.

Browser's History (dojo/back & dojo/hash)
-----------------------------------------
* :ref:`dojo.back <dojo/back>` (dojo/back)

  Browser history management resources (Back button functionality)

* :ref:`dojo.hash <dojo/hash>` (dojo/hash)
 
  Normalized onhashchange module

Data (dojo/data)
----------------
* :ref:`dojo.data <dojo/data>`

  A uniform data access layer

  * :ref:`dojo.data.api <dojo/data/api>`

  * :ref:`dojo.data.api.Read <dojo/data/api/Read>`

  * :ref:`dojo.data.api.Write <dojo/data/api/Write>`

  * :ref:`dojo.data.api.Identity <dojo/data/api/Identity>`

  * :ref:`dojo.data.api.Notification <dojo/data/api/Notification>`

  * :ref:`dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`

  * :ref:`dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`

Store (dojo/store)
------------------
* :ref:`dojo.store <dojo/store>`

  **1.6+** Dojo Store is an uniform interface for the access and manipulation of stored data that will eventually replace :ref:`dojo.data <dojo/data>`

  * :ref:`dojo.store.Memory <dojo/store/Memory>`

    A data access interface for in memory storage

  * :ref:`dojo.store.JsonRest <dojo/store/JsonRest>`

    A data access interface for a RESTful service providing JSON data

  * :ref:`dojo.store.Observable <dojo/store/Observable>`

    A wrapper for data stores that are observable

  * :ref:`dojo.store.Cache <dojo/store/Cache>`

    A wrapper for data stores that are cacheable

Cache (dojo/cache)
------------------
* :ref:`dojo.cache <dojo/cache>`

  **1.4+** A mechanism to cache inline text.

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

DND (dojo/dnd)
--------------
* :ref:`dojo.dnd <dojo/dnd>`

  Drag and Drop

  * :ref:`dojo.dnd.Moveable <dojo/dnd/Moveable>`

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

* :ref:`dojo.jaxer <dojo/jaxer>`

* :ref:`dojo.number <dojo/number>`

  Localized formatting and parsing methods for number data

* :ref:`dojo.parser <dojo/parser>`

  The Dom/Widget parsing package

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

========
See also
========

* :ref:`Dijit <dijit/index>`

  The widget system layered on top of Dojo

* :ref:`DojoX <dojox/index>`

  An area for development of extensions to the Dojo toolkit
