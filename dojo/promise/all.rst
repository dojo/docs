.. _dojo/promise/all:

================
dojo/promise/all
================

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/promise/all** is a function that takes multiple promises and returns a new promise that is fulfilled when all
promises have been fulfilled.

Introduction
============

``dojo/promise/all`` replaces :ref:`dojo/DeferredList <dojo/DeferredList>` and provides a mechanism to manage multiple
asynchronous processes by essentially combining the results of several promises into a single promise. An example usage
would be several different XHR requests to several different back end services to get some results and then to do
something when all the back end services have responded. This would increase the latency of the application because you
would only wait for the longest service to respond.

Usage
=====

Usage is straight forward, in that ``dojo/promise/all`` is a single argument that is either an Object or an Array. The
results are either returned as an Object that uses the same keys as supplied in the argument or an Array in the same
order that the supplied one:

.. js ::

  require(["dojo/promise/all"], function(all){
    
    all([promise1, promise2]).then(function(results){
      // results will be an Array
    });
    
    // -- or --
    
    all({
      promise1: promise1,
      promise2: promise2
    }).then(function(results){
      // results will be an Object using the keys "promise1" and "promise2"
    });
    
  });

As mentioned above, ``dojo/promise/all`` takes a single argument:

============= ============= ======================================
Argument      Type          Description
============= ============= ======================================
objectOrArray Object/Array? The object or array of promises to use
============= ============= ======================================

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example demonstrates simulating 3 service requests and then performing the handling of the results in one block
  of code.

  .. js ::

    require(["dojo/promise/all", "dojo/Deferred", "dojo/dom", "dojo/on", "dojo/json", "dojo/domReady!"],
    function(all, Deferred, dom, on, JSON){
    
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
        all([googleRequest(), bingRequest(), baiduRequest()]).then(function(results){
          dom.byId("output").innerHTML = JSON.stringify(results);
        });
      });
    
    });

  .. html ::

    <h1>Output:</h1>
    <pre id="output"></pre>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example is essentially the same as above, but passes an Object as a parameter to ``dojo/promise/all``.

  .. js ::

    require(["dojo/promise/all", "dojo/Deferred", "dojo/dom", "dojo/on", "dojo/json", "dojo/domReady!"],
    function(all, Deferred, dom, on, JSON){

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
        all({
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

* :ref:`dojo/promise/first <dojo/promise/first>` - Like ``dojo/promise/all`` except gets fulfilled when the first
  promise gets fulfilled.

* :ref:`dojo/Deferred <dojo/Deferred>` - The base class for managing asynchronous thread communication in Dojo.
