#format dojo_rst

Dojo Documentation Tools
========================

:Status: Draft
:Version: 1.0
:Project owner: Neil Roberts
:Available: since V1.3

.. contents::
   :depth: 2

Dojo uses a specially crafted, highly readable inline documentation format and distributes the PHP-based code parser used to collect the information. 

============
Introduction
============

The dojo javascript codebase makes use of a consistent commenting style to faciliate generated API documentation, which gives developers an outline of what methods are defined and how to use them. This is analagous to javadoc and similar conventions used in most programming languages today. The parser collects the information from the javascript files and produces output in json or XML format. This can be further transformed for use by editors and IDEs for example, or fed into a viewer application for a handy browsable interface to the API.  These pages describe the parts of the system and how to use them to generate your own documentation of both dojo and custom code.

* `API doc syntax <util/doctools/markup>`_ - how to markup API documentation in your code

* `Running the generation tools <util/doctools/generate>`_ - directories setup, defining custom namespaces, configuring and running the generation tools

* `Viewing the API output data <util/doctools/viewer>`_ - how to setup and load the extracted API data into a web-based viewer
