#format dojo_rst

Dojo Build System
=================

:Status: Draft
:Version: 1.0
:Project owner: Scott Jenkins
:Available: since 1.0

.. contents::
   :depth: 2

The Dojo build system is used to create efficient versions of Dojo customized for a particular application or web site.

============
Introduction
============

Dojo, in its default distribution, contains thousands of separate files and resources which may be used in any given web site or application. Each dojo.require statement on a source page can result in a synchronous call to the server to download the file containing that resource, if it has not already been loaded in the current web site.  This can substantially impair performance.

Dojo does not include a single file containing every possible dojo function; instead, the build system allows the creation of customized Dojo builds that combine the resources needed for the application or web site.

What is a layer?
----------------

A *layer* produced by the Dojo build system is a single, usually compressed, JavaScript file which aggregates multiple JavaScript functions from the base Dojo distribution into a single file.  This file can then be included on the site using standard HTML ``script`` tags which download the entire file asynchronously (and quite possibly from browser cache) thus substantially improving performance of the web site.

When you dojo.require a resource that has already been included in a layer on the page, no additional HTML call to the web server will be required, because the resource is already in memory.

What should go in layers?
-------------------------

You should build layers appropriate to your application or web site, including the resources that are used on *most* of the pages *most* of the time.

You can have different layers for different purposes, if you have collections of pages with differing Dojo resource requirements.  It is not necessary to include absolutely every Dojo resource possible--instead, the goal is to include the most commonly used resources.  Any resources not available to a web page from one of the layers included on the page will be loaded synchronously by dojo.require.

Via the build profile, you specify exactly which resources to include in the layers that you build.  You should balance what is included in each layer, thus increasing its size, against how often the resources is used in your site.  Frequently used resources should be placed in a layer; rarely used resources do not need to be put in a layer.

Layers can be minified
----------------------

The Dojo build system can (and will by default) compress each layer with Shrinksafe, which provides a very effective minification of the source JavaScript code that contributes to the layer, while still exactly preserving all public names.

By using Shrinksafe, the size of the layer file is substantially reduced, thus enhancing download speed.

TODOC: everything. outline here:

    * summary
    * requirements / setup
    * creating a profile
    * command line arguments
    * special builds: * layers * css
    * file structure

link to full docs to cover:

    * excludeStart/Stop
    * restoreRequire
    * layerDependencies
    * discard
    * .uncompressed.js
    * customBase
    * more...
