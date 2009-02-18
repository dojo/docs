#format dojo_rst

dojox.atom.io.model.Person
==========================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

This object represents a person object, which is used for the author and contributor types in the Atom specification. A person object can have a name, an email address, a URI, or both.

====================================
Public properties (and their types):
====================================

+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| **Type**                   | **Property**    | **Description**                                                                             |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | personType      | The type of person this object represents, typically either author or contributor.          |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | name            | The name of this person object                                                              |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | email           | This email address of this person                                                           |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | uri             | The URI of this person, such as a website, etc.                                             |
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
| undefined         | buildFromDom(DOMNode)                                | Builds this Person from a given DOMNode.                    |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | toString()                                           | Return the XML representation of the Person                 |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+

=========
See Also: 
=========

* `dojox.atom.io.model <dojox/atom/io/model>`_
