.. _dojo/request/notify:

===================
dojo/request/notify
===================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/notify** is a module, that provides a :ref:`dojo/Evented <dojo/Evented>` object for subscribing
to global events emitted by the Request API.

Introduction
============

Loading the ``dojo/request/notify`` module will cause providers to emit events. Subscribing to these events can
then allow code to be notified when events happen within providers.

See :ref:`dojo/Evented <dojo/Evented>` for general information on subscribing to events.

Usage
=====

Requiring the module will enable the emission of and subscription to the events:

.. js ::

  require(["dojo/request", "dojo/request/notify"], function(request, notify){
    notify.on("start", function(){
      // Do something when the request queue has started
      // This event won't fire again until "stop" has fired
    });
    notify.on("send", function(response, cancel){
      // Do something before a request has been sent
      // Calling cancel() will prevent the request from
      // being sent
    });
    notify.on("load", function(response){
      // Do something when a request has succeeded
    });
    notify.on("error", function(error){
      // Do something when a request has failed
    });
    notify.on("done", function(responseOrError){
      // Do something whether a request has succeeded or failed
      if(responseOrError instanceof Error){
        // Do something when a request has failed
      }else{
        // Do something when a request has succeeded
      }
    });
    notify.on("stop", function(){
      // Do something when all in-flight requests have finished
    });
    
    request.get("something.json");
  });

The events supported are:

====== =========================== ============================================================
Event  Arguments                   Description
====== =========================== ============================================================
start  None                        In-flight requests have started
send   Response, Cancel function   Emitted prior to a provider sending data; calling cancel
                                   prevents the request from being sent
load   Response                    A request successfully completed
error  Response                    A request failed
done   Response                    A request has finished (regardless of success or failure)
stop   None                        All in-flight requests have finished
====== =========================== ============================================================

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example listens to all the events supported and then makes a request to retrieve some JSON and displays the
  results.

  .. js ::

    require(["dojo/request/xhr", "dojo/request/notify", "dojo/on", "dojo/dom", "dojo/dom-construct",
        "dojo/json", "dojo/domReady!"],
    function(xhr, notify, on, dom, domConst, JSON){
      notify.on("start", function(){
        domConst.place("<p>start</p>", "output");
      });
      notify.on("send", function(response, cancel){
        // cancel() can be called to prevent the request from
        // being sent
        domConst.place("<p>send: <code>" + JSON.stringify(response) + "</code></p>", "output");
      });
      notify.on("load", function(response){
        domConst.place("<p>load: <code>" + JSON.stringify(response) + "</code></p>", "output");
      });
      notify.on("error", function(response){
        domConst.place("<p>error: <code>" + JSON.stringify(response) + "</code></p>", "output");
      });
      notify.on("done", function(response){
        domConst.place("<p>done: <code>" + JSON.stringify(response) + "</code></p>", "output");
      });
      notify.on("stop", function(){
        domConst.place("<p>stop</p>", "output");
      });
    
      on(dom.byId("startButton"), "click", function(){
        xhr.get("helloworld.json", {
          handleAs: "json"
        }).then(function(data){
          domConst.place("<p>request data: <code>" + JSON.stringify(data) + "</code></p>", "output");
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

See also
========

* :ref:`dojo/request <dojo/request>` - The Request API package

* :ref:`dojo/Evented <dojo/Evented>` - The Evented API package

* :ref:`dojo/request/xhr <dojo/request/xhr>` - The default provider for browser platforms

* :ref:`dojo/request/node <dojo/request/node>` - The default provider for the node.js platform

* :ref:`dojo/request/iframe <dojo/request/iframe>` - A provider that uses IFrame for transport

* :ref:`dojo/request/script <dojo/request/script>` - A provider that expects the response to be embedded in a
  ``<script>`` tag.
