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

String  	scheme  	The scheme for this category
String 	term 	The term for this category
String 	label 	The label for this category

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
| undefined         | buildFromDom(DOMNode)                                | Builds this AtomItem from a given DOMNode.                  |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | addAuthor(String name, String email, String uri)     | Adds an author to this item with the given information      |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | addContributor(String name, String email, String uri)| Adds a contributor to this item with the given information  |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | addCategory(String name, String term, String label)  | Adds a category to this item with the given information     |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | addLink(String href, String rel, String hrefLang,    | Adds a link with the given attributes to this item          |
|                   | String title, String type)                           |                                                             |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Number            | removeLink(String href, String rel)                  | Removes the given link from this item, returning the number |
|                   |                                                      | of links removed                                            |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Number            | removeBasicLinks()                                   | Removes all basic links (links with no rel attribute) from  |
|                   |                                                      | this item, returning the number of links removed            |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Array             | getCategories(String scheme)                         | Gets all categories matching the given scheme for this item |
|                   |                                                      | and returns them in an array                                |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Number            | removeCategories(String scheme, String term)         | Removes all categories matching the given scheme, returning |
|                   |                                                      | the number of categories removed.                           |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | setTitle(String str, String type)                    | Sets the title of this item to the given str with the given | 
|                   |                                                      | type, such as text, html, xml, etc.                         |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | addExtension(String name_space, String name,         | Adds in an extension namespace into the item.               |
|                   | Array attributes, String content, String shortNS)    |                                                             |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| Array             | getExtensions(String name_space, String name)        | Gets all extensions matching the given name_space and name  |
|                   |                                                      | and returns those extension in an array. name_space can be  |
|                   |                                                      | the full namespace (like 'http://www.w3.org/2005/Atom') or  |
|                   |                                                      | the given short name (like 'atom')                          |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | removeExtensions(String name_space, String name)     | Removes all extensions matching the given name_space and    |
|                   |                                                      | name                                                        |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
| undefined         | destroy()                                            | Deletes all variables associated with this item             |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+

=========
See Also: 
=========

* `dojox.atom.io.model <dojox/atom/io/model>`_
