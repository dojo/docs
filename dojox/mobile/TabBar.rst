.. _dojox/mobile/TabBar:

===================
dojox.mobile.TabBar
===================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.6

.. contents ::
    :depth: 2

TabBar is a container widget that has typically multiple TabBarButtons which controls visibility of views. It can be used as a tab container. There was dojox.mobile.TabContainer in dojo-1.5, but it is obsolete. In dojo-1.6 or later, use TabBar instead of TabContainer.

.. image :: TabBar.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconBase      |String    |""       |The default icon path for child items. If a child item does not have its own icon parameter specified,     |
|              |          |         |this value is used as its icon path. This parameter is especially useful when all or most of the icons are |
|              |          |         |the same, or you use CSS sprite icons, where you specify an aggregated icon image with this parameter and  |
|              |          |         |an icon position for each icon.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |""       |The default icon position for child items. This parameter is especially useful when all or most of the     |
|              |          |         |icons are the same.                                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|barType       |String    |tabBar   |"tabBar"(default) or "segmentedControl".                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Usage
=====

TabBar is in a separate module file from _base.js. You need to dojo.require TabBar as below.

.. js ::

  dojo.require("dojox.mobile.TabBar");

Examples
========

Tab Bar
-------

.. html ::

  <ul data-dojo-type="dojox.mobile.TabBar">
    <li data-dojo-type="dojox.mobile.TabBarButton" icon1="images/tab-icon-16.png" icon2="images/tab-icon-16h.png" moveTo="view1" selected="true">New</li>
    <li data-dojo-type="dojox.mobile.TabBarButton" icon1="images/tab-icon-15.png" icon2="images/tab-icon-15h.png" moveTo="view2">What's Hot</li>
    <li data-dojo-type="dojox.mobile.TabBarButton" icon1="images/tab-icon-10.png" icon2="images/tab-icon-10h.png" moveTo="view3">Genius</li>
  </ul>

.. image :: TabBar-example1.png

Tab Bar (CSS Sprite)
--------------------

In this example, an aggregated icon image as below is used for each TabBarButton icon. This way the number of requests to the server can be reduced and thus the performance could be improved.

.. image :: tab-icons.png

(tab-icons.png)

.. html ::

  <ul data-dojo-type="dojox.mobile.TabBar" iconBase="images/tab-icons.png">
    <li data-dojo-type="dojox.mobile.TabBarButton" iconPos1="0,0,29,29" iconPos2="29,0,29,29" selected="true">Featured</li>
    <li data-dojo-type="dojox.mobile.TabBarButton" iconPos1="0,29,29,29" iconPos2="29,29,29,29">Categories</li>
    <li data-dojo-type="dojox.mobile.TabBarButton" iconPos1="0,58,29,29" iconPos2="29,58,29,29">Top 25</li>
    <li data-dojo-type="dojox.mobile.TabBarButton" iconPos1="0,87,29,29" iconPos2="29,87,29,29">Search</li>
    <li data-dojo-type="dojox.mobile.TabBarButton" iconPos1="0,116,29,29" iconPos2="29,116,29,29">Updates</li>
  </ul>

.. image :: TabBar-example2.png

Segmented Control
-----------------

This type of bar is typically used at the top of the screen to control visibility of multiple views.

.. html ::

  <ul data-dojo-type="dojox.mobile.TabBar" barType="segmentedControl">
    <li data-dojo-type="dojox.mobile.TabBarButton" icon1="images/tab-icon-16.png" icon2="images/tab-icon-16h.png" moveTo="view1" selected="true">New</li>
    <li data-dojo-type="dojox.mobile.TabBarButton" icon1="images/tab-icon-15.png" icon2="images/tab-icon-15h.png" moveTo="view2">What's Hot</li>
    <li data-dojo-type="dojox.mobile.TabBarButton" icon1="images/tab-icon-10.png" icon2="images/tab-icon-10h.png" moveTo="view3">Genius</li>
  </ul>

.. image :: TabBar-example3.png

Grouped Tab Bar
---------------

TabBar forms kind of tab container whose panes are views. You may, however, want to treat the entire tab container as one view. In such cases, you can nest the view classes as shown in the following example. In this example, subview1, subview2, and subview3 are in the top level view groupview1. You can move to the hello view from subview1 or subview2, and then return to the top level view (=groupview1) instead of a specific child view (subview1, subview2, or subview3). When you return to groupview1, the currently visible view in groupview1 is shown.

.. html ::

  <div id="groupview1" data-dojo-type="dojox.mobile.View" selected="true">
      <ul data-dojo-type="dojox.mobile.TabBar" barType="segmentedControl" fixed="top">
        <li data-dojo-type="dojox.mobile.TabBarButton" moveTo="subview1" selected="true">New</li>
        <li data-dojo-type="dojox.mobile.TabBarButton" moveTo="subview2">What's Hot</li>
        <li data-dojo-type="dojox.mobile.TabBarButton" moveTo="subview3">Genius</li>
      </ul>

      <div id="subview1" data-dojo-type="dojox.mobile.ScrollableView" selected="true">
        <ul data-dojo-type="dojox.mobile.EdgeToEdgeList">
          <li data-dojo-type="dojox.mobile.ListItem" moveTo="hello">Hello</li>
        </ul>
      </div>

      <div id="subview2" data-dojo-type="dojox.mobile.ScrollableView">
        <ul data-dojo-type="dojox.mobile.RoundRectList">
          <li data-dojo-type="dojox.mobile.ListItem" moveTo="hello">Hello</li>
        </ul>
      </div>

      <div id="subview3" data-dojo-type="dojox.mobile.ScrollableView">
        <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">View3</div>
      </div>
  </div>

  <div id="hello" data-dojo-type="dojox.mobile.ScrollableView">
      <h1 data-dojo-type="dojox.mobile.Heading" back="Group1" moveTo="groupview1">Hello</h1>
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">Hello View</div>
  </div>

.. image :: TabBar-group-anim.gif
