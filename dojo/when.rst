.. _dojo/when:

=========
dojo/when
=========

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/when** transparently applies callbacks to values and/or promises as well as converts foreign promises to native ones.

Introduction
============

**dojo/when** is designed to make it easier to merge coding of synchronous and asynchronous threads.  Accepts promises but also transparently handles non-promises. If no callbacks are provided returns a promise, regardless of the initial value. Also, foreign promises are converted.

If callbacks are provided and the initial value is not a promise, the callback is executed immediately with no error handling. Returns a promise if the initial value is a promise, or the result of the callback otherwise.

Usage
=====

Usage is straight forward and similar to :ref:`dojo/promise/Promise::then() <dojo/promise/Promise#then>` method.

.. js ::

  require(["dojo/when"], function(when){
    when(someValue, function(value){
      // do something when resolved
    }, function(err){
      // do something when rejected
    }, function(update){
      // do something on progress
    });
  });

============== ========= ============================================================================================
Argument       Type      Description
============== ========= ============================================================================================
valueOrPromise Mixed     Either a value or a promise
callback       Function? *Optional* The function that should be called back when the promise is fulfilled, or will be
                         called immediately if ``valueOrPromise`` is not a promise.
errback        Function? *Optional* The function that should be called when a promise is rejected.
progback       Function? *Optional* The function that should be called when a promise provides progress.
============== ========= ============================================================================================

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  In this example, we demonstrate how we can handle both a synchronous and asynchronous process with the same code, by
  using when.

  .. js ::

    require(["dojo/when", "dojo/Deferred", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(when, Deferred, dom, on){
      function asyncProcess(){
        var deferred = new Deferred();
        
        setTimeout(function(){
          deferred.resolve("async");
        }, 1000);
        
        return deferred.promise;
      }
      
      function syncProcess(){
        return "sync";
      }
      
      function outputValue(value){
        dom.byId("output").innerHTML += "<br/>completed with value: " + value;
      }
      
      on(dom.byId("startButton"), "click", function(){
        when(asyncProcess(), outputValue);
        when(syncProcess(), outputValue);
      });
      
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

See also
========

* :ref:`dojo/promise/Promise <dojo/promise/Promise>` - The base Promise class.

* :ref:`dojo/Deferred <dojo/Deferred>` - The base async thread management class.
