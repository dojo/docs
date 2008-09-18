#format dojo_rst

dojox.data.GoogleSearchStore
============================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.2

.. contents::
  :depth: 3


The GoogleFeedStore is a store designed to work against Google's feed AJAX API.  This store is an extension of GoogleSearchStore.


**Note:**  These stores make use of Google's `AJAX search services. <http://code.google.com/apis/ajaxsearch/>`_.  In order to use them in your web-sites, please make sure to read `Google's terms and conditions <http://code.google.com/apis/ajaxsearch/terms.html>`_ and agree to them before using these stores.

===========
API Support
===========

* `dojo.data.api.Read <dojo/data/api/Read>`_

==================
Constructor Params
==================

The following parameters are supported by the GoogleFeedStore implementation.

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
dojox.data.GoogleFeedStore
----------------------------

+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The feed entry title.                                                                                                        |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|link             |The URL for the HTML version of the feed entry.                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|content          |The full content of the blog post, in HTML format                                                                            |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|summary          |A snippet of information about the feed entry, in plain text                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|published        |The string date on which the entry was published.                                                                            |
|                 |  You can parse the date with new Date(store.getValue(item, "published").                                                    |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|categories       |An array of string tags for the entry                                                                                        |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
