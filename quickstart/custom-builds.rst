#format dojo_rst

Custom Builds
====================================

:Status: Draft
:Version: 1.0
:Project owner: James Burke
:Available: since 1.0

.. contents::
   :depth: 4

How to use Dojo's custom build system to package your code for optimal runtime performance. This guide briefly covers many common usages and parameters. See the `full build documentation <build/index>`_ for all the details.


============
Introduction
============

A Dojo custom build speeds performance by doing the following:

#. First, it groups together modules into ''layers''.  A layer, which is one big .js file, loads faster than the individual .js modules that comprise it
#. Second, it ''interns'' external non-JavaScript files.  This is most important for Dijit templates, which are kept in a separate HTML file.  Interning pulls the entire file in and assigns it to a string.
#. Third, it smooshes the layer down with ShrinkSafe.  ShrinkSafe removes unneeded whitespace and comments, and compacts variable names down to smaller ones.  This file downloads and parses faster than the original.
#. Finally, it copies all non-layered scripts to the appropriate places.  While this doesn't speed anything up, it ensures that all Dojo modules can be loaded, even if not present in a layer.  If you use a particular module only once or twice, keeping it out of the layers makes those layers load faster.

The catch?  You have to designate the modules in each layer with a ''profile'', which is something like a Makefile or Ant script.  But that's not too hard if you know your app well.

So the input of the build system is the Dojo source tree, plus any source trees for custom stuff you wish to include ... plus the profile.  The output is a Dojo distribution tree which you can copy to your web server.  Sweet!

Prerequisites
-------------

You need the following installed on your computer to run Dojo's build system:

* `Java <http://java.sun.com/>`_ 1.4.2 or later (Java 1.5 recommended).
* A source build of Dojo, which you can obtain at http://download.dojotoolkit.org/.  The source builds are suffixed with "-src". If you want to download the latest code from the Subversion code repository, see the `Using Subversion <http://dojotoolkit.org/book/dojo-book-0-9/part-4-meta-dojo/get-code-subversion>`_ page.

Profiles and Command Line Parameters
------------------------------------

The build system is driven by the ``build.sh`` script (or ``build.bat`` batch file for Windows based hosts), which accepts several parameters on the command line, one of which should indicate which build profile to use to drive the build.  The parameters specified on the command line and in the profile are combined to one set of parameters to drive the build.

In Dojo versions 1.X CHECK FACT and later, if parameter values from the profile override parameters of the same name on the command line.  Prior to version 1.X CHECK FACT, parameters on the command line override parameters of the same name from the profile.

Where should profiles be placed?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The default directory for profiles, when you specify the profile name with the ``profile`` parameter is ``util/buildscripts/profiles``.

If you do not want your profiles to be within the Dojo directory structure (which is a best practice, so that you can use them with subsequent versions of Dojo), you can use the ``profileFile`` parameter instead to point to your profile anywhere within the file system.

Naming profiles
~~~~~~~~~~~~~~~

Your profiles should always be files named in the format ``name.profile.js``.   The ``profile`` parameter automatically appends ``profile.js`` to whatever string is specified to determine the actual file name.


Example:  Creating a Custom Profile
-----------------------------------

In this example, in the util/buildscripts/profiles directory, you will create a profile build file called foo.profile.js like this:

.. code-block :: javascript
 :linenos:

  dependencies ={

    layers:  [
        {
        name: "mydojo.js",
        dependencies: [
            "dijit.Button",
            "dojox.wire.Wire",
            "dojox.wire.XmlWire",
            "explosive.space.Modulator"
        ]
        }
    ],

    prefixes: [
	[ "dijit", "../dijit" ],
	[ "dojox", "../dojox" ],
        [ "explosive", "../../explosive" ]
    ]

  };


The dependencies section within the layer lists all the modules you call ''directly''.  Any referenced modules will also be included, so you don't have to trace back the dependency tree.
Also, Dojo base modules are an implicit dependency, so you don't need to list things like "dojo.query".  (Dojo core modules, however, do need to be listed.)

The modules for that layer are gathered together to make the "layer" file, in our example: "mydojo.js".  Then you just load this layer file in your pages with a SCRIPT tag.  Easy!

The prefixes section list any modules that need inclusion.  Note our "explosive" module, which is located away from the Dojo tree.  You need to list these if you use them, even if you don't want any modules from it in your layer file.

For the 1.0+: If you choose to optimize the JS files in a prefix directory (via the optimize= build parameter), you can choose to have a custom copyright text prepended to the optimized file. To do this, specify the path to a file tha contains the copyright info as the third array item in the prefixes array. For instance:

.. code-block :: javascript
 :linenos:

  prefixes: [
      [ "explosive", "../../explosive", "../../explosive/copyright.txt"]
  ]

If no copyright is specified in this optimize case, then by default, the dojo copyright will be used.

Running The Build
-----------------

After specifying a profile file as shown above that statically specifies the resources you want to include, and saving it as /buildscripts/profiles/foo.profile.js, you run the Rhino interpreter on it and specify the profile name as a parameter. For example, from the buildscripts directory::

  $ cd util/buildscripts
  $ build.sh profile=foo action=release

On Windows PC's, substitute build.bat for build.sh.  For both platforms, you may also specify additional build options. **Run build.sh with no options** to see a list of all supported options. Here is a sample of the supported options:

profile
  The name of the profile to use for the build. It must be the first part of the profile file name in the profiles/ directory. For instance, to use base.profile.js, specify profile=base. Default: base

profileFile
  A file path to the the profile file. Use this if your profile is outside of the profiles directory. Do not specify the "profile" build option if you use "profileFile" Default: ""

action
  The build action(s) to run. Can be a comma-separated list, like action=clean,release. The possible build actions are: clean, release Default: "help".

  Note:  the ''release'' action automatically implies the ''clean'' action, *except* when you have used the advanced parameter ''buildLayers'' in your profile.

version
  The build will be stamped with this version string Default: "0.0.0.dev"

localeList
  The set of locales to use when flattening i18n bundles Default: "en-gb,en-us,de-de,es-es,fr-fr,it-it,pt-br,ko-kr,zh-tw,zh-cn,ja-jp"

releaseName
  The name of the release. A directory inside 'releaseDir' will be created with this name Default: "dojo"

releaseDir
  The top level release directory where builds end up. The 'releaseName' directories will be placed inside this directory Default: "../../release/"

loader
  The type of dojo loader to use. "default" or "xdomain" are acceptable values." defaultValue: "default"

internStrings
  Turn on or off widget template/dojo.uri.cache() file interning Default: true

optimize
  Specifies how to optimize module files. If "comments" is specified, then code comments are stripped. If "shrinksafe" is specified, then the Dojo compressor will be used on the files, and line returns will be removed. If "shrinksafe.keepLines" is specified, then the Dojo compressor will be used on the files, and line returns will be preserved. If "packer" is specified, Then Dean Edwards' Packer will be used Default: ""

  Note:  using the ''packer'' option is discouraged in most environments.  In environments where the http server supports gzip compression automatically, ''shrinksafe'' will provide better performance.  ''packer'' also does more transformations to the underlying source code.

layerOptimize
  Specifies how to optimize the layer files. If "comments" is specified, then code comments are stripped. If "shrinksafe" is specified, then the Dojo compressor will be used on the files, and line returns will be removed. If "shrinksafe.keepLines" is specified, then the Dojo compressor will be used on the layer files, and line returns will be preserved. If "packer" is specified, Then Dean Edwards' Packer will be used Default: "shrinksafe"

copyTests
  Turn on or off copying of test files Default: true

log
  Sets the logging verbosity. See jslib/logger.js for possible integer values Default: logger.TRACE

xdDojoPath
  If the loader=xdomain build option is used, then the value of this option will be used for the path to Dojo modules. The dijit and dojox paths will be assumed to be sibilings of this path. The xdDojoPath should end in '/dojo' Default: ""

Cross Domain (XDomain) Builds
-----------------------------

Doing an xdomain build allows you to load Dojo and your custom modules from another domain.

Benefits
~~~~~~~~

* You get more connections in MSIE, since you can load from another domain. Faster loading.
* You get increased cacheability/startup if many of your applications use the same installation.
* Resource loading does not block the rest of the page from filling in as with Dojo's normal, synchronous loading.
* With a local install, your ISP may charge you for all of those Dojo bits that you are serving.


Implications/Limitations
~~~~~~~~~~~~~~~~~~~~~~~~

* Not all external resources can be xdomain loaded, in particular some support files that need to be loaded from the same domain as the HTML page. See module-specifc notes below.
* **Requires** a "xdomain" build of Dojo (see below for more info on how to make a xdomain build).
* Asynchronous loading. You MUST use dojo.addOnLoad() to register a callback function to get notification of package loading. This can be used even after the initial page load. Just do the dojo.require()s that you need, and then call dojo.addOnLoad() with a callback function, and once those new packages are loaded (or if they are already loaded), then the callback will be called. This technique works even for the normal Dojo loader, so this is a good practice to use even when not using an xdomain build.
* Avoid using document.write(): Since module can load asychnously, after the page is loaded, document.write can cause problems.

Module-specific Notes
~~~~~~~~~~~~~~~~~~~~~

**dojo.io.iframe.create(), dijit.Editor, dijit._editor.RichText**: You need to save dojo/resources/blank.html to the same domain as your HTML page and set djConfig.dojoBlankHtmlUrl to the path on that domain. **Note:** The dijit.Editor/dijit._editor.RichText has a bug in release 1.1.0 where it was not using this djConfig parameter. It is fixed in Dojo 1.1.1 and later.

**dojo.back**: You need to save dojo/resources/blank.html to the same domain as your HTML page and set djConfig.dojoIframeHistoryUrl to the path on that domain.

**dojox.flash.Info()**: It uses document.write() which will cause problems if dojox.flash is loaded via dojo.require().

Doing xdomain builds
~~~~~~~~~~~~~~~~~~~~

Sample xdomain build command::

  $ cd util/buildscripts
  $ build.sh profile=foo loader=xdomain xdDojoPath=http://my.server.com/path/to/buildoutputdir action=release

xdDojoPath is optional. It just burns in the location of dojo, dijit and dojox into the built dojo.js. If you do not specify that option, then you will need to use djConfig.modulePaths/dojo.registerModulePath() in your HTML page to set the xdomain locations for dojo, dijit and dojox. For your own custom modules, you will have to set djConfig.modulePaths/dojo.registerModulePath() even if you use the xdDojoPath build option.

**For Dojo 0.9 through 1.1.x:** there is a `bug about loading dojox.gfx with an xdomain build <http://trac.dojotoolkit.org/ticket/4462>`_. This is **fixed in Dojo 1.2**. If you want to use dojox.gfx with an xdomain build of Dojo 0.9-1.1.x, there are some workarounds until the bug gets fixed:

#. Include dojox/gfx.js directly in your page with a script tag in the HTML source, after the dojo.js script tag (do not use gfx.xd.js, use gfx.js).
#. Include dojox.gfx in a layer file that you load via a script tag in the HTML source (load the .js layer file, not the .xd.js layer file).

How to use xdomain builds in web pages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* In **djConfig**, add **useXDomain = true**.
* In **djConfig**, add a modulePaths object that maps where to find your modules.
* **Only use dojo.require()** to load xdomain layers. Do not reference the .xd.js file for the layer file. The one exception is dojo.xd.js. If your layer does not map to a real module name, then specify a resourceName: property for that layer in your build profile. The other option is to load the built .js file (not .xd.js file) in a script tag.
* Register a callback function to get notification of when the packages are loaded by using **dojo.addOnLoad()**.
* Optional: set a wait time in milliseconds (**djConfig.xdWaitSeconds**) that specifies how long the resource loader should wait for a resource to load until returning an error. Since script elements do not give information about failed or long-running requests, this timeout is used to prevent infinite waiting in the browser. An exception will be thrown to indicate a load error. The default xdWaitSeconds is 15.

XDomain Example
~~~~~~~~~~~~~~~

`Here is an example <http://jburke.dojotoolkit.org/demos/xdlocal/LocalAndXd.html>`_ showing how to load local modules along with an xdomain-loaded dojo and dijit. You can `download this example <http://jburke.dojotoolkit.org/demos/xdlocal/xdlocal.zip>`_.


``TODOC: everything. outline here:``

* summary
* requirements / setup
* creating a profile
* command line arguments
* special builds:
  * layers
  * css
* file structure

link to full docs to cover:

* excludeStart/Stop
* restoreRequire
* layerDependencies
* discard
* .uncompressed.js
* customBase
* more...
