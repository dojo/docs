.. _dojox/gauges/GlossyHorizontalGauge:

==================================
dojox.gauges.GlossyHorizontalGauge
==================================

:Project owner: Emmanuel Tissandier, Philippe Toussaint
:since: 1.7

.. contents ::
   :depth: 2

A glossy horizontal gauge with a variety of indicators, used to display numerical data.

.. image :: GlossyHorizontalGauge.png

Introduction
============

This gauge widget is based on dojox.gauges.BarGauge. It provides a way to display data on a horizontal gauge with a glossy appearance, for displaying a finite data value at a point in time.
It is created with predefined indicators and thus is ready to use.

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
| majorTicksInterval       |  "10"                                   |  The interval between each majors tick                         |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| majorTicksColor          |  "#c4c4c4"                              |  Color of the major tick marks on the scale                    |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| minorTicksInterval       |  "5"                                    |  The interval between each minor tick                          |
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
| noChange                 |  "true"                                 |  Indicates if user can change the value of the gauge by        |
|                          |                                         |  interacting with the cursor                                   |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| title                    |  "title"                                |  The title displayed in the needle's tooltip                   |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+
| scalePrecision           |  "0"                                    |  The precision for the formatting of numbers in the scale      |
+--------------------------+-----------------------------------------+----------------------------------------------------------------+


Examples
========

Slider style gauge (programmatic)
---------------------------------------------------------------

The HTML <div> element to display the gauge widget:

.. html ::
    
    <div id="HorizontalGauge" ></div>


The JavaScript code creating the gauge:

.. js ::

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
        dojo.ready(makeGauge );
    
