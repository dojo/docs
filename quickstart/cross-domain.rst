#format dojo_rst

Cross-Domain Dojo
=================

:Status: Draft
:Version: 1.0
:Author: Victor Danilchenko

.. contents::
   :depth: 4

How to use Dojo's cross-domain distributions

============
Introduction
============

A cross-domain Dojo build is one which can be loaded from the server other than the one where the application deployment occurs. It can be a `custom build <quickstart/custom-builds>`_ or a `CDN <http://en.wikipedia.org/wiki/Content_Delivery_Network>`_ distribution.

Advantages
----------
#. You get more connections in MSIE, since you can load from another domain. Faster loading.
#. You get increased cacheability/startup if many of your applications use the same installation.
#. Resource loading does not block the rest of the page from filling in as with Dojo's normal, synchronous loading.
#. With a local install, your ISP may otherwise charge you for all of those Dojo bits that you are serving.

Disadvantages
-------------
#. You have to use a cross-domain build of Dojo. All CDN-hosted distributions are already XDified, but if you are using your own servers, you have to `build a custom Dojo distribution <quickstart/custom-builds>`_ for it.
#. The coding gets a little more complicated, as some things don't work the same in an XD build as in a local one. See 'Caveats and Gotchas' below.
#. You become dependent on the CDN's status. CDNs don't go down often, but when they do, your Dojo application may be impaired or even rendered temporarily useless.

======================================
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

.. code-block :: html

  <script src="http://ajax.googleapis.com/ajax/libs/dojo/VERSION/dojo/dojo.xd.js"></script>

or by using Google API:

.. code-block :: html

  <script src="http://www.google.com/jsapi"></script>
  <script>
      google.load("dojo", "VERSION");
  </script>

Note that if you use the Google API, google.load must reside within its own <script> tag, if you intend to do any immediate Dojo manipulations, such as setting configuration parameters. See the code example below. Also, if you are using Google API, you still have to import CSS files explicitly.


AOL
~~~
AOL `also hosts a cross-domain Dojo distribution <http://dev.aol.com/dojo>`_. To use it, include the following script tag in your page:

.. code-block :: html

  <script type="text/javascript" src="http://o.aolcdn.com/dojo/VERSION/dojo/dojo.xd.js"></script> 

Making a custom build
---------------------
See the `custom builds <quickstart/custom-builds>`_ page.


Caveats and Gotchas
-------------------
**Asynchronous loading**. You **must** use dojo.addOnLoad() to register a callback function to get notification of package loading. This can be used even after the initial page load. Just do the dojo.require()s that you need, and then call dojo.addOnLoad() with a callback function, and once those new packages are loaded (or if they are already loaded), then the callback will be called.

**Local blank page**. You have to save a local copy of a blank HTML page to location specified via 'dojoBlankHtmlUrl' configuration parameter, e.g.:

.. code-block :: html

  <script>
    dojo.config.dojoBlankHtmlUrl = '/blank.html';
  </script>

Multiple modules (dojo.io.iframe, dijit.Editor, dojo.back) require this to properly function under XD Dojo. **Note:** The dijit.Editor/dijit._editor.RichText has a bug in release 1.1.0 where it was not using this djConfig parameter. It is fixed in Dojo 1.1.1 and later.

**dojox.flash.Info()**: It uses document.write() which will cause problems if dojox.flash is loaded via dojo.require().

=============
Usage example
=============

.. code-block :: html

  <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/dojo/1.2/dijit/themes/tundra/tundra.css" />
  <script src="http://www.google.com/jsapi"></script>
  <script>google.load("dojo", "1.2");</script>
  <script>
      function loader () {
          dojo.require ("dijit.Editor");
          dojo.addOnLoad(callback);
      }    

      function callback () {
          new dijit.Editor ({}, dojo.byId("editorNode"));
      }

      dojo.config.parseOnLoad = true;
      dojo.config.dojoBlankHtmlUrl = '/blank.html';
      dojo.addOnLoad(loader);
  </script>

  <div id="editorNode" class="tundra">Hello, world!</div>

============================
Using CDN with Local modules
============================

To use Dojo from a CDN alongside your own local/custom namespace, you must register the module path via djConfig:

.. code-block :: html
  :linenos:

        <script type="text/javascript">
          djConfig={
            parseOnLoad: true, 
            isDebug: true,
            baseUrl: "./",
            modulePaths: { my: "relative/path/to/local/dijits" }
          };
      </script>
      
      <!-- Bootstrap Dojo From AOL's CDN-->
      <script 
          type="text/javascript"
          src="http://o.aolcdn.com/dojo/1.2/dojo/dojo.xd.js">
      </script>

      <script type="text/javascript">
          dojo.require("my.FooWidget");
      </script>


the file FooWidget.js would live in the path "relative/path/to/local/dijits/my/FooWidget.js"
