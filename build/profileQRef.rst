#format dojo_rst

Quick Reference of all Profile Properties
=========================================

:Version: 1.7
:Author: Rawld Gill

===============
Program Control
===============

``release`` (default = ``undefined``)
  * [*truthy*] Process all profiles resources, discover and transform all resources
  * [*falsy*] No effect, ignored

===============
Transform: copy
===============

`Transform Documentation Page... <build/transforms/copy>`_

None.

===================
Transform: depsDump
===================

`Transform Documentation Page... <build/transforms/depsDump>`_

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

===================
Transform: depsScan
===================

`Transform Documentation Page... <build/transforms/depsScan>`_

``platform`` (default = ``undefined``)

  * [*string*] The target platform when procesing legacy ``dojo.platformRequire`` applications
  * [*falsy*] ``dojo.platformRequire`` ignores any platform-dependent dependencies

``internStrings`` (default = ``undefined``)

  * [*truthy*] Strings are interned for legacy modules.
  * [*falsy*] Strings are not interned for legacy modules.

``internStringsSkipList`` (default = ``undefined``)

  * [*array of module identifiers (strings)*] List of string resources to ignore during string interning.
  * [*falsy*] All string resources discovered during the string interning process are interned.

``internSkipList`` (default = ``undefined``)

  * This is a backcompat synonm for ``internStringsSkipList``

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

======================
Transform: dojoPragmas
======================

`Transform Documentation Page... <build/transforms/dojoPragmas>`_

The entire profile object is placed in the lexical variable ``kwargs`` when thea condition associated with the pragmas
``includeStart`` and ``excludeEnd`` is evaluated. Any property in the profile may be used to affect these conditions.

=====================
Transform: dojoReport
=====================

`Transform Documentation Page... <build/transforms/dojoReport>`_

This section not complete; please consult source at util/build/transforms/dojoReport.js

=====================
Transform: hasFindAll
=====================

`Transform Documentation Page... <build/transforms/hasFindAll>`_

``hasReport`` (default = ``undefined``)
  * [*truthy*] A report of all has tests and their locations is written in the build report.

  * [*falsy*] No has location report is written.

===================
Transform: hasFixup
===================

`Transform Documentation Page... <build/transforms/hasFixup>`_

``staticHasFeatures`` (default = xxx)

  * [*map from feature name to booleanish or -1*] If -1, then the has feature is removed from the ``staticHasFeatures``;
    otherwise, if truthy, then the feature is assumed to be always true in the built code and conversely. Multiple
    ``staticHasFeatures`` maps may be provided from multiple profile resources. If more than one ``staticHasFeatures``
    property value is provided, then they are mixed on a per-has-feature basis in the order they appear on the command line.

========================
Transform: insertSymbols
========================

`Transform Documentation Page... <build/transforms/insertSymbols>`_

This section not complete; please consult source at util/build/transforms/insertSymbols.js

======================
Transform: optimizeCss
======================

`Transform Documentation Page... <build/transforms/optimizeCss>`_

This section not complete; please consult source at util/build/transforms/optimizeCss.js

===============
Transform: read
===============

`Transform Documentation Page... <build/transforms/read>`_

This section not complete; please consult source at util/build/transforms/read.js

================
Transform: write
================

`Transform Documentation Page... <build/transforms/write>`_

None.

===================
Transform: writeAmd
===================

`Transform Documentation Page... <build/transforms/writeAmd>`_

``layers`` (default = ``undefined``)
  * [*map from module identifier to layer item*] Indicates the given module should be written as a layer.

  If multiple layer objects are given by multiple profile resources, they are mixed on a per-layer basis, as profile
  items are processed left to right on the command line. For example, if two profile resources define the "x/y/z" layer,
  the layer item that exists in the last profile processed will overwrite the first layer item completely.

``insertAbsMids`` (default = ``undefined``)
  * [*truthy*] Causes the transform to ensure that every AMD define application includes a module identifier argument.

  * [*falsy*] The transform does nothing to the module identifier argument in define applications. In particular, a
    falsy value doe *not* cause the transform to remoave a module identifier argument that exists in the source code.

Layer items are Javascript objects with the following properties

``include`` (default = ``[]``)
  The set of module identifiers that, together with their dependency graphs, should be included in the layer, exclusive
  of the exclude module graph (see next).

``exclude`` (default = ``[]``)
  The set of module identifiers that, together with their dependecy graphs, should be excluded from the layer after all
  include dependencies are computed.

``discard`` (default = ``undefined``)
  If truthy, then the layer is computed and memorized but not written. This feature is used to construct a layer that is
  used in the ``include`` or ``exclude`` arrays of other layers.

``boot`` (default = ``undefined``)
  If truthy, then the layer is computed and memorized but not written. The computed layer is used by the writeDojo
  transform to write the layer along with the dojo loader to form a boot layer.

``copyright`` (default = "")
  If a string that gives an existing filename, the the contents of the named file is used as copyright text for the
  module. Relative filenames are computed with respect to the path that holds the profile resource that contains the
  layer item. If a string that does not give an existing filename, the string it interpretted as an explicit copyright
  message. If no string value is given, then no copyright text is output.

====================
Transform: writeDojo
====================

`Transform Documentation Page... <build/transforms/writeDojo>`_

``defaultConfig`` (default = see below)
  * [*object that gives the default loader configuration*] Used to build up the default loader configuration. Typically
     not provided.

``userConfig`` (default = ``"this.dojoConfig || this.djConfig || this.require || {}"``)
  * [*string*] The explit text to write for the user configuration applied to the loader factory.

  * [*object*] The object to user for the user configuration applied to the loader factory. The object need not be a
    strict JSON object.

  **Warning**: When a user configuration is given by providing a value of for the profile property ``userConfig``, the
  resulting loader will not automatically consume a global ``dojoConfig``, ``djConfig``, or ``require`` loader
  configuration object.

``version`` (default = *the version given by the dojo package*) 
  * [*string*] A string with the format *major* **.** minor* **.** *patch* **.** *flag*, where major, minor, and patch
    must all be positive integers and flag can be anything. Any less significant subset may be ommitted; ommitted minor
    and patch segments default to "0"; an ommitted flag segment defaults to an empty string.

``dojo/dojo`` layer configuration
  The dojo/dojo layer configuration gives the contents of the dojo layer, usually written to dojo/dojo.js. The default
  value of the dojo/dojo layer is given as follows:

.. code-block :: javascript

    {
        include:["dojo/main"],
        exclude:[],
        boot:true
    }

=========================
Transform: writeOptimized
=========================

`Transform Documentation Page... <build/transforms/writeOptimize>`_

``layerOptimize`` (default = "shrinksafe")
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


``optimize`` (default = "undefined")
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

``stripConsole`` (default = "normal")
  * ["none"] No console applications are stripped.

  * ["normal"] All console applications are stripped except ``console.error`` and ``console.warn``.

  * ["warn"] All console applications are stripped except ``console.error``.

  * ["all"] All console applications are stripped.
