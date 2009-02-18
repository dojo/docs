#format dojo_rst

dojox.atom.io.model.Entry
=========================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

This object represents a Entry tag in an ATOM feed, the core container object of ATOM.

====================================
Public properties (and their types):
====================================

This function extends from `dojox.atom.io.model.AtomItem <dojox/atom/io/model/AtomItem>`_ so please refer to it for lists of properties and functions it inherits.

+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| **Type**                   | **Property**    | **Description**                                                                             |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | feedUrl         | The URL of the Atom feed that owns this entry                                               |
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
| undefined         | buildFromDom(DOMNode)                                | Builds this Entry from a given DOMNode.                     |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | toString()                                           | Return the XML representation of the Entry                  |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | getEditHref()                                        | Discovers the URL to send updated entry information to by   |
|                   |                                                      | way of the Atom Publishing Protocol                         |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+

=========
See Also: 
=========

* `dojox.atom.io.model <dojox/atom/io/model>`_
* `dojox.atom.io.model.AtomItem <dojox/atom/io/model/AtomItem>`_
