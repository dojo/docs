#format dojo_rst

The Dojo Build System
=====================

:Status: Draft
:Version: 1.7+
:Author: Rawld Gill

=====================
The Dojo Build System
=====================

The Dojo build system is a general-purpose program for transforming a set of resources. It was built to solve the
problem of transforming a set of resources that comprise an application in order to improve the performance of that
application. These kind of optimization are termed "deployment optimizations", and the build system includes a rich set
of such optimizations.

However, the build system is not limited to these kind of transforms. At its core, the build system is an engine for
applying an ordered, synchronized, configurable set of transforms to a configurable input set. Examples of other usages
include document generators, style checkers, code formatters, lint checkers, and many more. In some ways it is like a
make program, except the external processes that typical make programs execute can be implemented within the build system's
pluggable transform infrastructure. Of course external processes can be executed as well.

*Note: the build system was completely redesigned and reimplemented in version 1.7. The pre-1.7 build system is still important to some existing installations. All historical documentation for that system is listed at* `The Dojo Build System Prior to version 1.7`_

`The Build System <build/buildSystem>`_
  The top-level tutorial and reference that describes the basic operation of the build system when used for deployment optimizations.

`Build Quick Reference <build/qref>`_
  A quick reference manual for all build system switches and knobs.

The Dojo Toolkit includes the deployment optimization transforms listed below. See individual transform reference pages
for complete documentation.

`copy <build/transforms/copy>`_
  Copies a resource from a source location to a destination location.

`depsDump <build/transforms/depsDump>`_
  Prints the module dependency graph of one or more modules.

`depsScan <build/transforms/depsScan>`_
  Determines a module's dependencies and interns legacy dojo.cache string resources.

`dojoPragmas <build/transforms/dojoPragmas>`_
  Applies dojo pragmas to a resource.

`dojoReport <build/transforms/dojoReport>`_
  Outputs a report describing a single run of the deployment optimization transforms.

`hasFindAll <build/transforms/hasFindAll>`_
  Finds and optionally reports all has.js feature test usages.

`hasFixup <build/transforms/hasFixup>`_
  Trims dead code branches consequent to has feature values known at build time.

`hasReport <build/transforms/hasReport>`_
  Outputs a report describing the name and location of all has.js feature tests.

`insertSymbols <build/transforms/insertSymbols>`_
  Inserts debugging symbols into Javascript resources.

`optimizeCss <build/transforms/optimizeCss>`_
  Inlines CSS imports and/or removes comments from CSS files.

`read <build/transforms/read>`_
  Reads a resource from the file system.

`write <build/transforms/write>`_
  Writes a resource to the file system.

`writeAmd <build/transforms/writeAmd>`_
  Writes an AMD module to the file system.

`writeCss <build/transforms/writeCss>`_
  Writes a CSS style sheet to the file system

`writeDojo <build/transforms/writeDojo>`_
  Outputs a module that includes the dojo loader; this transform is responsible for writing dojo.js.

`writeOptimized <build/transforms/writeOptimized>`_
  Processes a resource with shrinksafe or the closure compiler and writes the result to the file system.

==========================================
The Dojo Build System Prior to version 1.7
==========================================

The build system was completely redesigned and reimplemented in version 1.7. The version of the build system available
before 1.7 is still important to some existing installations. All historical documentation for that system is listed
below:

`The Dojo Build System Prior To 1.7 <build/pre17/build>`_
  The main tutorial and reference for the build system prior to version 1.7.
