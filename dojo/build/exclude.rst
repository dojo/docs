#format dojo_rst

Dojo build system:  conditional exclusions
==========================================

:Status: Draft
:Version: 1.0
:Project owner: Scott Jenkins
:Available: 1.0?

.. contents::
   :depth: 3


============
Introduction
============

In very advanced situations, you may wish to have certain source code excluded from the built version of the file, based on some condition that is evaluated during the build itself.

The Dojo build system permits special directives (known as pragmas) to be passed to the builder via comments within JavaScript source code  that it is processing,  The existing pramas allow the builder to conditionally include or exclude certain parts of the source file from the as-built version of the file.

This is somewhat analogous to the use of ``#ifdef`` pragmas within the C pre-processor.

For example, you might wish to strip a profiling module from a release build but include it in a development build.

======
Syntax
======

This feature is implemented by creating exclusion regions bracketed by start and end pragmas, as follows:

.. code-block :: javascript
  :linenos:

  //>>startExclude("Tag", kwArgs.layers.length > 1)

  ... code within the region here

  //>>stopExclude("Tag")

Lines 1 and 5, beginning with ``//>>`` are the pramas.  The ``//`` makes the lines comments in JavaScript, so they will not cause errors.  The full ``//>>`` is the symbol that the builder is looking for to tell it there is a pragma.

The pragmas ``startExclude`` and ``stopExclude`` work together to create the exclusion region:  the region begins with the startExclude, and ends with the matching stopExclude pragma.

The syntax of the pragma itself is equivalent to a JavaScript function call.  The parameters of the conditional inclusion pragmas are:

``startExclude(`` *tag* ``, `` *condition* ``)``

``stopExclude(`` *tag* ``)``

where

  * *tag* is a string (usually a string literal) naming the pair.  This permits matching startExclude and stopExclude tags to be determined. 
  * *condition* is a condition indicating when the text within the exclusion region should not be included in the as-built version of the JavaScript file.  That is, if the condition evaluates to true, none of the text from the exclusion region is copied into the as-built file.

Note:  the tag for the startExclude pragma must be equal to the tag for the stopExclude pragma.

=========
Condition
=========

The builder evaluates the condition in the startExclude pramga *at build time* to determine whether or not to exclude the region from the as-built file.

This parameter is actually JavaScript code which is evaluated by the builder at the time it encounters the pragma against the builder's own executing JavaScript context.  Therefore, the expression can access objects which exist within the builder.

The object you most commonly will evaluate against is ``kwArgs`` which is where the builder stores its profile (it actually stores all of its parameters there, whether they originate in the profile, on the build command line, or from the builders' built in defaults).

===============
Builder Objects
===============

TODOC:  Document builder objects of interest

============================
Nesting conditional excludes
============================

It is technically possible to nest conditional excludes.  However, this is discouraged.

If you do nest, the exclusion regions must be fully and properly nested.  Thus, the following would be illegal:

.. code-block :: javascript
  :linenos:

  //>>startExclude("AAA", kwArgs.layers.length > 1)

  ...

  //>>startExclude("BBB", kwArgs.layers.indexOf("dojo") == 1)

  ...

  //>>stopExclude("AAA")
  //>>stopExclude("BBB")

because the named regions overlap.

========
See also
========

* TODO: links to other related articles
