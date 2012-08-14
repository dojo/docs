.. _dojo/request/registry:

=====================
dojo/request/registry
=====================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/registry** is a module that provides the ability to register providers to handle requests based on
criteria such as the URL of the request.

Introduction
============

``dojo/request/registry`` allows for the registration of providers against a URL pattern or other criteria, which
is then matched when a request is made. This allows using the same API call across an application while using
multiple providers. An example of this would be using ``dojo/request/xhr`` for same domain requests and
``dojo/request/script`` for cross domain requests, but only ever calling ``dojo/request``.

Usage
=====

To use the registry, you need to require it, register providers, and make your requests:

.. js ::

  require(["dojo/request/registry", "dojo/request/xhr", "dojo/request/script"], function(request, xhr, script){
    // Register with a regex
    request.register(/^foo/, xhr);
    
    // Register with a string
    request.register("bar", script);
    
    // Register with a function and add to the beginning
    // of the list of providers using a truthy third argument
    request.register(function(url, options){
      // Return a truthy value if this provider should be matched, otherwise
      // return a falsey value
      return !!options.useXHR;
    }, xhr, true);
    
    // Will match the first registration
    request.get("foobar.html").then(function(text){
      // Do something with the response
    });
    
    // Will match the second registration
    request.get("bar").then(function(text){
      // Do something with the response
    });

    // Will match the third registration because
    // it was added to the beginning of the provider
    // list and will match before the first registration
    request.get("foo.html", {
      useXHR: true
    }).then(function(text){
      // Do something with the response
    });
    
    // Will use the fallback provider (the platform default unless explicitly set)
    request.get("somethingelse").then(function(response){
      // Do something with the response
    });
  });

As providers are registered, they are pushed onto the registry stack, whereby the first positive match encountered
is used. There is an optional third argument to ``register()`` which, if truthy, will put the provider being
registered at the top of the stack. If there are no matches, the registry will fallback to the platform default
provider.

The base function of the module conforms to the Request API and will use the default HTTP method of the matching
provider.

register()
----------

This registers a provider.  It takes up to three arguments:

======== ====================== ===================================================================================
Argument Type                   Description
======== ====================== ===================================================================================
url      String|RegExp|Function The criteria the registry should use to determine if ``provider`` should be used
                                to make a request. If this is a function, it should take two arguments and return
                                a truthy value if the provider should handle the request:
                                
                                * ``url`` - The URL being requested
                                
                                * ``options`` - The options being set on the request
                                
provider Function               The provider that should handle the request if matched.
first    Boolean?               *Optional* If truthy, the provider will be added to the beginning of the list of
                                providers, possibly overriding previously registered providers.
======== ====================== ===================================================================================

``register()`` returns a handle that can be used to remove the matcher from the stack:

.. js ::

  require(["dojo/request/registry", "dojo/request/xhr"], function(request, xhr){
    var handle = request.register("foobar", xhr);
    
    // ...
    
    handle.remove();
  });

get()
-----

Calls the mapped provider with a method of ``GET``.

post()
------

Calls the mapped provider with a method of ``POST``. Note that the you need to ensure that any matched provider
supports this method.

put()
-----

Calls the mapped provider with a method of ``PUT``. Note that the you need to ensure that any matched provider
supports this method.

delete()
--------

Calls the mapped provider with a method of ``DELETE``. Note that the you need to ensure that any matched provider
supports this method.

Examples
========

.. code-example ::

  This example will register a regular expression that will route anything that ends in ``.jsonp.js`` to the
  ``dojo/request/script`` provider; all other requests will go through the platform default provider (in the
  case of the browser, ``dojo/request/xhr``).

  .. js ::

    require(["dojo/request/registry", "dojo/request/script", "dojo/dom", "dojo/dom-construct", "dojo/on",
        "dojo/domReady!"], 
    function(request, script, dom, domConst, on){
      // Registers anything that ends in ".jsonp.js" be sent to the script provider
      request.register(/\.jsonp\.js$/i, script);
  
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<p>request: 'helloworld.jsonp.js'</p>", "output");
        request.get("helloworld.jsonp.js", {
          jsonp: "callback"
        }).then(function(data){
          domConst.place("<p>script data: <code>" + JSON.stringify(data) + "</code></p>", "output");
        });
        domConst.place("<p>request: 'helloworld.json'</p>", "output");
        request.get("helloworld.json", {
          handleAs: "json"
        }).then(function(data){
          domConst.place("<p>xhr data: <code>" + JSON.stringify(data) + "</code></p>", "output");
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

