.. _dojox/mobile/PageIndicator:

==============================
dojox.mobile.PageIndicator
==============================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

PageIndicator displays a series of gray and white dots to indicate which page is currently being viewed. It can typically be used with :ref:`dojox.mobile.SwapView <dojox/mobile/SwapView>`. It is also internally used in :ref:`dojox.mobile.Carousel <dojox/mobile/Carousel>`.

.. image :: PageIndicator.png

The PageIndicator widget uses the dojo's pub/sub event system to communicate with the other widgets. It subscribes to the "/dojox/mobile/viewChanged" message, and refreshes the indicator status.

Usage
=====

To use PageIndicator with SwapView, place it as a sibling of the SwapView widgets. Then the PageIndicator searches its parent DOM nodes for the SwapView widgets to create an indicator that reflects them.

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|refId         |String    |""       |An ID of a DOM node to be searched. Siblings of the reference node will be searched for views. If not      |
|              |          |         |specified, this.domNode will be the reference node.                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. html ::

  <body style="background-color:#6D6D6D">
      <div data-dojo-type="dojox.mobile.SwapView">
          <h1>My Pictures</h1>
          <img src="images/pic1.jpg">
      </div>

      <div data-dojo-type="dojox.mobile.SwapView">
          <h1>May 3, 2011</h1>
          <img src="images/pic2.jpg">
      </div>

      <div data-dojo-type="dojox.mobile.SwapView">
          <h1>May 3, 2011</h1>
          <img src="images/pic3.jpg">
      </div>

      <div data-dojo-type="dojox.mobile.PageIndicator" fixed="bottom"></div>
  </body>

.. image :: PageIndicator-anim.png
