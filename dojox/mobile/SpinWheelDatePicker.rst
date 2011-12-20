.. _dojox/mobile/SpinWheelDatePicker:

================================
dojox.mobile.SpinWheelDatePicker
================================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

SpinWheelDatePicker  is a date picker widget. It is a subclass of dojox.mobile.SpinWheel. It has the year, month, and day slots.

.. image :: SpinWheelDatePicker.png

Usage
=====

SpinWheelDatePicker is in a separate module file from _base.js. You need to dojo.require SpinWheelDatePicker as below.

.. js ::

  <link href="../themes/common/SpinWheel.css" rel="stylesheet">

  dojo.require("dojox.mobile.SpinWheelDatePicker");

Examples
========

Declarative example
-------------------

.. html ::

  <div id="spin1" data-dojo-type="dojox.mobile.SpinWheelDatePicker"></div>
