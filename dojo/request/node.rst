.. _dojo/request/node:

=================
dojo/request/node
=================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/node** is a provider that uses `Node.js <http://nodejs.org/>`_\'s ``http`` or ``https`` modules to
perform an asynchronous request. It is the default provider for *node* based platforms.

Introduction
============

``dojo/request/node`` provides a consistent API interface for making requests within a *node* environment, which can
make it easier to manage your code both client side and server side. Once you have bootstrapped Dojo within node, you
can easily require in :ref:`dojo/request <dojo/request>` to return this module to handle your requests, or of course you
can require it in directly.

Usage
=====

Usage follows the client side API:

.. js ::

  require(["dojo/request/node"], function(nodeRequest){
    nodeRequest("http://localhost/example.json", {
      handleAs: "json"
    }).then(function(response){
      // Do something with the response
    }, function(err){
      // Handle the error condition
    }, function(evt){
      // Handle a progress event from the request
    });
  });

But it is preferred to require in the ``dojo/request`` module like the following, also specifying the method you intend
to use:

.. js ::

  require(["dojo/request"], function(request){
    request.get("http://localhost/example.json", {
      handleAs: "json"
    }).then(function(response){
      // Do something with the response
    }, function(err){
      // Handle the error condition
    }, function(evt){
      // Handle a progress event from the request
    });
  });

The progress event will contain any chunks of data (as a string) that have been returned as they are returned to the
request.

``dojo/request/node`` takes two arguments:

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
preventCache Boolean       ``false`` If ``true`` will send an extra query parameter to ensure the browser and the server 
                                     won't supply cached values.
method       String        ``GET``   The HTTP method that should be used to send the request.
headers      Object                  A hash of the custom headers to be sent with the request.  Defaults to none.
============ ============= ========= ===================================================================================

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

Because *node.js* is a server side technology, it is not possible to provide working *codeglass* examples for this
module. Here is a basic example of creating a server and then making a request of that server to retrieve some JSON:

.. js ::

  require(['require', 'dojo/request'], function(require, request){
    var http = require.nodeRequire('http'),
      timeout;

    var server = http.createServer(function(request, response){
      var body = '{ "foo": "bar" }';
      response.writeHead(200, {
        'Content-Length': body.length,
        'Content-Type': 'application/json'
      });
      response.write(body);
      response.end();
    });

    server.on('close', function(){
      if(timeout){ clearTimeout(timeout); }
    });

    server.on('listening', function(){
      request.get('http://localhost:8124', {
        handleAs: 'json',
        headers: { 'Range': '1-2' },
        timeout: 1000
      }).then(function(response){
        console.log(response.data);
        server.close();
      }, function(err){
        console.log(err);
        server.close();
      });
    });

    server.listen(8124);
  });

See also
========

* :ref:`dojo/request <dojo/request>` - The whole Dojo Request API

* :ref:`dojo/request/xhr <dojo/request/xhr>` - The default provider for browser based platforms

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
