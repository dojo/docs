.. _dojox/mobile/SwapView:

=====================
dojox.mobile.SwapView
=====================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

SwapView is a container widget that represents entire mobile device screen, and can be swiped horizontally. (In dojo-1.6, it was called 'FlippableView'.) SwapView is a subclass of :ref:`dojox.mobile.View <dojox/mobile/View>`. SwapView allows the user to swipe the screen left or right to move between the views. When SwapView is swiped, it finds an adjacent SwapView to open it.

Constructor Parameters
======================

Inherited from dojox.mobile.View
--------------------------------

+--------------+----------+---------+------------------------------------------------+
|Parameter     |Type      |Default  |Description                                     |
+--------------+----------+---------+------------------------------------------------+
|selected      |Boolean   |false    |If true, the view is displayed at startup time. |
+--------------+----------+---------+------------------------------------------------+

Usage
=====

Basic usage is the same as for :ref:`dojox.mobile.View <dojox/mobile/View>`. View transition will be performed in the order you place SwapViews in a page.

Examples
========

Declarative example
-------------------

In this example, there are two SwapViews, and the user can swipe the screen to move the views back and forth.

.. html ::

  <div id="foo" data-dojo-type="dojox.mobile.SwapView">
    <h2 data-dojo-type="dojox.mobile.RoundRectCategory">Page flipping demo</h2>
    <div data-dojo-type="dojox.mobile.RoundRect">
      Swipe the screen left or right to flip between the views.
    </div>
  </div>

  <div id="bar" data-dojo-type="dojox.mobile.SwapView">
    <h1 data-dojo-type="dojox.mobile.Heading">View 2</h1>
    <div data-dojo-type="dojox.mobile.RoundRect">
      View 2
    </div>
  </div>

.. image :: SwapView-anim.gif
