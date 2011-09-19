## page was renamed from 1.2/dojo
#format dojo_rst

Dojo
====

.. contents::
   :depth: 2

Dojo is divided into two parts: ``dojo.js``, and the rest of Dojo Core. Typically, if a function or Class exists within the dojo namespace directly (eg: ``dojo.require()``, ``dojo.addOnLoad()``) it is provided directly by ``dojo.js``. If the function or Class exists beneath the dojo namespace (eg: ``dojo.dnd.Mover``), you will need to require the appropriate module (eg: ``dojo.require("dojo.dnd.Mover");``)

These pages cover both cases, and indicate how they are provided.

==================
Base Dojo: dojo.js
==================

Dojo Base is the functionality you get by just including a stock built dojo.js or dojo.xd.js in your page.

Configuring Dojo (dojo/_base/config)
------------------------------------

* `dojoConfig (dojo/_base/config) <dojo/config>`_

  Possibility to override certain global settings that control how the framework operates

Array utilities (dojo/_base/array)
----------------------------------

Details on dojo.every, dojo.filter, dojo.forEach, dojo.indexOf, dojo.lastIndexOf, dojo.map, and dojo.some. See the `Array QuickStart <quickstart/arrays>`_ for an overview.

* `dojo.forEach <dojo/forEach>`_

  Invokes a callback function for every item in array

* `dojo.map <dojo/map>`_

  Applies a callback to each element of arr and returns an Array with the results

* `dojo.some <dojo/some>`_

  Iterate over an array, escaping when the callback returns true for some logic check.

* `dojo.every <dojo/every>`_

  Iterate over an array, escaping when the callback returns false for some logic check.

* `dojo.filter <dojo/filter>`_

  Iterate over an array, reducing the array based on the callback return.

* `dojo.indexOf <dojo/indexOf>`_

  Find the index of some element in an Array.

* `NodeList array methods <dojo/NodeList#array>`_

  * NodeList.indexOf, NodeList.lastIndexOf, NodeList.forEach, NodeList.every, NodeList.some, NodeList.concat, NodeList.map, NodeList.filter, NodeList.at

Language Utilities (dojo/_base/lang)
------------------------------------
* `dojo.hitch <dojo/hitch>`_

  Function that generates a wrapper function that ensures a function that will only ever execute in a defined scope.

* `dojo.partial <dojo/partial>`_

  Function that generates a wrapper function that ensures a function will only ever execute globally.

* `dojo.clone <dojo/clone>`_

  Clones objects (including DOM nodes) and all children.

* `dojo.delegate <dojo/delegate>`_

  Returns a new object which "looks" to obj for properties which it does not have a value for.

* `dojo.isString <dojo/isString>`_

  Checks if the parameter is a String

* `dojo.isArray <dojo/isArray>`_

  Checks if the parameter is an Array

* `dojo.isFunction <dojo/isFunction>`_

  Checks if the parameter is a Function

* `dojo.isObject <dojo/isObject>`_

  Checks if the parameter is an Object

* `dojo.isArrayLike <dojo/isArrayLike>`_

  Checks if the parameter is like an Array

* `dojo.isAlien <dojo/isAlien>`_

  Checks if the parameter is a built-in function

* `dojo.trim <dojo/trim>`_

  Trim whitespace from a String

* `dojo.replace <dojo/replace>`_

  Simple templates with parameterized substitutions.

* `dojo.mixin <dojo/mixin>`_

  Mixes one object into another. Can be used as a shallow copy

* `dojo.extend <dojo/extend>`_

* `dojo.getObject <dojo/getObject>`_

  Get a property from a dot-separated string, such as "A.B.C"

* `dojo.setObject <dojo/setObject>`_

  Set a property from a dot-separated string, such as "A.B.C"

* `dojo.exists <dojo/exists>`_

  Determine if an object supports a given method

HTML Utility (dojo/_base/html)
------------------------------
* `dojo/_base/html <dojo/_base/html>`_

  **dojo/_base/html** module contains basic DOM & HTML handling functions for backward compatibility purpose.

Deferred Utility (dojo/_base/Deferred)
--------------------------------------
* `dojo.Deferred <dojo/Deferred>`_

  Communication between asynchronous calls

Kernel (dojo/_base/kernel)
--------------------------

from 1.7 + dojo/_base/kernel module collects following part of dojo APIs

* `dojo.deprecated <dojo/deprecated>`_

  Log a debug message to indicate that a behavior has been deprecated

* `dojo.eval <dojo/eval>`_

  Evaluate some string of JavaScript

* `dojo.locale <dojo/locale>`_

  A string containing the current locale as defined by Dojo

* `dojo.moduleUrl <dojo/moduleUrl>`_

  Returns a URL relative to a module

* `dojo.version <dojo/version>`_

  The current version number of Dojo

Window (dojo/_base/window)
--------------------------

from 1.7 + dojo/_base/window module collects following part of dojo APIs

* `dojo.doc <dojo/doc>`_

  Alias for the current document.

* `dojo.body <dojo/body>`_

  Return the body element of the document

* `dojo.setContext <dojo/setContext>`_

  Changes the behavior of many core Dojo functions that deal with namespace and DOM lookup

* `dojo.withGlobal <dojo/withGlobal>`_

  Call callback with globalObject as dojo.global and globalObject.document as dojo.doc

* `dojo.withDoc <dojo/withDoc>`_

  Call callback with documentObject as dojo.doc

Effects (dojo/_base/fx)
-----------------------

* `dojo.animateProperty <dojo/animateProperty>`_

  The workhorse of most `dojo.fx <dojo/fx>`_ animations. Used for animating CSS properties

* `dojo.Animation <dojo/Animation>`_

  **1.4+** previously dojo._Animation, the class behind all dojo.fx

* `dojo.anim <dojo/anim>`_

  Shorthand version of animateProperty using positional arguments

* `dojo.fadeOut <dojo/fadeOut>`_

* `dojo.fadeIn <dojo/fadeIn>`_

Connect (dojo/_base/connect)
----------------------------

* `dojo.connect <dojo/connect>`_

  Connects events to methods

* `dojo.disconnect <dojo/disconnect>`_

  Disconnects methods from linked topics

* `dojo.subscribe <dojo/subscribe>`_

  Linked a listener to a named topic

* `dojo.unsubscribe <dojo/unsubscribe>`_

  Remove a topic listener

* `dojo.publish <dojo/publish>`_

  Publish an event to all subscribers of a topic

* `dojo.connectPublisher <dojo/connectPublisher>`_

  Ensure that everytime an event is called, a message is published on the topic.

NodeList (dojo/_base/NodeList)
------------------------------
* `NodeList.connect <dojo/NodeList#connect>`_

  Connects events to every node in the list, like dojo.connect

* `NodeList.events <dojo/NodeList#events>`_

  Common event names mapped as functions on a NodeList - eg: .onclick(function(){})

Event (dojo/_base/event)
------------------------
* `dojo/_base/event <dojo/_base/event>`_

  Defines dojo DOM event API.

Document Lifecycle - Unload (dojo/_base/unload)
-----------------------------------------------

* `dojo.addOnUnload <dojo/addOnUnload>`_

  Call functions when the page unloads

* `dojo.addOnWindowUnload <dojo/addOnWindowUnload>`_

  Call functions when window.onunload fires

* `dojo.windowUnloaded <dojo/windowUnloaded>`_

  Signal fired by impending window destruction

Ajax / XHR (dojo/_base/xhr)
---------------------------

* `IO Pipeline Topics <dojo/ioPipelineTopics>`_

* `dojo.contentHandlers <dojo/contentHandlers>`_

  **1.4+** Pre-defined XHR content handlers, and an extension point to add your own custom handling.

* `dojo.xhr <dojo/xhr>`_

  Core for all xhr* verbs, eg: xhrPost, getGet

* `dojo.xhrDelete <dojo/xhrDelete>`_

* `dojo.xhrGet <dojo/xhrGet>`_

* `dojo.xhrPost <dojo/xhrPost>`_

* `dojo.xhrPut <dojo/xhrPut>`_

* `dojo.rawXhrPost <dojo/rawXhrPost>`_

* `dojo.rawXhrPut <dojo/rawXhrPut>`_

Package System (defined in dojo/_base/loader)
---------------------------------------------

* `dojo.registerModulePath <dojo/registerModulePath>`_

  Maps module name to a path

* `dojo.require <dojo/require>`_

  Loads a Javascript module from the appropriate URI

* `dojo.provide <dojo/provide>`_

JSON Tools (dojo/_base/json)
----------------------------

* `dojo.fromJson <dojo/fromJson>`_

  Parses a JSON string to return a JavaScript object

* `dojo.toJson <dojo/toJson>`_

  Returns a JSON serialization of an object

Objects / OO Tool (dojo/_base/declare)
--------------------------------------

* `dojo.declare (dojo/_base/declare) <dojo/declare>`_

  Creates a constructor using a compact notation for inheritance and prototype extension


Colors
------

* `dojo._base.Color <dojo/_base/Color>`_

  Color object and utility functions to handle colors.
  Details on

* dojo.colorFromArray

* dojo.colorFromHex

* dojo.colorFromString

* dojo.colorFromRgb.


Miscellaneous Base
------------------

* `dojo.global <dojo/global>`_

  Alias for the global scope

* `dojo.keys <dojo/keys>`_

  A collection of key constants.

* `dojo._Url <dojo/Url>`_

  dojo._Url is used to manage the url object.

* `dojo/_base/sniff <quickstart/browser-sniffing>`_

  dojo/_base/sniff is introduced in dojo 1.7 as the browser detection utility.

=========
Dojo Core
=========

DOM (dojo/dom*)
---------------
from 1.7 + dojo/dom module collects following part of dojo APIs

* `dojo.byId <dojo/byId>`_

  Select a DOM node by 'id'.

* dojo.isDescendant

* dojo.setSelectable

* Manipulation (dojo/dom-construct)

  * dojo.toDom

    Instantiates an HTML fragment returning the corresponding DOM.

  * `dojo.create <dojo/create>`_

    Creates a dom node with optional values and placement

  * `dojo.place <dojo/place>`_

    Place DOM nodes relative to others

  * `dojo.destroy <dojo/destroy>`_

    Destroy a DOM element

  * `dojo.empty <dojo/empty>`_

    Empty the contents of a DOM element


* Attributes (dojo/dom-attr)

  * `dojo.attr <dojo/attr>`_

    Modifying DOM node attributes

  * `dojo.getAttr <dojo/getAttr>`_

    Gets an attribute on an HTML element.

  * `dojo.setAttr <dojo/setAttr>`_

    Sets an attribute on an HTML element.

  * `dojo.hasAttr <dojo/hasAttr>`_

    Returns true if the requested attribute is specified on the given element, and false otherwise.

  * `dojo.removeAttr <dojo/removeAttr>`_

    Removes an attribute from an HTML element.

  * `dojo.getNodeProp <dojo/getNodeProp>`_

    Returns an effective value of a property or an attribute.

* Form (dojo/dom-form)

  * `dojo.fieldToObject <dojo/fieldToObject>`_

    Serialize a form field to a JavaScript object.

  * `dojo.formToJson <dojo/formToJson>`_

    Create an object from an form node

  * `dojo.formToObject <dojo/formToObject>`_

    Serialize a form node to a JavaScript object.

  * `dojo.formToQuery <dojo/formToQuery>`_

    Returns a URL-encoded string representing the form passed as either a node or string ID identifying the form to serialize

* Styles (dojo/dom-style)

  * `dojo.style <dojo/style>`_

    A getter/setter for styles on a DOM node

  * `dojo.getComputedStyle <dojo/getComputedStyle>`_

    Return a cachable object of all computed styles for a node

  * `dojo.getStyle <dojo/getStyle>`_

    Accesses styles on a node.

  * `dojo.setStyle <dojo/setStyle>`_

    Sets styles on a node.

* Class (dojo/dom-class)

  * `dojo.hasClass <dojo/hasClass>`_

    Returns a boolean depending on whether or not a node has a passed class string.

  * `dojo.addClass <dojo/addClass>`_

    Adds a CSS class to a node.

  * `dojo.removeClass <dojo/removeClass>`_

    Removes a class from a Node.

  * `dojo.toggleClass <dojo/toggleClass>`_

    Toggles a className (or now in 1.4 an array of classNames).

  * `dojo.replaceClass <dojo/replaceClass>`_

    Replaces one or more classes on a node if not present. Operates more quickly than calling dojo.removeClass and dojo.addClass 

* Geometry (dojo/dom-geometry)

  * `dojo.coords <dojo/coords>`_

    Getter for the coordinates (relative to parent and absolute) of a DOM node.  Deprecated in Dojo 1.4.

  * `dojo.position <dojo/position>`_

    Getter for the border-box x/y coordinates and size of a DOM node.
  
  * `dojo.marginBox <dojo/marginBox>`_

    Getter/setter for the margin-box of node

  * `dojo.contentBox <dojo/contentBox>`_

    Getter/setter for the content-box of node

  * `dojo.getMarginBox <dojo.getMarginBox>`_

    Get an object that encodes the width, height, left and top positions of the node's margin box. 

  * `dojo.setMarginBox <dojo.setMarginBox>`_ 

    Sets the size of the node's margin box and placement (left/top), irrespective of box model. 

  * `dojo.getContentBox <dojo.getContentBox>`_

    Get an object that encodes the width, height, left and top positions of the node's content box, irrespective of the current box model. 

  * `dojo.setContentSize <dojo.setContentSize>`_ 

    Sets the size of the node's contents, irrespective of margins, padding, or borders. 

* Property (dojo/dom-prop)

  * `dojo.prop <dojo/prop>`_

    Gets or sets a property on an HTML element.

  * `dojo.getProp <dojo/getProp>`_

    Gets a property on an HTML element. 

  * `dojo.setProp <dojo/setProp>`_

    Sets a property on an HTML element.
    
    
IO-Query (dojo/io-query)
------------------------
* `dojo.objectToQuery <dojo/objectToQuery>`_

  Takes a name/value mapping object and returns a string representing a URL-encoded version of that object.
  
* `dojo.queryToObject <dojo/queryToObject>`_

  Create an object representing a de-serialized query section of a URL. Query keys with multiple values are returned in an array.
  
Robot (dojo/robot & dojo/robotx)
--------------------------------
* `dojo/robot <dojo/robot>`_

  Users who use doh+dojo get the added convenience of dojo.mouseMoveAt instead of computing the absolute coordinates of their
  elements themselves
  
* `dojo/robotx <dojo/robotx>`_

  Loads an external app into an iframe and points dojo.doc to the iframe document, allowing the robot to control it

Document Lifecycle - Onload (dojo/ready)
----------------------------------------
* `dojo.addOnLoad <dojo/addOnLoad>`_

  Call functions after the DOM has finished loading and widgets declared in markup have been instantiated

* `dojo.ready <dojo/ready>`_

  **1.4+** Alias for `dojo.addOnLoad <dojo/addOnLoad>`_

AJAX I/O transports (dojo/io/\*)
--------------------------------
* `dojo.io.iframe <dojo/io/iframe>`_

  Sends an AJAX I/O call using an IFrame

* `dojo.io.script <dojo/io/script>`_

  Sends a JSONP request using a script tag

AJAX RPC transports (dojo/rpc/\*)
---------------------------------
* `dojo.rpc <dojo/rpc>`_

  Communicate via Remote Procedure Calls (RPC) with Backend Servers

* `dojo.rpc.JsonpService <dojo/rpc/JsonpService>`_

  Generic JSONP service

* `dojo.rpc.JsonService <dojo/rpc/JsonService>`_

  JSON RPC service

* `dojo.rpc.RpcService <dojo/rpc/RpcService>`_

  RPC service class

Query (dojo/query)
------------------
* `dojo.query <dojo/query>`_

  The swiss army knife of DOM node manipulation in Dojo.

NodeList (dojo/NodeList-\*)
---------------------------
* `dojo.NodeList <dojo/NodeList>`_

  A class to handle a list of DOM nodes. Most commonly returned from a `dojo.query` call.

* `NodeList.instantiate <dojo/NodeList#instantiate>`_

  Create classes out of each node in the list

* `dojo.NodeList-data <dojo/NodeList-data>`_

  Adds a .data() and .removeData() API to `dojo.query <dojo/query>`_ operations

* `dojo.NodeList-fx <dojo/NodeList-fx>`_

  Adds dojo.fx animation support to dojo.query()

* `dojo.NodeList-html <dojo/NodeList-html>`_

  Adds a chainable html method to dojo.query()

* `dojo.NodeList-manipulate <dojo/NodeList-manipulate>`_

  **1.4+** Method extensions to dojo.NodeList/dojo.query() that manipulate HTML.

* `dojo.NodeList-traverse <dojo/NodeList-traverse>`_

  **1.4+** Method extensions to dojo.NodeList/dojo.query() for traversing the DOM.

Browser's History (dojo/back & dojo/hash)
-----------------------------------------
* `dojo.back <dojo/back>`_ (dojo/back)

  Browser history management resources (Back button functionality)

* `dojo.hash <dojo/hash>`_ (dojo/hash)
 
  Normalized onhashchange module

Data (dojo/data)
----------------
* `dojo.data <dojo/data>`_

  A uniform data access layer

  * `dojo.data.api <dojo/data/api>`_

  * `dojo.data.api.Read <dojo/data/api/Read>`_

  * `dojo.data.api.Write <dojo/data/api/Write>`_

  * `dojo.data.api.Identity <dojo/data/api/Identity>`_

  * `dojo.data.api.Notification <dojo/data/api/Notification>`_

  * `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_

  * `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_

Store (dojo/store)
------------------
* `dojo.store <dojo/store>`_

  **1.6+** Dojo Store is an uniform interface for the access and manipulation of stored data that will eventually replace `dojo.data <dojo/data>`_

  * `dojo.store.Memory <dojo/store/Memory>`_

    A data access interface for in memory storage

  * `dojo.store.JsonRest <dojo/store/JsonRest>`_

    A data access interface for a RESTful service providing JSON data

  * `dojo.store.Observable <dojo/store/Observable>`_

    A wrapper for data stores that are observable

  * `dojo.store.Cache <dojo/store/Cache>`_

    A wrapper for data stores that are cacheable

Cache (dojo/cache)
------------------
* `dojo.cache <dojo/cache>`_

  **1.4+** A mechanism to cache inline text.

Date (dojo/date)
----------------
* `dojo.date <dojo/date>`_

  Date manipulation utilities

  * dojo.date.locale

    Offers a library of localization methods to format and parse dates and times

    * `dojo.date.locale.addCustomFormats <dojo/date/locale/addCustomFormats>`_

      Adds a reference to a bundle containing localized custom formats to be used by date/time formatting and parsing routines.

    * `dojo.date.locale.format <dojo/date/locale/format>`_

      Formats a Date object as a String, using locale-specific settings or custom patterns.

    * `dojo.date.locale.getNames <dojo/date/locale/getNames>`_

      Used to get localized strings from dojo.cldr for day or month names.

    * `dojo.date.locale.isWeekend <dojo/date/locale/isWeekend>`_

      Determines if the date falls on a weekend, according to local custom.

    * `dojo.date.locale.parse <dojo/date/locale/parse>`_

      Converts a properly formatted string to a primitive Date object, using locale-specific settings.

    * `dojo.date.locale.regexp <dojo/date/locale/regexp>`_

      Builds the regular needed to parse a localized date

Miscellaneous Core
------------------

* `dojo.AdapterRegistry <dojo/AdapterRegistry>`_

  A registry to make contextual calling/searching easier

* `dojo.behavior <dojo/behavior>`_

  Utility for unobtrusive/progressive event binding, DOM traversal, and manipulation

* `dojo.cldr <dojo/cldr>`_

  A Common Locale Data Repository (CLDR) implementation

* `dojo.colors <dojo/colors>`_

  CSS color manipulation functions

* `dojo.cookie <dojo/cookie>`_

  Simple HTTP cookie manipulation

* `dojo.currency <dojo/currency>`_

  Localized formatting and parsing routines for currency data

* `dojo.DeferredList <dojo/DeferredList>`_

  Event handling for a group of Deferred objects

* `dojo.dnd <dojo/dnd>`_

  Drag and Drop

  * `dojo.dnd.Moveable <dojo/dnd/Moveable>`_

* `dojo.fx <dojo/fx>`_

  Effects library on top of Base animations

* `dojo.gears <dojo/gears>`_

  Google Gears

* `dojo.html <dojo/html>`_

  Inserting contents in HTML nodes

* `dojo.i18n <dojo/i18n>`_

  Utility classes to enable loading of resources for internationalization

* `dojo.jaxer <dojo/jaxer>`_

* `dojo.number <dojo/number>`_

  Localized formatting and parsing methods for number data

* `dojo.parser <dojo/parser>`_

  The Dom/Widget parsing package

* `dojo.regexp <dojo/regexp>`_

  Regular expressions and Builder resources

* `dojo.string <dojo/string>`_

  String utilities for Dojo


========
See also
========

* `Dijit <dijit/index>`__

  The widget system layered on top of Dojo

* `DojoX <dojox/index>`__

  An area for development of extensions to the Dojo toolkit
