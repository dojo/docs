#format dojo_rst

Docu Wiki ToDo
==============

.. contents::
   :depth: 2

The following pages needs more love:


=======================
Top priority: Dojo Base
=======================

* `dojo.attr <dojo/attr>`_

* `dojo.exists <dojo/exists>`_

* `dojo.registerModulePath <dojo/registerModulePath>`_

  needed: Examples

* `dojo.setObject <dojo/setObject>`_

* `dojo.version <dojo/version>`_

  needed: Examples

* `dojo.windowUnloaded <dojo/windowUnloaded>`_


----

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

  * `dojo._base.json <dojo/_base/json>`_

    JSON helpers

    * `dojo.fromJson <dojo/fromJson>`_

      Parses a JSON string to return a JavaScript object

    * `dojo.toJson <dojo/toJson>`_

      Returns a JSON serialization of an object

  * `dojo._base.lang <dojo/_base/lang>`_

    Support for Polymorphism

    * `dojo.isString <dojo/isString>`_

      Checks if the parameter is a String

    * `dojo.isArray <dojo/isArray>`_

      Checks if the parameter is an Array

    * `dojo.isFunction <dojo/isFunction>`_

      Checks if the parameter is a Function

    * `dojo.isObject <dojo/isObject>`_

      Checks if the parameter is a Object

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

    * `dojo.formToJson <dojo/formToJson>`_
    * `dojo.formToObject <dojo/formToObject>`_
    * `dojo.formToQuery <dojo/formToQuery>`_
    * `dojo.objectToQuery <dojo/objectToQuery>`_
    * `dojo.queryToObject <dojo/queryToObject>`_
    * `dojo.xhrDelete <dojo/xhrDelete>`_
    * `dojo.xhrGet <dojo/xhrGet>`_
    * `dojo.rawXhrPost <dojo/rawXhrPost>`_
    * `dojo.rawXhrPut <dojo/rawXhrPut>`_




=====================
Priority 2: Dojo Core
=====================


=================
Priority 3: Dijit
=================


=================
Priority 4: DojoX
=================
