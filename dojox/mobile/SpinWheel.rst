.. _dojox/mobile/SpinWheel:

======================
dojox.mobile.SpinWheel
======================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

SpinWheel is a value picker component. It is a sectioned wheel that can be used to pick up some values from the wheel slots by spinning them.

.. image :: SpinWheel-custom.png

Usage
=====

SpinWheel is in a separate module file from _base.js. You need to dojo.require SpinWheel as below.

.. js ::

  <link href="../themes/common/SpinWheel.css" rel="stylesheet">

  dojo.require("dojox.mobile.SpinWheel");

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|slotClasses   |Array     |[]       |An array of slot classes to be this SpinWheel's slots.                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|slotProps     |Array     |[]       |An array of property objects for each slot class specified in slotClasses.                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. html ::

  <div data-dojo-type="dojox.mobile.View" selected="true">
      <h1 data-dojo-type="dojox.mobile.Heading">Custom SpinWheel</h1>
      <div id="spin1" data-dojo-type="dojox.mobile.SpinWheel">
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labels="['A','B','C','D','E','F','G','H','I','J','K']"
           style="text-align:center;width:40px;"></div>
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labelFrom="3000" labelTo="3100"
           style="width:70px;"></div>
       <div id="pt" class="mblSpinWheelSlot"></div>
       <div id="txt" class="mblSpinWheelSlot">.</div>
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labelFrom="0" labelTo="9"
           style="width:30px;"></div>
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labels="['pt','px','cm']"
           style="width:50px;"></div>
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labels="[
               '<img src=images/i-icon-1.png>',
               '<img src=images/i-icon-2.png>',
               '<img src=images/i-icon-3.png>',
               '<img src=images/i-icon-4.png>',
               '<img src=images/i-icon-5.png>'
           ]"
           style="width:70px;text-align: center;"></div>
      </div>
  </div>
