.. _dojox/mobile/SpinWheelSlot:

==========================
dojox.mobile.SpinWheelSlot
==========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

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
|zeroPad       |Number    |0        |Length of zero padding numbers.                                                                            |
|              |          |         |Ex. zeroPad=2 -> "00", "01", ...                                                                           |
|              |          |         |Ex. zeroPad=3 -> "000", "001", ...                                                                         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|value         |String    |""       |The initial value of the slot.                                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|step          |Number    |1        |The steps between labelFrom and labelTo.                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|tabIndex      |String    |"0"      |Tabindex setting for this widget so users can hit the tab key to focus on it.                              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

See the :ref:`dojox.mobile.SpinWheel <dojox/mobile/SpinWheel>` widget for various examples.
