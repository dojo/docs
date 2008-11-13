#format dojo_rst

dojox.widget.AnalogGauge
========================

:Status: Contributed, Draft
:Version: 1.3
:Author: Benjamin Schell
:Available: since V1.3

.. contents::
  :depth: 2

========
Overview
========
The analog gauge widget provides a way to display data on a circular, or semi-circular gauge, such as a speedometer or a pressure gauge, for displaying a finite data value at a point in time.  This UI paradigm has been around for a very long time and is quite common in most devices that people are familiar with, such as the dashboard of an automobile.  

The analog gauge widget is entirely built upon the dojox.gfx package and as such, works extremely well across many browsers.  The way to conceptually understand how the analog gauge widget works is that it is effectively a layering of a background shape, a circle or semi-circle, with a series of indicators for denoting values on the gauge face.  An optional capability of the analog gauge is that the values for each indicator can be displayed beneath the gauge (and are by default).  This makes the gauge accessible-compliant.  

Examples
========

===============================================================
Example 1:  A simple full circle gauge with a single indicator.
===============================================================

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.widget.AnalogGauge");
    </script>

  .. cv :: html 
