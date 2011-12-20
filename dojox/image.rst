.. _dojox/image:

===========
dojox.image
===========

:Project owner: Peter Higgins
:since: V1.2

.. contents ::
   :depth: 2

The DojoX Image project provides a number of image-related widgets as extensions to Dijit, such as a Lightbox, SlideShow, FlickrBadge, among others. The goal is to provide a common way of handling images, though some Image project widgets are designed for edge-cases, like the Magnifier.

Most widgets within this project are experimental.

Core API
========

Prior to Dojo 1.3, no "core API" was provided. Newer versions include helper functions, available by loading the dojox.image module:

.. js ::
  
  dojo.require("dojox.image");

Preloading Images
-----------------

When setting an image to a new src="" attribute, if the image has not been cached by the browser, there will be a delay before the new image is seen. This can be significant if the images are large or the connection is slow. In DojoX Image package, a function ``preload`` is provided to load these images off-screen. It is a very simple function, and does not do any notification about image readiness. All browsers treat a unique image url as one, so the image will be already loading if someone attempts to view image you are preloading.

Just pass an array of url's to the function:

.. js ::
  
  // must be after dom ready:
  dojo.require("dojox.image");
  dojo.ready(function(){
      dojox.image.preload(["pic.png", "face.jpg", "http://example.com/logo.gif"]);
  });

Alternately, you can specify a list of url's as an array to a dojoConfig parameter before dojo.js is loaded with the `preloadImages` option:

.. js ::
  
  var dojoConfig = {
      preloadImages:["foo.jpg", "bar.png"]
  }



Additional Components
=====================

There are several additional widgets available in the project. Each has it's own requirements and usage:

* :ref:`dojox.image.Badge <dojox/image/Badge>`

  Attach images or background images, and let them loop.

* :ref:`dojox.image.FlickrBadge <dojox/image/FlickrBadge>`

  An extension on dojox.image.Badge, using Flickr as a data provider. Flickr API key needed.

* :ref:`dojox.image.Gallery <dojox/image/Gallery>`

  A combination of a SlideShow and ThumbnailPicker into a mashup Gallery thing.

* :ref:`dojox.image.Lightbox <dojox/image/Lightbox>`

  A widget which shows a single image (or groups of images) in a custom modal Dialog

* :ref:`dojox.image.LightboxNano <dojox/image/LightboxNano>`

  Similar to a Lightbox, though much lighter weight, and animated to center from position in page.

* :ref:`dojox.image.Magnifier <dojox/image/Magnifier>`

  A dojox.gfx-based version of the :ref:`MagnifierLite <dojox/image/MagnifierLite>` widget

* :ref:`dojox.image.MagnifierLite <dojox/image/MagnifierLite>`

  A simple hover behavior for images, showing a zoomed version of a size image

* :ref:`dojox.image.SlideShow <dojox/image/SlideShow>`

  A slideshow of images. Used by Gallery for viewport.

* :ref:`dojox.image.ThumbnailPicker <dojox/image/ThumbnailPicker>`

  A dojo.data-powered ThumbnailPicker, which powers Gallery
