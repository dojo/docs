.. _dojox/mobile/Rating:

===================
dojox.mobile.Rating
===================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.Rating is a widget which shows the rating using stars. This widget simply shows the specified number of stars. It is a read-only widget, and has no editing capability.

.. image :: Rating.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|image         |String    |""       |Path to a star image file. This file includes three stars, full star, empty star, and half star, from left |
|              |          |         |to right.                                                                                                  |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|numStars      |Number    |5        |The number of stars to show.                                                                               |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|value         |Number    |0        |The current value of the Rating.                                                                           |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|alt           |String    |""       |An alt text for the icon image.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------
.. html ::

  <span data-dojo-type="dojox.mobile.Rating"
        data-dojo-props='image:"images/star-orange.png",
        numStars:3, value:0.5'></span><br>
  <span data-dojo-type="dojox.mobile.Rating"
        data-dojo-props='image:"images/star-yellow.png",
        numStars:3, value:2.5'></span><br>
  <span data-dojo-type="dojox.mobile.Rating"
        data-dojo-props='image:"images/star-green.png",
        numStars:5, value:1'></span><br>
  <span data-dojo-type="dojox.mobile.Rating"
        data-dojo-props='image:"images/star-blue.png",
        numStars:5, value:4'></span><br>

.. image :: Rating-example1.png


Programmatic example
--------------------

.. js ::

  require([
    "dojo/_base/window",
    "dojox/mobile/Rating"
  ], function(win, Rating){
    var widget = new Rating({
      image: "images/star-orange.png",
      numStars: 10,
      value: 5.5
    });
    win.body().appendChild(widget.domNode);
  });

.. image :: Rating-example2.png
