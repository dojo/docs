.. _dojo/promise/tracer:

===================
dojo/promise/tracer
===================

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/promise/tracer** enables tracing promise fulfilment.

Introduction
============

``dojo/promise/tracer`` will extend :ref:`dojo/promise/Promise <dojo/promise/Promise>` so that if ``.trace()`` or
``.traceRejected()`` will cause the promise to emit events. ``.trace()`` will enable the emission of ``resolved``,
``rejected`` and ``progress`` events. ``.traceRejected()`` will only enable the emission of ``rejected``.

The target of the events will be the Object returned from the module and the event arguments will be an array of the
result, plus whatever other arguments that were passed the ``.tracer()`` or ``.traceRejected()``.

Usage
=====

Usage requires requiring the ``dojo/promise/tracer`` module, enabling tracing on a promise and setting up event
handlers:

.. js ::

  require(["dojo/promise/tracer", "dojo/Deferred"], function(tracer)){
    // Create a deferred
    var deferred = new Deferred();
    // Enable tracing
    deferred.promise.trace();
    
    // Setup event handlers
    tracer.on("resolved", function(args){
      // Handle a resolved event
    });
    tracer.on("rejected", function(args){
      // Handle a rejected event
    });
    tracer.on("progress", function(args){
      // Handle a progress event
    });
  }

Any arguments passed to ``.trace()`` or ``.traceRejected()`` will be passed when the event is emitted and the module
instantiates a singleton object which is the target for all trace events.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  In this example, we create an async process which automatically turns on its own trace. Then we set our response to
  events on the tracer and then we start the process.

  .. js ::

    require(["dojo/promise/tracer", "dojo/Deferred", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on",
        "dojo/domReady!"],
    function(tracer, Deferred, dom, domConst, JSON, on){
      function asyncProcess(){
        var deferred = new Deferred();
        deferred.promise.trace();
        
        setTimeout(function(){
          deferred.progress("progress");
        }, 1000);
        
        setTimeout(function(){
          deferred.resolve("complete");
        }, 2000);
        
        return deferred;
      }
      
      tracer.on("progress", function(e){
        domConst.place("<p>progress: <code>" + JSON.stringify(e) + "</code></p>", "output");
      });

      tracer.on("rejected", function(e){
        domConst.place("<p>rejected: <code>" + JSON.stringify(e) + "</code></p>", "output");
      });

      tracer.on("resolved", function(e){
        domConst.place("<p>resolved: <code>" + JSON.stringify(e) + "</code></p>", "output");
      });
      
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Running...</p>", "output");
        asyncProcess().then(function(result){
          domConst.place("<p>then: <code>" + JSON.stringify(result) + "</code></p>", "output");
        });
      });
      
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

See also
========

* :ref:`dojo/promise <dojo/promise>` - The rest of Dojo's Promise API.

* :ref:`dojo/Deferred <dojo/Deferred>` - The base class for managing asynchronous thread communication in Dojo.

* :ref:`dojo/on <dojo/on>` - Dojo's general purpose event handler.
