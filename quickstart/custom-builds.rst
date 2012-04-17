.. _quickstart/custom-builds:

====================================
Custom Builds
====================================

:Project owner: James Burke
:since: 1.0

.. contents ::
   :depth: 4

How to use Dojo's custom build system to package your code for optimal runtime performance. This guide briefly covers many common usages and parameters. See the :ref:`full build documentation <build/index>` for all the details.


Introduction
============

A Dojo custom build speeds performance by doing the following:

       1. First, it groups together modules into "layers".
       2. Second, it "interns" external non-JavaScript files, such as widget templates which are kept in a separate HTML file during development. Interning makes the file contents a string in the resulting script.
       3. Third, it minifies the layer with ShrinkSafe. ShrinkSafe removes unneeded white space and comments, and compacts variable names down to smaller ones. This file downloads and parses faster than the original.
       4. Finally, it copies all non-layered scripts to the appropriate places. While this doesn’t speed anything up, it ensures that all Dojo modules can be loaded, even if not present in a layer. If you use a particular module only once or twice, keeping it out of the layers makes those layers load faster.


The catch?  You have to designate the modules in each layer with a ''profile'', which is something like a Makefile or Ant script.  But that's not too hard if you know your app well.

So the input of the build system is the Dojo source tree, plus any source trees for custom stuff you wish to include ... plus the profile.  The output is a Dojo distribution tree which you can copy to your web server.  Sweet!

Prerequisites
-------------

You need the following installed on your computer to run Dojo's build system:

* Node.js or `Java <http://java.sun.com/>`_ 1.4.2 or later (Java 1.5 recommended).
* A source build of Dojo, which you can obtain at http://download.dojotoolkit.org/.  The source builds are suffixed with "-src". If you want to download the latest code from the Subversion code repository, see the `Using Subversion <developer/svn>`_ page.

Profiles and Command Line Parameters
------------------------------------

The build system is driven by the ``build.sh`` script (or ``build.bat`` batch file for Windows based hosts), which accepts several parameters on the command line, one of which should indicate which build profile to use to drive the build.  The parameters specified on the command line and in the profile are combined to one set of parameters to drive the build.

In Dojo versions 1.X CHECK FACT and later, if parameter values from the profile override parameters of the same name on the command line.  Prior to version 1.X CHECK FACT, parameters on the command line override parameters of the same name from the profile.

Where should profiles be placed?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you do not want your profiles to be within the Dojo directory structure (which is a best practice, so that you can use them with subsequent versions of Dojo), you can use the ``profile`` parameter with a path to point to your profile anywhere within the file system.

The default directory for profiles, when you specify the profile name (rather than a path) with the ``profile`` parameter is ``util/buildscripts/profiles``.


Naming profiles
~~~~~~~~~~~~~~~

Your profiles should always be files named in the format ``name.profile.js``.   The ``profile`` parameter automatically appends ``profile.js`` to whatever string is specified to determine the actual file name.


Example: Creating a Custom Profile
-----------------------------------

In this example, in the util/buildscripts/profiles directory, you will create a profile build file called foo.profile.js like this:

.. js ::

    var profile = {
        packages:[
            {
                name:"mydojo",
                location:"./dojo"
            },
            {
                name:"dijit",
                location:"./dijit"
            },
            {
                name:"dojox",
                location:"./dojox"
            },
            {
                name:"explosive",
                location:"../../explosive"
            }
        ],

        // the layers property is a map from AMD module id to layer properties...
        layers: {
            "dojo/dojo":{
                include: [
                    // the include vector gives the modules to include in this layer
                    "dojo/main",
                    "dijit/form/Button",
                ]
            },
            "explosive/explosive":{
                include: [
                    "explosive/space/Modulator"
                ],
                exclude: [
                    // dependency forrest to exclude from this layer
                    "dojo/dojo"
                ]
            }
        }
    };

The include section within the layer lists all the modules you call ''directly''.  Any referenced modules will also be included, so you don't have to trace back the dependency tree.

The modules for that layer are gathered together to make the "layer" file, in our example: "dojox/mobile.js" and "dojox/mobile/app.js".  Then you just load this layer file in your pages with a SCRIPT tag.  Easy!

The packages section list any modules that need inclusion.  Note our "explosive" module, which is located away from the Dojo tree.  You need to list these if you use them, even if you don't want any modules from it in your layer file.

Running The Build
-----------------

After specifying a profile file as shown above that statically specifies the resources you want to include, and saving it as /buildscripts/profiles/foo.profile.js, you run the Rhino interpreter on it and specify the profile name as a parameter. For example, from the buildscripts directory::

  $ cd util/buildscripts
  $ build.sh --profile foo --release

On Windows PC's, substitute build.bat for build.sh.  For both platforms, you may also specify additional build options. **Run build.sh with no options** to see a list of all supported options. Here is a sample of the supported options:

``--profile nameOrPath``
  The name of the profile to use for the build. It must be the first part of the profile file name in the profiles/ directory. For instance, to use base.profile.js, specify profile=base. Default: base.
  Alternately this can be a path to a profile file.

``--release``
  Do a build.   You should always specify this flag.

``--releaseDir dir``
  The top level release directory where builds end up. The 'releaseName' directories will be placed inside this directory Default: "../../release/"

``--internStrings``
  Turn on or off widget template/dojo.uri.cache() file interning Default: true

``--optimize val``
  Specifies how to optimize module files.

  * [*falsy*] Non-layer modules are not optimized; the ``stripConsole`` profile property, if any, is ignored.

  * ["comment.keeplines"] All comments are removed fromm all non-layer modules; new-lines are preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["comment"] All comments are removed form all non-layer modules; new-lines are *not* preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["shrinksafe.keeplines"] All non-layer modules are processed by shrinksafe; new-lines are preserved; the semantics of
    the ``stripConsole`` property are executed.

  * ["shrinksafe"] All non-layer modules are processed by shrinksafe; new-lines are *not* preserved; the semantics of the
    ``stripConsole`` property are executed.

  * ["closure.keepLines"] All non-layer modules are processed by the Google Closure compiler, simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["closure"] All non-layer modules are processed by the Google Closure compiler, simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

**Important**: Dead code removal consequent to static has.js feature values and the hasFixup transform requires a Google
  Closure compiler optimization switch setting

``--layerOptimize val``
  Specifies how to optimize the layer files.

  * [*falsy*] Layer modules are not optimized; the ``stripConsole`` profile property, if any, is ignored.

  * ["comment.keeplines"] All comments are removed fromm all layer modules; new-lines are preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["comment"] All comments are removed form all layer modules; new-lines are *not* preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["shrinksafe.keeplines"] All layer modules are processed by shrinksafe; new-lines are preserved; the semantics of
    the ``stripConsole`` property are executed.

  * ["shrinksafe"] All layer modules are processed by shrinksafe; new-lines are *not* preserved; the semantics of the
    ``stripConsole`` property are executed.

  * ["closure.keepLines"] All layer modules are processed by the Google Closure compiler, simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["closure"] All layer modules are processed by the Google Closure compiler, simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

``--copyTests trueOrFalse``
  Turn on or off copying of test files Default: true

