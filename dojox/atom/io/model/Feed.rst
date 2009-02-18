#format dojo_rst

dojox.atom.io.model.Feed
========================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

This object represents an ATOM Feed.

====================================
Public properties (and their types):
====================================

This function extends from `dojox.atom.io.model.AtomItem <dojox/atom/io/model/AtomItem>`_ so please refer to it for the list of properties it inherits.

==========================================
Public functions (and their return types):
==========================================

This function extends from `dojox.atom.io.model.AtomItem <dojox/atom/io/model/AtomItem>`_ so please refer to it for the list of functions it inherits.

Below are all the additional functions implemented by this model class.


String 	()


+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| **Return Type**   | **Function**                                         | **Description**                                             |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Boolean           | accept(String)                                       | Returns whether this item accepts the given tag name.       |
|                   |                                                      | Overriden by child classes                                  |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | toString()                                           | Return the XML representation of the Entry                  |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | addNamespace(String fullName, String shortName)      | Adds the given namespace to this feed                       |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | addEntry(dojox.atom.io.model.Entry Entry)            | Adds the given entry into this object representation of the |
|                   |                                                      | Atom feed. This function does not send any data to the      |
|                   |                                                      | server.                                                     |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Entry             | getFirstEntry()                                      | Retrieves the first dojox.atom.io.model.Entry of this Atom  |
|                   |                                                      | feed                                                        |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Entry             | getEntry(String)                                     | Retrieves the dojox.atom.io.model.Entry identified by the   |
|                   |                                                      | given ID string                                             |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Number 	    | removeEntry(dojox.atom.io.model.Entry)               | Removes the given entry from the feed, returning the number |
|                   |                                                      | of entries removed                                          |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | setEntries(Array arrayOfEntry)                       | Adds the entries contained in the given array into this Atom|
|                   |                                                      | feed                                                        |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Entry             | createEntry()                                        | Creates a new dojox.atom.io.model.Entry entry object, sets  |
|                   |                                                      | its feedUrl variable, and returns the entry object          |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| String            | getSelfHref()                                        | Gets the URL of this Atom feed, or returns a null value if  |
|                   |                                                      | the feed does not include the appropriate link object       |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+

=========
See Also: 
=========

* `dojox.atom.io.model <dojox/atom/io/model>`_
* `dojox.atom.io.model.AtomItem <dojox/atom/io/model/AtomItem>`_
