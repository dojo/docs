.. _build/transforms/depsScan:

========================
Build Transform depsScan
========================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Scans AMD and legacy module for dependencies; automatically convert legacy modules to AMD modules (both normal code
modules and NLS modules); interns strings for legacy modules.

Description
===========

Modules tagged with "amd" or containing the dojo pragma "//>> pure-amd" are evaluated in the global scope with global
define() and global require() replaced with thunk functions execute a no-op. This allows the transform to gain access to
the dependency vector and absolute module identifier, if any, without using regular expressions. Well-constructed
AMD modules should not depend on or manipulate the environment unless and until their factory functions are
applied. Therefore, it is safe to execute these kinds of modules in the build environment.

**Note**: though bad practice, it is certainly possible to write an AMD module that depends on a certain execution
environment when it is evaluated and/or mutates the execution environment is such a way as to cause the build system to
crash.

Modules tagged with "nls" must be either AMD NLS modules or legacy NLS modules. AMD NLS modules are evaluated just as if
the module was tagged with "amd" as described above. Notice that this allows AMD NLS modules to have dependencies. If
a legacy NLS module is detected, then it is automatically converted to the AMD NLS format. Legacy NLS modules are
assumed to have no dependencies.

Modules that are not tagged with "amd" and are not NLS modules are scanned for dependencies using a process that
depends on regular expressions. Due to the lexical conventions of JavaScript, it is impossible to construct a regular
expression that can properly differentiate between comments, strings, and regular expression literals (a parser is
required that can compute context). Nevertheless, the regular-expression-based dependency scanning process works in all
but the most defective cases and is identical to the process that is used with the legacy xdomain loader and build
system in v1.6-.

The process begins by interning strings if the profile property ``internStrings`` is truthy. Three patterns of
expressions are interned:

* a templatePath property in an object literal (often used to define a dojo.declare'd widget):

  ``templatePath : dojo.moduleUrl(`` *module* ``,`` *url* ``)``


* assigning to templatePath

  *anything* ``templatePath = dojo.moduleUrl(`` *module* ``, `` *url* ``)``

* any dojo.cache expression with either of these formats

  ``dojo.cache(``  *module* ``, `` *url* ``)``

  ``dojo.cache(``  *module* ``, `` *url* ``,`` *value* ``)``

In all cases, the pattern matching algorithm is not sensitive to white space.

Zero or more string resources may be excluded from being interned by placing the resource module identifier in the
profile property ``internStringsSkipList``, an array of module identifiers (strings). Module identifiers of
non-JavaScript resources (e.g. HTML template files) must include the proper file type. For example, the resource at
dijit/templates/tree.html has the resource identifier "dijit/templates/TreeNode.html".

After strings are interned (if necessary), the module is scanned for legacy loader API functions applications
(``dojo.require``, ``dojo.provide``, et al). If no such applications are found, then the module is scanned for AMD
``define`` and/or ``require`` applications. If found, then the module is assumed to be an AMD module, the transform is
advised of any dependencies, and a warning is given stating that the module appears to be a proper AMD module but was
not tagged as such. In this case, the ``resourceTags`` property of either the profile or the package configuration
should be adjusted to properly tag the module. Alternatively, the ``//>> pure-amd`` pragma may be added to the module, but
this should be considered a short-term solution.

If legacy loader API function applications are discovered, then the module is converted to an AMD module. The conversion
algorithm is identical to the algorithm used to convert local legacy modules to modules that may be loaded
asynchronously when the loader is in xdomain mode. This process is fairly complex and is fully described here xxx
(TODO). As far as the transform process is concerned, just like all other cases, the process results in discovering any
module dependencies. *Note*: This process can be used as a basis for converting legacy module to AMD modules.

In summary, the transform process discovers any module dependencies through one of the following methods:

* For known AMD modules, the module is evaluated and define/require thunks find the dependencies.

* Legacy NLS modules are assumed to have no dependencies.

* Modules of unknown type that do not contain legacy API applications and do contain AMD API applications are scanned
  with a regular expression process to find dependencies.

* Modules of unknown type that do contain legacy API applications are processed with a regular expression process to
  find dependencies; the process is identical to the process used by the loader when in xdomain mode.

Once all dependencies are found, the transform ensures all dependencies exist in the discovered modules. Missing
dependencies result in an error being logged to the console and the build report.

Profile Knobs
=============

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

  * This is a back-compat synonym for ``internStringsSkipList``

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

Source Location
===============

util/build/transforms/depsScan.js
