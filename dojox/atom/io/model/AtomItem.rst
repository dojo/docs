#format dojo_rst

dojox.atom.io.model.AtomItem
============================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

The AtomItem class is generally not used independently.  It is AtomItem class is the base class for Atom feed and entry objects, because they share some common components (title, subtitle, icon, arrays of authors, contributors, and links).

====================================
Public properties (and their types):
====================================

+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| **Type**                   | **Property**    | **Description**                                                                             |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | ATOM_URI        | The URI of the Atom namespace                                                               |                                                                 
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| Array                      | links           | Houses multiple dojox.atom.io.model.Link objects of the links associated with this Atom item|
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| Array                      | authors         | Houses the dojox.atom.io.model.Person objects of the authors                                |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| Array                      | categories      | Houses the dojox.atom.io.model.Category objects associated with this Atom item              |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| Array                      | contributors    | Houses the idojox.atom.io.model.Person objects of the contributors                          |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+ 
| String                     | icon            | The URL to the icon for this item.                                                          |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | id              | The ID of this item                                                                         |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | logo            | The URL to the logo for this item                                                           |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| String                     | rights          | The associated rights for this Atom item                                                    |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| dojox.atom.io.model.Content| title           | The title of this item                                                                      |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| dojox.atom.io.model.Content| subtitle        | The subtitle of this item                                                                   |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| Date                       | updated         | The date that this item was updated                                                         |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| dojox.atom.io.model.Content| content         | The content of this item                                                                    |
+----------------------------+-----------------+---------------------------------------------------------------------------------------------+
| Array                      | entries         | Array of dojox.atom.io.model.Entry objects for this item                                    |
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
| void              | destroy()                                            | Deletes all variables associated with this item             |
+-------------------+------------------------------------------------------+-------------------------------------------------------------+
