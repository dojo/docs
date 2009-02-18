#format dojo_rst

dojox.atom.io.model.Generator
=============================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

This Atom element conveys information about the package that generated this Atom feed. A generator can have a URI and a version number, in addition to the human-readable name.

====================================
Public properties (and their types):
====================================

+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| **Type**                   | **Property**    | **Description**                                                                             |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | uri             | The URI for this generator                                                                  |                                                                 
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | version         | The version number of this generator                                                        |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | value           | The human-readable name of this generator                                                   |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+

==========================================
Public functions (and their return types):
==========================================

Below are all the functions implemented by this model class.

+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| **Return Type**   | **Function**                                         | **Description**                                             |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | buildFromDom(DOMNode)                                | Builds this Generator from a given DOMNode.                 |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | toString()                                           | Return the XML representation of the Generator              |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+

=========
See Also: 
=========

* `dojox.atom.io.model <dojox/atom/io/model>`_
