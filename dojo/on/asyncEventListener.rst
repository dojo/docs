.. _dojo/on/asyncEventListener:

==========================
dojo/on/asyncEventListener
==========================

:Authors: Benjamin Santalucia
:Project owner: 
:since: 1.10

.. contents ::
  :depth: 2

In old browsers (such as IE 8 and bellow) the event object can be invalid when reached from an asynchronous function (like a debounce).
This utility accepts a function as its parameter.
It evaluates if the browser supports asynchronous event listener and returns an appropriate listener, where the event will be valid.

Usage
=====

The module's return value is a function that can be used as an event listener:

.. js ::

  require(["dojo/on/asyncEventListener"], function(asyncEventListener){
    var listener = function() {
      console.log("i am a listener");
    };
    var fixedListener = asyncEventListener(listener);
  });

The signature of the function is:

.. api-doc :: dojo/on/asyncEventListener
  :topfunc:
  :sig:
  :returns:
  :no-headers:

Examples
========

Asynchronous click event
------------------------

.. code-example ::
  :djConfig: async: true

  Using asyncEventListener to prevent an invalid event object

  .. js ::

    require([
      "dojo/_base/lang",
      "dojo/dom",
      "dojo/on",
      "dojo/on/asyncEventListener",
      "dojo/domReady!"
    ], function(lang, dom, on, asyncEventListener) {
      var asyncListener = function(e) {
          console.log(e);
      }
      asyncListener = asyncEventListener(asyncListener);
  
      on(dom.byId("test"), "click", function(e) {
          setTimeout(lang.hitch(null, asyncListener, e), 100);
      });
  
    });

  .. css ::


  .. html ::

    <button id="test">test async event listener</button>
