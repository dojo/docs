.. _dojox/mobile/ScrollableView:

===========================
dojox/mobile/ScrollableView
===========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.6

.. contents ::
    :depth: 2

Introduction
============

ScrollableView is a container widget which represents an entire mobile device screen, and has a touch scrolling capability. ScrollableView is a subclass of :ref:`dojox/mobile/View <dojox/mobile/View>`. Unlike the base View class, ScrollableView's domNode always stays at the top of the screen and its height is "100%" of the screen. Inside this fixed domNode, the containerNode scrolls. The browser's default scrolling behavior is disabled, and the scrolling mechanism is re-implemented in JavaScript. Thus the user does not need to use the two-finger operation to scroll the inner DIV (containerNode). The main purpose of this widget is to realize fixed-positioned header and/or footer bars.

The animation below shows the difference between View and ScrollableView scrolling behavior. 

.. image :: ScrollableView-anim.gif

Constructor Parameters
======================

Inherited from dojox/mobile/View
--------------------------------

+--------------+----------+---------+-------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                    |
+--------------+----------+---------+-------------------------------------------------------------------------------+
|selected      |Boolean   |false    |If true, the view is displayed at startup time.                                |
+--------------+----------+---------+-------------------------------------------------------------------------------+

Inherited from dojox/mobile/scrollable
--------------------------------------

+----------------------+----------+---------+---------------------------------------------------------------------------------------+
|Parameter             |Type      |Default  |Description                                                                            |
+----------------------+----------+---------+---------------------------------------------------------------------------------------+
|scrollBar             |Boolean   |true     |If true, scroll bar is displayed.                                                      |
+----------------------+----------+---------+---------------------------------------------------------------------------------------+
|scrollDir             |String    |"v"      |Specify a scrolling direction. "v" for vertical, "h" for horizontal, or "vh" for both. |
+----------------------+----------+---------+---------------------------------------------------------------------------------------+
|fadeScrollBar         |Boolean   |true     |Use the fade animation to hide scroll bar.                                             |
+----------------------+----------+---------+---------------------------------------------------------------------------------------+
|disableFlashScrollBar |Boolean   |false    |Disable flashing of scroll bar when a view is shown.                                   |
+----------------------+----------+---------+---------------------------------------------------------------------------------------+
|threshold             |Number    |4        |Drag threshold value in pixels. The user needs to drag at least the specified pixels   |
|                      |          |         |before a real drag operation starts.                                                   |
+----------------------+----------+---------+---------------------------------------------------------------------------------------+
|height                |String    |""       |Explicitly specified height of the widget (ex. "300px"). If "inherit" is specified,    |
|                      |          |         |the height is inherited from its offset parent. If "auto" is specified, the content    |
|                      |          |         |height, which could be smaller than the entire screen height, is used. If nothing is   |
|                      |          |         |specified, the entire screen height is used.                                           |
+----------------------+----------+---------+---------------------------------------------------------------------------------------+

Usage
=====
Basic usage is the same as for :ref:`dojox/mobile/View <dojox/mobile/View>`. If you do not need fixed-positioned header and/or footer bars, you should use :ref:`dojox/mobile/View <dojox/mobile/View>`.

Examples
========

View header/footer bar example
------------------------------

View header/footer bars are fixed-positioned bars which are local to the view in which they belong. That is, the bars stay in fixed positions while their parent view is shown, but when the view moves to another, they go away with the view.

To make a bar widget (Heading, TabBar, or perhaps your custom bar widget) fixed-positioned,

1. Place it inside ScrollableView
2. Add fixed:"top" for a header bar, or fixed:"bottom" for a footer bar

.. html ::

  <div id="view1" data-dojo-type="dojox/mobile/ScrollableView">
    <h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props='fixed:"top"'>View Header Bar</h1>
    ....
    <h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props='fixed:"bottom"'>View Footer Bar</h1>
  </div>

Programmatic:

.. js ::

        require([
            "dojo/ready",
            "dijit/registry",
            "dojox/mobile/ScrollableView",
            "dojox/mobile/Heading"
        ], function(ready, registry, ScrollableView, Heading){
            var sv = new ScrollableView({id:"view1"});
            var h = new Heading({fixed:"top", label:"View Header Bar"});
            sv.addChild(h);
            // Add contents here...
            // ...
            var f = new Heading({fixed:"bottom", label:"View Footer Bar"});
            sv.addChild(f);
            sv.placeAt(document.body);
            sv.startup();
        });

.. image :: ScrollableView-example1-anim.gif

Application header/footer bar example
-------------------------------------

Application header/footer bars are fixed-positioned bars which are global to the application (=page). That is, the bars always stay in fixed positions regardless of what view is currently shown.

To make a bar widget (Heading, TabBar, or perhaps your custom bar widget) fixed-positioned,

1. Place it outside ScrollableView
2. Add fixed:"top" for a header bar, or fixed:"bottom" for a footer bar

.. html ::

  <h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props='fixed:"top"'>Application Header Bar</h1>
  <div id="view1" data-dojo-type="dojox/mobile/ScrollableView">
      ....
  </div>
  <div id="view2" data-dojo-type="dojox/mobile/ScrollableView">
      ....
  </div>
  <h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props='fixed:"bottom"'>Application Footer Bar</h1>

.. image :: ScrollableView-example2-anim.gif
