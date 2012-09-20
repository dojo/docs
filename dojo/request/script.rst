.. _dojo/request/script:

===================
dojo/request/script
===================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/script** is a provider that uses dynamic ``<script>`` tags to make requests and receive responses.
It is typically used when cross-domain requests need to be made.

Introduction
============

``dojo/request/script`` deprecates :ref:`dojo/io/script <dojo/io/script>` and is part of Dojo's Request API. It is
typically used in the scenario where a request needs to be made cross-domain (where the target domain is different
than the domain that was used to serve the requesting code). This is accomplished by dynamically inserting
``<script>`` tags into the body of the requesting document.

Because of the nature of the requests, JSONP is inherently supported (see:
`Wikipedia Article on JSON <http://en.wikipedia.org/wiki/JSONP>`_). This is essentially a JSON payload that is
wrapped with a callback function that is set up by the provider and executed once the server has completed its
response.

There are a couple of limitations to note with ``dojo/request/script``:

* It can only make requests that are ``GET`` requests. All other HTTP methods are not supported (``POST``,
  ``PUT`` and ``DELETE``).

* It cannot be used in synchronous mode like :ref:`dojo/request/xhr <dojo/request/xhr>`. This means that code using
  it **must** handle request asynchronously (which is easily done with the
  :ref:`dojo/promise/Promise <dojo/promise/Promise>` API).

Usage
=====

There are two main ways of retrieving data with ``dojo/request/script``: JSONP and "check string". To use JSONP
(which is recommended), set the ``jsonp`` option to the name of the query parameter the server is expecting the
name of the callback function to appear in. For instance, Yahoo! expects the name of the callback to use to
appear in the "callback" query parameter, so the ``jsonp`` option would need to be set to ``"callback"``. "Check
string" is a method in which a global variable will be populated with the data from the server; after injecting the
dynamic ``<script>`` element, the global variable is checked to see if it has been assigned to. To use "check
string", set the ``checkString`` option to the name of the global variable that is defined in the response from the
server. If either ``jsonp`` or ``checkString`` is not set, the provider will simply load and execute the script.
Note that for both ``jsonp`` and ``checkString``, data is not run through a response handler since both return
JavaScript objects; this means the ``handleAs`` option is ignored.

Making a JSONP request would look like this:

.. js ::

  require(["dojo/request/script"], function(script){
    script.get("something.js", {
      jsonp: "callback"
    }).then(function(data){
      // Do something with the response data
    }, function(err){
      // Handle the error condition
    });
    // Progress events are not supported
  });

**Note** ``dojo/request/script()`` and ``dojo/request/script::get()`` are exactly the same function, but ``.get()``
is provided to make this provider API compatible with other providers.

The provider takes two arguments:

======== ======= ===========================================
Argument Type    Description
======== ======= ===========================================
url      String  The URL that the request should be made to.
options  Object? *Optional* A hash of options.
======== ======= ===========================================

The ``options`` argument supports the following:

============ ============== ========= =============================================================================
Property     Type           Default   Description
============ ============== ========= =============================================================================
checkString  String         ``null``  The name of a variable that is defined in the loaded script that will
                                      determine if the request has finished.
jsonp        String         ``null``  The name of the query parameter the server expects the name of the callback
                                      function to appear in.
query        String|Object  ``null``  The query string, if any, that should be sent with the request.
preventCache Boolean        ``false`` If ``true`` will send an extra query parameter to ensure the browser and the 
                                      server won't supply cached values.
timeout      Integer        ``null``  The number of milliseconds to wait for the response. If this time passes the
                                      request is canceled and the promise rejected.
============ ============== ========= =============================================================================

``dojo/request/script()`` returns a promise that is fulfilled with the response. Errors will be directed to the
error callack if it is supplied. Progress events are unsupported.

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
        }).then(function(data){
          domConst.place("<p>response data: <code>" + JSON.stringify(data) + "</code></p>", "output");
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

* :ref:`dojo/request/registry <dojo/request/registry>` - Allows for registration of different providers against
  different URIs.

* :ref:`dojo/request/notify <dojo/request/notify>` - Publishes the ``dojo/request`` topics for requests.

* :ref:`dojo/Deferred <dojo/Deferred>` - The base class for managing asynchronous processes.

* :ref:`dojo/promise <dojo/promise>` - The package that provides the Dojo Promise API.
