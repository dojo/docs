.. _dojo/request/xhr:

================
dojo/request/xhr
================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/xhr** is a provider that uses the XmlHttpRequest (XHR) to provide asynchronous request/responses. It is
the default provider for browser based platforms.

Introduction
============

``dojo/request/xhr`` deprecates :ref:`dojo/_base/xhr <dojo/_base/xhr>` and is part of Dojo's Request API. XmlHttpRequest
(XHR) is the core of AJAX development and provides an asynchronous way for sending and receiving information in a
browser based platform. This module is implemented in a cross-browser fashion so that end developer don't need to be
aware of the differences between different browsers in order to use the functionality.

Of course, aim of the Request API is to further abstract the end developers from even having to code for the particular
platform they are on, and requiring the :ref:`dojo/request <dojo/request>` module would automatically load the
``dojo/request/xhr`` module if the code was running on a browser, but of course the module can be required directly if
desired.

Usage
=====

An example of making a request to retrieve some JSON would look like:

.. js ::

  require(["dojo/request/xhr"], function(xhr){
    xhr("example.json", {
      handleAs: "json"
    }).then(function(response){
      // Do something with the response
    }, function(err){
      // Handle the error condition
    }, function(evt){
      // Handle a progress event from the request
    });
  });

``dojo/request/xhr`` takes two arguments:

======== ======= ===========================================
Argument Type    Description
======== ======= ===========================================
url      String  The URL that the request should be made to.
options  Object? *Optional* A hash of options.
======== ======= ===========================================

The ``options`` argument supports the following:

============ ============= ========= ===================================================================================
Property     Type          Default   Description
============ ============= ========= ===================================================================================
data         String|Object ``null``  Data, if any, that should be sent with the request.
query        String|Object ``null``  The query string, if any, that should be sent with the request.
sync         Boolean       ``false`` If the request should be blocking or not.  If ``true`` the request will block until 
                                     the request is resolved.
preventCache Boolean       ``false`` If ``true`` will send an extra query parameter to ensure the browser and the server 
                                     won't supply cached values.
method       String        ``GET``   The HTTP method that should be used to send the request.
headers      Object                  A hash of the custom headers to be sent with the request.  Defaults to:

                                     .. js ::

                                       { 'Content-Type': 'application/x-www-form-urlencoded' }
============ ============= ========= ===================================================================================

``dojo/request/xhr()`` returns a promise that is fulfilled with the response. Errors will be directed to the errback and
progress to the progback if supplied.

The provider defaults to ``GET`` but the ``method`` option can be used to expressly set the method. Also there are
helper functions for common methods:

get()
-----

Same as the base function, but the ``method`` is set to ``GET``.

post()
------

Same as the base function, but the ``method`` is set to ``POST``.

put()
-----

Same as the base function, but the ``method`` is set to ``PUT``.

del()
-----

Same as the base function, but the ``method`` is set to ``DELETE``.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example retrieves some JSON from the server and then outputs the data that is returned.

  .. js ::

    require(["dojo/request/xhr", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"], 
    function(xhr, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        xhr("helloworld.json", {
          handleAs: "json"
        }).then(function(response){
          domConst.place("<p>response: <code>" + JSON.stringify(response.data) + "</code></p>", "output");
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example intentionally attempts to retrieve a resource that doesn't exist in order to demonstrate how the error
  handling works.

  .. js ::

    require(["dojo/request/xhr", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"], 
    function(xhr, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        xhr("nothing.json").then(function(response){
          domConst.place("<p>response: <code>" + JSON.stringify(response) + "</code></p>", "output");
        }, function(err){
          domConst.place("<p>error: <p>" + err.response.text + "</p></p>", "output");
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  The following example demonstrates how to set query parameters. *Note:* you will need to inspect developer's tools to
  see the request being sent with the parameters.

  .. js ::

    require(["dojo/request/xhr", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"], 
    function(xhr, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        xhr("helloworld.json",{ 
          query: {
            key1: "value1",
            key2: "value2"
          },
          handleAs: "json"
        }).then(function(response){
          domConst.place("<p>response: <code>" + JSON.stringify(response.data) + "</code></p>", "output");
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

See also
========

* :ref:`dojo/request <dojo/request>` - The whole Dojo Request API

* :ref:`dojo/request/node <dojo/request/node>` - The default provider for the node.js platform

* :ref:`dojo/request/iframe <dojo/request/iframe>` - A provider that uses IFrame for transport

* :ref:`dojo/request/script <dojo/request/script>` - A provider that expects the response to be embedded in a
  ``<script>`` tag.

* :ref:`dojo/request/handlers <dojo/request/handlers>` - Handles the data from a response as designated in the
  ``handleAs`` request option. Also provides the ability to register additional types of handlers.

* :ref:`dojo/request/registry <dojo/request/registry>` - Allows for registration of different providers against
  different URIs.

* :ref:`dojo/request/notify <dojo/request/notify>` - Publishes the ``dojo/request`` topics for requests.

* :ref:`dojo/request/watch <dojo/request/watch>` - Allows the watching of inflight requests.

* :ref:`dojo/Deferred <dojo/Deferred>` - The base class for managing asynchronous processes.

* :ref:`dojo/promise <dojo/promise>` - The package that provides the Dojo Promise API.
