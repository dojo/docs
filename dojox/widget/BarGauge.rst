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
