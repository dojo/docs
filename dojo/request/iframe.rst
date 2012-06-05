.. _dojo/request/iframe:

===================
dojo/request/iframe
===================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/iframe** is a provider that uses the an IFrame to provide asynchronous request/responses.

Introduction
============

``dojo/request/iframe`` deprecates :ref:`dojo/io/iframe <dojo/io/iframe>` and is part of Dojo's Request API. It is designed to handle complex request/response scenarios which cannot be handled by the standard :ref:`dojo/request/xhr <dojo/request/xhr>`.  The two main scenarios are:

* Calling a service on a server other than the one that originated the calling page (cross-domain request). Note that in
  this case, the response body cannot be read. So you can send data, but not get any replies. If you need access to the
  return data, see :ref:`dojo/request/script <dojo/request/script>`.

* Uploading files from a form (e.g. file input controls). The normal XHR mechanism cannot access file data referenced by
  file selection tags as a security measure. ``dojo/request/iframe``, however, can by proxying those calls through an
  IFrame make it possible to still do file uploads in an asynchronous manner.

``dojo/request/iframe`` works similar to other providers, but it has some specific caveats because of the nature of the
mechanism.

Usage
=====

An example of making a request to retrieve some XML would look like:

.. js ::

  require(["dojo/request/iframe"], function(iframe){
    iframe("something.xml", {
      handleAs: "xml"
    }).then(function(response){
      // Do something with the response
    }, function(err){
      // Handle the error condition
    }, function(evt){
      // Handle a progress event from the request
    });
  });

``dojo/request/iframe`` takes two arguments:

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
data         String|Object  ``null``  Data, if any, that should be sent with the request.
query        String|Object  ``null``  The query string, if any, that should be sent with the request.
form         String|DomNode ``null``  The form, if any, that should be sent with the request.
preventCache Boolean        ``false`` If ``true`` will send an extra query parameter to ensure the browser and the 
                                      server won't supply cached values.
method       String         ``POST``  The HTTP method that should be used to send the request.  ``dojo/request/iframe``
                                      only supports ``POST`` and ``GET`` methods.
headers      Object         ``null``  A hash of the custom headers to be sent with the request.
============ ============== ========= ==================================================================================

``dojo/request/iframe()`` returns a promise that is fulfilled with the response. Errors will be directed to the errback
and progress to the progback if supplied.

get()
-----

Same as the base function, but the ``method`` is set to ``GET``.

post()
------

Same as the base function, but the ``method`` is set to ``POST``.

create()
--------

Creates an IFrame for handling requests and returns a reference to the IFrame. Normally this function does not need to
be called to use the provider.

doc()
-----

Returns a reference to the document for the supplied ``iframeNode``. Normally this function does not need to be called
to use the provider.

setSrc()
--------

Sets the source of an IFrame.  The function takes three arguments:

======== ======== ==================================================================
Argument Type     Description
======== ======== ==================================================================
iframe   DomNode  The reference to the IFrame node.
src      String   The new source.
replace  Boolean? Should the new source be set our replaced.  Defaults to ``false``.
======== ======== ==================================================================

Normally this function does not need to be called to use the provider.
  
Content Handling
----------------

**Important** If your payload is something other than *html* or *xml* (e.g. *text*, *JSON*) the server response needs to enclose the content in a ``<textarea>`` tag.  This is because this is the only cross-browser way for this provider to know when the content has been successfully loaded.  Therefore the server response should look something like this:

.. html ::

  <html>
    <body>
      <textarea>
        payload
      </textarea>
    </body>
  </html>

Where ``payload`` would be the content that you are actually attempting to load.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example retrieves some JSON from the server and then outputs the data that is returned.

  .. js ::

    require(["dojo/request/iframe", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"], 
    function(iframe, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        iframe.get("helloworld.json.html", {
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

    require(["dojo/request/iframe", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"], 
    function(iframe, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        iframe("nothing.xml").then(function(response){
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

  The following example demonstrates how to have the provider automatically post a form.

  .. js ::

    require(["dojo/request/iframe", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"], 
    function(iframe, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        iframe("helloworld.json.html",{ 
          form: "theForm",
          handleAs: "json"
        }).then(function(response){
          domConst.place("<p>response: <code>" + JSON.stringify(response.data) + "</code></p>", "output");
        });
      });
    });

  .. html ::

    <form id="theForm" method="post" enctype="multipart/form-data">
      <label for="field1">Field1</label><input type="text" name="field1" value="Hello" /><br />
      <label for="field1">Field1</label><input type="text" name="field1" value="World" /><br />
    </form>
    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

See also
========

* :ref:`dojo/request <dojo/request>` - The whole Dojo Request API

* :ref:`dojo/request/xhr <dojo/request/xhr>` - The default provider for a browser based platform

* :ref:`dojo/request/node <dojo/request/node>` - The default provider for the node.js platform

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
