#format dojo_rst

dojox.atom.io.model.Category
============================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

This object represents the Category element of the Atom specification. Entries and feeds can each have category elements to convey information about the entry or feed.

====================================
Public properties (and their types):
====================================

+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| **Type**                   | **Property**    | **Description**                                                                             |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | scheme          | The scheme for this category                                                                |                                                                 
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | term            | The term for this category                                                                  |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | label           | The label for this category                                                                 |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+

==========================================
Public functions (and their return types):
==========================================

Below are all the functions implemented by this model class.


+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| **Return Type**   | **Function**                                         | **Description**                                             |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Boolean           | accept(String)                                       | Returns whether this item accepts the given tag name.       |
|                   |                                                      | Overriden by child classes                                  |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | buildFromDom(DOMNode)                                | Builds this Category from a given DOMNode.                  |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | toString()                                           | Return the XML representation of the Category               |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+

=========
See Also: 
=========

* `dojox.atom.io.model <dojox/atom/io/model>`_
