.. _dojox/mobile/SpinWheelSlot:

==========================
dojox.mobile.SpinWheelSlot
==========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

SpinWheelSlot is a slot that is placed in the SpinWheel widget.

Usage
=====

Use this widget as child widgets of the :ref:`dojox.mobile.SpinWheel <dojox/mobile/SpinWheel>` widget.

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|items         |Array     |[]       |An array of array of key-label paris. (e.g. [[0,"Jan"],[1,"Feb"],...] ) If key values for each label are   |
|              |          |         |not necessary, labels can be used instead.                                                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|labels        |Array     |[]       |An array of labels to be displayed on the slot. (e.g. ["Jan","Feb",...] ) This is a simplified version of  |
|              |          |         |the items property.                                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|labelFrom     |Number    |0        |The start value of display values of the slot. This parameter is especially useful when slot has serial    |
|              |          |         |values.                                                                                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|labelTo       |Number    |0        |The end value of display values of the slot.                                                               |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|value         |String    |""       |The initial value of the slot.                                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

See the :ref:`dojox.mobile.SpinWheel <dojox/mobile/SpinWheel>` widget for various examples.
