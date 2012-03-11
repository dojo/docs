.. _build/index:

=====================
The Dojo Build System
=====================

:Author: Rawld Gill

Introduction
============

The Dojo build system is a general-purpose program for transforming a set of resources. It was built to solve the
problem of transforming a set of resources that comprise an application in order to improve the performance of that
application. These kind of optimizations are termed "deployment optimizations", and the build system includes a rich set
of such optimizations.

However, the build system is not limited to these kind of transforms. At its core, the build system is an engine for
applying an ordered, synchronized, configurable set of transforms to a configurable input set. Examples of other usages
include document generators, style checkers, code formatters, lint checkers, and many more. In some ways it is like a
make program, except the external processes that typical make programs execute can be implemented within the build system's
pluggable transform infrastructure. Of course external processes can be executed as well.

*Note*: the build system was completely redesigned and reimplemented in version 1.7.
The pre-1.7 build system is still important to some existing installations.
All historical documentation for that system is listed at
:ref:`The Dojo Build System Prior to version 1.7 <build/pre17/build>`

:ref:`The Build System <build/buildSystem>`
  The top-level tutorial and reference that describes the basic operation of the build system when used for deployment optimizations.

:ref:`Quick Reference for Optimization Build Program <build/qref>`
  A quick reference manual for all build system switches and knobs.

Deployment Optimization Transforms
==================================

The Dojo Toolkit includes the deployment optimization transforms listed below. See individual transform reference pages
for complete documentation.

:ref:`copy <build/transforms/copy>`
  Copies a resource from a source location to a destination location.

:ref:`depsDump <build/transforms/depsDump>`
  Prints the module dependency graph of one or more modules.

:ref:`depsScan <build/transforms/depsScan>`
  Determines a module's dependencies and interns legacy dojo.cache string resources.

:ref:`dojoPragmas <build/transforms/dojoPragmas>`
  Applies dojo pragmas to a resource.

:ref:`dojoReport <build/transforms/dojoReport>`
  Outputs a report describing a single run of the deployment optimization transforms.

:ref:`hasFindAll <build/transforms/hasFindAll>`
  Finds and optionally reports all has.js feature test usages.

:ref:`hasFixup <build/transforms/hasFixup>`
  Trims dead code branches consequent to has feature values known at build time.

:ref:`hasReport <build/transforms/hasReport>`
  Outputs a report describing the name and location of all has.js feature tests.

:ref:`insertSymbols <build/transforms/insertSymbols>`
  Inserts debugging symbols into JavaScript resources.

:ref:`optimizeCss <build/transforms/optimizeCss>`
  Inlines CSS imports and/or removes comments from CSS files.

:ref:`read <build/transforms/read>`
  Reads a resource from the file system.

:ref:`write <build/transforms/write>`
  Writes a resource to the file system.

:ref:`writeAmd <build/transforms/writeAmd>`
  Writes an AMD module to the file system.

:ref:`writeCss <build/transforms/writeCss>`
  Writes a CSS style sheet to the file system

:ref:`writeDojo <build/transforms/writeDojo>`
  Outputs a module that includes the dojo loader; this transform is responsible for writing dojo.js.

:ref:`writeOptimized <build/transforms/writeOptimized>`
  Processes a resource with shrinksafe or the closure compiler and writes the result to the file system.

The Dojo Build System Prior to version 1.7
==========================================

The build system was completely redesigned and reimplemented in version 1.7. The version of the build system available
before 1.7 is still important to some existing installations. All historical documentation for that system is listed
below:

:ref:`The Dojo Build System Prior To 1.7 <build/pre17/build>`
  The main tutorial and reference for the build system prior to version 1.7.
