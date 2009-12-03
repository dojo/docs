#format dojo_rst

dojox.rpc.Service
=================

:Author: Kris Zyp and Dustin Machi
:Available: since V?

.. contents::
    :depth: 2

dojox.rpc.Service is the foundation of most `RPC <dojox/rpc>`_ transportation. To use a Service, you need an SMD. Defining the SMD is a separate discussion, so for now we'll reuse some pre-defined SMD's available in the RPC project's `SMDLibrary/ <dojox/rpc/SMDLibrary>`_ folder.

First, you need the code:

.. code-block :: javascript

  dojo.require("dojox.rpc.Service");

There are several transports/envelopes that are defined in separate modules to minimize the size of dojox.rpc.Service. These must also be loaded if they are used by the SMD:

* JSONP Transport requires `dojo.io.script <dojo/io/script>`_

* REST transport requires `dojox.rpc.Rest <dojox/rpc/Rest>`_

* JSON-RPC-2.0 and JSON-RPC-1.0 envelopes require `dojox.rpc.JsonRPC <dojox/rpc/JsonRPC>`_  

All of the provided SMDLibrary SMD's are based on JSONP, and consequently require `dojo.io.script <dojo/io/script>`_. If you define your own SMD with a local target endpoint, `dojo.io.script <dojo/io/script>`_ is not needed.

==================
Starting a Service 
==================

Service is a constructor, returning a pointer to the API defined in the SMD. 

.. code-block :: javascript

  var goog = new dojox.rpc.Service(dojo.moduleUrl("dojox.rpc","SMDLibrary/google.smd"));

The ``google.smd`` file is located in a fixed location, available from `dojo.moduleUrl <dojo/moduleUrl>`_ calculations. 

If the argument passed to ``new Service()`` is an object, it is assumed to be the direct service definition:

.. code-block :: javascript

  var goog = null;
  dojo.xhrGet({
     url: dojo.moduleUrl("dojox.rpc", "SMDLibrary/google.smd"),
     handleAs: "json",
     load: function(data){
         goog = new dojox.rpc.Service(data);
     }
  });

Or if it is a string, it will be treated as a URL, and the above code will be run for you:

.. code-block :: javascript

  // assuming your dojox/ is in js/ 
  var goog = new dojox.rpc.Service("js/dojox/rpc/SMDLibrary/google.smd"); 

Additionally, in 1.2 you are able to take advantage of `scriptFrame <dojox/io/scriptFrame>`_ transport, which will divert all traffic through a hidden iframe, preventing other `io.script <dojo/io/script>`_ processes from being 'blocked' while they wait on response data.
Simply provide a ``frameDoc`` attribute and passed as an optional parameter to the constructor:

.. code-block :: javascript

  dojo.require("dojox.io.scriptFrame");
  dojo.require("dojox.rpc.Service");
  var goog = new dojox.rpc.Service("js/dojox/rpc/SMDLibrary/google.smd", {
      frameDoc:"someIframeID"
  });

An iframe will be created if one cannot be found.

===============
Using a Service 
===============

Service, like io.script, works around Dojo's built in `Deferred <dojo/Deferred>`_ system, providing asynchronous communication around a familiar API. Once we've created our Service from an SMD, the methods defined in the SMD are available through the return handle provided. 

.. code-block :: javascript

  var goog = new dojox.rpc.Service(dojo.moduleUrl("dojox.rpc.SMDLibrary", "google.smd"));
  goog.webSearch({ q:"Dojo Toolkit" })
      .addCallback(function(data){
         // in this particular RPC call, the results you seek are:
         console.log(data.responseData.results);
      })
      .addErrback(function(data){
         // an error occured. timeout, bad data, etc.
      });

This will trigger a web search for the phrase "Dojo Toolkit", and fire your callback function when complete. 

If you are unfamiliar with `Deferreds <dojo/Deferred>`_, you should dig deeper. You will thank us later. 

=====================
Creating your own SMD
=====================

Please see http://groups.google.com/group/json-schema/web/service-mapping-description-proposal for a definition of the SMD format and how to define your own.
