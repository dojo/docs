.. _dojo/request/handlers:

=====================
dojo/request/handlers
=====================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/handlers** is a module that provides handlers that deal with the data that is returned in a
response to a request.

Introduction
============

``dojo/request/handlers`` provides handlers that will convert the response payload into a data object. By
setting the ``handleAs`` option to a request, the returned promise will resolve to the resulting data object
rather than the text of the response payload. The returned promise's ``response`` property will resolve to an
object with a ``data`` property that is converted data object. The standard handlers are:

* ``json`` - Will attempt to parse the response as a JSON string.

* ``javascript`` - The response will be assumed to be JavaScript and be ``eval()``/ed.

* ``xml`` - The response will be treated as XML.

``dojo/request/handlers`` allows registration of custom handlers using the ``.register()`` function.

Usage
=====

register()
----------

Normally, ``dojo/request/handlers`` is not used directly, except when you want to register a new handler type. In
that case, usage would look like this:

.. js ::

  require([
    "dojo/request/handlers",
    "dojo/request"
  ], function(handlers, request){
    handlers.register("split", function(response){
      // Do something with response.text
      return response.text.split(",");
    });
    
    request("http://example.com/something", {
      handleAs: "split"
    }).then(function(data){
      // data contains an array of strings
    });
  });

Whatever a handler returns, when used as the handler, will be what the returned promise resolves to and will be put
into the ``data`` property of the object the ``response`` promise resolves to. The payload of the un-handled
response is in the ``text`` property of the object the ``response`` promise resolves to.

``.register()`` takes two arguments:

======== ======== ===================================================================================
Argument Type     Description
======== ======== ===================================================================================
name     String   The name that will be matched when ``handleAs`` option is specified in a a request.
handler  Function The function that handles the response and returns the converted object.
======== ======== ===================================================================================

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example retrieves a JSON resource, which is set to be handled as ``json`` and outputs ``data``, which will
  be a JavaScript object that has been converted from the JSON.

  .. js ::

    require(["dojo/request", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"],
    function(request, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        request("./helloworld.json", {
          handleAs: "json"
        }).then(function(data){
          domConst.place("<p>data: <code>" + JSON.stringify(data) + "</code>", "output");
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example retrieves an XML resource, which is set to be handled as ``xml`` and outputs ``data``, which will be
  an XML document object created from the XML text.

  .. js ::

    require(["dojo/request", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"],
    function(request, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        request("./helloworld.xml",{
          handleAs: "xml"
        }).then(function(xmldoc){
          domConst.place("<p>xmldoc: <code>" + JSON.stringify(xmldoc) + "</code>", "output");
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example retrieves a JavaScript resource, which is set to be handled as ``javascript`` and outputs ``data``,
  which will be the result of calling ``eval()`` in the global scope on the text of the response.

  .. js ::

    require(["dojo/request", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"],
    function(request, dom, domConst, JSON, on){
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        request("./helloworld.js",{
          handleAs: "javascript"
        }).then(function(data){
          domConst.place("<p>data: <code>" + JSON.stringify(data) + "</code>", "output");
        });
      });
    });

  .. html ::

    <h1>Output:</h1>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example registers a custom handler and requests a resource that will be handled by the custom handler.

  .. js ::

    require(["dojo/request/handlers", "dojo/request", "dojo/dom", "dojo/dom-construct", "dojo/json",
        "dojo/on", "dojo/domReady!"],
    function(handlers, request, dom, domConst, JSON, on){
      handlers.register("custom", function(response){
        var data = JSON.parse(response.text);
        data.hello += "!";
        return data;
      });
      
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>Requesting...</p>", "output");
        request("./helloworld.json", {
          handleAs: "custom"
        }).then(function(data){
          domConst.place("<p>data: <code>" + JSON.stringify(data) + "</code>", "output");
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

