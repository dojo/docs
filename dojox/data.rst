.. _dojox/data:

dojox.data
==========

:Project owners: Frank Fortson, Russell Jones, Jared Jurkiewicz, Wolfram Kriesing, Dustin Machi, Shane O'Sullivan, Benjamin Schell, Kurt Stutsman, Kris Zyp
:Authors: Wolfram Kriesing, Nikolia Onken, Marcus Reimann
:Available: since V0.9

.. contents::
   :depth: 2

The DojoX Data project is a container for extensions and extra example stores that implement the dojo.data APIs. It may also contain utility functions for working with specific types of data.


========
Features
========

* :ref:`dojox.data.AndOrReadStore <dojox/data/AndOrReadStore>`

  A clone of :ref:`dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`, which supports more complex queries than the simple AND format property matching

* :ref:`dojox.data.AndOrWriteStore <dojox/data/AndOrWriteStore>`

  A clone of :ref:`dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`, which supports more complex queries than the simple AND format property matching

* :ref:`dojox.data.AppStore <dojox/data/AppStore>`

  A store implementing an Atom store with complete ATOM Publishing Protocol support. Allows reading and writing of ATOM formatted feeds.

* :ref:`dojox.data.AtomReadStore <dojox/data/AtomReadStore>`

  A store designed to provide read-only access to Atom XML documents

* :ref:`dojox.data.CouchDBRestStore <dojox/data/CouchDBRestStore>`

  A datastore for connecting to the open source document-oriented database Apache CouchDB

* :ref:`dojox.data.CssClassStore <dojox/data/CssClassStore>`

  A read interface based on the :ref:`dojox.data.CssRuleStore <dojox/data/CssRuleStore>`

* :ref:`dojox.data.CssRuleStore <dojox/data/CssRuleStore>`

  A read interface to the CSS rules loaded in the current page

* :ref:`dojox.data.CsvStore <dojox/data/CsvStore>`

  A read interface that works with CSV formated data files

* :ref:`dojox.data.FileStore <dojox/data/FileStore>`

  A lightweight data store implementation for accessing details about a remote FileSystem

* :ref:`dojox.data.FlickrRestStore <dojox/data/FlickrRestStore>`

  Provides access to the Flickr photo sharing site's REST API

* :ref:`dojox.data.FlickrStore <dojox/data/FlickrStore>`

  A wrapper to the public photo feed of the Flickr service

* :ref:`dojox.data.GoogleFeedStore <dojox/data/GoogleFeedStore>`

  A Google AJAX API powered data store for retrieving RSS and Atom feeds from Google

* :ref:`dojox.data.GoogleSearchStore <dojox/data/GoogleSearchStore>`

  Several data stores to interface Google's AJAX search services:

  * :ref:`dojox.data.GoogleWebSearchStore <dojox/data/GoogleWebSearchStore>`

    A data store for retrieving search results from Google

  * :ref:`dojox.data.GoogleBlogSearchStore <dojox/data/GoogleBlogSearchStore>`

    A data store for retrieving search results from Google Blogs

  * :ref:`dojox.data.GoogleLocalSearchStore <dojox/data/GoogleLocalSearchStore>`

    A data store for retrieving search results from Google Location Search

  * :ref:`dojox.data.GoogleVideoSearchStore <dojox/data/GoogleVideoSearchStore>`

    A data store for retrieving search results from Google Video

  * :ref:`dojox.data.GoogleNewsSearchStore <dojox/data/GoogleNewsSearchStore>`

    A data store for retrieving search results from Google News

  * :ref:`dojox.data.GoogleBookSearchStore <dojox/data/GoogleBookSearchStore>`

    A data store for retrieving search results from Google Book

  * :ref:`dojox.data.GoogleImageSearchStore <dojox/data/GoogleImageSearchStore>`

    A data store for retrieving search results from Google Image

* :ref:`dojox.data.HtmlStore <dojox/data/HtmlStore>`

  An extension of :ref:`dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>` to work with HTML tables, lists, and collections of DIV and SPAN tags

* :ref:`dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>`

  A read interface to work with HTML tables

* :ref:`dojox.data.jsonPathStore <dojox/data/jsonPathStore>`

  A local (in memory) store which can attach a dojo.data interface to each javascript object and uses jsonPath as the query language

* :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>`

  A lightweight data store implementation of a RESTful client

* :ref:`dojox.data.KeyValueStore <dojox/data/KeyValueStore>`

  An interface for reading property style files (key/value pairs)

* :ref:`dojox.data.OpmlStore <dojox/data/OpmlStore>`

  A read-only store to work with Opml formatted XML files

* :ref:`dojox.data.PersevereStore <dojox/data/PersevereStore>`

  An extension of :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>` to handle Persevere's special features

* :ref:`dojox.data.PicasaStore <dojox/data/PicasaStore>`

  A data store interface to one of the basic services of the Picasa service, the public photo feed

* :ref:`dojox.data.QueryReadStore <dojox/data/QueryReadStore>`

  A read-only store, which makes a request to the server for each sorting or query in order to work with big datasets

* :ref:`dojox.data.S3Store <dojox/data/S3Store>`

  An extension of :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>` to handle Amazon's S3 service using JSON data

* :ref:`dojox.data.ServiceStore <dojox/data/ServiceStore>`

  ServiceStore and it's subclasses are a generalized dojo.data implementation for any webservice

* :ref:`dojox.data.SnapLogicStore <dojox/data/SnapLogicStore>`

  A data store interface to use the SnapLogic framework

* :ref:`dojox.data.WikipediaStore <dojox/data/WikipediaStore>`

  An extension of :ref:`dojox.data.ServiceStore <dojox/data/ServiceStore>` to use Wikipedia's search service

* :ref:`dojox.data.XmlStore <dojox/data/XmlStore>`

  A read and write interface to basic XML data


========
See also
========

* :ref:`Dojo Data Introduction <dojo/data>`
* :ref:`Quickstart Tutorial: Using Dojo Data <quickstart/data/usingdatastores>`
