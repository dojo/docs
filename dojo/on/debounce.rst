.. _dojo/on/debounce:

==========================
dojo/on/debounce
==========================

:Authors: Benjamin Santalucia
:Project owner: 
:since: 1.10

.. contents ::
  :depth: 2

This module provide an extension event to use with dojo/on.
This extension event allows to debounce an event.
More information on debouncing are available in dojo/debounce.


Usage
=====

The module's return value is a function that can be used as event listener:

.. js ::

  require(["dojo/on/debounce"], function(debounceEvent){
    var listener = function() {
      console.log("i am a listener");
    };
    var delay = 100;
    var debounceListener = debounceEvent(listener, delay);
  });

The signature of the function is:

.. api-doc :: dojo/on/debounce
  :topfunc:
  :sig:
  :returns:
  :no-headers:

Examples
========

Debouncing a mousemouve event
-----------------------------

.. code-example ::
  :djConfig: async: true

  Using debounce to execute the event listener only when no more events are fired during the interval.

  .. js ::

    require([
      'dojo/dom',
      'dojo/on',
      'dojo/on/debounce',
      'dojo/domReady!'
    ], function(dom, on, debounce) {
      var listener = function(e) {
          console.log(e);
      }
      var delay = 1000; //1 second
      debounceListener = debounce(listener, delay);
  
      on(dom.byId('test'), 'mousemove', debounceListener);
  
    });

  .. css ::


  .. html ::

    <div id="test">mouve the mouse over me</div>
