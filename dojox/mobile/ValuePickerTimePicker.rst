.. _dojox/mobile/ValuePickerTimePicker:

==================================
dojox.mobile.ValuePickerTimePicker
==================================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

ValuePickerTimePicker is a time picker widget. It is a subclass of dojox.mobile.ValuePicker. It has the hour and minute slots.

.. image :: ValuePickerTimePicker.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|readOnly      |Boolean   |false    |If true, slot input fields are read-only. Only the plus and minus buttons can be used to change the values.|
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|is24h         |Boolean   |false    |If true, the time is displayed in 24h format. Otherwise, displayed in AM/PM mode.                          |
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
      "dojox/mobile/ValuePickerTimePicker"
  ]);

.. html ::

  <div id="picker1" data-dojo-type="dojox.mobile.ValuePickerTimePicker"></div>

.. image :: ValuePickerTimePicker.png

.. html ::

  <div id="picker1" data-dojo-type="dojox.mobile.ValuePickerTimePicker"
      data-dojo-props='is24h:true'></div>

.. image :: ValuePickerTimePicker2.png


Programmatic example
--------------------

.. js ::

  require([
      "dojo/_base/window",
      "dojo/ready",
      "dojox/mobile/ValuePickerTimePicker",
      "dojox/mobile/parser"
  ], function(win, ready, registry, ValuePickerTimePicker){
      ready(function(){
        var widget = new ValuePickerTimePicker({id:"picker1", is24h:false});
        win.body().appendChild(widget.domNode);
        widget.startup();
      });
  });

Setting the time
----------------

.. js ::

  registry.byId("picker1").set("values", ["22", "06"]); // 22:06 or 10:06 PM
