.. _dojox/mobile/ValuePickerDatePicker:

==================================
dojox.mobile.ValuePickerDatePicker
==================================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

ValuePickerDatePicker is a date picker widget. It is a subclass of :ref:`dojox.mobile.ValuePicker <dojox/mobile/ValuePicker>`. It has the year, month, and day slots.

.. image :: ValuePickerDatePicker.png

Constructor Parameters
======================

Inherited from dojox.mobile._DatePickerMixin
--------------------------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|yearPattern   |String    |"yyyy"   |A pattern to be used to format year.                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|monthPattern  |String    |"MMM"    |A pattern to be used to format month.                                                                      |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|dayPattern    |String    |"d"      |A pattern to be used to format day.                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Parameters from this widget
---------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|readOnly      |Boolean   |false    |If true, slot input fields are read-only. Only the plus and minus buttons can be used to change the values.|
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|value         |String    |null     |The initial value to be displayed. The value should be an ISO date string. (ex. "2000-10-24")              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|values        |Array     |null     |The initial value to be displayed. The value should be an array of integers. (ex. [2000,10,24])            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile/ValuePickerDatePicker"
  ]);

.. html ::

  <div id="picker1" data-dojo-type="dojox.mobile.ValuePickerDatePicker"></div>


Programmatic example
--------------------

.. js ::

  require([
      "dojo/_base/window",
      "dojo/ready",
      "dojox/mobile/ValuePickerDatePicker",
      "dojox/mobile/parser"
  ], function(win, ready, ValuePickerDatePicker){
      ready(function(){
        var widget = new ValuePickerDatePicker({id:"picker1"});
        win.body().appendChild(widget.domNode);
        widget.startup();
      });
  });

Setting the date with the ISO date string
-----------------------------------------

.. js ::

  registry.byId("picker1").set("value", "2012-10-06"); // Oct 6, 2012

Setting the date with a number array
------------------------------------

.. js ::

  registry.byId("picker1").set("values", [2012, 10, 6]); // Oct 6, 2012
