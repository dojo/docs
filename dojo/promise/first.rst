.. _dojo/promise/first:

==================
dojo/promise/first
==================

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/promise/first** is a function that takes multiple promises and returns a new promise that is fulfilled when the first of those promises is fulfilled.

Introduction
============

``dojo/promise/first`` is useful when managing multiple promises that may resolve at different times. This could be
useful in a situation where you are going against responses against several services but only really care about
whichever one is the fastest to return.

*Note* Cancelling the returned promise from ``dojo/promise/first`` will not cancel any of the passed promises.

Usage
=====

Usage is straight forward, in that ``dojo/promise/first`` is a single argument that is either an Object or an Array. The
returned promise is fulfilled with the results from the first promise that is fulfilled:

.. js ::

  require(["dojo/promise/first"], function(first){

    first([promise1, promise2]).then(function(result){
      // result will be either promise1 or promise2 results, whichever is fulfilled first
    });

    // -- or --

    first({
      promise1: promise1,
      promise2: promise2
    }).then(function(result){
      // result will be either promise1 or promise2 results, whichever is fulfilled first
    });

  });

As mentioned above, ``dojo/promise/first`` takes a single argument:

============= ============= ======================================
Argument      Type          Description
============= ============= ======================================
objectOrArray Object/Array? The object or array of promises to use
============= ============= ======================================

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example demonstrates simulating 3 service requests and then acting on the first one to return.

  .. js ::

    require(["dojo/promise/first", "dojo/Deferred", "dojo/dom", "dojo/on", "dojo/json", "dojo/domReady!"],
    function(first, Deferred, dom, on, JSON){

      function googleRequest(){
        var deferred = new Deferred();
        setTimeout(function(){
          deferred.resolve("foo");
        }, 500);
        return deferred;
      }

      function bingRequest(){
        var deferred = new Deferred();
        setTimeout(function(){
          deferred.resolve("bar");
        }, 750);
        return deferred;
      }

      function baiduRequest(){
        var deferred = new Deferred();
        setTimeout(function(){
          deferred.resolve("baz");
        }, 1000);
        return deferred;
      }

      on(dom.byId("startButton"), "click", function(){
        dom.byId("output").innerHTML = "Running...";
        first([googleRequest(), bingRequest(), baiduRequest()]).then(function(result){
          dom.byId("output").innerHTML = JSON.stringify(result);
        });
      });

    });

  .. html ::

    <h1>Output:</h1>
    <pre id="output"></pre>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example is essentially the same as above, but passes an Object as a parameter to ``dojo/promise/first``.

  .. js ::

    require(["dojo/promise/first", "dojo/Deferred", "dojo/dom", "dojo/on", "dojo/json", "dojo/domReady!"],
    function(first, Deferred, dom, on, JSON){

      function googleRequest(){
        var deferred = new Deferred();
        setTimeout(function(){
          deferred.resolve("foo");
        }, 500);
        return deferred;
      }

      function bingRequest(){
        var deferred = new Deferred();
        setTimeout(function(){
          deferred.resolve("bar");
        }, 750);
        return deferred;
      }

      function baiduRequest(){
        var deferred = new Deferred();
        setTimeout(function(){
          deferred.resolve("baz");
        }, 1000);
        return deferred;
      }

      on(dom.byId("startButton"), "click", function(){
        dom.byId("output").innerHTML = "Running...";
        first({
          google: googleRequest(), 
          bing: bingRequest(), 
          baidu: baiduRequest()
        }).then(function(results){
          dom.byId("output").innerHTML = JSON.stringify(results);
        });
      });

    });

  .. html ::

    <h1>Output:</h1>
    <pre id="output"></pre>
    <button type="button" id="startButton">Start</button>


See also
========

* :ref:`dojo/promise <dojo/promise>` - The rest of the Dojo Promise API

* :ref:`dojo/promise/all <dojo/promise/all>` - Like ``dojo/promise/first`` except gets fulfilled when all the promises
  get fulfilled.

* :ref:`dojo/Deferred <dojo/Deferred>` - The base class for managing asynchronous thread communication in Dojo.
