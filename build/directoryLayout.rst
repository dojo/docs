#format dojo_rst

Sample Directory Layout for Builds
==================================

:Status: Draft
:Version: 1.0
:Project owner: (docs) Scott A Jenkins
:Available: since 1.0

.. contents::
   :depth: 2

This document summarizes an effective layout for managing Dojo directories for the build process.


============
Introduction
============

Each source version of Dojo contains a util/buildscripts directory with the appropriate building scripts and tools for that version.  This is part of the main directory tree for the Dojo release.

Additionally, many Dojo users would like to maintain private namespaces, with their own source directory tree, independently of the particular Dojo release version, and make build files based on that.

This directory layout (which is used in each of the scenario examples) facilitates these goals:

 1. No additional files are mixed into the Dojo source release directory tree.
 2.  No additional build files are mixed into any private namespace directory trees.
 3.  The build files (profiles and other support files) do not need to be moved into new specific directories each time a new version of Dojo is released, or a new version of a custom namespace is created.

================
Directory Layout
================

Here is a sample directory layout (from a Windows operating system, but the concepts would be the same for a unix-type operating system):

.. image :: dojo-download-src.png



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
