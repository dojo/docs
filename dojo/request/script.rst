.. _dojo/request/script:

===================
dojo/request/script
===================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/script** is a provider that uses dynamic ``<script>`` tags to makes requests and received responses.  It is typically used when cross-domain requests need to be made.

Introduction
============

``dojo/request/script`` deprecates :ref:`dojo/io/script <dojo/io/script>` and is part of Dojo's Request API. This is
typically used in the scenario where a request needs to be made cross-domain (where the target domain is different than
the domain that was used to serve the requesting code). This is accomplished by dynamically inserting ``<script>`` tags
into the body of the requesting document.

Because of the nature of the requests, inherently JSONP is supported (see: `Wikipedia Article on JSON <http://en.wikipedia.org/wiki/JSONP>`_). This essentially a JSON payload that is wrapped with a callback function that
is executed by the provider in order to evaluate the JSON.

There are a couple of limitations to note with ``dojo/request/script``:

* It can only make requests that are essentially ``GET`` requests. Therefore the other HTTP methods are not supported
  (``POST``, ``PUT`` and ``DELETE``).

* It cannot be used in a synchronous mode, like :ref:`dojo/request/xhr <dojo/request/xhr>`. This means that code using
  it must be asynchronous aware.

Usage
=====

There are two main ways of retrieving data with ``dojo/request/script``. There is the JSONP method and there is the
"check string" method. When using JSONP, set the ``jsonp`` option to the name of the appropriate callback function in
the loaded JavaScript file that will return the data structure. With "check string", set the ``checkString`` property to
the name of a variable that is defined in the JavaScript file that would indicate that the file is properly loaded.  If there is neither ``jsonp`` or ``checkString`` set, the provider will simply load and execute the script.

Making a JSONP request would look like this:

.. js ::

  require(["dojo/request/script"], function(script){
    script.get("something.js", {
      jsonp: "callback"
    }).then(function(response){
      // Do something with the response
    }, function(err){
      // Handle the error condition
    }, function(evt){
      // Handle a progress event from the request
    });
  });

**Note** ``dojo/request/script()`` and ``dojo/request/script::get()`` are exactly the same function, but the ``.get()``
is provided to make this provider API compatible with other providers.

The provider takes two arguments:

======== ======= ===========================================
Argument Type    Description
======== ======= ===========================================
url      String  The URL that the request should be made to.
options  Object? *Optional* A hash of options.
======== ======= ===========================================

The ``options`` argument supports the following:

============ ============== ========= ==================================================================================
Property     Type           Default   Description
============ ============== ========= ==================================================================================
checkString  String         ``null``  The name of something that is defined in the loaded script that will determine 
                                      that it has been loaded properly.
jsonp        String         ``null``  The name of the callback function that should be called once the script is loaded
                                      that will return the requested JSON data.
query        String|Object  ``null``  The query string, if any, that should be sent with the request.
preventCache Boolean        ``false`` If ``true`` will send an extra query parameter to ensure the browser and the 
                                      server won't supply cached values.
============ ============== ========= ==================================================================================

``dojo/request/script()`` returns a promise that is fulfilled with the response. Errors will be directed to the errback
and progress to the progback if supplied.

get()
-----

This is a synonym for the base function of the module.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example retrieves some JSONP from a webserver and returns the response in the ``data`` property.

  .. js ::

    require(["dojo/request/script", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"], 
    function(script, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        script.get("helloworld.jsonp.js", {
          jsonp: "callback"
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

* :ref:`dojo/request/xhr <dojo/request/xhr>` - The default provider for a browser based platform

* :ref:`dojo/request/node <dojo/request/node>` - The default provider for the node.js platform

* :ref:`dojo/request/iframe <dojo/request/iframe>` - A provider that uses IFrame for transport

* :ref:`dojo/request/handlers <dojo/request/handlers>` - Handles the data from a response as designated in the
  ``handleAs`` request option. Also provides the ability to register additional types of handlers.

* :ref:`dojo/request/registry <dojo/request/registry>` - Allows for registration of different providers against
  different URIs.

* :ref:`dojo/request/notify <dojo/request/notify>` - Publishes the ``dojo/request`` topics for requests.

* :ref:`dojo/request/watch <dojo/request/watch>` - Allows the watching of inflight requests.

* :ref:`dojo/Deferred <dojo/Deferred>` - The base class for managing asynchronous processes.

* :ref:`dojo/promise <dojo/promise>` - The package that provides the Dojo Promise API.
