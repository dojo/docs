#format dojo_rst

dojox.data
==========

:Status: Draft
:Version: 1.0
:Authors: Wolfram Kriesing, Nikolia Onken, Marcus Reimann
:Developers: Frank Fortson, Russell Jones, Jared Jurkiewicz, Wolfram Kriesing, Dustin Machi, Shane O'Sullivan, Benjamin Schell, Kurt Stutsman, Kris Zyp
:Available: since V0.9

.. contents::
   :depth: 2

The DojoX Data project is a container for extensions and extra example stores that implement the dojo.data APIs. It may also contain utility functions for working with specific types of data.


========
Features
========

* `dojox.data.AndOrReadStore <dojox/data/AndOrReadStore>`_
* `dojox.data.AndOrWriteStore <dojox/data/AndOrWriteStore>`_
* `dojox.data.AtomReadStore <dojox/data/AtomReadStore>`_
* `dojox.data.CouchDBRestStore <dojox/data/CouchDBRestStore>`_

  An extension of `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`__ to handle CouchDB's idiosyncrasies, special features, and deviations from standard HTTP Rest

* `dojox.data.CssClassStore <dojox/data/CssClassStore>`_
* `dojox.data.CssRuleStore <dojox/data/CssRuleStore>`_
* `dojox.data.CsvStore <dojox/data/CsvStore>`_
* `dojox.data.FileStore <dojox/data/FileStore>`_
* `dojox.data.FlickrRestStore <dojox/data/FlickrRestStore>`_
* `dojox.data.FlickrStore <dojox/data/FlickrStore>`_
* `dojox.data.GoogleFeedStore <dojox/data/GoogleFeedStore>`_

  A Google AJAX API powered data store for retrieving RSS and Atom feeds from Google

* `dojox.data.GoogleSearchStore <dojox/data/GoogleSearchStore>`_

  Several data stores to interface Google's AJAX search services:

    * `dojox.data.GoogleWebSearchStore <dojox/data/GoogleWebSearchStore>`_
    * `dojox.data.GoogleBlogSearchStore <dojox/data/GoogleBlogSearchStore>`_
    * `dojox.data.GoogleLocalSearchStore <dojox/data/GoogleLocalSearchStore>`_
    * `dojox.data.GoogleVideoSearchStore <dojox/data/GoogleVideoSearchStore>`_
    * `dojox.data.GoogleNewsSearchStore <dojox/data/GoogleNewsSearchStore>`_
    * `dojox.data.GoogleBookSearchStore <dojox/data/GoogleBookSearchStore>`_
    * `dojox.data.GoogleImageSearchStore <dojox/data/GoogleImageSearchStore>`_

* `dojox.data.HtmlStore <dojox/data/HtmlStore>`_
* `dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>`_
* `dojox.data.jsonPathStore <dojox/data/jsonPathStore>`_
* `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_

  A lightweight data store implementation of a RESTful client

* `dojox.data.KeyValueStore <dojox/data/KeyValueStore>`_
* `dojox.data.OpmlStore <dojox/data/OpmlStore>`_
* `dojox.data.PersevereStore <dojox/data/PersevereStore>`_

  An extension of `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`__ to handle Persevere's special features

* `dojox.data.PicasaStore <dojox/data/PicasaStore>`_
* `dojox.data.QueryReadStore <dojox/data/QueryReadStore>`_
* `dojox.data.S3Store <dojox/data/S3Store>`_

  An extension of `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`__ to handle Amazon's S3 service using JSON data

* `dojox.data.ServiceStore <dojox/data/ServiceStore>`_
* `dojox.data.SnapLogicStore <dojox/data/SnapLogicStore>`_
* `dojox.data.WikipediaStore <dojox/data/WikipediaStore>`_
* `dojox.data.XmlStore <dojox/data/XmlStore>`_
