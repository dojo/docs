#format dojo_rst

Dojo Build System
=================

:Status: Draft
:Version: 1.0
:Project owner: (docs) Scott Jenkins
:Available: since 1.0

.. contents::
   :depth: 3

The Dojo build system creates efficient versions of Dojo and application modules for deployment.

============
Introduction
============

Dojo, in its source distribution, contains thousands of separate files and resources which are available to any app via the package system. Normally each "`dojo.require <dojo/require>`_" statement results in a synchronous HTTP call to the server to retrieve a resource (`dojo.require` avoids re-requesting resources that have already been loaded, but the module needs to be loaded before it can be used).  

Because browsers wait for each synchronous web call to finish before allowing anything else to happen, this can substantially impair performance. Large apps that have many dependencies can take a very long time to load when a build isn't used, or flash and redraw several times.

Furthermore, in the source distribution, files are not `minified <http://en.wikipedia.org/wiki/Minify>`_, and larger files require more time and bandwidth to download to the page.

Dojo does not include a single file containing every possible dojo function, since this would be very large (especially with optional modules from Dijit and Dojox); instead, the build system allows the creation of customized Dojo builds tailored to the needs of your particular web site. Better yet, the build system works with the packaging tools to allow you to make *your* modules faster too.

What is a layer?
----------------

A *layer* is a single, minified JavaScript file which combines all of the JavaScript code from multiple source files, including dependencies. This file can then be included on the site using standard HTML ``script`` tags.

You load a layer file into your web page using the normal `<script>` tags, similar to:

.. code-block :: html

  <!-- dojo.js always provides the package system and base utilities -->
  <script type="text/javascript" src="/js/src/dojo/dojo.js"></script>
  
  <!-- we want dijit.js to be treated like a layer of its own -->
  <script type="text/javascript" src="/js/src/dijit/dijit.js"></script>
  
  <!-- include the rest of the modules we need -->
  <script type="text/javascript" src="/js/src/acme/mylayer.js"></script>

JavaScript files specified in script tags download asynchronously from the web server, but in modern browsers execution order is guaranteed, so more than one download can be in progress at once, making pages load faster. Since extra HTTP calls to the server are usually the single biggest factor in slow page loads, loading only one larger file (quite possibly from browser cache) instead of multiple little files makes your web page load much faster.

We use ``dojo.require`` to specify modules that an app needs, but larger Dojo apps put this list of requirements into a single file that *only* includes a list of dependencies. The source version of ``mylayer.js`` might read like this:

.. code-block :: javascript
   
   // this file is located at:
   //
   //   <server_root>/js/src/acme/mylayer.js
   
    // This is a layer file. It's like any other Dojo module, except that we
    // don't put any code other than require/provide statements in it. When we
    // make a build, this will be replaced by a single minified copy of all
    // the modules listed below, as well as their dependencies, all in the
    // right order:
    
    dojo.provide("acme.mylayer");
    
    // some basics
    dojo.require("dojo.parser");
    dojo.require("dijit.dijit");
    dojo.require("dojo.NodeList-fx");
    
    // it's a pretty sophisticated app, needs grids and border containers
    dojo.require("dojox.grid.DataGrid");
    dojo.require("dijit.layout.BorderContainer");
    
    // we need the full suite of django templating
    dojo.require("dojox.dtl");
    dojo.require("dojox.dtl.tag.logic");
    dojo.require("dojox.dtl.filter.misc");
    dojo.require("dojox.dtl.filter.logic");
    dojo.require("dojox.dtl.Context");
    dojo.require("dojox.dtl._Templated");
    
    // finally, some app-specific modules
    dojo.require("acme.base");
    dojo.require("acme.controllers");
    dojo.require("acme.CustomDataStore");

Since ``dojo.require`` checks if the module has already been downloaded, a module will not be downloaded again if it was included in a layer on the page.

What should go in layers?
-------------------------

You should build layers appropriate to your application or web site, including the resources that are used on *most* of the pages *most* of the time.  For a simple web site, you can build a single layer file containing all of the most common resources, both from Dojo (including Dijit and Dojox).

More complicated websites can have multiple layers for different purposes.  Layers can include custom code from your own modules as well as those from the Dojo distribution.

It is not necessary to include absolutely every Dojo resource possible--instead, the goal is to include the most commonly used resources.  Any resources not available to a web page from one of the layers included on the page will be loaded synchronously by dojo.require.

You specify, via a build profile, exactly which resources to include in the layers that you build.  You should balance what is included in each layer, thus increasing its size, against how often the resources is used in your site.  Frequently used resources should be placed in a layer; rarely used resources may not need to be put in a layer. Think of it as a dial you can turn depending on the performance vs. maintainability constraints of your application.

Minification
------------

The Dojo build system compresses each layer with Shrinksafe, which provides a very effective minification.

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
   2. Second, it ''interns'' external non-JavaScript files, such as widget templates which are kept in a separate HTML file during development. Interning makes the file contents a string in the resulting script. 
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

        You can download a Java runtime environment from `Sun's Java download page <http://www.java.com/en/download/index.jsp>`_.

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
   
    // this file is located at:
    //
    //      <server root>/js/src/mylayer.profile.js
    //
	// This profile is used just to illustrate the layout of a layered build.
	// All layers have an implicit dependency on dojo.js.
    //	
    // Normally you should not specify a layer object for dojo.js, as it will
    // be built by default with the right options. Custom dojo.js files are 
    // possible, but not recommended for most apps.
	
	dependencies = {
		layers: [
			{
				// This layer will be discarded, it is just used
				// to specify some modules that should not be included
				// in a later layer, but something that should not be
				// saved as an actual layer output. The important property
				// is the "discard" property. If set to true, then the layer
				// will not be a saved layer in the release directory.
				name: "acme.discard",
				resourceName: "acme.discard",
				discard: true,
				// Path to the copyright file must be relative to
				// the util/buildscripts directory, or an absolute path.
				copyrightFile: "myCopyright.txt",
				dependencies: [
					"dojo.string"
				]
			},
			{
                // one of the stock layers. It builds a "roll up" for
                // dijit.dijit which includes most of the infrastructure needed to
                // build widgets in a single file. We explicitly ignore the string
                // stuff via the previous exclude layer.
                
                // where the output file goes, relative to the dojo dir
				name: "../dijit/dijit.js",
                // what the module's name will be, i.e., what gets generated
                // for dojo.provide(<name here>);
				resourceName: "dijit.dijit",
                // modules not to include code for
				layerDependencies: [
                    "string.discard"
				],
                // modules to use as the "source" for this layer
				dependencies: [
					"dijit.dijit"
				]
			},
            {
                // where to put the output relative to the Dojo root in a build
                name: "../acme/mylayer.js"
                // what to name it (redundant w/ or example layer)
                resourceName: "acme.mylayer",
                // what other layers to assume will have already been loaded
                // specifying modules here prevents them from being included in
                // this layer's output file
				layerDependencies: [
                    "dijit.dijit"
				],
                // which modules to pull in. All of the depedencies not
                // provided by dojo.js or other items in the "layerDependencies"
                // array are also included.
				dependencies: [
                    // our acme.mylayer specifies all the stuff our app will
                    // need, so we don't need to list them all out here.
                    "acme.mylayer"
                ]
            }
        ],
	
        prefixes: [
            // the system knows where to find the "dojo/" directory, but we
            // need to tell it about everything else. Directories listed here
            // are, at a minimum, copied to the build directory.
            [ "dijit", "../dijit" ],
            [ "dojox", "../dojox" ],
            [ "acme", "../acme" ]
        ]
    }
	
    // If you choose to optimize the JS files in a prefix directory (via the
    // optimize= build parameter), you can choose to have a custom copyright
    // text prepended to the optimized file. To do this, specify the path to a
    // file tha contains the copyright info as the third array item in the
    // prefixes array. For instance:
	//	prefixes: [
	//		[ "acme", "/path/to/acme", "/path/to/acme/copyright.txt"]
	//	]
	//
    // NOTE: 
    //    If no copyright is specified in this optimize case, then by default,
    //    the Dojo copyright will be used.

Take notice that backslashes in prefix paths do not work on windows.

============
Build Script
============

To actually begin your build, you use the ``build.sh`` (or ``build.bat`` on Windows).  For full details on the arguments to ``build``, see `build script <build/buildScript>`_.

A typical build command looks something like this:

.. code-block :: text

  build profileFile=../../../js/mylayer action=clean,release version=1.3.0beta3 releaseName=

This illustrates the most important command line parameters to the build system:

``profile`` 
   The profile to be used for the build. ``.profile.js`` is appended automatically. The default directory is the ``<dojo root>/util/buildscripts/profiles`` directory within the Dojo source distribution, so if your build task specifies ``profile=thinger``, the system will search for ``<dojo root>/util/build/scripts/profiles/thinger.profile.js``.  However, most often you will want to reference a profile not within the source tree. To do this, you can specify a ``profileFile`` parameter which specifies a path from the current working directory (note, ``.profile.js`` is still appended to this file name!). 

``action`` 
   The list of actions to perform. The most common one is ``release`` which does the default build magic.  The ``clean`` option removes previous build artifacts.

``version`` 
   Optional. The version number to "bake in" to the build. When you interrogate ``dojo.version``, this is the number that will be reported.
   
``releaseName``
    By specifying an empty ``releaseName`` parameter, we over-rid the default of ``dojo``, clobbering the generation of a named sub-directory in the output ``/js/release/`` directory. This makes it somewhat simpler to deal with paths at development time, but if you are creating versioned builds, you may chose to specify something like ``r1234`` to indicate a unique build number which you can then check in. Note that specifying a blank ``releaseName`` does not work in version of Dojo prior to 1.3.

Once we've run the build script, all we need to do to use our new-fangled, much-faster layer file is to change the directory we point our ``<script>`` tags at. Intead of using the source files located in ``/js/src/<modulename>``, we now look for them in ``/js/release/<modulename>``:

.. code-block :: html

  <!-- dojo.js always provides the package system and base utilities -->
  <script type="text/javascript" src="/js/release/dojo/dojo.js"></script>
  
  <!-- we want dijit.js to be treated like a layer of its own -->
  <script type="text/javascript" src="/js/release/dijit/dijit.js"></script>
  
  <!-- include the rest of the modules we need -->
  <script type="text/javascript" src="/js/release/acme/mylayer.js"></script>



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

Directory Layout
----------------

See `possible directory layout <build/directoryLayout>`_ for the directory scheme used in these example scenarios.  This layout is designed to allow Dojo and private namespaces to work together without mixing source file trees.

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
