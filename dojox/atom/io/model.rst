#format dojo_rst

dojox.atom.io.model
===================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

The *dojox.atom.io.model* module is a JavaScript model of an ATOM feed.  

============
Introduction
============

This module handles the parsing of the ATOM XML into a JavaScript structure that can be easily modified and then serialized out as XML.  This set of classes handles browser idiosyncrasies when parsing the XML, making it very cross-browser compatible and is far simpler to work with than using DOM apis to walk the ATOM XML document.

============================
Classes defined in the model
============================

When the model file is loaded, several classes are defined that represent ATOM tags.  Please refer to the following table for the class names and a description of what they represent.  Each entry in the class name table also acts as a link to specific documentation about that class and what core functions it provides.

+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| **Class Name**                                      | **Description**                                                                        |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.AtomItem                        | A generic superclass used to represent specific ATOM details that are common for all   |
|                                                     | ATOM tags.                                                                             |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Category                        | Model to represent the Category tag of an ATOM document.  Contains all Category        |
|                                                     | properties and a toString function for serializing it back to XML                      |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Content                         | Model to represent the Content style tags in an ATOM document.  This is used to        |
|                                                     | represent Summary, Content, Title, and Subtitle elements in an ATOM feed.  In other    |
|                                                     | words, it represents any element that can contain Test, HTML, XHTML, etc as content    |
|                                                     | format.  It also has a toString function used to generate the corresponding XML tag    |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Link                            |	Atom link element.  Used for representing link attributes/  Handles multiple link types|
|                                                     | (edit, alt, etc.)                                                                      |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Person                          | Atom person element. Used to represent authors and contributors.                       |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Entry                           | Atom entry element. Represents an Atom entry, including storing the authors,           |
|                                                     | contributors, title, content, and so on.                                               |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Feed                            | Atom feed element. Represents an Atom Feed, including the feed elements such as the    |
|                                                     | title and author, and also represents the entry list.                                  | 
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Service                         |	Atom service element                                                                   |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Workspace                       |	Atom workspace element                                                                 |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.Collection                      |	Atom collection element                                                                |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+

=================
Utility Functions
=================

There are also several utility functions defined by the model.  These functions are used by all of the subclasses and can be useful in standalone cases as well.  Please refer to the following table for function name and description:

+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| **Function**                                        | **Description**                                                                        |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.util.createDate(DOMNode)        | A function for parsing the text content of a DOM node and creating a Date object from  |
|                                                     | it.                                                                                    |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.util.escapeHtml(String)         | A function for escaping HTML control and entity characters in a string so that it can  |
|                                                     | be handled as text without the markup affecting the XML document.                      |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.util.unEscapeHtml(String)       | A function for restoring the HTML control and tag characters to a string.  Useful when |
|                                                     | you wish to unEscape the content of an entry and display it in a Content Pane.         |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.util.getNodename(Node)          | A function for getting the node name of an XML node.  This function exists to handle   |
|                                                     | browser quirks.  Specifically things such as Internet Explorer's poor namespace        |
|                                                     | handling.                                                                              |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+


=====
Usage
=====

For specific usage, please see each module's documentation page:

* `dojox.atom.io.model <dojox/atom/io/model>`_
* `dojox.atom.io.Connection <dojox/atom/io/Connection>`_

========
See Also
========

* `dojox.data.AppStore <dojox/data/AppStore>`_: A datastore built upon the *io* modules and provides full APP support.
