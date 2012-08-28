.. _dojo/request:

============
dojo/request
============

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request** is a package which provides asynchronous requests in a cross platform way. This is commonly
referred to as AJAX.

Introduction
============

**dojo/request** is comprised of several modules that provide functionality around asynchronous requests. It
leverages the :ref:`dojo/promise <dojo/promise>` API to manage the asynchronous communication. The concept is
that a *request* has a *provider*. The providers behave in similar way and have the same core API, but may add
additional interfaces as needed to fully support the functionality of the particular type of provider. The
following providers are available in ``dojo/request``:

* :ref:`dojo/request/xhr <dojo/request/xhr>` - Provides a cross browser compatible ``XmlHttpRequest``. It is
  the default provider for browser platforms.

* :ref:`dojo/request/node <dojo/request/node>` - Provides an asynchronous request for
  `node.js <http://nodejs.org/>`_. It is the default provider for node.js.

* :ref:`dojo/request/iframe <dojo/request/iframe>` - Provides an IFrame transport for the asynchronous request.
  This is useful in situations where files need to be submitted or certain cross domain situations.

* :ref:`dojo/request/script <dojo/request/script>` - Provides a transport where the return payload is expected
  to be embedded in a ``<script>`` tag.

By requiring the ``dojo/request`` module, it will return the default provider for the current platform.

Once the request is fulfilled, the response can be handled by a handler. ``dojo/request`` provides the following
handlers as a default:

* ``json`` - The response is expected to be JSON and is converted to an object.

* ``xml`` - The response is expected to be XML and is converted to an object.

* ``javascript`` - The response is expected to be JavaScript and ``eval()`` is used against the response.

In addition, :ref:`dojo/request/handlers <dojo/request/handlers>` provides a mechanism to register additional
handlers that then can be used to deal with different types of responses.

There are a few modules as part of the package which assist in managing requests:

* :ref:`dojo/request/notify <dojo/request/notify>` - Provides an :ref:`dojo/Evented <dojo/Evented>` interface
  for global request event notification.

* :ref:`dojo/request/registry <dojo/request/registry>` - Allows registering different providers by a URI pattern, so
  that different providers can be used based on the target URI without the user having to code separate code paths.

Usage
=====

Requiring the ``dojo/request`` module returns the default provider, so in most cases, all you need to do is simply
require that module and specify the resource you need. The most basic usage would look like this:

.. js ::

  require(["dojo/request"], function(request){
    request("request.html").then(function(data){
      // do something with handled data
    }, function(err){
      // handle an error condition
    }, function(evt){
      // handle a progress event
    });
  });

If the above was on a browser, ``dojo/request/xhr`` would have been used and if it was on node.js,
``dojo/request/node`` would have been used.

Providers take two arguments:

======== ======= ==================================================
Argument Type    Description
======== ======= ==================================================
url      String  The URL the request should be made to
options  Object? *Optional* A hash of any options for the provider.
======== ======= ==================================================

The ``options`` argument is dependent upon the provider, but some common options are:

============ ============= ========= =============================================================================
Property     Type          Default   Description
============ ============= ========= =============================================================================
data         String|Object ``null``  Data, if any, that should be sent with the request.
query        String|Object ``null``  The query string, if any, that should be sent with the request.
preventCache Boolean       ``false`` If ``true`` will send an extra query parameter to ensure the the server won't
                                     supply cached values.
method       String        ``GET``   The HTTP method that should be used to send the request.
timeout      Integer       ``null``  The number of milliseconds to wait for the response. If this time passes the
                                     request is canceled and the promise rejected.
handleAs     String        ``text``  The content handler to process the response payload with.
============ ============= ========= =============================================================================

The provider returns a promise (see :ref:`dojo/promise/Promise <dojo/promise/Promise>`) that is fulfilled with the
handled data of the response. The provider will also error out by calling the errorback function if provided.
Progress data will be given to the progress handler if it is provided and if the platform supports progress events
(any browser supporting XHR2 or node.js).

The promise returned by the provider has an extra property not on standard promises: ``response``. This property
is a standard promise that is fulfilled with an object representing the response from the server. This object
will contain the following properties:

===================== =================================================================
Property              Description
===================== =================================================================
url                   The URL that was originally requested.
options               Any options that were originally requested.
data                  Contains the data of the response if appropriate.
text                  Contains the text of the response if appropriate.
status                Contains the status of the request as returned from the provider.
getHeader(headerName) A function to retrieve headers sent from the server.
===================== =================================================================

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example retrieves a resource from the server and then outputs the results that are returned.

  .. js ::

    require(["dojo/request", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"], 
    function(request, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        request("request/helloworld.json").then(function(text){
          domConst.place("<p>response: <code>" + text + "</code>", "output");
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

See also
========

* :ref:`dojo/request/xhr <dojo/request/xhr>` - The default provider for browser platforms

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
