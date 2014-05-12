.. _dojo/debounce:

=============
dojo/debounce
=============

:Authors: Benjamin Santalucia
:Project owner: 
:since: 1.10

.. contents ::
  :depth: 2

This module provide a function debouncer.
Debouncing prevents repeated execution of a function by delaying it.
If another call arrives before the execution starts, the previous execution is canceled and a new one is scheduled.

Usage
=====

The module's return value is a function that can be directly invoked:

.. js ::

  require(["dojo/debounce"], function(debounce){
    var original = function() {
      console.log("i am debounced");
    };
    var delay = 100;
    var debounced = debounce(original, delay);
  });

The signature of the function is:

.. api-doc :: dojo/debounce
  :topfunc:
  :sig:
  :returns:
  :no-headers:

Examples
========

debouncing a topic callback
---------------------------

.. code-example ::
  :djConfig: async: true

  Using debounce to prevent a refresh to occur every time a topic is published

  .. js ::

    require([
      "dojo/topic",
      "dojo/dom",
      "dojo/debounce"
      "dojo/domReady!"
    ], function(topic, dom, debounce) {
  
      var normalCount = 0;
      var debounceCount = 0;
      var normalFunction = function() {
        dom.byId("normal").innerHTML = ++normalCount;
      }
      var debounceFunction = debounce(function() {
        dom.byId("debounce").innerHTML = ++debounceCount;
      }, 500);
      topic.subscribe("demo/debounce", normalFunction);
      topic.subscribe("demo/debounce", debounceFunction);
      
      var debounceDemo = function() {
        var i = 0;
        var interval = setInterval(function() {
          if(i++ >= 20) {
            clearInterval(interval);
            alert("done");
          } else {
            topic.publish("demo/debounce");
          }
        }, 100);
      }
  
    });

  .. css ::


  .. html ::

    <h1>Normal function count :</h1>
    <div id="normal">0</div>
    <h1>Debounced function count :</h1>
    <div id="debounce">0</div>
    <button onclick="debounceDemo()">start</button>
