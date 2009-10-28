#format dojo_rst

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

* `dojox.data.AndOrReadStore <dojox/data/AndOrReadStore>`_

  A clone of `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`__, which supports more complex queries than the simple AND format property matching

* `dojox.data.AndOrWriteStore <dojox/data/AndOrWriteStore>`_

  A clone of `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`__, which supports more complex queries than the simple AND format property matching

* `dojox.data.AppStore <dojox/data/AppStore>`_

  A store implementing an Atom store with complete ATOM Publishing Protocol support. Allows reading and writing of ATOM formatted feeds.

* `dojox.data.AtomReadStore <dojox/data/AtomReadStore>`_

  A store designed to provide read-only access to Atom XML documents

* `dojox.data.CouchDBRestStore <dojox/data/CouchDBRestStore>`_

  A datastore for connecting to the open source document-oriented database Apache CouchDB

* `dojox.data.CssClassStore <dojox/data/CssClassStore>`_

  A read interface based on the `dojox.data.CssRuleStore <dojox/data/CssRuleStore>`__

* `dojox.data.CssRuleStore <dojox/data/CssRuleStore>`_

  A read interface to the CSS rules loaded in the current page

* `dojox.data.CsvStore <dojox/data/CsvStore>`_

  A read interface that works with CSV formated data files

* `dojox.data.FileStore <dojox/data/FileStore>`_

  A lightweight data store implementation for accessing details about a remote FileSystem

* `dojox.data.FlickrRestStore <dojox/data/FlickrRestStore>`_

  Provides access to the Flickr photo sharing site's REST API

* `dojox.data.FlickrStore <dojox/data/FlickrStore>`_

  A wrapper to the public photo feed of the Flickr service

* `dojox.data.GoogleFeedStore <dojox/data/GoogleFeedStore>`_

  A Google AJAX API powered data store for retrieving RSS and Atom feeds from Google

* `dojox.data.GoogleSearchStore <dojox/data/GoogleSearchStore>`_

  Several data stores to interface Google's AJAX search services:

  * `dojox.data.GoogleWebSearchStore <dojox/data/GoogleWebSearchStore>`_

    A data store for retrieving search results from Google

  * `dojox.data.GoogleBlogSearchStore <dojox/data/GoogleBlogSearchStore>`_

    A data store for retrieving search results from Google Blogs

  * `dojox.data.GoogleLocalSearchStore <dojox/data/GoogleLocalSearchStore>`_

    A data store for retrieving search results from Google Location Search

  * `dojox.data.GoogleVideoSearchStore <dojox/data/GoogleVideoSearchStore>`_

    A data store for retrieving search results from Google Video

  * `dojox.data.GoogleNewsSearchStore <dojox/data/GoogleNewsSearchStore>`_

    A data store for retrieving search results from Google News

  * `dojox.data.GoogleBookSearchStore <dojox/data/GoogleBookSearchStore>`_

    A data store for retrieving search results from Google Book

  * `dojox.data.GoogleImageSearchStore <dojox/data/GoogleImageSearchStore>`_

    A data store for retrieving search results from Google Image

* `dojox.data.HtmlStore <dojox/data/HtmlStore>`_

  An extension of `dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>`__ to work with HTML tables, lists, and collections of DIV and SPAN tags

* `dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>`_

  A read interface to work with HTML tables

* `dojox.data.jsonPathStore <dojox/data/jsonPathStore>`_

  A local (in memory) store which can attach a dojo.data interface to each javascript object and uses jsonPath as the query language

* `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_

  A lightweight data store implementation of a RESTful client

* `dojox.data.KeyValueStore <dojox/data/KeyValueStore>`_

  An interface for reading property style files (key/value pairs)

* `dojox.data.OpmlStore <dojox/data/OpmlStore>`_

  A read-only store to work with Opml formatted XML files

* `dojox.data.PersevereStore <dojox/data/PersevereStore>`_

  An extension of `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`__ to handle Persevere's special features

* `dojox.data.PicasaStore <dojox/data/PicasaStore>`_

  A data store interface to one of the basic services of the Picasa service, the public photo feed

* `dojox.data.QueryReadStore <dojox/data/QueryReadStore>`_

  A read-only store, which makes a request to the server for each sorting or query in order to work with big datasets

* `dojox.data.S3Store <dojox/data/S3Store>`_

  An extension of `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`__ to handle Amazon's S3 service using JSON data

* `dojox.data.ServiceStore <dojox/data/ServiceStore>`_

  ServiceStore and it's subclasses are a generalized dojo.data implementation for any webservice

* `dojox.data.SnapLogicStore <dojox/data/SnapLogicStore>`_

  A data store interface to use the SnapLogic framework

* `dojox.data.WikipediaStore <dojox/data/WikipediaStore>`_

  An extension of `dojox.data.ServiceStore <dojox/data/ServiceStore>`__ to use Wikipedia's search service

* `dojox.data.XmlStore <dojox/data/XmlStore>`_

  A read and write interface to basic XML data


========
See also
========

* `Dojo Data Introduction <dojo/data>`_
* `Quickstart Tutorial: Using Dojo Data <quickstart/data/usingdatastores>`_
