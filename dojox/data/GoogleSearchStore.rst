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
