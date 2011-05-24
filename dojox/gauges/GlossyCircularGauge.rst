#format dojo_rst

dojox.gauges.GlossyCircularGauge
================================

:Status: Draft
:Version: 1.0
:Project owner: Emmanuel Tissandier, Philippe Toussaint
:Available: since V?

.. contents::
   :depth: 2

A glossy circular gauge with a variety of indicators, used to display numerical data.


============
Introduction
============

This gauge widget provides a way to display data on a circular gauge with a glossy appearance, such as a speedometer or a pressure gauge, for displaying a finite data value at a point in time. This UI paradigm has been around for a very long time and is quite common in most devices that people are familiar with, such as the dashboard of an automobile.

The glossy circular gauge widget is entirely built upon the dojox.gfx package and as such, works extremely well across many browsers. The way to conceptually understand how the gauge widget works is that it is effectively a layering of a series of indicators to display the background shpae, the major and minor ticks, the needle...

.. code-example::
  :type: inline
  :height: 500
  :width: 500
  :toolbar: versions

  .. html::

    <div id="CircularGauge" style="width: 500px; height: 500px"></div>

  .. javascript::

    <script type="text/javascript">
        dojo.require('dojox.gauges.GlossyCircularGauge');                
        makeGauge = function(){
        	var glossyCircular = new dojox.gauges.GlossyCircularGauge({
        		background: [255, 255, 255, 0],
        		title: 'Value',
        		id: "glossyGauge",
        		width: 300,
        		height: 300
        	}, dojo.byId("CircularGauge"));
        	glossyCircular.startup();
        };
        dojo.addOnLoad(makeGauge );
    </script>



=====
Usage
=====


==========
Indicators
==========

========
Examples
========
