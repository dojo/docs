.. _dojox/mobile/ScrollablePane:

===========================
dojox.mobile.ScrollablePane
===========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

The dojox.mobile.ScrollablePane widget is a pane that has the touch-scrolling capability. Unlike :ref:`dojox.mobile.ScrollableView <dojox/mobile/ScrollableView>`, ScrollablePane is not a view. ScrollablePane can be placed in a view to create a partial scrolling area.

.. image :: ScrollablePane.png

Constructor Parameters
======================

+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter      |Type      |Default  |Description                                                                                                |
+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|roundCornerMask|Boolean   |false    |If true, create a rounded corner mask to clip corners of a child widget or dom node. Works only on         |
|               |          |         |WebKit-based browsers.                                                                                     |
+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|radius         |Number    |0        |Radius of the rounded corner mask.                                                                         |
+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/ScrollablePane"
  ]);

.. html ::

  <div data-dojo-type="dojox.mobile.View" style="height:100px">
    <div data-dojo-type="dojox.mobile.ScrollablePane" 
         data-dojo-props='height:"inherit"'
         style="background-color:yellow;color:black;">
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
    </div>
  </div>

.. image :: ScrollablePane-example1.png

Rounded corner mask example
---------------------------

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/ScrollablePane",
    "dojox/mobile/ContentPane"
  ]);

.. html ::

  <div data-dojo-type="dojox.mobile.View">
    <div data-dojo-type="dojox.mobile.ScrollablePane"
         data-dojo-props='height:"100px",
                          roundCornerMask:true,
                          radius:"5"'>
      <div data-dojo-type="dojox.mobile.ContentPane"
           style="margin:5px 9px 7px 9px;padding:8px;
                  background-color:white;color:black;">
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
      </div>
    </div>
  </div>

.. image :: ScrollablePane-example2.png
