## page was renamed from 1.2/dojo
#format dojo_rst

Dojo
====

:Status: Draft
:Version: 1.0
:Available: since version 0.9

.. contents::
   :depth: 2

Dojo is divided into two parts: ``dojo.js``, and the rest of Dojo Core. Typically, if a function or Class exists within the dojo namespace directly (eg: ``dojo.require()``, ``dojo.addOnLoad()``) it is provided directly by ``dojo.js``. If the function or Class exists beneath the dojo namespace (eg: ``dojo.dnd.Mover``), you will need to require the appropriate module (eg: ``dojo.require("dojo.dnd.Mover");``)

These pages cover both cases, and indicate how they are provided.

==================
Base Dojo: dojo.js
==================

Dojo Base is the functionality you get by just including a stock built dojo.js or dojo.xd.js in your page.

`djConfig <djConfig>`_
----------------------

  Configuring Dojo with djConfig

Array utilities
---------------

  Details on dojo.every, dojo.filter, dojo.forEach, dojo.indexOf, dojo.lastIndexOf, dojo.map, and dojo.some.

  * `dojo.forEach <dojo/forEach>`_

    Invokes a callback function for every item in array

  * `dojo.map <dojo/map>`_

    Applies a callback to each element of arr and returns an Array with the results
    
  * `NodeList array methods <dojo/NodeList#array>`_
  
    * NodeList.indexOf, NodeList.lastIndexOf, NodeList.forEach, NodeList.every, NodeList.some, NodeList.concat, NodeList.map, NodeList.filter, NodeList.at

Language Utilities
------------------

  * `dojo.Deferred <dojo/Deferred>`_

    Communication between threads

  * `dojo.hitch <dojo/hitch>`_
  
    Function that generates a wrapper function that ensures a function that will only ever execute in a defined scope.
    
  * `dojo.partial <dojo/partial>`_
    
    Function that generates a wrapper function that ensures a function will only ever execute globally.

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
  
DOM 
---

  * `dojo.query <dojo/query>`_

    The swiss army knife of DOM node manipulation in Dojo. 
  
  * `dojo.NodeList <dojo/NodeList>`_

    A class to handle a list of DOM nodes. Most commonly returned from a `dojo.query` call.

  * `dojo.doc <dojo/doc>`_

    Alias for the current document

  * `dojo.body <dojo/body>`_

    Return the body element of the document

  * `dojo.byId <dojo/byId>`_

    Select a DOM node by 'id'

  * Manipulation

    * `dojo.create <dojo/create>`_

      Creates a dom node with optional values and placement

    * `dojo.place <dojo/place>`_

      Place DOM nodes relative to others
      
    * NodeList.place
        
      Place DOM nodes in list relative to others

    * NodeList.orphan 
    
    * NodeList.adopt
    
    * NodeList.clone
    
    * NodeList.addContent
    
    * `dojo.destroy <dojo/destroy>`_
    
      Destroy a DOM element
    
    * NodeList.destroy

      
    * `dojo.empty <dojo/empty>`_
    
      Empty the contents of a DOM element

    * NodeList.empty 



  * Attributes

    * `dojo.formToJson <dojo/formToJson>`_
    
      Create an object from an form node
      
    * `dojo.attr <dojo/attr>`_

      Modifying DOM node attributes

    * NodeList.attr
    
      Set/Get attributes for nodes in the list

    * dojo.hasAttr
    
    * dojo.removeAttr
      
    * `dojo.formToObject <dojo/formToObject>`_
    * `dojo.formToQuery <dojo/formToQuery>`_

    * dojo.isDescendant
    
    * dojo.setSelectable
    

  * Styles

    * `dojo.coords <dojo/coords>`_

      Getter for the coordinates (relative to parent and absolute) of a dom node.
      
    * NodeList.coords
    
      Getter for the coordinates of each node in the list

    * `dojo.style <dojo/style>`_

      A getter/setter for styles on a DOM node
      
    * `dojo.getComputedStyle <dojo/getComputedStyle>`_
    
      Return a cachable object of all computed styles for a node
      
    * Class Utilities
    
      * `dojo.hasClass <dojo/hasClass>`_ 

      * `dojo.addClass <dojo/addClass>`_

      * `dojo.removeClass <dojo/removeClass>`_

      * `dojo.toggleClass <dojo/toggleClass>`_

    * `dojo.marginBox <dojo/marginBox>`_

      Getter/setter for the margin-box of node

    * `dojo.contentBox <dojo/contentBox>`_

      Getter/setter for the content-box of node

Effects
-------

  * `dojo.animateProperty <dojo/animateProperty>`_

    The workhorse of most `dojo.fx <dojo/fx>`_ animations. Used for animating CSS properties
    
  * `dojo.Animation <dojo/Animation>`_
  
    **1.4+** previously dojo._Animation, the class behind all dojo.fx
    
  * `dojo.anim <dojo/anim>`_
  
    Shorthand version of animateProperty using positional arguments
    
  * `dojo.fadeOut <dojo/fadeOut>`_
  
  * `dojo.fadeIn <dojo/fadeIn>`_

Events
------

  * `dojo.connect <dojo/connect>`_

    Connects events to methods

  * `NodeList.connect <dojo/NodeList#connect>`_
  
    Connects events to every node in the list, like dojo.connect
    
  * `NodeList.events <dojo/NodeList#events>`_
  
    Common event names mapped as functions on a NodeList - eg: .onclick(function(){})

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
    
  * `dojo.stopEvent <dojo/stopEvent>`_
  
    Stop an event's bubbling and propagation.
    
  
Document Lifecycle
------------------

  * `dojo.addOnLoad <dojo/addOnLoad>`_

    Call functions after the DOM has finished loading and widgets declared in markup have been instantiated

  * `dojo.addOnUnload <dojo/addOnUnload>`_

    Call functions when the page unloads

  * `dojo.addOnWindowUnload <dojo/addOnWindowUnload>`_

    Call functions when window.onunload fires

  * `dojo.windowUnloaded <dojo/windowUnloaded>`_

    Signal fired by impending window destruction

Ajax / IO
---------

  * `IO Pipeline Topics <dojo/ioPipelineTopics>`_
  * `dojo.xhr` <dojo/xhr>`_
  
    Core for all xhr* verbs, eg: xhrPost, getGet
  
  * `dojo.xhrDelete <dojo/xhrDelete>`_
  * `dojo.xhrGet <dojo/xhrGet>`_
  * `dojo.xhrPost <dojo/xhrPost>`_
  * `dojo.xhrPut <dojo/xhrPut>`_
  * `dojo.rawXhrPost <dojo/rawXhrPost>`_
  * `dojo.rawXhrPut <dojo/rawXhrPut>`_

Package System
--------------

  * `dojo.registerModulePath <dojo/registerModulePath>`_

    Maps module name to a path

  * `dojo.require <dojo/require>`_

    Loads a Javascript module from the appropriate URI
    
  * `dojo.provide <dojo/provide>`_
  
  * `dojo.moduleUrl <dojo/moduleUrl>`_

JSON Tools
----------

  * `dojo.fromJson <dojo/fromJson>`_

    Parses a JSON string to return a JavaScript object

  * `dojo.toJson <dojo/toJson>`_

    Returns a JSON serialization of an object

Objects / OO Tools
------------------

  * `dojo.mixin <dojo/mixin>`_
  
    Mixes one object into another. Can be used as a shallow copy
    
  * `dojo.declare <dojo/declare>`_

    Creates a constructor using a compact notation for inheritance and prototype extension

  * `dojo.extend <dojo/extend>`_

  * `dojo.exists <dojo/exists>`_

    Determine if an object supports a given method
    
  * `dojo.delegate <dojo/delegate>`_
  
    Delegate an Object (beget)

  * `dojo.getObject <dojo/getObject>`_

    Get a property from a dot-separated string, such as "A.B.C"

  * `dojo.setObject <dojo/setObject>`_

    Set a property from a dot-separated string, such as "A.B.C"

  * `dojo.objectToQuery <dojo/objectToQuery>`_
  * `dojo.queryToObject <dojo/queryToObject>`_

  * `NodeList.instantiate <dojo/NodeList#instantiate>`_
  
    Create classes out of each node in the list


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

  * `dojo.keys <dojo/keys>`_
  
    A collection of key constants.
    
  * `dojo.deprecated <dojo/deprecated>`_

    Log a debug message to indicate that a behavior has been deprecated

  * `dojo.version <dojo/version>`_

    The current version number of Dojo

  * `dojo.global <dojo/global>`_

    Alias for the global scope

  * `dojo.setContext <dojo/setContext>`_

    Changes the behavior of many core Dojo functions that deal with namespace and DOM lookup

  * `dojo.withGlobal <dojo/withGlobal>`_

    Call callback with globalObject as dojo.global and globalObject.document as dojo.doc

  * `dojo.withDoc <dojo/withDoc>`_

    Call callback with documentObject as dojo.doc

  * `dojo.eval <dojo/eval>`_
  
    Evaluate some string of JavaScript

=========    
Dojo Core
=========

* `dojo.AdapterRegistry <dojo/AdapterRegistry>`_

  A registry to make contextual calling/searching easier

* `dojo.back <dojo/back>`_

  Browser history management resources (Back button functionality)

* `dojo.behavior <dojo/behavior>`_

  Utility for unobtrusive/progressive event binding, DOM traversal, and manipulation

* `dojo.cldr <dojo/cldr>`_

  A Common Locale Data Repository (CLDR) implementation

* `dojo.cache <dojo/cache>`_ 

  **1.4+** A mechanism to cache inline text.
  
* `dojo.colors <dojo/colors>`_

  CSS color manipulation functions

* `dojo.cookie <dojo/cookie>`_

  Simple HTTP cookie manipulation

* `dojo.currency <dojo/currency>`_

  Localized formatting and parsing routines for currency data

* `dojo.data <dojo/data>`_

  A uniform data access layer

  * `dojo.data.api <dojo/data/api>`_
  * `dojo.data.api.Read <dojo/data/api/Read>`_
  * `dojo.data.api.Write <dojo/data/api/Write>`_
  * `dojo.data.api.Identity <dojo/data/api/Identity>`_
  * `dojo.data.api.Notification <dojo/data/api/Notification>`_
  * `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_
  * `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_

* `dojo.date <dojo/date>`_

  Date manipulation utilities

  * `dojo.date.locale.format <dojo/date/locale/format>`_

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

* `dojo.io <dojo/io>`_

  Additional AJAX I/O transports

  * `dojo.io.iframe <dojo/io/iframe>`_

    Sends an AJAX I/O call using an IFrame

  * `dojo.io.script <dojo/io/script>`_

    Sends a JSONP request using a script tag

* `dojo.jaxer <dojo/jaxer>`_

* `dojo.NodeList-fx <dojo/NodeList-fx>`_

  Adds dojo.fx animation support to dojo.query()

* `dojo.NodeList-html <dojo/NodeList-html>`_

  Adds a chainable html method to dojo.query()

* `dojo.NodeList-manipulate <dojo/NodeList-manipulate>`_

  **1.4+** Method extensions to dojo.NodeList/dojo.query() that manipulate HTML.
  
* `dojo.NodeList-traverse <dojo/NodeList-traverse>`_

  **1.4+** Method extensions to dojo.NodeList/dojo.query() for traversing the DOM.
  
* `dojo.number <dojo/number>`_

  Localized formatting and parsing methods for number data

* `dojo.parser <dojo/parser>`_

  The Dom/Widget parsing package

* `dojo.regexp <dojo/regexp>`_

  Regular expressions and Builder resources

* `dojo.robot <dojo/robot>`_

  experimental module for DOH users

* `dojo.robotx <dojo/robotx>`_

  experimental module for DOH users

* `dojo.rpc <dojo/rpc>`_

  Communicate via Remote Procedure Calls (RPC) with Backend Servers

  * `dojo.rpc.JsonpService <dojo/rpc/JsonpService>`_

    Generic JSONP service

  * `dojo.rpc.JsonService <dojo/rpc/JsonService>`_

    JSON RPC service

  * `dojo.rpc.RpcService <dojo/rpc/RpcService>`_

    RPC service class

* `dojo.string <dojo/string>`_

  String utilities for Dojo


========
See also
========

* `Dijit <dijit/index>`__

  The widget system layered on top of Dojo

* `DojoX <dojox/index>`__

  An area for development of extensions to the Dojo toolkit
