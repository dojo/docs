.. _dojo/request/registry:

=====================
dojo/request/registry
=====================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/registry** is a module that provides the ability to register different providers to handle different URL
patterns.

Introduction
============

``dojo/request/registry`` allows for the registration of different providers against a URL pattern, which is then
matched against when a request is made. This allows for the ability for example to use ``dojo/request/xhr`` for same
domain requests and ``dojo/request/script`` for cross domain requests, allowing the same code path, irrespective of the
target of the request.

Usage
=====

To use the module, you need to require it in and register different providers by URL and then make your requests:

.. js ::

  require(["dojo/request/registry", "dojo/request/xhr", "dojo/request/script"], function(request, xhr, script){
    // Maps via a regex
    request.register(/^foo/, xhr);
    
    // Maps via a string
    request.register("bar", script);
    
    // Maps via a function
    request.register(function(url, options){
      // Return a truthy value if this provider should be matched, otherwise
      return false;
    }, xhr);
    
    // Will match the first registration
    request.get("foobar.html").then(function(response){
      // Do something with the response
    });
    
    // Will match the second registration
    request.get("bar").then(function(response){
      // Do something with the response
    });
    
    // Will use the fallback provider
    request.get("somethingelse").then(function(response){
      // Do something with the response
    });
  });

As matches are registered, they get pushed onto the stack, whereby the first match is used. There is the optional third
argument to ``register()`` that will put that registration at the top of the stack. If there are no matches, the
registry will fallback to the platform default provider.

The base function of the module is like other providers and will equivalent to the ``get()`` method.

register()
----------

This method maps a URL to a provider.  It takes up to three arguments:

======== ====================== ========================================================================================
Argument Type                   Description
======== ====================== ========================================================================================
url      String|RegExp|Function What the registry should use to match against requests made to find the appropriate 
                                provider.  If a function, it should take two argument and return true if the provider 
                                should handle the request:
                                
                                * ``url`` - The URL being requested
                                
                                * ``options`` - The options being set on the request
                                
provider Function               The provider that should handle the request if matched.
first    Boolean?               *Optional* If true, it will be unshifted onto the stack of matchers, thereby overriding 
                                previously registered matches.
======== ====================== ========================================================================================

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
  ``dojo/request/script`` provider, where everything else will will go to the platform default provider
  ``dojo/request/xhr``.

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
        }).then(function(response){
          domConst.place("<p>script repsonse.data: <code>" + JSON.stringify(response.data) + "</code></p>", "output");
        });
        domConst.place("<p>request: 'helloworld.json'</p>", "output");
        request.get("helloworld.json", {
          handleAs: "json"
        }).then(function(response){
          domConst.place("<p>xhr repsonse.data: <code>" + JSON.stringify(response.data) + "</code></p>", "output");
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

