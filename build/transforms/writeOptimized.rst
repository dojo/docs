.. _build/transforms/writeOptimized:

==============================
Build Transform writeOptimized
==============================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Submits transformed resource text to either Shrinksafe or the Google Closure Compiler.

Description
===========

If the profile property ``layerOptimize`` is a valid optimizer (see below), then, for every layer module, this transform
writes the current value of the transformed text to the destination location with the filetype ".uncompressed.js" and
then causes the named optimizer to process the resource and write the result to the destination location.

If the profile property ``optimize`` is a valid optimizer (see below), then, for non-layer module, this transform
writes the current value of the transformed text to the destination location with the filetype ".uncompressed.js" and
then causes the named optimizer to process the resource and write the result to the destination location.

The profile property ``stripConsole`` may also be set as described below to strip all console output.

When the build application is executed in the node.js environment, multiple child processes are started so that several
resources may be optimized concurrently, thereby decreasing build times. This feature is not available in the Rhino
environment.

Profile Knobs
=============


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

  * ["closure.keeplines"] All layer modules are processed by the Google Closure compiler, simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["closure"] All layer modules are processed by the Google Closure compiler, simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["uglify.keeplines"] All layer modules are processed by the UglifyJS compiler (version 1 only), simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["uglify"] All layer modules are processed by the UglifyJS compiler (version 1 only), simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.


``optimize`` (default = "undefined")
  * [*falsy*] Non-layer modules are not optimized; the ``stripConsole`` profile property, if any, is ignored.

  * ["comment.keeplines"] All comments are removed from all non-layer modules; new-lines are preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["comment"] All comments are removed form all non-layer modules; new-lines are *not* preserved; the ``stripConsole``
    profile property, if any, is ignored.

  * ["shrinksafe.keeplines"] All non-layer modules are processed by shrinksafe; new-lines are preserved; the semantics of
    the ``stripConsole`` property are executed.

  * ["shrinksafe"] All non-layer modules are processed by shrinksafe; new-lines are *not* preserved; the semantics of the
    ``stripConsole`` property are executed.

  * ["closure.keeplines"] All non-layer modules are processed by the Google Closure compiler, simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["closure"] All non-layer modules are processed by the Google Closure compiler, simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["uglify.keeplines"] All layer modules are processed by the UglifyJS compiler (version 1 only), simple-mode; new-lines are
    preserved; the semantics of the ``stripConsole`` property are executed.

  * ["uglify"] All layer modules are processed by the UglifyJS compiler (version 1 only), simple-mode; new-lines are *not*
    preserved; the semantics of the ``stripConsole`` property are executed.

**Important**: Dead code removal consequent to static has.js feature values and the hasFixup transform requires a Google
  Closure or UglifyJS compiler optimization switch setting. To use UglifyJS, you will need to ``npm install uglify-js@1``, in a directory parallel to ``util``

``stripConsole`` (default = "normal")
  * ["none"] No console applications are stripped.

  * ["normal"] All console applications are stripped except ``console.error`` and ``console.warn``.

  * ["warn"] All console applications are stripped except ``console.error``.

  * ["all"] All console applications are stripped.

Source Location
===============

util/build/transforms/writeOptimized.js
