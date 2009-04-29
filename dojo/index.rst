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

dojo.js
-------

Dojo Base is the functionality you get by just including dojo.js or dojo.xd.js in your page.

* `dojo._base <dojo/base>`_

  * `dojo._base._loader <dojo/base/loader>`_

    Dojo's Bootstrap

    * `djConfig <djConfig>`_

      Configuring Dojo with djConfig

    * `dojo.addOnLoad <dojo/addOnLoad>`_

      Call functions after the DOM has finished loading and widgets declared in markup have been instantiated

    * `dojo.addOnUnload <dojo/addOnUnload>`_

      Call functions when the page unloads

    * `dojo.addOnWindowUnload <dojo/addOnWindowUnload>`_

      Call functions when window.onunload fires

    * `dojo.attr <dojo/attr>`_

      Modifying DOM node attributes

    * `dojo.deprecated <dojo/deprecated>`_

      Log a debug message to indicate that a behavior has been deprecated

    * `dojo.exists <dojo/exists>`_

      Determine if an object supports a given method

    * `dojo.getObject <dojo/getObject>`_

      Get a property from a dot-separated string, such as "A.B.C"

    * `dojo.global <dojo/global>`_

      Alias for the global scope

    * `dojo.mixin <dojo/mixin>`_

      Multiple inheritance

    * `dojo.place <dojo/place>`_

      Place DOM nodes relative to others

    * `dojo.registerModulePath <dojo/registerModulePath>`_

      Maps module name to a path

    * `dojo.require <dojo/require>`_

      Loads a Javascript module from the appropriate URI

    * `dojo.setObject <dojo/setObject>`_

      Set a property from a dot-separated string, such as "A.B.C"

    * `dojo.version <dojo/version>`_

      The current version number of Dojo

    * `dojo.windowUnloaded <dojo/windowUnloaded>`_

      Signal fired by impending window destruction

  * `dojo._base.array <dojo/_base/array>`_

    Array utilities.
    Details on dojo.every, dojo.filter, dojo.forEach, dojo.indexOf, dojo.lastIndexOf, dojo.map, and dojo.some.

    * `dojo.forEach <dojo/forEach>`_

      Invokes a callback function for every item in array

    * `dojo.map <dojo/map>`_

      Applies a callback to each element of arr and returns an Array with the results

  * `dojo._base.Color <dojo/_base/Color>`_

    Functions for setting Colors

  * `dojo._base.connect <dojo/_base/connect>`_

    Functions for connecting methods to events and to subscribe and publish events

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

  * `dojo._base.declare <dojo/_base/declare>`_

    Defining Classes

    * `dojo.declare <dojo/declare>`_

      Creates a constructor using a compact notation for inheritance and prototype extension

  * `dojo._base.Deferred <dojo/_base/Deferred>`_

    Managing Callbacks

    * `dojo.Deferred <dojo/Deferred>`_

      Communication between threads

  * `dojo._base.event <dojo/_base/event>`_

    DOM Events

  * `dojo._base.fx <dojo/_base/fx>`_

    Dojo animation effects

    * `dojo.animateProperty <dojo/animateProperty>`_

      A very useful method for animating CSS properties

  * `dojo._base.html <dojo/_base/html>`_

    Basic DOM handling functions

    * `dojo.byId <dojo/byId>`_

      Select a DOM node by 'id'

    * `dojo.style <dojo/style>`_

      A getter/setter for styles on a DOM node

    * `dojo.coords <dojo/coords>`_

      Getter for the coordinates (relative to parent and absolute) of a dom node.

    * `dojo.marginBox <dojo/marginBox>`_

      Getter/setter for the margin-box of node

    * `dojo.contentBox <dojo/contentBox>`_

      Getter/setter for the content-box of node

  * `dojo._base.json <dojo/_base/json>`_

    JSON helpers

    * `dojo.fromJson <dojo/fromJson>`_

      Parses a JSON string to return a JavaScript object

    * `dojo.toJson <dojo/toJson>`_

      Returns a JSON serialization of an object

  * `dojo._base.lang <dojo/_base/lang>`_

    Support for Polymorphism

    * `dojo.hitch <dojo/hitch>`_

      Function that generates a wrapper function that ensures a function that will only ever execute in a defined scope.

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

  * `dojo._base.NodeList <dojo/_base/NodeList>`_

    Syntactic sugar for chaining, common iteration operations, animation, and node manipulation

    * `dojo.NodeList <dojo/NodeList>`_

      A class to handle a list of DOM nodes

  * `dojo._base.query <dojo/_base/query>`_

    A relatively full-featured CSS3 query library

    * `dojo.query <dojo/query>`_

      The swiss army knife of DOM node manipulation in Dojo

  * `dojo._base.window <dojo/_base/window>`_

    Functions for dealing with the document-wide DOM and context related stuff

    * `dojo.doc <dojo/doc>`_

      Alias for the current document

    * `dojo.body <dojo/body>`_

      Return the body element of the document

    * `dojo.setContext <dojo/setContext>`_

      Changes the behavior of many core Dojo functions that deal with namespace and DOM lookup

    * `dojo.withGlobal <dojo/withGlobal>`_

      Call callback with globalObject as dojo.global and globalObject.document as dojo.doc

    * `dojo.withDoc <dojo/withDoc>`_

      Call callback with documentObject as dojo.doc

  * `dojo._base.xhr <dojo/_base/xhr>`_

    AJAX I/O transports and utility methods

    * `IO Pipeline Topics <dojo/ioPipelineTopics>`_
    * `dojo.formToJson <dojo/formToJson>`_
    * `dojo.fieldToObject <dojo/fieldToObject>`_
    * `dojo.formToObject <dojo/formToObject>`_
    * `dojo.formToQuery <dojo/formToQuery>`_
    * `dojo.objectToQuery <dojo/objectToQuery>`_
    * `dojo.queryToObject <dojo/queryToObject>`_
    * `dojo.xhrDelete <dojo/xhrDelete>`_
    * `dojo.xhrGet <dojo/xhrGet>`_
    * `dojo.xhrPost <dojo/xhrPost>`_
    * `dojo.xhrPut <dojo/xhrPut>`_
    * `dojo.rawXhrPost <dojo/rawXhrPost>`_
    * `dojo.rawXhrPut <dojo/rawXhrPut>`_

Dojo Core
---------

* `dojo.AdapterRegistry <dojo/AdapterRegistry>`_

  A registry to make contextual calling/searching easier

* `dojo.back <dojo/back>`_

  Browser history management resources (Back button functionality)

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

See also
--------

* `Dijit <dijit/index>`__

  The widget system layered on top of Dojo

* `DojoX <dojox/index>`__

  An area for development of extensions to the Dojo toolkit
