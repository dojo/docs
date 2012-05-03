.. _dojox/mobile/Icon:

=================
dojox.mobile.Icon
=================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.Icon is a utility for creating an image icon, a css sprite icon, or a DOM Button. It calls iconUtils.createIcon() with given parameters to create an icon. Note that this module is not a widget, i.e., it does not inherit from dijit._WidgetBase.

.. image :: Icon.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|icon          |String    |""       |An icon to display. The value can be either a path for an image file or a class name of a DOM button.      |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |""       |The position of an aggregated icon. IconPos is comma separated values like top,left,width,height           |
|              |          |         |(ex. "0,0,29,29").                                                                                         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|alt           |String    |""       |An alt text for the icon image.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|tag           |String    |"div"    |A name of html tag to create as this.domNode.                                                              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------
.. html ::

  <div data-dojo-type="dojox.mobile.Icon"
       data-dojo-props='icon:"images/tab-icon-23h.png"'></div>
  <div data-dojo-type="dojox.mobile.Icon"
       data-dojo-props='icon:"images/tab-icons.png",iconPos:"29,116,29,29"'></div>
  <div data-dojo-type="dojox.mobile.Icon"
       data-dojo-props='icon:"mblDomButtonBlueCircleArrow"'></div>

.. image :: Icon-example1.png

Programmatic example
--------------------
.. js ::

  require([
    "dojo/ready",
    "dojox/mobile/Icon"
  ], function(ready, Icon){
    ready(function(){
      var icon1 = new Icon({icon:"images/tab-icon-23h.png"},
                            "icon1");
      var icon2 = new Icon({icon:"images/tab-icons.png", iconPos:"29,116,29,29"},
                            "icon2");
      var icon3 = new Icon({icon:"mblDomButtonBlueCircleArrow"},
                            "icon3");
    });
  });
.. html ::

  <div id="icon1"></div>
  <div id="icon2"></div>
  <div id="icon3"></div>

.. image :: Icon-example1.png
