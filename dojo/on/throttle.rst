.. _dojo/on/throttle:

==========================
dojo/on/throttle
==========================

:Authors: Benjamin Santalucia
:Project owner: 
:since: 1.10

.. contents ::
  :depth: 2

This module provide an extension event to use with dojo/on.
This extension event allows to throttle an event.
More information on throttling are available in dojo/throttle.


Usage
=====

The module's return value is a function that can be used as event listener:

.. js ::

  require(["dojo/on/throttle"], function(throttleEvent){
    var listener = function() {
      console.log("i am a listener");
    };
    var delay = 100;
    var throttleListener = throttleEvent(listener, delay);
  });

The signature of the function is:

.. api-doc :: dojo/on/throttle
  :topfunc:
  :sig:
  :returns:
  :no-headers:

Examples
========

Throttling a mousemouve event
-----------------------------

.. code-example ::
  :djConfig: async: true

  Using throttle to execute the event listener only once during an interval.

  .. js ::

    require([
      'dojo/dom',
      'dojo/on',
      'dojo/on/throttle',
      'dojo/domReady!'
    ], function(dom, on, throttle) {
      var listener = function(e) {
          console.log(e);
      }
      var delay = 1000; //1 second
      throttleListener = throttle(listener, delay);
  
      on(dom.byId('test'), 'mousemove', throttleListener);
  
    });

  .. css ::


  .. html ::

    <div id="test">mouve the mouse over me</div>
