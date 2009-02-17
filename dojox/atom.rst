#format dojo_rst

dojox.atom
==========

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

The *dojox.atom* project is a container project for functions and widgets that specifically deal with working with the `ATOM <http://en.wikipedia.org/wiki/Atom_(standard)>`_ data format.

============
Introduction
============

ATOM is a syndication format that uses a defined schema of XML for providing updated lists of things.  The things can be news events, blog posts, whatever the syndication publisher wishes to publish.  It came about as an alternative (and a more extensible), competitor to the widely used `RSS <http://en.wikipedia.org/wiki/RSS_(file_format)>`_ format.  This project contains libraries and and examples of how to work with ATOM feeds using the Dojo Toolkit.

======================
Available Sub-projects
======================

* **io**:  Modules dealing with the reading and writing of ATOM data.

  * **model.js**:  A module that defines a JavaScript model of the ATOM XML data feed.  It allows for easier lookup of ATOM attributes and generation of ATOM formatted XML documents.

  * **Connection.js**:  A module that wrappers the JavaScript model for an ATOM feed and provides several helper functions for getting feeds, updating entries, creating new entries, and deleting entries.  Under the covers it uses model.js and the `dojo.xhr <dojo/xhr>`_ functions to implement the full APP (ATOM Publishing Protocol).

* **widget**:  Example widgets that use the ATOM IO later and model to render and edit ATOM feeds.  These are primarily examples and may not be perfect.
* **tests**: Tests for the various modules.

=====
Usage
=====

For specific usage, please see each module's documentation page:

* `dojox.atom.io.model <dojox/atom/io/model>`_
* `dojox.atom.io.Connection <dojox/atom/io/model>`_

========
See Also
========

* `dojox.data.AppStore <dojox/data/AppStore>`_: A datastore built upon the *io* modules and provides full APP support.
