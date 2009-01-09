#format dojo_rst

dojo.modulename
===============

:Status: Draft
:Version: 1.0
:Project owner: Scott Jenkins
:Available: 1.0?

.. contents::
   :depth: 2

The Dojo build system permits special directives to be passed to the builder via comments within JavaScript source code (pragmas), to conditionally include or exclude certain parts of the source file from the built version of the file.

============
Introduction
============

In very advanced situations, you may wish to have certain source code excluded from the built version of the file, based on some condition that is evaluated during the build itself.

For example, you might wish to strip a profiling module from a release build.

Syntax
------

This feature is implemented by creating exclusion regions bracketed by start and end pragmas, as follows:

.. code-block :: javascript
  :linenos:

  //>>startExclude("Tag", kwArgs.layers.length > 1)

  ... code within the region here

  //>>stopExclude("Tag")

Lines 1 and 5, beginning with ``//>>`` are the pramas.  The ``//`` makes the lines comments in JavaScript, so they will not cause errors.  The full ``//>>`` is the symbol that the builder is looking for to tell it there is a pragma.

The syntax of the pragma itself is equivalent to a JavaScript function call.

The pragmas ``startExclude`` and ``stopExclude`` work together to create the exclusion region:  the region begins with the startExclude, and ends with the matching stopExclude pragma.

The regions match if the first parameter of the pro

Tags
====






=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
