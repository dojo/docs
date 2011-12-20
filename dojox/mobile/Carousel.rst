.. _dojox/mobile/Carousel:

=====================
dojox.mobile.Carousel
=====================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

The carousel widget manages a list of images that can be displayed horizontally, and allows the user to scroll through the list and select a single item.

.. image :: Carousel.png

Usage
=====

Carousel is in a separate module file from _base.js. You need to dojo.require Carousel as below.

.. js ::

  <link href="../themes/iphone/Carousel.css" rel="stylesheet">

  dojo.require("dojox.mobile.Carousel");

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|numVisible    |Number    |3        |The number of visible items.                                                                               |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|title         |String    |""       |A title of the carousel to be displayed on the title bar.                                                  |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|pageIndicator |Boolean   |true     |If true, a page indicator, a series of small dots that indicate the current page, is displayed on the title|
|              |          |         |bar.                                                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|navButton     |Boolean   |false    |If true, navigation buttons are displayed on the title bar.                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|height        |String    |"300px"  |Explicitly specified height of the widget (ex. "300px"). If "inherit" is specified, the height is inherited|
|              |          |         |from its offset parent.                                                                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|store         |Object    |null     |Reference to data provider object used by this widget.                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|query         |Object    |null     |A query that can be passed to 'store' to initially filter the items.                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|queryOptions  |Object    |null     |A query options that can be passed to 'store' to initially filter the items.                               |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. html ::

  <div id="carousel1" data-dojo-type="dojox.mobile.Carousel" height="150px" navButton="true" store="store1" numVisible="2" title="Category"></div>

.. image :: Carousel-desc.png
