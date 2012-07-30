.. _util/doctools:

============================
Dojo API Documentation Tools
============================

:Project owner: Neil Roberts
:since: V1.3

.. contents ::
   :depth: 2

Deprecated, see https://github.com/wkeese/api-viewer/blob/master/README.rst for latest instructions.

Dojo uses a specially crafted, highly readable inline documentation format and distributes the PHP-based code parser used
to collect the information.

Introduction
============

The Dojo JavaScript codebase makes use of a consistent commenting style to facilitate generated API documentation, which
gives developers an outline of what methods are defined and how to use them.  This is analogous to
`Javadoc <http://en.wikipedia.org/wiki/Javadoc>`_ and similar conventions used in most programming languages today.  The
parser collects the information from the JavaScript files and produces output in json or XML format.  This can be further
transformed for use by editors and IDEs for example, or fed into a viewer application for a handy browsable interface to
the API.  These pages describe the parts of the system and how to use them to generate your own documentation of both
Dojo and custom code.

* :ref:`API doc syntax <developer/markup>` - how to markup API documentation in your code

* :ref:`Running the generation tools <util/doctools/generate>` - directories setup, defining custom namespaces,
  configuring and running the generation tools

* :ref:`Viewing the API output data <util/doctools/viewer>` - how to setup and load the extracted API data into a
  web-based viewer
