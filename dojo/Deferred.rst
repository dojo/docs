.. _dojo/Deferred:

=============
dojo/Deferred
=============

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/Deferred** manages the communication between asynchronous threads (callbacks). Previously it resided in Dojo
Base, but in 1.8 it was rewritten based on the new Promise architecture and moved out of base. ``dojo/Deferred``
encapsulates a sequence of callbacks in response to a value that may not yet be available. All of ``dojo/request``
modules make use of this class.

Introduction
============

**dojo/Deferred** is a class that is used as the foundation for managing asynchronous threads in Dojo.  Packages like ``dojo/request`` use this class to return a *promise* that gets *resolved* when the asynchronous thread is complete.  In order trigger a callback to occur when the thread is complete, the ``.then()`` method is used.  As well as the thread can be informed to cancel itself by using the ``.cancel()`` method.  If the thread has completed, then the ``.then()`` callback will be executed immediately.

Usage
=====

Basic usage is instantiating a ``dojo/Deferred`` object, starting the thread and when it completes calling ``.resolve()`` with any results and returning the object to the consumer.  From a consumer perspective it is generally setting either a ``.then()`` callback with potentially an additional error callback as the second argument of then.  If the asynchronous process supports cancelling and it has been implemented, then the process can be cancelled via ``.cancel()``.

.. js ::

  require(["dojo/Deferred"], function(Deferred){
    var deferred = new Deferred(function(reason){
      // do something when the Deferred is cancelled
    });
    
    // do something asynchronously
    
    // provide an update on progress:
    deferred.progress(update);
    
    // when the process finishes:
    deferred.resolve(value);
    
    // performing "callbacks" with the process:
    deferred.then(function(value){
      // Do something when the process completes
    }, function(err){
      // Do something when the process errors out
    }, function(update){
      // Do something when the process provides progress information
    });
    
    // to cancel the asynchronous process:
    deferred.cancel(reason);
  });

Because ``.then()`` returns a new promise that is fulfilled when the callback completes, you can chain a Deferred like this:

.. js ::

  require(["dojo/Deferred"], function(Deferred){
    var deferred = new Deferred();
    
    deferred.then(function(value){
      // do something
      return something;
    }).then(function(something){
      // do something else
    });
  });

``dojo/Deferred`` contains the following properties:

================================= ======================================================================================
Property                          Description
================================= ======================================================================================
promise                           Points to the ``dojo/promise/Promise`` object related to this object
isResolved()                      Returns ``true`` if the Deferred is resolved
isRejected()                      Returns ``true`` if the Deferred is rejected
isFulfilled()                     Returns ``true`` if the Deferred is fulfilled
isCanceled()                      Returns ``true`` if the Deferred is cancelled
progress(update, strict)          Called by the async process to provide progress updates.  The second argument, which
                                  is optional, if ``true`` means it will throw an error if the promise is fulfilled. 
                                  Defaults to ``false``.
resolve(value, strict)            Called by the async process, when complete, providing any results to be passed to the
                                  callback.  The second argument, which is optional, if ``true`` means it will throw an 
                                  error if the promise is fulfilled.  Defaults to ``false``.
reject(error, strict)             Called by the async process to reject (error out) the deferred.  The second argument,
                                  which is optional, if ``true`` means it will throw an error if the promise is 
                                  fulfilled.  Defaults to ``false``.
then(callback, errback, progback) Used to set the callbacks for a Deferred.  ``errback`` and ``progback`` are optional
                                  functions that will be called if there is a rejection or a progress update,
                                  respectively.  ``.then()`` returns a new promise that will be fulfilled when the
                                  callback completes.  Anything that is returned from ``progback`` will be passed as 
                                  the ``value`` to any callbacks to that promise, and any errors thrown by ``errback`` will be passed as the ``error`` to any of its errbacks.  If the Deferred is rejected and ``errback`` is called, but it does not throw an error, the new promise will be resolved with ``value`` being what was returned by ``errback``.  This allows for chaining of callbacks, and for intermediate promises to handle errors for later ones.
cancel(reason, strict)            Signal the deferred that we're no longer interested in the result. The deferred may 
                                  subsequently cancel its operation and reject the promise. Can affect other promises 
                                  that originate with the same deferred. Returns the rejection reason if the deferred
                                  was canceled normally. The second argument, which is optional, if ``true`` means it 
                                  will throw an error if the promise is fulfilled.  Defaults to ``false``.
================================= ======================================================================================

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example provides a basic usage of Deferred, where we are creating an async process via the ``setTimeout``
  function.

  .. js ::

    require(["dojo/Deferred", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(Deferred, dom, on){
      function asyncProcess(){
        var deferred = new Deferred();
        
        dom.byId("output").innerHTML = "I'm running...";
        
        setTimeout(function(){
          deferred.resolve("success");
        }, 1000);
        
        return deferred.promise;
      }
      
      on(dom.byId("startButton"), "click", function(){
        var process = asyncProcess();
        process.then(function(results){
          dom.byId("output").innerHTML = "I'm finished, and the result was: " + results;
        });
      });
      
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output">Not yet started.</div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example shows how ``.then()`` can be chained.

  .. js ::

    require(["dojo/Deferred", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(Deferred, dom, on){
      function asyncProcess(msg){
        var deferred = new Deferred();
        
        dom.byId("output").innerHTML += "<br/>I'm running...";
        
        setTimeout(function(){
          deferred.resolve(msg);
        }, 1000);
        
        return deferred.promise;
      }
      
      on(dom.byId("startButton"), "click", function(){
        var process = asyncProcess("first");
        process.then(function(results){
          dom.byId("output").innerHTML += "<br/>I'm finished, and the result was: " + results;
          return asyncProcess("second");
        }).then(function(results){
          dom.byId("output").innerHTML += "<br/>I'm really finished now, and the result was: " + results;
        });
      });
      
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output">Not yet started.</div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example shows how ``.progress()`` and ``.reject()`` are used. You can see that while the `.resolve()` gets
  called, because the promise will already be fullfilled (by being rejected), the callback is never called.

  .. js ::

    require(["dojo/Deferred", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(Deferred, dom, on){
      function asyncProcess(msg){
        var deferred = new Deferred();
        
        dom.byId("output").innerHTML += "<br/>I'm running...";
        
        setTimeout(function(){
          deferred.progress("halfway");
        }, 1000);
        
        setTimeout(function(){
          deferred.resolve("finished");
        }, 2000);
        
        setTimeout(function(){
          deferred.reject("ooops");
        }, 1500);
        
        return deferred.promise;
      }
      
      on(dom.byId("startButton"), "click", function(){
        var process = asyncProcess();
        process.then(function(results){
          dom.byId("output").innerHTML += "<br/>I'm finished, and the result was: " + results;
        }, function(err){
          dom.byId("output").innerHTML += "<br/>I errored out with: " + err;
        }, function(progress){
          dom.byId("output").innerHTML += "<br/>I made some progress: " + progress;
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output">Not yet started.</div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  In this example, we have implemented the ability to ``.cancel()`` a Deferred.

  .. js ::

    require(["dojo/Deferred", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(Deferred, dom, on){
      function asyncProcess(){
        var timeout;
        var deferred = new Deferred(function(reason){
          clearTimeout(timeout);
          dom.byId("output").innerHTML += "<br/>I was cancelled with reason: " + reason;
        });
        
        dom.byId("output").innerHTML += "<br/>I'm running...";
        
        timeout = setTimeout(function(){
          dom.byId("output").innerHTML += "<br/>My process completed!";
          deferred.resolve("finished");
        }, 2000);
        
        return deferred.promise;
      }
      
      on(dom.byId("startButton"), "click", function(){
        var process = asyncProcess();
        process.then(function(results){
          dom.byId("output").innerHTML += "<br/>I'm finished, and the result was: " + results;
        });
        
        setTimeout(function(){
          process.cancel("goodbye");
        }, 1000);
      });
      
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output">Not yet started.</div>
    <button type="button" id="startButton">Start</button>

See also
========

* :ref:`dojo/promise <dojo/promise>` - The module that underpins ``dojo/Deferred``.

* :ref:`dojo/promise/Promise <dojo/promise/Promise>` - The underlying object used to provide the asynchronous thread
  communication.

* :ref:`dojo/when <dojo/when>` - The module that allows transparent management of promises and non-promise values.
