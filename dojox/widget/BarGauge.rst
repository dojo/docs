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

The bar gauge widget is entirely built upon the dojox.gfx package and as such, works extremely well across many browsers. The way to conceptually understand how the bar gauge widget works is that it is effectively a layering indicators over a set of ranges along a horizontal axis.  Tick marks are displayed above the gauge ranges.   An optional capability of the bar gauge is that the values for each indicator can be displayed beneath the gauge (and are by default). This makes the gauge accessibility compliant.

=====
Usage
=====

As demonstrated in the examples below, creating a bar gauge widget requires a few attributes: width and height of the gauge surface, width and height of the area the ranges should cover, and an x/y location for the placement of the range areas. Ranges can either be added in the constructor or after creation using the addRange[s] functions.  A gauge can have a few advanced features, such as an image overlaid on top of the gauge, a gradient background, and CSS styled ranges. CSS styled ranges are used by setting the 'useRangeStyles' attribute to the number of CSS classes that have been created for this purpose, then creating those classes as .dojoxGaugeRangeN where N is the number of the range. CSS styled ranges are not available when the renderer is VML.

Indicators can be handled separate of the gauge. In other words, once an indicator has been created and added to the gauge, one can update the value of the indicator by simply calling the update function on the indicator (rather than having to have a handle on the gauge itself). New indicators can be created by inheriting from dojox.widget._Indicator and overriding the appropriate functions (draw is the most important).

==========
Indicators
==========

There are 2 indicators provided by default for use with the Bar Gauge widget:

* BarLineIndicator - The default indicator for the Bar Gauge, it can be used to create tick marks (with an offset) or to indicate a value on the gauge as a vertical line
* BarIndicator - A bar that extends from the minimum edge of the gauge to it's current value.  It is 'resized' rather than 'moved' to change the value.

========
Examples
========

A bar gauge with two indicators (programmatic)
----------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.require("dojox.widget.BarGauge");

      function init() {
        var gauge;
        var ranges1 = [ {low:5, high:10, hover:'5 - 10'},
          {low:10, high:20, hover:'10 - 20'},
          {low:20, high:30, hover:'20 - 30'},
          {low:30, high:40, hover:'30 - 40'},
          {low:40, high:50, hover:'40 - 50'},
          {low:50, high:60, hover:'50 - 60'},
          {low:60, high:70, hover:'60 - 70'},
          {low:70, high:75, hover:'70 - 75'}
        ];
        gauge = dojo.byId("defaultGauge");
        gauge = new dojox.widget.BarGauge({
          id: "defaultGauge",
          width: 300,
          height: 55,
          dataHeight: 25,
          dataWidth: 275,
          dataY: 25,
          dataX: 10,
          ranges: ranges1,
          majorTicks: {
            length: 5,
            width: 1,
            offset: -5,
            interval: 5
          },
          indicators: [
            new dojox.widget.BarIndicator({
              value:17,
              width: 7,
              hover:'Value: 17',
              title: 'Value'
            }),
            new dojox.widget.BarLineIndicator({
              value:6,
              width: 5,
              color:'#D00000',
              hover:'Target: 6',
              title: 'Target'
            })
          ]  
        }, gauge);
        gauge.startup();
      }
      dojo.addOnLoad(init);

    </script>

  .. cv:: html

    <div id="defaultGauge"></div>

A declarative example with gradient ranges
------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.require("dojox.widget.BarGauge");
      dojo.require('dojox.widget.gauge.BarIndicator');
    </script>

  .. cv:: html

    <div dojoType="dojox.widget.BarGauge"
		id="declarativeGauge"
		width="300"
		height="55"
		dataHeight="25"
		dataWidth="275"
		dataX="10"
		dataY="25"
		useRangeStyles="0"
		hideValues="true"
		majorTicks="{length: 5, width: 1, offset: -5, interval: 5}"
		background="{
			type: 'linear',
			x1: 0,
			x2: 0,
			y1: 55,
			y2: 0,
			colors: [{offset: 0, color: '#ECECEC'}, {offset: 1, color: 'white'}]
		}">
	<div	dojoType="dojox.widget.gauge.Range"
			low="5"
			high="10"
			hover="5 - 10"
			color="{
				'type': 'linear',
				'colors': [{offset: 0, color:'#606060'}, {offset: 1, color: '#707070'}]
			}">
	</div>
	<div	dojoType="dojox.widget.gauge.Range"
			id="range1"
			low="10"
			high="20"
			hover="10 - 20"
			color="{
				'type': 'linear',
				'colors': [{offset: 0, color:'#707070'}, {offset: 1, color: '#808080'}]
			}">
	</div>
	<div	dojoType="dojox.widget.gauge.Range"
			id="range2"
			low="20"
			high="30"
			hover="20 - 30"
			color="{
				'type': 'linear',
				'colors': [{offset: 0, color:'#808080'}, {offset: 1, color: '#909090'}]
			}">
	</div>
	<div	dojoType="dojox.widget.gauge.Range"
			id="range3"
			low="30"
			high="40"
			hover="30 - 40"
			color="{
				'type': 'linear',
				'colors': [{offset: 0, color:'#909090'}, {offset: 1, color: '#A0A0A0'}]
			}">
	</div>
	<div	dojoType="dojox.widget.gauge.Range"
			id="range4"
			low="40"
			high="50"
			hover="40 - 50"
			color="{
				'type': 'linear',
				'colors': [{offset: 0, color:'#A0A0A0'}, {offset: 1, color: '#B0B0B0'}]
			}">
	</div>
	<div	dojoType="dojox.widget.gauge.Range"
			id="range5"
			low="50"
			high="60"
			hover="50 - 60"
			color="{
				'type': 'linear',
				'colors': [{offset: 0, color:'#B0B0B0'}, {offset: 1, color: '#C0C0C0'}]
			}">
	</div>
	<div	dojoType="dojox.widget.gauge.Range"
			id="range6"
			low="60"
			high="70"
			hover="60 - 70"
			color="{
				'type': 'linear',
				'colors': [{offset: 0, color:'#C0C0C0'}, {offset: 1, color: '#C0C0C0'}]
			}">
	</div>
	<div	dojoType="dojox.widget.gauge.Range"
			id="range7"
			low="70"
			high="75"
			hover="70 - 75"
			color="{
				'type': 'linear',
				'colors': [{offset: 0, color:'#C0C0C0'}, {offset: 1, color: '#E0E0E0'}]
			}">
	</div>
	<div	dojoType="dojox.widget.gauge.BarLineIndicator"
			id="target"
			value="6"
			color="#D00000"
			width="3"
			hover="Target: 6"
			title="Target">
	</div>
	<div 	dojoType="dojox.widget.gauge.BarIndicator"
			id="value"
			value="17"
			length="135"
			width="3"
			hover="Value: 17"
			title="Value">
	</div>
    </div>
