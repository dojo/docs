.. _build/qref:


Quick Reference for Optimization Build Program
==============================================

:Author: Rawld Gill

Reference Documentation
=======================

  * :ref:`The Dojo Build System <build/buildSystem>`: The top-level tutorial and reference that describes the basic
    operation of the build system when used for deployment optimizations.

  * :ref:`Build Document Catalog <build/index>`: A complete list of build system documentation resources.

Command Line Switch Reference
==============================

``--profile`` *profile-name*
  Read and process the profile given by *profile-name*. If *profile-name* does not include a file type, then the file
  type ".profile.js" is assumed. If *profile-name* does not include a file type **and** the *profile-name* does not
  contain any path segments **and** the implied filename is not found in the current working directory, then the program
  attempts to read the profile from the /utils/buildscripts/profiles directory.

``-p`` *profile-name*
  Equivalent to --profile

``--dojoConfig`` *filename*
  Read and process a loader configuration object given by the variable ``dojoConfig`` that must exist in the resource given by *filename*.

``--require`` *filename*
  Read and process a loader configuration application that must exist in the resource given by *filename*.

``--package`` *path*
  Read and process a package.json resource that must exist in the directory given by *path*.

``--release``
  Process all profiles resources, discover and transform all resources.

``--releaseDir *directory*``
  Creates specified directory and puts build there.  Defaults to dojoRoot/release.

``-r`` *filename*
  Equivalent to --releaseDir

``--check``
  Process all command line switches and dump the computed profile to the console.

``--check-args``
  Process all command line switches and dump the raw profile resources to the console (the profile resources are not
  aggregated).

``--check-discovery``
  Echo all discovered resources and exit

``--help``
  Print the help message

``--version``
  Print the version number of the build program

Any scalar profile property can be specified on the command line. For example, ``basePath`` could be specified
as follows:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> ./build.sh --profile myApp --basePath /www/deploy/myApp --release

*Note*: although **action=** *switch* defined by the v1.6- system may be used, that syntax is deprecated and you should just
specify the switch.

*Note*: the clean action has been removed. Since the system is now extremely flexible is describing where output is
written, a mistake in a profile could result in cleaning your hard drive. We'll let you do that yourself with the
rm/rmdir commands. (We also note that deleting file trees is not the typical function of a compiler program).

Discovery Profile Properties
============================

basePath
  Analogous to baseUrl when resolving package locations with the dojo loader. Defaults to "." for profile and
  package.json files; no default otherwise.

releaseDir
  Analogous to baseUrl when resolving package locations with the dojo loader. Defaults to "./release" for v1.7+
  profiles; defaults to /util/buildscripts/../../release for 1.6- profiles.

trees
  Identical to the trees property available in a package configuration object, except package independent. Relative
  source and/or destination names are relative tod basePath and releaseDir respectively.

dirs
  Identical to the dirs property available in a package configuration object, except package independent. Relative
  source and/or destination names are relative tod basePath and releaseDir respectively.

files
  Identical to the files property available in a package configuration object, except package independent. Relative
  source and/or destination names are relative tod basePath and releaseDir respectively.

packages
  An array of package configurations objects. Packages are mixed on a per-package level. Package configuration objects
  may contain the properties name, location, main, and packageMap as described in xxx. The destination location for a package
  is given by the analogous properties destName, destLocation, destMain, and destPackageMap. Typically, the destination
  properties are derived from the source properties with destName===name, destLocation===destBasePath/destName,
  destMain===main, and destPackageMap===packageMap. Packages may also contain the properties trees, dirs, and files as
  described in xxx.

copyTests
  If truthy but not "build", then copy  all resources tagged as a tests to the release destination. If "build", then apply
  all appropriate transforms to any resource tagged as a test as if it were not tagged as a test. If falsy, ignore the
  all resources tagged as tests.

mini
  If truthy ignore all resources tagged as excludeMini; if copyTests is falsy or missing, also ignore all resources
  tagged as tests.

Transform: copy
===============

:ref:`copy transform reference... <build/transforms/copy>`

None.

Transform: depsDump
===================

:ref:`depsDump transform reference... <build/transforms/depsDump>`

``depsDumpFilename`` (default = ``undefined``)

  * [*string*] filename to output dependency graph
  * [*falsy*] dependency graph is not output

``depsDumpDotFilename`` (default = ``undefined``)

  * [*string*] filename to output dot program
  * [*falsy*] dot program is not output

``dotModules`` (default = ``undefined``)

  * [*comma-separated string of module identifiers*]  set of identifiers to include in graph (these modules and their
    dependency trees will be included in the output)
  * [*falsy*] all modules are included

Transform: depsScan
===================

:ref:`depsScan transform reference... <build/transforms/depsScan>`

``platform`` (default = ``undefined``)

  * [*string*] The target platform when processing legacy ``dojo.platformRequire`` applications
  * [*falsy*] ``dojo.platformRequire`` ignores any platform-dependent dependencies

``internStrings`` (default = ``undefined``)

  * [*truthy*] Strings are interned for legacy modules.
  * [*falsy*] Strings are not interned for legacy modules.

``internStringsSkipList`` (default = ``undefined``)

  * [*array of module identifiers (strings)*] List of string resources to ignore during string interning.
  * [*falsy*] All string resources discovered during the string interning process are interned.

``internSkipList`` (default = ``undefined``)

  * This is a backcompat synonym for ``internStringsSkipList``

``scopeNames`` (default = ``["dojo", "dijit", "dojox"]``)

  * [*array of top-level module identifiers (strings)*] The top-level modules names to bring into scope when executing a
    legacy module converted to AMD. See xxx. The vector is guaranteed to contain "dojo", "dijit", and
    "dojox". Additional names may be added if required; however, it is highly advised that users of this feature convert
    their modules to proper AMD modules which eliminates the need for this feature.

``scopeMap`` (default = ``undefined``)

  * [*map from top-level module identifier to relocated top-level module identifier (string)*] The property names of
    ``scopeMap`` are used to populate ``scopeNames``; the property values of ``scopeMap`` are not meaningful to the
    build system.

**Warning**: All knobs mentioned above support legacy features which are deprecated. It is strongly encouraged to convert
legacy modules to properly-expressed AMD modules.

Transform: dojoPragmas
======================

:ref:`dojoPragmas transform reference... <build/transforms/dojoPragmas>`

The entire profile object is placed in the lexical variable ``kwargs`` when thea condition associated with the pragmas
``includeStart`` and ``excludeEnd`` is evaluated. Any property in the profile may be used to affect these conditions.

Transform: dojoReport
=====================

:ref:`dojoReport transform reference... <build/transforms/dojoReport>`

This section not complete; please consult source at util/build/transforms/dojoReport.js

Transform: hasFindAll
=====================

:ref:`hadFindAll transform reference... <build/transforms/hasFindAll>`

``hasReport`` (default = ``undefined``)
  * [*truthy*] A report of all has tests and their locations is written in the build report.

  * [*falsy*] No has location report is written.

Transform: hasFixup
===================

:ref:`hasFixup transform reference... <build/transforms/hasFixup>`

``staticHasFeatures`` (default = xxx)

  * [*map from feature name to booleanish or -1*] If -1, then the has feature is removed from the ``staticHasFeatures``;
    otherwise, if truthy, then the feature is assumed to be always true in the built code and conversely. Multiple
    ``staticHasFeatures`` maps may be provided from multiple profile resources. If more than one ``staticHasFeatures``
    property value is provided, then they are mixed on a per-has-feature basis in the order they appear on the command line.

Transform: insertSymbols
========================

:ref:`insertSymbols transform reference... <build/transforms/insertSymbols>`

This section not complete; please consult source at util/build/transforms/insertSymbols.js

Transform: optimizeCss
======================

:ref:`optimizeCss transform reference... <build/transforms/optimizeCss>`

This section not complete; please consult source at util/build/transforms/optimizeCss.js

Transform: read
===============

:ref:`read transform reference... <build/transforms/read>`

This section not complete; please consult source at util/build/transforms/read.js

Transform: write
================

:ref:`write transform reference... <build/transforms/write>`

None.

Transform: writeAmd
===================

:ref:`writeAmd transform reference... <build/transforms/writeAmd>`

``layers`` (default = ``undefined``)
  * [*map from module identifier to layer item*] Indicates the given module should be written as a layer.

  If multiple layer objects are given by multiple profile resources, they are mixed on a per-layer basis, as profile
  items are processed left to right on the command line. For example, if two profile resources define the "x/y/z" layer,
  the layer item that exists in the last profile processed will overwrite the first layer item completely.

``insertAbsMids`` (default = ``undefined``)
  * [*truthy*] Causes the transform to ensure that every AMD define application includes a module identifier argument.

  * [*falsy*] The transform does nothing to the module identifier argument in define applications. In particular, a
    falsy value doe *not* cause the transform to remove a module identifier argument that exists in the source code.

Layer items are JavaScript objects with the following properties

``include`` (default = ``[]``)
  The set of module identifiers that, together with their dependency graphs, should be included in the layer, exclusive
  of the exclude module graph (see next).

``exclude`` (default = ``[]``)
  The set of module identifiers that, together with their dependency graphs, should be excluded from the layer after all
  include dependencies are computed.

``discard`` (default = ``undefined``)
  If truthy, then the layer is computed and memorized but not written. This feature is used to construct a layer that is
  used in the ``include`` or ``exclude`` arrays of other layers.

``boot`` (default = ``undefined``)
  If truthy, then the layer is computed and memorized but not written. The computed layer is used by the writeDojo
  transform to write the layer along with the dojo loader to form a boot layer.

``copyright`` (default = "")
  If a string that gives an existing filename, the contents of the named file is used as copyright text for the
  module. Relative filenames are computed with respect to the path that holds the profile resource that contains the
  layer item. If a string that does not give an existing filename, the string it interpreted as an explicit copyright
  message. If no string value is given, then no copyright text is output.

Transform: writeDojo
====================

:ref:`writeDojo transform reference... <build/transforms/writeDojo>`

``defaultConfig`` (default = see below)
  * [*object that gives the default loader configuration*] Used to build up the default loader configuration. Typically
     not provided.

``userConfig`` (default = ``"this.dojoConfig || this.djConfig || this.require || {}"``)
  * [*string*] The explicit text to write for the user configuration applied to the loader factory.

  * [*object*] The object to use for the user configuration applied to the loader factory. The object need not be a
    strict JSON object.

  **Warning**: When a user configuration is given by providing a value of for the profile property ``userConfig``, the
  resulting loader will not automatically consume a global ``dojoConfig``, ``djConfig``, or ``require`` loader
  configuration object.

``version`` (default = *the version given by the dojo package*)
  * [*string*] A string with the format *major* **.** minor* **.** *patch* **.** *flag*, where major, minor, and patch
    must all be positive integers and flag can be anything. Any less significant subset may be omitted; omitted minor
    and patch segments default to "0"; an omitted flag segment defaults to an empty string.

``dojo/dojo`` layer configuration
  The dojo/dojo layer configuration gives the contents of the dojo layer, usually written to dojo/dojo.js. The default
  value of the dojo/dojo layer is given as follows:

.. js ::

    {
        include:["dojo/main"],
        exclude:[],
        boot:true
    }

Transform: writeOptimized
=========================

:ref:`writeOptimized transform reference... <build/transforms/writeOptimized>`

``layerOptimize`` (default = "shrinksafe")
  * [*falsy*] Layer modules are not optimized; the ``stripConsole`` profile property, if any, is ignored.

  * ["comments.keeplines"] All comments are removed from all layer modules; new-lines are preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["comments"] All comments are removed form all layer modules; new-lines are *not* preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["shrinksafe.keeplines"] All layer modules are processed by shrinksafe; new-lines are preserved; the semantics of
    the ``stripConsole`` property are executed.

  * ["shrinksafe"] All layer modules are processed by shrinksafe; new-lines are *not* preserved; the semantics of the
    ``stripConsole`` property are executed.

  * ["closure.keepLines"] All layer modules are processed by the Google Closure compiler, simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["closure"] All layer modules are processed by the Google Closure compiler, simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["uglify.keeplines"] All layer modules are processed by the UglifyJS compiler (version 1 only), simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["uglify"] All layer modules are processed by the UglifyJS compiler (version 1 only), simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

``optimize`` (default = "undefined")
  * [*falsy*] Non-layer modules are not optimized; the ``stripConsole`` profile property, if any, is ignored.

  * ["comments.keeplines"] All comments are removed from all non-layer modules; new-lines are preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["comments"] All comments are removed form all non-layer modules; new-lines are *not* preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["shrinksafe.keeplines"] All non-layer modules are processed by shrinksafe; new-lines are preserved; the semantics of
    the ``stripConsole`` property are executed.

  * ["shrinksafe"] All non-layer modules are processed by shrinksafe; new-lines are *not* preserved; the semantics of the
    ``stripConsole`` property are executed.

  * ["closure.keepLines"] All non-layer modules are processed by the Google Closure compiler, simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["closure"] All non-layer modules are processed by the Google Closure compiler, simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["uglify.keeplines"] All layer modules are processed by the UglifyJS compiler (version 1 only), simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["uglify"] All layer modules are processed by the UglifyJS compiler (version 1 only), simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

**Important**: Dead code removal consequent to static has.js feature values and the hasFixup transform requires a Google
  Closure or UglifyJS compiler optimization switch setting. To use UglifyJS, you will need to ``npm install uglify-js@1``, in a directory parallel to ``util``

``optimizeOptions`` (default = "undefined")
    This object is passed to the JavaScript optimizer to allow for compiler specific settings. Settings for UglifyJS and closure 
    compiler can be set using this object.

``stripConsole`` (default = "normal")
  * ["none"] No console applications are stripped.

  * ["normal"] All console applications are stripped except ``console.error`` and ``console.warn``.

  * ["warn"] All console applications are stripped except ``console.error``.

  * ["all"] All console applications are stripped.

Deprecated Profile Properties
=============================

The action clean is no longer supported. Use ``rm`` on Unix/Linux/OS X or ``rmdir`` on Windows.

Removed Profile Properties
==========================

The following profile properties are not necessary with the introduction of the new loader, query machinery, build
system, and AMD module format in 1.7: ``localeList``, ``loader``, ``log``, ``xdDojoPath``, ``scopeDjConfig``,
``xdScopeArgs``, ``xdDojoScopeName``, ``expandProvide``, ``buildLayers``, ``query``, ``removeDefaultNameSpace``,
``addGuards``.
