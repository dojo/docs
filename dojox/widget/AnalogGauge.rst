#format dojo_rst

dojox.widget.AnalogGauge
========================

:Status: Draft
:Version: 1.2
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

A circular gauge with a variety of indicators, used to display numerical data.


============
Introduction
============

The analog gauge widget provides a way to display data on a circular, or semi-circular gauge, such as a speedometer or a pressure gauge, for displaying a finite data value at a point in time. This UI paradigm has been around for a very long time and is quite common in most devices that people are familiar with, such as the dashboard of an automobile.

The analog gauge widget is entirely built upon the dojox.gfx package and as such, works extremely well across many browsers. The way to conceptually understand how the analog gauge widget works is that it is effectively a layering of a background shape, a circle or semi-circle, with a series of indicators for denoting values on the gauge face. An optional capability of the analog gauge is that the values for each indicator can be displayed beneath the gauge (and are by default). This makes the gauge accessibility compliant.

=====
Usage
=====

As demonstrated in the examples below, creating an analog gauge widget requires a few attributes: width and height of the gauge surface, the center of the gauge, the radius of the gauge, and a start and end angle.  Angles can be negative and the default start/end is -90/90 degrees. A gauge can have a few advanced features, such as an image overlaid on top of the gauge, a gradient background, and CSS styled ranges.  CSS styled ranges are used by setting the 'useRangeStyles' attribute to the number of CSS classes that have been created for this purpose, then creating those classes as .dojoxGaugeRangeN where N is the number of the range.  CSS styled ranges are not available when the renderer is VML.

Indicators can be handled separate of the gauge.  In other words, once an indicator has been created and added to the gauge, one can update the value of the indicator by simply calling the update function on the indicator (rather than having to have a handle on the gauge itself).  New indicators can be created by inheriting from dojox.widget._Indicator and overriding the appropriate functions (draw is the most important).

==========
Indicators
==========

There are 4 indicators included as a part of the Analog Gauge widget:

* AnalogLineIndicator - Is used to create the tick marks (with an offset from the middle).  Can also be used as a value indicator (without the offset).  See first example.
* AnalogArrowIndicator - Behaves and looks similar to the line indicator, but has an arrow head at the end.
* AnalogNeedleIndicator - An indicator similar to the needle on a variety of gauges.  Has a central circular hub and a triangular shaft that tapers to a point.
* AnalogArcIndicator - Draws an arc around the center of the gauge.  Can be made wider or narrower by varying the width.  Useful for making a gradient track towards the end of a gauge (see test file).

========
Examples
========

A partial circle gauge with two indicators (programmatic)
---------------------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.require("dojox.widget.AnalogGauge");
      dojo.require("dojox.widget.gauge.AnalogArrowIndicator");


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
        gauge = dojo.byId('defaultGauge');
        gauge = new dojox.widget.AnalogGauge({
          id: "defaultGauge",
          width: 300,
          height: 200,
          cx: 150,
          cy: 175,
          radius: 125,
          ranges: ranges1,
          minorTicks: {
            offset: 125,
            interval: 5,
            length: 5,
            color: 'gray'
          },
          majorTicks: {
            offset: 125,
            interval: 10,
            length: 10
          },
          indicators: [
            new dojox.widget.gauge.AnalogArrowIndicator({
              value:17, 
              width: 3,
              hover:'Value: 17', 
              title: 'Value'
           }),
           new dojox.widget.gauge.AnalogLineIndicator({
             value:6, 
             color:'#D00000',
             width: 3,
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

A partial circle gauge with two indicators and a set of gradient ranges
-----------------------------------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script>
      console.debug('require');
      dojo.require("dojox.widget.AnalogGauge");
      console.debug('require2');
      dojo.require("dojox.widget.gauge.AnalogArrowIndicator");
      console.debug('addonloaddddd');
      dojo.addOnLoad(function(){
        var gauge = dijit.byId('declarativeGauge');
        console.debug(gauge);
        gauge.addIndicator(new dojox.widget.gauge.AnalogLineIndicator({
          'id': 'target',
          'value': '52,
          'color': '#D00000',
          'width': 3,
          'hover': 'Target: 52',
          'title': 'Target'
        }));
        gauge.addIndicator(new dojox.widget.gauge.AnalogArrowIndicator({
          'id': 'value',
          'value': 17,
          'length': 135,
          'width': 3,
          'hover': 'Value: 17',
          'title': 'Value'
        }));
      });
    </script>

  .. cv:: html

    <div dojoType="dojox.widget.AnalogGauge"
	id="declarativeGauge"
	width="350"
	height="275"
	cx="175"
	cy="175"
	radius="135"
	startAngle="-120"
	endAngle="120"
	useRangeStyles="0"
	hideValues="true"
	majorTicks="{length: 5, offset: 135, interval: 5}">
      <div dojoType="dojox.widget.gauge.Range"
        low="0"
	high="10"
	hover="0 - 10"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#606060'}, {'offset': 1, 'color': '#707070'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        id="range1"
        low="10"
        high="20"
        hover="10 - 20"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#707070'}, {'offset': 1, 'color': '#808080'}]
	}">
      </div>
      <div  dojoType="dojox.widget.gauge.Range"
        id="range2"
        low="20"
        high="30"
        hover="20 - 30"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#808080'}, {'offset': 1, 'color': '#909090'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        id="range3"
        low="30"
        high="40"
        hover="30 - 40"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#909090'}, {'offset': 1, 'color': '#A0A0A0'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
         id="range4"
         low="40"
         high="50"
         hover="40 - 50"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#A0A0A0'}, {'offset': 1, 'color': '#B0B0B0'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        id="range5"
        low="50"
        high="60"
        hover="50 - 60"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#B0B0B0'}, {'offset': 1, 'color': '#C0C0C0'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        id="range6"
        low="60"
        high="70"
        hover="60 - 70"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#C0C0C0'}, {'offset': 1, 'color': '#D0D0D0'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        id="range7"
        low="70"
        high="80"
        hover="70 - 80"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#D0D0D0'}, {'offset': 1, 'color': '#E0E0E0'}]
	}">
      </div>
    </div>


A half circle gauge with two indicators overlay graphic
-------------------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.require("dojox.widget.AnalogGauge");
      dojo.require("dojox.widget.gauge.AnalogArrowIndicator");

      dojo.addOnLoad(function(){
        var gauge = dijit.byId('halfCircle');
        console.debug(gauge);
        gauge.addIndicator(new dojox.widget.gauge.AnalogLineIndicator({
          'value': 52,
          'color': '#D00000',
          'width': 3,
          'hover': 'Target: 52',
          'title': 'Target'
        }));
        gauge.addIndicator(new dojox.widget.gauge.AnalogArrowIndicator({
          'value': 17,
          'length': 125,
          'width': 3,
          'hover': 'Value: 17',
          'title': 'Value'
        }));
      });
    </script>

  .. cv:: html

    <div dojoType="dojox.widget.AnalogGauge"
      id="halfCircle"
      width="350"
      height="225"
      cx="175"
      cy="175"
      radius="125"
      startAngle="-90"
      endAngle="90"
      useRangeStyles="0"
      hideValues="true"
      majorTicks="{length: 5, offset: 125, interval: 5}"
      image="{url:'{{dataUrl}}dojox/widget/tests/images/gaugeOverlay.png', width: 280, height: 155,x: 35, y: 38,overlay: true}">
      <div dojoType="dojox.widget.gauge.Range"
        low="0"
	high="10"
	hover="0 - 10"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#606060'}, {'offset': 1, 'color': '#707070'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        low="10"
        high="20"
        hover="10 - 20"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#707070'}, {'offset': 1, 'color': '#808080'}]
	}">
      </div>
      <div  dojoType="dojox.widget.gauge.Range"
        low="20"
        high="30"
        hover="20 - 30"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#808080'}, {'offset': 1, 'color': '#909090'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        low="30"
        high="40"
        hover="30 - 40"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#909090'}, {'offset': 1, 'color': '#A0A0A0'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
         low="40"
         high="50"
         hover="40 - 50"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#A0A0A0'}, {'offset': 1, 'color': '#B0B0B0'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        low="50"
        high="60"
        hover="50 - 60"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#B0B0B0'}, {'offset': 1, 'color': '#C0C0C0'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        low="60"
        high="70"
        hover="60 - 70"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#C0C0C0'}, {'offset': 1, 'color': '#D0D0D0'}]
	}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        low="70"
        high="75"
        hover="70 - 75"
	color="{
		'type': 'linear',
		'colors': [{'offset': 0, 'color': '#D0D0D0'}, {'offset': 1, 'color': '#E0E0E0'}]
	}">
      </div>
    </div>


Speedometer style gauge with arc indicator and needle indicator
---------------------------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.require("dojox.widget.AnalogGauge");
      dojo.require("dojox.widget.gauge.AnalogArcIndicator");
      dojo.require("dojox.widget.gauge.AnalogNeedleIndicator");

      dojo.addOnLoad(function(){
	  var gauge = dijit.byId('speedo');
	  // Used for a gradient arc indicator below:
	  var fill = {
	    'type': 'linear',
	    'x1': 50,
	    'y1': 50,
	    'x2': 350,
	    'y2': 350,
	    'colors': [{offset: 0, color: 'black'}, {offset: 0.5, color: 'black'}, {offset: 0.75, color: 'yellow'}, {offset: 1, color: 'red'}]
	  };
	  gauge.addIndicator(new dojox.widget.gauge.AnalogArcIndicator({
	    'value': 200,
	    'width': 20,
	    'offset': 150,
	    'color': fill,
	    'noChange': true,
	    'hideValues': true
	  }));
	  gauge.addIndicator(new dojox.widget.gauge.AnalogArcIndicator({
	    'value': 80,
	    'width': 10,
	    'offset': 150,
	    'color': 'blue',
	    'title': 'Arc',
	    'hover': 'Arc: 80'
	  }));
          gauge.addIndicator(new dojox.widget.gauge.AnalogNeedleIndicator({
            'value': 100,
            'width': 8,
            'length': 150,
            'color': 'red',
            'title': 'Needle',
            'hover': 'Needle: 100'
          }));
      });
    </script>

  .. cv:: html

    <div dojoType="dojox.widget.AnalogGauge"
      id='speedo'
      width="450"
      height="300"
      cx="225"
      cy="175"
      radius="150"
      startAngle="-135"
      endAngle="135"
      useRangeStyles="0"
      hideValues="true"
      color: "white"
      majorTicks="{length: 10, offset: 105, interval: 10, color: 'gray'}"
      minorTicks="{length: 5, offset: 105, interval: 5, color: 'gray'}">
      <div dojoType="dojox.widget.gauge.Range"
        low="0"
	high="100"
        color="{'color': 'black'}">
      </div>
      <div dojoType="dojox.widget.gauge.Range"
        low="100"
	high="200"
        color="{'color': 'black'}">
      </div>
    </div>
