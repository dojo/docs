.. _dojox/mobile/SpinWheelTimePicker:

================================
dojox.mobile.SpinWheelTimePicker
================================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

SpinWheelTimePicker is a time picker widget. It is a subclass of dojox.mobile.SpinWheel. It has the hour and minute slots.

.. image :: SpinWheelTimePicker.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|values        |Array     |null     |The initial value to be displayed. The value should be an array of strings. (ex. ["22","06"])              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile/SpinWheelTimePicker"
  ]);

.. html ::

  <div id="spin1" data-dojo-type="dojox.mobile.SpinWheelTimePicker"></div>

Programmatic example
--------------------

.. js ::

  require([
      "dojo/_base/window",
      "dojo/ready",
      "dojox/mobile/SpinWheelTimePicker",
      "dojox/mobile/parser"
  ], function(win, ready, registry, SpinWheelTimePicker){
      ready(function(){
        var widget = new SpinWheelTimePicker({id:"spin1"});
        win.body().appendChild(widget.domNode);
        widget.startup();
      });
  });

Setting the time
----------------

.. js ::

  registry.byId("spin1").set("values", ["2", "06"]); // 2:06

Note that values should be specified with an array of strings. In the above example, [2, 6] does not match, because minute has zero padding by default.
