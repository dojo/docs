.. _dojo/request/notify:

===================
dojo/request/notify
===================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/notify** is a module, when loaded, will cause providers to publish topics related to requests that can be
subscribed to.

Introduction
============

Loading the ``dojo/request/notify`` module will cause providers to publish topic events. Subscribing to these events can
then allow code to be notified when events happen within providers.

See :ref:`dojo/topic <dojo/topic>` for general information on subscribing to topics.

Usage
=====

Just requiring in the module will enable the publications of the topics:

.. js ::

  require(["dojo/request", "dojo/topic", "dojo/request/notify"], function(request, topic){
    topic.subscribe("dojo/request/start", function(data){
      // Do something on "dojo/request/start"
    });
    topic.subscripe("dojo/request/send", function(data){
      // Do something on "dojo/request/send"
    });
    topic.subscribe("dojo/request/load", function(data){
      // Do something on "dojo/request/load"
    });
    topic.subscribe("dojo/request/error", function(data){
      // Do something on "dojo/request/error"
    });
    topic.subscribe("dojo/request/done", function(data){
      // Do something on "dojo/request/done"
    });
    topic.subscribe("dojo/request/stop", function(data){
      // Do something on "dojo/request/stop"
    });
    
    request.get("something.json");
  });

The topics supported are:

================== ============================================================
Topic              Description
================== ============================================================
dojo/request/start Called once when the provider starts a request
dojo/request/send  Called every time a provider sends
dojo/request/load  Called when a provider load event occurs
dojo/request/error Called when a provider error event occurs
dojo/request/done  Called every time a provider finishes a request
dojo/request/stop  Called once once when all the requests have published a done
================== ============================================================

Each topic publish contains a single argument. The contents of the argument will vary based on the capabilities of the
provider.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example subscribes to all the topics supported and then makes a request to retrieve some JSON and displays the
  results.

  .. js ::

    require(["dojo/request/xhr", "dojo/topic", "dojo/on", "dojo/dom", "dojo/dom-construct", "dojo/json",
        "dojo/request/notify", "dojo/domReady!"],
    function(xhr, topic, on, dom, domConst, JSON){
      topic.subscribe("dojo/request/start", function(data){
        domConst.place("<p>dojo/request/start: <code>" + JSON.stringify(data) + "</code>", "output");
      });
      topic.subscribe("dojo/request/send", function(data){
        domConst.place("<p>dojo/request/send: <code>" + JSON.stringify(data) + "</code>", "output");
      });
      topic.subscribe("dojo/request/load", function(data){
        domConst.place("<p>dojo/request/load: <code>" + JSON.stringify(data) + "</code>", "output");
      });
      topic.subscribe("dojo/request/error", function(data){
        domConst.place("<p>dojo/request/error: <code>" + JSON.stringify(data) + "</code>", "output");
      });
      topic.subscribe("dojo/request/done", function(data){
        domConst.place("<p>dojo/request/done: <code>" + JSON.stringify(data) + "</code>", "output");
      });
      topic.subscribe("dojo/request/stop", function(data){
        domConst.place("<p>dojo/request/stop: <code>" + JSON.stringify(data) + "</code>", "output");
      });
    
      on(dom.byId("startButton"), "click", function(){
        xhr.get("helloworld.json", {
          handleAs: "json"
        }).then(function(response){
          domConst.place("<p>request response.data: <code>" + JSON.stringify(response.data) + "</code>", "output");
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

* :ref:`dojo/request/xhr <dojo/request/xhr>` - The default provider for browser platforms

* :ref:`dojo/request/node <dojo/request/node>` - The default provider for the node.js platform

* :ref:`dojo/request/iframe <dojo/request/iframe>` - A provider that uses IFrame for transport

* :ref:`dojo/request/script <dojo/request/script>` - A provider that expects the response to be embedded in a
  ``<script>`` tag.
