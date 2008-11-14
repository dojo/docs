#format dojo_rst

dojox.widget.BarGauge
=====================

:Status: Draft
:Version: 1.2
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

A horizontal bar gauge with a variety of indicators, used to display numerical data.

============
Introduction
============

The bar gauge widget provides a way to display data on a horizontal bar gauge.  This sort of gauge widget is common in monitoring systems and even in a variety of electronics to show volume levels and the like.

The bargauge widget is entirely built upon the dojox.gfx package and as such, works extremely well across many browsers. The way to conceptually understand how the bar gauge widget works is that it is effectively a layering indicators over a set of ranges along a horizontal axis.  Tick marks are displayed above the gauge ranges.   An optional capability of the bar gauge is that the values for each indicator can be displayed beneath the gauge (and are by default). This makes the gauge accessibility compliant.


========
Examples
========
