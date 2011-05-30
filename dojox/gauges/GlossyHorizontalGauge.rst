#format dojo_rst

dojox.gauges.GlossyCircularGauge
================================

:Status: Draft
:Version: 1.0
:Project owner: Emmanuel Tissandier, Philippe Toussaint
:Available: since V?

.. contents::
   :depth: 2

A glossy horizontal gauge with a variety of indicators, used to display numerical data.


============
Introduction
============

This gauge widget provides a way to display data on a horizontal gauge with a glossy appearance, for displaying a finite data value at a point in time. 

The glossy horizontal gauge widget is entirely built upon the dojox.gfx package and as such, works extremely well across many browsers. The way to conceptually understand how the gauge widget works is that it is effectively a layering of a series of indicators to display the background shape, the major and minor ticks, the value indicator...



=====
Usage
=====

Creating a default horizontal glossy gauge requires a few parameters: size and eventually a background color. The others gauge's parameters such as start and end angle, minimum and maximum values, etc... have default values. Thus, you can quickly use the gauge in you application and customize it according to you needs.
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
| markerColor              |  "#c4c4c4"                              |  Color of the value marker                                     | 
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| font                     |  "normal normal normal 10pt sans-serif" |  Definition of the font used to display the values on the scale|
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| textIndicatorFont        |  "normal normal normal 20pt sans-serif" |  Definition of the font used to display the current value      |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| noChange                 |  "true"                                 |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| title                    |  "title"                                |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| scalePrecision           |  "0"                                    |                                                                |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+



==========
Indicators
==========

A gauge is made of several parts called "indicators". These parts are created by the gauge when its startup function is called.

Here are the indicators included as a part of the glossy horinzontal gauge widget:

+-----------------------------------------+---------------------------------------------------------------------------------------------+
| Indicator class                         | Description                                                                                 |
+=========================================+=============================================================================================+
| dojox.gauges.GlossyHorizontalGaugeMarker| An indicator similar to the cursor on a variety of gauges                                   |
+-----------------------------------------+---------------------------------------------------------------------------------------------+
| dojox.gauges.BarCircleIndicator         | An indicator drawing a circle, used to display the tick marks in the gauge                  |
+-----------------------------------------+---------------------------------------------------------------------------------------------+

======
Ranges
======

You can add colored areas on the background of the gauge to emphasize some range of values. A range is defined by a low and high value, 
by a size and a color. The color can be a gradient. It is possible to add several ranges on a gauge.



========
Examples
========

Speedometer style gauge (programmatic)
---------------------------------------------------------------

The HTML <div> element to display the gauge widget:

.. code-block :: html
  :linenos:  
  
    <div id="HorizontalGauge" ></div>


The Javascript code creating the gauge:

.. code-block :: javascript
  :linenos:
  
    <script type="text/javascript">
        dojo.require('dijit.form.Button');
        dojo.require('dojox.gauges.GlossyHorizontalGauge');                
        makeGauge = function(){
        	var glossygauge = new dojox.gauges.GlossyHorizontalGauge({
        		background: [255, 255, 255, 0],
        		title: 'Value',
        		id: "glossyGauge",
        		width: 300,
        		height: 300
        	}, dojo.byId("HorizontalGauge"));
        	glossygauge.startup();
        };
        dojo.addOnLoad(makeGauge );
    </script>
    
