#format dojo_rst

Dojo Build System
=================

:Status: Draft
:Version: 1.0
:Project owner: (docs) Scott Jenkins
:Available: since 1.0

.. contents::
   :depth: 3

The Dojo build system is used to create efficient versions of Dojo customized for a particular application or web site.

============
Introduction
============

Dojo, in its default distribution, contains thousands of separate files and resources which may be used in any given web site or application. Each "`dojo.require <dojo/require>`_" statement on a given web page results a synchronous HTTP call to the web server to download the file containing that resource (dojo.require does check if the resource has already been loaded on the page, but every resource will need to be loaded once).  

Because browsers wait for each synchronous web call to finish before contacting the web server with the next synchronous call, this can substantially impair performance.  It can make your web page appear to take a very long time to load, or flash and redraw several times as Dojo resources are downloaded to the browser.

Furthermore, in the default distribution, most of the files are not `minified <http://en.wikipedia.org/wiki/Minify>`_, and larger files require more time and bandwidth to download to the page.

Dojo does not include a single file containing every possible dojo function, since this would very large (especially with optional modules from Dijit and Dojox); instead, the build system allows the creation of customized Dojo builds tailored to the needs of your particular web site.

What is a layer?
----------------

A *layer* is a single, usually minified, JavaScript file which combines all of the JavaScript code from multiple JavaScript files from the base Dojo distribution (as well as possibly your custom JavaScript code).  This single JavaScript layer file can then be included on the site using standard HTML ``script`` tags.  

You load a layer file into your web page using the normal <script> tags, similar to:

.. code-block :: html

  <script type="text/javascript" src="/custombuild/dojo/mylayer.js"></script>

JavaScript files specified in script tags download asynchronously from the web server, so more than one download can be in progress at once, making pages load faster.  Furthermore, since extra HTTP calls to the server are usually the single biggest factor in slow page loads, loading only one larger file (quite possibly from browser cache) instead of multiple little files makes your web page load much faster.

You can (and should) still use dojo.require to specify every Dojo module that you use in your web page.  Since dojo.require checks if the module has already been downloaded, a module will not be downloaded again if it was included in a layer on the page.

What should go in layers?
-------------------------

You should build layers appropriate to your application or web site, including the resources that are used on *most* of the pages *most* of the time.  For a simple web site, you can build a single layer file containing all of the most common resources, both from Dojo (including Dijit and Dojox).

More complicated websites can have multiple layers for different purposes.  Layers can include custom code from your own modules as well as those from the Dojo distribution.

It is not necessary to include absolutely every Dojo resource possible--instead, the goal is to include the most commonly used resources.  Any resources not available to a web page from one of the layers included on the page will be loaded synchronously by dojo.require.

You specify, via a build profile, exactly which resources to include in the layers that you build.  You should balance what is included in each layer, thus increasing its size, against how often the resources is used in your site.  Frequently used resources should be placed in a layer; rarely used resources do not need to be put in a layer.

Minification
------------

The Dojo build system can (and will by default) compress each layer with Shrinksafe, which provides a very effective minification.

Minificatation takes your JavaScript code and makes it smaller by, for example:

   * Removing all extra spaces and blank lines   
   * Removing comments
   * Making internal variable names (inside of functions, which are not visible to the caller of a function) shorter

Since layers can be large files, the minification can provide significant help in making them load faster--and, since they are smaller, they take less time for the browser's JavaScript engine to parse.

=============================
What does the build system do
=============================

The primary purpose of the build system is to create the layer files.  Overall, the build system does four things to enhance performance:

   1. First, it groups together modules into ''layers''
   2. Second, it ''interns'' external non-JavaScript files. This is most important for Dijit templates, which are kept in a separate HTML file. Interning pulls the entire file in and assigns it to a string.
   3. Third, it minifies the layer with ShrinkSafe. ShrinkSafe removes unneeded whitepsace and comments, and compacts variable names down to smaller ones. This file downloads and parses faster than the original.
   4. Finally, it copies all non-layered scripts to the appropriate places. While this doesn't speed anything up, it ensures that all Dojo modules can be loaded, even if not present in a layer. If you use a particular module only once or twice, keeping it out of the layers makes those layers load faster.

=============
Prerequisites
=============

To use the build system, you must have the following:

    1.  **A *source code version* of Dojo.**

        You can download one from `download.dojotoolkit.org <http://download.dojotoolkit.org/>`_.  

        Choose any release of Dojo (usually, you will choose the most recent), and be sure to select the source code build, which has `-src` in its file name:

        .. image :: dojo-download-src.png

        You can also obtain a source build of dojo from the Subversion source code tree.  TODOC:  Link to subversion page when it is available.

    2.  **A Java runtime envionment, version 1.4.2 or higher** on the machine you will use to create your custom build.  

        This is necessary because the builder, although written in JavaScript, requires the Rhino implementation of JavaScript to run it, and Rhino is built with Java.

        At a minimum, you must use Java 1.4.2; Java 1.5 or higher is recommended.

        You can download a Java runtime environment from `Sun's Java download page <http://www.java.com/en/download/index.jsp>`_.  At the time of this writing, this was at least Java 1.6.

    3.  Optionally, the source code tree for any custom built resources (JavaScript modules, CSS files, Dojo widgets, and so on) that you would like built into your custom build.

        As a best practice, your source tree should *not* be under your Dojo distribution's source tree.  By keeping it independent, you make it easier to make new builds when new versions of Dojo are available.

    4.  **A profile**, which you create, that controls how the build system creates your custom build.  For details on this, see the `build profiles page <build/profiles>`_.

========
Profiles
========

The profile is a file which defines exactly what the build system will include in your built version of dojo.  For a detailed discussion of the profile and all of its options, see `profiles <build/profiles>`_.

The profile should be a file named *something*\.profile\.js, and it contains a single JavaScript object called ``dependencies``.  The main property within ``dependencies`` is ``layers``, which is an array of definitions of the layers that should be built.

Here is a sample profile from the Dojo 1.2.3 release directory tree, ``/utils/buildscripts/profiles/layers.profile.js`` (many build profiles will not need all of the options and complexity that this one includes, but it shows the major features of the profile):

.. code-block :: javascript
   
	//This profile is used just to illustrate the layout of a layered build.
	//All layers have an implicit dependency on dojo.js.
	
	//Normally you should not specify a layer object for dojo.js. It is normally
	//implicitly built containing the dojo "base" functionality (dojo._base).
	//However, if you prefer the Dojo 0.4.x build behavior, you can specify a
	//"dojo.js" layer to get that behavior. It is shown below, but the normal
	//0.9 approach is to *not* specify it.
	
	//
	
	dependencies = {
		layers: [
			{
				//For 0.9 you normally do not specify a dojo.js layer.
				//Note that you do not need to specify dojo.js as a dependency for
				//other layers -- it is always an implicit dependency.
				name: "dojo.js",
				dependencies: [
					"dojo.parser"
				]
			},
			{
				//This layer will be discarded, it is just used
				//to specify some modules that should not be included
				//in a later layer, but something that should not be
				//saved as an actual layer output. The important property
				//is the "discard" property. If set to true, then the layer
				//will not be a saved layer in the release directory.
				name: "string.discard",
				resourceName: "string.discard",
				discard: true,
				//Path to the copyright file must be relative to
				//the util/buildscripts directory, or an absolute path.
				copyrightFile: "myCopyright.txt",
				dependencies: [
					"dojo.string"
				]
			},
			{
				name: "../dijit/dijit.js",
				resourceName: "dijit.dijit",
				layerDependencies: [
				"string.discard"
				],
				dependencies: [
					"dijit.dijit"
				]
			}
		],
	
		prefixes: [
			[ "dijit", "../dijit" ],
			[ "dojox", "../dojox" ]
		]
	}
	
	//If you choose to optimize the JS files in a prefix directory (via the optimize= build parameter),
	//you can choose to have a custom copyright text prepended to the optimized file. To do this, specify
	//the path to a file tha contains the copyright info as the third array item in the prefixes array. For
	//instance:
	//	prefixes: [
	//		[ "mycompany", "/path/to/mycompany", "/path/to/mycompany/copyright.txt"]
	//	]
	//
	//	If no copyright is specified in this optimize case, then by default, the dojo copyright will be used.

============
Build Script
============

To actually begin your build, you use the ``build.sh`` (for unix type environments) or ``build.bat`` file for Windows type environments.  For full details on the arguments to ``build``, see `build script <build/buildScript>`_.

A typical build invocation looks something like this:

.. code-block :: text

  build profile=layers action=release version=0.9.0

This illustrates the most important command line parameters to the build system:


``profile`` 
   The profile to be used for the build.  ``.profile.js`` is appended automatically.  The default directory is the ``/util/buildscripts/profiles`` directory within the Dojo source distribution.  However, most often you will want to reference a profile not within the source tree.

``action`` 
   The action the build is to perform.  The most common one is ``release`` to build a release build, doing the common behaviors.  Another option is ``clean`` to remove a build.

``version`` 
   The version number of the build.
   
TODOC: everything. outline here:

    * summary
    * requirements / setup DONE
    * creating a profile
    * command line arguments
    * special builds: * layers * css
    * file structure

link to full docs to cover:

=====================
Advanced Build Topics
=====================

The following build topics are for expert users, and not needed for routine builds:

    * conditional inclusion via the `excludeStart and exludeStop <build/exclude>`_ pragmas
    * prevent inlining of a resource named in a dojo.require with `keepRequires <build/keepRequires>`_
    * layerDependencies
    * discard
    * .uncompressed.js
    * create extremely small custom base ``Dojo.js`` builds with `customBase <build/customBase>`_
    * Faster loading of layer files by reducing dojo.provide usage with the `expandProvide <build/expand-provide>`_ parameter
    * Minimizing ``dojo.js`` for mobile platforms with the `webkitMobile <build/webkit-mobile>`_ parameter
    * more...

=======================
Build Build Scenarios
=======================

TODOC:  All of the following, with both build invocation command line and profile

Basic Scenarios
---------------

Base Build
~~~~~~~~~~

A simple default build that creates the basic distribution tree from the source tree:  `base build <build/scenario-base>`_

Dojo Core Only Build
~~~~~~~~~~~~~~~~~~~~

A small Dojo build which only builds the Dojo core into a layer, without dijit and the other name spaces:  `core build <build/scenario-core>`_

* Simple one-layer build of all required Dojo resources, including other dijit and dojox namespaces
* Single layer containing required resources from a custom namespace in addition to Dojo namespaces
* Simple cross-domain build
* Custom namespace build that works in conjunction with a cross-domain build without duplicating resources

Basic Cross Domain Build
~~~~~~~~~~~~~~~~~~~~~~~~

A basic cross-domain build of Dojo and some required components from dijit: `Basic cross domain build <build/scenario-xDomain>`_

Custom Namespace Scenarios
--------------------------

Same Domain
~~~~~~~~~~~

A same domain build creating a layer including both Dojo and custom namespace components:  `Custom module build <build/scenario-customModule`_

Cross Domain 
~~~~~~~~~~~~

A custom name space build which uses a cross domain built Dojo distribution for Dojo, dijit, and dojox resources, and a local file system build of the custom namespace for custom resources:  `Cross domain custom name space build <build/scenario-xDomainCustomModule>`_


Advanced and Special Purpose Scenarios
--------------------------------------

Micro Build
~~~~~~~~~~~

An absolutely minimal build of Dojo containing just the most essential core elements, suitable for smart phones and other resource-limited hosts:  Micro-build <build/scenario-micro>

* Others?
