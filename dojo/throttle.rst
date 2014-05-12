.. _dojo/throttle:

=============
dojo/throttle
=============

:Authors: Benjamin Santalucia
:Project owner: 
:since: 1.10

.. contents ::
  :depth: 2

This module provide a function throttler.
Throttling ensures that a function is only executed once during a predefined interval.
After an execution, any call of the function during this interval will be ignored.

Usage
=====

The module's return value is a function that can be directly invoked:

.. js ::

  require(["dojo/throttle"], function(throttle){
    var original = function() {
      console.log("i am throttled");
    };
    var delay = 100;
    var throttled = throttle(original, delay);
  });

The signature of the function is:

.. api-doc :: dojo/throttle
  :topfunc:
  :sig:
  :returns:
  :no-headers:

Examples
========

throttling a topic callback
---------------------------

.. code-example ::
  :djConfig: async: true

  Using throttle to prevent a refresh to occur every time a topic is published

  .. js ::

    require([
      "dojo/topic",
      "dojo/dom",
      "dojo/throttle"
      "dojo/domReady!"
    ], function(topic, dom, throttle) {
  
      var normalCount = 0;
      var throttleCount = 0;
      var normalFunction = function() {
        dom.byId("normal").innerHTML = ++normalCount;
      }
      var throttleFunction = throttle(function() {
        dom.byId("throttle").innerHTML = ++throttleCount;
      }, 500);
      topic.subscribe("demo/throttle", normalFunction);
      topic.subscribe("demo/throttle", throttleFunction);
      
      var throttleDemo = function() {
        var i = 0;
        var interval = setInterval(function() {
          if(i++ >= 20) {
            clearInterval(interval);
            alert("done");
          } else {
            topic.publish("demo/throttle");
          }
        }, 100);
      }
  
    });

  .. css ::


  .. html ::

    <h1>Normal function count :</h1>
    <div id="normal">0</div>
    <h1>throttled function count :</h1>
    <div id="throttle">0</div>
    <button onclick="throttleDemo()">start</button>
