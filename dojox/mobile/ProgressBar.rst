.. _dojox/mobile/ProgressBar:

========================
dojox/mobile/ProgressBar
========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

The dojox/mobile/ProgressBar widget shows the progress of a task. The value it displays 
can be a number (0 to maximum) or percentage (0% to 100%).
The setter of the ``value`` property can be used to update the degree of completion of the task.

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

  <div data-dojo-type="dojox/mobile/ProgressBar"
       data-dojo-props='value:"30%", label:"30/100"'></div>

.. image :: ProgressBar-example1.png

Programmatic example
--------------------
.. js ::

  require([
    "dojo/dom",
    "dojo/ready",
    "dojox/mobile/ProgressBar"
  ], function(dom, ready, ProgressBar){
    ready(function(){
      var pb = new ProgressBar({value:"30%", label:"30/100", style:{width:"200px"}});
      pb.placeAt(dom.byId("foo"));
      pb.startup();
    });
  });

