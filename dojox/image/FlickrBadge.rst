.. _dojox/image/FlickrBadge:

=======================
dojox.image.FlickrBadge
=======================

:Project owner: ?--
:since: V1.0

.. contents ::
   :depth: 2

An extension on :ref:`dojox.image.Badge <dojox/image/Badge>`, using Flickr as a data provider.


Introduction
============

Flickr badge displays images on a page and cycles through the images displaying "badge" size
instances.


Usage
=====

There are a number of configurable parameters, most of which are optional:

==========    ======================================================================
Parameter     Description
==========    ======================================================================
apikey        your Flickr API key
columns       # of columns of images to display
rows          # of rows of images to display
searchText    free text search of title, description, and tags
setid         id of a Flickr set to use in displaying images
tags          a comma separated list of tags or an array of tags to grab from Flickr
userid        your flickr userid (saves a lookup request)
username      your flickr username
==========    ======================================================================

Examples
========

Declarative example
-------------------

.. code-example ::

  .. js ::
             
     dojo.require("dojox.image.FlickrBadge");

  .. html ::

     <div data-dojo-type="dojox.image.FlickrBadge" data-dojo-props="rows:8, cols:3, username:'dylans',
        tags:'dojotoolkit,italy'"></div>

  .. css ::

    @import "{{baseUrl}}dojox/image/resources/image.css";

    img.thing { width:50px; height:50px; }



See also
========

* http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/image/tests/test_FlickrBadge.html
* http://www.sitepen.com/blog/2008/06/23/replacing-the-flash-flickr-badge-with-dojo/
