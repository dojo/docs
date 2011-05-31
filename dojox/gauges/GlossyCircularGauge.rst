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

This gauge widget is based on dojox.gauges.AnalogGauge. It provides a way to display data on a circular gauge with a glossy appearance, such as a speedometer or a pressure gauge, for displaying a finite data value at a point in time.

The glossy circular gauge widget is entirely built upon the dojox.gfx. The way to conceptually understand how the gauge widget works is that it is effectively a layering of a series of indicators to display the background shape, the major and minor ticks, the needle...



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

======
Ranges
======

You can add colored areas on the background of the gauge to emphasize some range of values. A range is defined by a low and high value, 
by a size and a color. The color can be a gradient, and on a circular gauge a range will be represented by an arc.
It is possible to add several ranges on a gauge.



========
Examples
========

Speedometer style gauge (programmatic)
---------------------------------------------------------------

The HTML <div> element to display the gauge widget:

.. code-block :: html
  :linenos:  
  
    <div id="CircularGauge" ></div>


The Javascript code creating the gauge:

.. code-block :: javascript
  :linenos:
  
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
    
    
A gauge with two ranges (programmatic)
---------------------------------------------------------------

.. code-block :: html
  :linenos:  
    
        <div dojoType="dojox.gauges.GlossyCircularGauge"
             id="csGaugeMargin"
             value="0"
             width="170"
             height="100"
             min="-150"
             max="150"
             majorTicksInterval="150"
             minorTicksInterval="50"
             background="[255, 255, 255, 0]"
             title="Margin"
             noChange="true"
             textIndicatorFont="normal small-caps bold 12pt Arial"
             radius="40"
             majorTicksLabelPlacement="outside"
             majorTicksColor="white"
             textIndicatorVisible="false">
          <div dojoType="dojox.gauges.Range"
               low="-150"
               high="0"
               size="5"
               color="{'type': 'linear', 'colors': [{offset: 0, color:'#FF0000'}, {offset: 1, color: '#FFFF00'}] }">
          </div>
          <div dojoType="dojox.gauges.Range"
               low="0"
               high="150"
               size="5"
               color="{'type': 'linear', 'colors': [{offset: 0, color:'#FFFF00'}, {offset: 1, color: '#00FF00'}] }">
          </div>
        </div>		
    
