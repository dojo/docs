#format dojo_rst

dojox.image
===========

:Status: Draft
:Version: beta
:Authors: Peter Higgins, Bryan Forbes, Shane O'Sullivan

The DojoX Image project provides a number of image-related widgets as extensions to Dijit, such as a Lightbox, SlideShow, FlickrBadge, among others. The goal is to provide a common way of handling images, though some Image project widgets are designed for edge-cases, like the Magnifier.

Most widgets within this project are experimental.

Components
----------

* `Badge <dojox/image/Badge>`_
* `FlickrBadge <dojox/image/FlickrBadge>`_ - an extension on dojox.image.Badge, using Flickr as a data provider.
* `Gallery <dojox/image/Gallery>`_ - A combination of a SlideShow and ThumbnailPicker
* `Lightbox <dojox/image/Lightbox>`_ - A widget which shows a single image (or groups of images) in a Dialog
* `Magnifier <dojox/image/Magnifier>`_ - A dojox.gfx-based version of the `MagnifierLite`_ widget.
* `MagnifierLite`_ - A simple hover behavior for images, showing a zoomed version of a size image.
* SlideShow - A slideshow of images
* ThumbnailPicker - a dojo.data-powered 

.. _link: dojox/image/MagnifierLite
