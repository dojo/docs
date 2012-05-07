.. _quickstart/cross-domain:

=================
Cross-Domain Dojo
=================

:Author: Victor Danilchenko

.. contents ::
   :depth: 4

How to use Dojo's cross-domain distributions

Introduction
============

A cross-domain Dojo build is one which can be loaded from the server other than the one where the application deployment occurs. It can be a `custom build <custom-builds>`_ or a `CDN <http://en.wikipedia.org/wiki/Content_Delivery_Network>`_ distribution.

Advantages
----------

Disadvantages
-------------

Using a cross-domain Dojo distribution
======================================
CDN or a custom build?
----------------------
There is really no right answer. A CDN distribution delivers geographic caching of the Dojo files, allowing the user to retrieve them from a nearby location, which speeds up loading. A custom build, however, allows you to create layers (bundles of classes), also speeding up loading.

Available CDNs
--------------
In the examples below, 'VERSION' is the Dojo version you want to use, e.g. "1.2". While you can specify a more specific version, such as "1.2.3", it is recommended you use a major version number (1.2) -- newer dot-releases will be pushed to the /1.2/ URL automatically.

Google
~~~~~~
Google `hosts a cross-domain Dojo distribution <http://code.google.com/apis/ajaxlibs/documentation/#dojo>`_ and makes it available via `Google Ajax Libraries API <http://code.google.com/apis/ajaxlibs/>`_. You can use it either by direct loading:

.. html ::

  <script src="http://ajax.googleapis.com/ajax/libs/dojo/VERSION/dojo/dojo.js"></script>

or by using Google API:

.. html ::

  <script src="http://www.google.com/jsapi"></script>
  <script>
      google.load("dojo", "VERSION");
  </script>

Note that if you use the Google API, google.load must reside within its own <script> tag, if you intend to do any immediate Dojo manipulations, such as setting configuration parameters. See the code example below. Also, if you are using Google API, you still have to import CSS files explicitly.


AOL
~~~
AOL `also hosts a cross-domain Dojo distribution <http://dev.aol.com/dojo>`_. To use it, include the following script tag in your page:

.. html ::

  <script type="text/javascript" src="http://o.aolcdn.com/dojo/VERSION/dojo/dojo.js"></script>

Making a custom build
---------------------
See the :ref:`custom builds <quickstart/custom-builds>` page.


Caveats and Gotchas
-------------------
**Asynchronous loading**. You **must** use dojo.ready() to register a callback function to get notification of package loading. This can be used even after the initial page load. Just do the dojo.require()s that you need, and then call dojo.ready() with a callback function, and once those new packages are loaded (or if they are already loaded), then the callback will be called.

**Local blank page**. You have to save a local copy of a blank HTML page to location specified via 'dojoBlankHtmlUrl' configuration parameter, e.g.:

.. html ::

  <script type="text/javascript">
    var dojoConfig = {
      dojoBlankHtmlUrl = '/blank.html'
    };
  </script>

Multiple modules (dojo.io.iframe, dijit.Editor, dojo.back) require this to properly function under XD Dojo. **Note:** The dijit.Editor/dijit._editor.RichText has a bug in release 1.1.0 where it was not using this djConfig parameter. It is fixed in Dojo 1.1.1 and later.

**dojox.flash.Info()**: It uses document.write() which will cause problems if dojox.flash is loaded via dojo.require().

Usage example
=============

.. html ::

  <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/dojo/1.2/dijit/themes/tundra/tundra.css" />
  <script src="http://www.google.com/jsapi"></script>
  <script>google.load("dojo", "1.2");</script>
  <script>
      var dojoConfig = {
          parseOnLoad = true,
          dojoBlankHtmlUrl = '/blank.html'
      };
      
      function loader(){
          dojo.require("dijit.Editor");
          dojo.ready(callback);
      }

      function callback(){
          new dijit.Editor({}, dojo.byId("editorNode"));
      }

      dojo.ready(loader);
  </script>

  <div id="editorNode" class="tundra">Hello, world!</div>

Using CDN with Local modules
============================

Dojo 1.7+
---------

To use Dojo 1.7 or later from a CDN in conjunction with a local custom namespace, you can register your local namespace
in the ``packages`` array via ``dojoConfig``:

.. html ::

    <script type="text/javascript">
        var dojoConfig = {
            async: true,
            packages: [
                {
                    name: "my",
                    location: "/absolute/path/to/local/modules/my"
                }
            ]
        };
    </script>
    
    <!-- Bootstrap Dojo From Google's CDN -->
    <script
        type="text/javascript"
        src="http://ajax.googleapis.com/ajax/libs/dojo/1.7.1/dojo/dojo.js">
    </script>

    <script type="text/javascript">
        require(["my/FooModule"], function(FooModule){
            // ...
        });
    </script>

In this case, the file ``FooModule.js`` would be located at ``/absolute/path/to/local/modules/FooModule.js``,
absolute to the domain root.

Note that unlike with Dojo 1.6 and earlier (see below), the package location needs to specify an absolute path.
If necessary, it is possible to determine the path of the current web page via JavaScript; for example,
``location.pathname.replace(/\/[^/]+$/, "")`` will work for most cases.

**Note:** Dojo 1.7 currently has a limitation where it is unable to properly load local modules which use the legacy
``dojo.require`` syntax alongside ``dojo.js`` from another domain.  Currently the only workarounds are to update
the local modules to use AMD syntax, or download the Dojo Toolkit and run all modules from the same host.

Dojo <= 1.6
-----------

To use Dojo 1.6 or earlier from a CDN in conjunction with a local custom namespace, you must register the module path
via ``dojoConfig``:

.. html ::
  
    <script type="text/javascript">
        var dojoConfig = {
            baseUrl: "./",
            modulePaths: { my: "relative/path/to/local/modules/my" }
        };
    </script>
    
    <!-- Bootstrap Dojo From Google's CDN -->
    <script
        type="text/javascript"
        src="http://ajax.googleapis.com/ajax/libs/dojo/1.6.1/dojo/dojo.xd.js">
    </script>

    <script type="text/javascript">
        dojo.require("my.FooModule");
        // ...
    </script>


In this case, the file ``FooModule.js`` would be located at ``relative/path/to/local/modules/my/FooModule.js``,
relative to the web page.
