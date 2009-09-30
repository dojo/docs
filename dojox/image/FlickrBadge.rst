#format dojo_rst

dojox.image.FlickrBadge
=======================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: 1.0

.. contents::
   :depth: 2

An extension on `dojox.image.Badge <dojox/image/Badge>`_, using Flickr as a data provider.


============
Introduction
============

Flickr badge displays images on a page and cycles through the images displaying "badge" size
instances.


=====
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

========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript
             
        <script type="text/javascript">
	     dojo.require("dojox.image.FlickrBadge"); 
	</script>

  .. cv:: html

   <div dojoType="dojox.image.FlickrBadge" rows="8" cols="3" username="dylans" 
	tags="dojotoolkit,italy"></div>

  .. cv:: css

   <style>
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/image/resources/image.css";
    
    img.thing { width:50px; height:50px; }

   </style>


========
See also
========

* http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/image/tests/test_FlickrBadge.html
* http://www.sitepen.com/blog/2008/06/23/replacing-the-flash-flickr-badge-with-dojo/
