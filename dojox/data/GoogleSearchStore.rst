#format dojo_rst

dojox.data.GoogleSearchStore
============================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.2

.. contents::
  :depth: 3


The GoogleSearchStore is actually a collection of stores designed to work with Google's Ajax search services.  GoogleSearchStore is the base class  that all subclasses of GoogleSearchStore extend from.  It provides all the basics of working with Google's search API in a dojo.data compliant implementation.  The following stores are avaialble for use after dojo.require() is used to load dojox.data.GoogleSearchStore:

* **dojox.data.GoogleSearchStore** - The basic search store that all more fine-grained searches inherit from.  This store defaults to querying Google's Web-search Ajax calls.
* **dojox.data.GoogleWebSearchStore** - A store configured to search specifically against Google's Web search Ajax calls.
* **dojox.data.GoogleBlogSearchStore** - A store configured to search specifically against Google's Blog (Web log) search Ajax calls.
* **dojox.data.GoogleLocalSearchStore** - A store configured to search specifically against Google's Location related search Ajax calls.
* **dojox.data.GoogleVideoSearchStore** - A store configured to search specifically against Google's Video search Ajax calls.
* **dojox.data.GoogleBookSearchStore** - A store configured to search specifically against Google's Book search Ajax calls.
* **dojox.data.GoogleImageSearchStore** - A store configured to search specifically against Google's Image search Ajax calls.

**Note:**  These stores make use of Google's `AJAX search services. <http://code.google.com/apis/ajaxsearch/>`_.  In order to use them in your web-sites, please make sure to read `Google's terms and conditions <http://code.google.com/apis/ajaxsearch/terms.html>`_ and agree to them before using these stores.

===========
API Support
===========

* `dojo.data.api.Read <dojo/data/api/Read>`_

==================
Constructor Params
==================

The following parameters are supported by all Google store implementations.

+-------------+------------------------------------------------------------------------------------------+----------------------+
| **name**    | **description**                                                                          | **type**             |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|label        |The attribute of the search returns to use as the item's label.  Defaults to              |string                | 
|             |titleNoFormatting.                                                                        |                      |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|key          |Your Google API key (optional)                                                            | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|lang         |The language locale to use. Defaults to the browser locale.                               | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+

===============
Item Attributes
===============

Depending on which of the search stores you instantiate, the supported list of item attributes changes.  This is because each search service exposes different information, since each type of search by its nature deems specific information the key information to return.  Below you will find a list of expected attribute names for each search service and what they are:

----------------------------
dojox.data.GoogleSearchStore
----------------------------
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|url              |The URL for the item returned by the search                                                                                  |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|unescapedUrl     |The URL for the item, without URL escaping. This is often more readable.                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|visibleUrl       |The URL with no protocol specified.                                                                                          |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|cacheUrl         |The URL to the copy of the document cached by Google                                                                         |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The page title in HTML format.                                                                                               |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting|The page title in plain text                                                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|content          |A snippet of information about the page.                                                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
