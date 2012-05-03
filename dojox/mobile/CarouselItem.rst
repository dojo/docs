.. _dojox/mobile/CarouselItem:

=========================
dojox.mobile.CarouselItem
=========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

CarouselItem represents an item of :ref:`dojox.mobile.Carousel <dojox/mobile/Carousel>`. In typical use cases, users do not use this widget alone. Instead, it is used in conjunction with the Carousel widget.

.. image :: CarouselItem.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|alt           |String    |""       |An alt text for the carousel item image.                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|src           |String    |""       |A path for an image to be displayed as a carousel item.                                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|headerText    |String    |""       |A text that is displayed above the carousel item image.                                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|footerText    |String    |""       |A text that is displayed below the carousel item image.                                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. html ::

  <style>
  .mblCarouselItem {
      height: 120px;
      margin: 0 10px;
      float: left;
  }
  </style>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/CarouselItem"
  ]);

.. html ::

  <!-- Display an image with both header and footer -->
  <div data-dojo-type="dojox.mobile.CarouselItem"
       data-dojo-props='src:"images/glass1.jpg", headerText:"My Header", footerText:"My Footer"'></div>

  <!-- Display an image with header -->
  <div data-dojo-type="dojox.mobile.CarouselItem"
       data-dojo-props='src:"images/glass1.jpg", headerText:"My Header"'></div>

  <!-- Display an image footer -->
  <div data-dojo-type="dojox.mobile.CarouselItem"
       data-dojo-props='src:"images/glass1.jpg", footerText:"My Footer"'></div>

  <!-- Display only an image -->
  <div data-dojo-type="dojox.mobile.CarouselItem"
       data-dojo-props='src:"images/glass1.jpg"'></div>

.. image :: CarouselItem-example1.png

Programmatic example
--------------------

.. html ::

  <style>
  .mblCarouselItem {
      height: 120px;
      margin: 0 10px;
      float: left;
  }
  </style>

.. js ::

  require([
      "dojo/ready",
      "dojox/mobile/CarouselItem",
      "dojox/mobile",
      "dojox/mobile/parser"
  ], function(ready, CarouselItem){
      ready(function(){
          // Display an image with both header and footer
          var item1 = new CarouselItem({
              src: "images/glass1.jpg", headerText:"My Header", footerText:"My Footer"
          }, "item1");
          item1.startup();
          
          // Display an image with header
          var item2 = new CarouselItem({
              src: "images/glass1.jpg", headerText:"My Header"
          }, "item2");
          item2.startup();
          
          // Display an image with footer
          var item3 = new CarouselItem({
              src: "images/glass1.jpg", footerText:"My Footer"
          }, "item3");
          item3.startup();
          
          // Display only an image
          var item4 = new CarouselItem({
              src: "images/glass1.jpg"
          }, "item4");
          item4.startup();
      });
  });

.. html ::

  <div id="item1"></div>
  <div id="item2"></div>
  <div id="item3"></div>
  <div id="item4"></div>

.. image :: CarouselItem-example1.png

Using CarouselItem together with Carousel widget
------------------------------------------------

See :ref:`dojox.mobile.Carousel <dojox/mobile/Carousel>` widget for various examples.
