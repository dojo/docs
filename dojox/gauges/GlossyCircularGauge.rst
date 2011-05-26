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

    <div id="CircularGauge" ></div>

  .. javascript::

    <script type="text/javascript">
        dojo.require('dijit.form.Button');
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

Creating a default circular glossy gauge requires a few parameters: size and eventually a background color. The others gauge's parameters such as start and end angle, minimum and maximum values, etc... have default values. Thus, you can quickly use the gauge in you application and customize it according to you needs.
Here are the other customizable parameters.

+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| Parameter                |  Default value                          |  Description                                                   |
+==========================+=========================================+================================================================+
| width                    |  "300"                                  |  The width of gauge.                                           |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| height                   |  "300"                                  |  The height of the gauge                                       |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| min                      |  "0"                                    |  The minimum allowed value.                                    |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| max                      |  "100"                                  |  The maximum allowed value.                                    |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| value                    |  "0"                                    |  The current value.                                            |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| majorTicksInterval       |  "10"                                   |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| majorTicksColor          |  "#c4c4c4"                              |  Color of the major tick marks on the scale                    |   
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| minorTicksInterval       |  "5"                                    |                                                                | 
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| minorTicksColor          |  "#c4c4c4"                              |  Color of the minor tick marks on the scale                    |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| color                    |  "black"                                |  Color of the gauge                                            |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| needleColor              |  "#c4c4c4"                              |  Color of the needle                                           | 
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| font                     |  "normal normal normal 10pt sans-serif" |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| textIndicatorFont        |  "normal normal normal 20pt sans-serif" |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| textIndicatorVisible     |  "true"                                 |  Indicated if the text displaying the current value is visible |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| textIndicatorColor       |  "#c4c4c4"                              |  The color of the text displaying the current value            |                                           
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| majorTicksLabelPlacement |  "inside"                               |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| noChange                 |  "true"                                 |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| title                    |  "title"                                |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| scalePrecision           |  "0"                                    |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| textIndicatorPrecision   |  "0"                                    |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+



==========
Indicators
==========

========
Examples
========
