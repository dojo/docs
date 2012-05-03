.. _dojox/mobile/ProgressBar:

========================
dojox.mobile.ProgressBar
========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.ProgressBar is a progress indication widget that shows the status of a task.

.. image :: ProgressBar.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|value         |String    |"0"      |Number ("0" to maximum) or percentage ("0%" to "100%") indicating the amount of task completed.            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|maximum       |Number    |100      |Max sample number.                                                                                         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|label         |String    |""       |A text to be shown at the center of the progress bar.                                                      |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------
.. html ::

  <div data-dojo-type="dojox.mobile.ProgressBar"
       data-dojo-props='value:"30%", label:"30/100"'></div>

.. image :: ProgressBar-example1.png
