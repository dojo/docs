#format dojo_rst

dojox.image
===========

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann
:Developers: Bryan Forbes, Peter Higgins, Jared Jurkiewicz, Heng Liu, Shane O'Sullivan, Adam Peller, Alex Russell, Nathan Toone
:Available: since V1.2

.. contents::
    :depth: 2

The DojoX Image project provides a number of image-related widgets as extensions to Dijit, such as a Lightbox, SlideShow, FlickrBadge, among others. The goal is to provide a common way of handling images, though some Image project widgets are designed for edge-cases, like the Magnifier.

Most widgets within this project are experimental.


========
Features
========

* `dojox.image.Badge <dojox/image/Badge>`_

  Attach images or background images, and let them loop

* `dojox.image.FlickrBadge <dojox/image/FlickrBadge>`_

  An extension on dojox.image.Badge, using Flickr as a data provider

* `dojox.image.Gallery <dojox/image/Gallery>`_

  A combination of a SlideShow and ThumbnailPicker

* `dojox.image.Lightbox <dojox/image/Lightbox>`_

  A widget which shows a single image (or groups of images) in a Dialog

* `dojox.image.Magnifier <dojox/image/Magnifier>`_

  A dojox.gfx-based version of the `MagnifierLite <dojox/image/MagnifierLite>`__ widget

* `dojox.image.MagnifierLite <dojox/image/MagnifierLite>`__

  A simple hover behavior for images, showing a zoomed version of a size image

* `dojox.image.SlideShow <dojox/image/SlideShow>`_

  A slideshow of images

* `dojox.image.ThumbnailPicker <dojox/image/ThumbnailPicker>`_

  A dojo.data-powered ThumbnailPicker
