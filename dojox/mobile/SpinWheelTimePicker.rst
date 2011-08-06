#format dojo_rst

dojox.mobile.SpinWheelTimePicker
================================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:Available: since V1.7

.. contents::
    :depth: 2

SpinWheelTimePicker  is a time picker widget. It is a subclass of dojox.mobile.SpinWheel. It has the hour and minute slots.

.. image:: SpinWheelTimePicker.png

=====
Usage
=====

SpinWheelTimePicker is in a separate module file from _base.js. You need to dojo.require SpinWheelTimePicker as below.

.. code-block :: javascript

  <link href="../themes/common/SpinWheel.css" rel="stylesheet">

  dojo.require("dojox.mobile.SpinWheelTimePicker");

========
Examples
========

Declarative example
-------------------

.. code-block :: html

  <div id="spin1" dojoType="dojox.mobile.SpinWheelTimePicker"></div>