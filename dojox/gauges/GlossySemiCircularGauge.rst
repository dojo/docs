#format dojo_rst

dojox.gauges.GlossySemiCircularGauge
====================================

:Status: Draft
:Version: 1.0
:Project owner: Emmanuel Tissandier, Philippe Toussaint
:Available: since V?

.. contents::
   :depth: 2

A glossy semi circular gauge with a variety of indicators, used to display numerical data.


============
Introduction
============

This gauge widget provides a way to display data on a semi circular gauge with a glossy appearance. This UI paradigm has been around for a very long time and is quite common in most devices that people are familiar with, such as the dashboard of an automobile.

The glossy semi circular gauge widget is entirely built upon the dojox.gfx package and as such, works extremely well across many browsers. The way to conceptually understand how the gauge widget works is that it is effectively a layering of a series of indicators to display the background shpae, the major and minor ticks, the needle...







=====
Usage
=====

Creating a default semi circular glossy gauge requires a few parameters: size and eventually a background color. The others gauge's parameters such as start and end angle, minimum and maximum values, etc... have default values. Thus, you can quickly use the gauge in you application and customize it according to you needs.
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
| majorTicksInterval       |  "10"                                   |  The interval beetwen each majors tick                         |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| majorTicksColor          |  "#c4c4c4"                              |  Color of the major tick marks on the scale                    |   
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| minorTicksInterval       |  "5"                                    |  The interval beetwen each minor tick                          | 
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| minorTicksColor          |  "#c4c4c4"                              |  Color of the minor tick marks on the scale                    |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| color                    |  "black"                                |  Color of the gauge                                            |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| needleColor              |  "#c4c4c4"                              |  Color of the needle                                           | 
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| font                     |  "normal normal normal 10pt sans-serif" |  Definition of the font used to display the values on the scale|
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| textIndicatorFont        |  "normal normal normal 20pt sans-serif" |  Definition of the font used to display the current value      |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| textIndicatorVisible     |  "true"                                 |  Indicates if the text displaying the current value is visible |
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

A gauge is made of several parts called "indicators". These parts are created by the gauge when its startup function is called.

There are 3 indicators included as a part of the glossy circular Gauge widget:

+-----------------------------------------+---------------------------------------------------------------------------------------------+
| Indicator class                         | Description                                                                                 |
+=========================================+=============================================================================================+
| dojox.gauges.TextIndicator              | Draws the value of the gauge as text.                                                       |
+-----------------------------------------+---------------------------------------------------------------------------------------------+
| dojox.gauges.GlossyCircularGaugeNeedle  |An indicator similar to the needle on a variety of gauges                                    |
+-----------------------------------------+---------------------------------------------------------------------------------------------+
| dojox.gauges.AnalogCircleIndicator      | An indicator drawing a circle, used to display the tick marks in the GlossyCircularGauge    |
+-----------------------------------------+---------------------------------------------------------------------------------------------+



========
Examples
========

.. code-example::

  .. html::

    <div id="SemiCircularGauge" ></div>

  .. javascript::

    <script type="text/javascript">
        dojo.require('dijit.form.Button');
        dojo.require('dojox.gauges.GlossySemiCircularGauge');                
        makeGauge = function(){
        	var glossyCircular = new dojox.gauges.GlossySemiCircularGauge({
        		background: [255, 255, 255, 0],
        		title: 'Value',
        		id: "glossyGauge",
        		width: 300,
        		height: 300
        	}, dojo.byId("SemiCircularGauge"));
        	glossyCircular.startup();
        };
        dojo.addOnLoad(makeGauge );
    </script>
