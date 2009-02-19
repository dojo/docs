#format dojo_rst

dojox.charting
==============

:Status: Draft
:Version: 1.0
:Project owner: Eugene Lazutkin, Tom Trenka
:Available: since V?

.. contents::
   :depth: 2

Dojo comes with an amazing charting library, in the form of dojox.charting. A large number of features are supported, with new ones being added constantly.


============
Introduction
============

Dojo's Charting module provides a way to quickly and easily add great looking and functional dynamic charts and graphs to your web pages. All you need is a tiny bit of JavaScript skills and a copy of Dojo.

=====
Usage 
=====

Here is an HTML fragment that is typical of a starting point for creating a Dojo Chart:

.. code-block :: html

  <html>
  <head>
  <title>Basic Charting</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <script type="text/javascript" src="dojo/dojo.js" djConfig="isDebug: true"></script>
  <script type="text/javascript">
    dojo.require("dojox.charting.Chart2D"); 
    makeCharts = function(){
  	var chart1 = new dojox.charting.Chart2D("simplechart");
  	chart1.addPlot("default", {type: "Lines"});
  	chart1.addAxis("x");
  	chart1.addAxis("y", {vertical: true});
  	chart1.addSeries("Series 1", [1, 2, 2, 3, 4, 5, 5, 7]);
  	chart1.render();
  };
  dojo.addOnLoad(makeCharts);
  </script>
  </head>
  <body>
    <div id="simplechart" style="width: 250px; height: 150px;"></div>
  </body>
  </html>

This source code produces the following simple chart.

TODO: Live chart example

Simple Chart
------------

In the above example you can see that most of the work in defining the chart is done in the addPlot(), addAxis(), and addSeries() functions. The next section examines the addPlot(), addAxis() and addSeries() api's in more detail.

Got Plot?
---------

The addPlot() call determines what type of chart you are going to produce, and there are a variety of options to select. Here are a few examples:

Some Chart Types
----------------

addPlot() accepts 2 parameters, a name and an arguments array. The name is important if you want to have more than 1 plot type on your chart, a concept we will cover shortly. The arguments array contains your options, and these may vary depending on the type of plot you use. Note that your choice of plot type may define appropriate default options.

Let’s examine our options. Type is the main option, and the default value is a basic line chart.

.. code-block :: javascript

  chart1.addPlot("default", {type: "Areas"});

Available 2D chart types include:

  * Areas - Area under data line(s) will be filled
  * Bars - Horizontal bars.
  * ClusteredBars - Horizontal bars with clustered data sets
  * ClusteredColumns - Vertical bars with clustered data sets
  * Columns - Vertical bars
  * Grid - For adding a grid layer to you chart
  * Lines - Basic line chart
  * Markers - Lines with markers
  * MarkersOnly - Markers, sans lines
  * Pie - Goes great with punch!
  * Scatter - Cooler name for MarkersOnly
  * Stacked - Data sets charted in relation to the previous data set.
  * StackedAreas - Stacked data sets with filled areas under chart lines
  * StackedBars - Stacked data sets with horizontal bars
  * StackedColumns - Stacked data sets with vertical bars
  * StackedLines - Stacked data sets using lines

With any of the lines, areas or markers types you have 5 specific options. First, there are three options for controlling aspects of lines, areas, and markers. These are often defined by the chosen plot type, but can be changed to get other behaviors. The lines option determines whether or not lines are used to connect data points. If the areas type is selected, the area below the data line will be filled. The markers option will determine if markers are placed at data points.

.. code-block :: javascript

  chart1.addPlot("default", {type: "StackedAreas", lines: true, areas: true, 
  	markers: false});

There are also two graphical options, tension and shadows. Tension allows you to add some curve to the lines on you plot. By default this option is set to 0 which is off. A tension in the range from 2 to 4 should be a good range for natural looking curves. For some crazy effects try setting the tension to values < 1 or negative. Shadows allow you to add a shadow effect, and consists of an array of three parameters, dx, dy and dw, which represent the offset to the right, the offset down, and the width of the shadow line, respectively. Negative values can be specified for the dx and dy parameters to produce a shadow that is to the left or above the chart line.

.. code-block :: javascript

  chart1.addPlot("default", {type: "StackedLines",tension:3, 
  	shadows: {dx: 2, dy: 2, dw: 2}});

Bar and column graph types have 1 unique option: they will accept a gap parameter that determines the spacing between your bars or columns in pixels.

.. code-block :: javascript

  chart1.addPlot("default", {type: "Bars", gap: 5});

For any chart type that supports axes, you can also define custom names to your axes here. By default they are “x” and “y”, but this option becomes useful if you wish to have a chart with multiple plots and multiple axes.

.. code-block :: javascript

  chart1.addPlot("default", {type: "Bars", hAxis: "cool x", 
  	vAxis: "super y"});

Pie charts have a separate list of parameters. Here are the parameters for the pie chart, from Pie.js:

.. code-block :: javascript

  defaultParams: {
  	labels: true,
  	ticks: false,
  	fixed: true,
  	precision: 1,
  	labelOffset: 20,
  	labelStyle: "default",      // default/rows/auto
  	htmlLabels: true            // use HTML to draw labels
  },
  optionalParams: {
  	font: "",
  	fontColor: "",
  	radius: 0
  },  

One other type with unique options is the grid. This plot type will draw grid lines along the tick marks and supports the following four boolean options to determine if lines will be displayed at the horizontal or vertical and major or minor axis tick marks. 

.. code-block :: javascript

  chart1.addPlot("default", {type: "Grid",
          hMajorLines: true, 
          hMinorLines: false,
          vMajorLines: true,
          vMinorLines: false});

Shadows and curve can be added to the lines, and markers on data points as follows:

.. code-block :: javascript

  chart1.addPlot("default", {type: "Lines", markers: true, 
  	tension:3, shadows: {dx: 2, dy: 2, dw: 2}});

The resulting chart looks like this:

TODO: Example

Some Chart Types
----------------

One last feature I’d like to touch on is adding multiple plots to the same chart. Multiple plots can be of differing types and can all be configured separately. Each plot you add with addPlot() will be layered behind the previous plot. In addition, plots can have their own axes or share them with other plots on the chart. Now, if we add an areas plot to our lines example, we can create the following effect.

.. code-block :: javascript

  var chart1 = new dojox.charting.Chart2D("simplechart");
  chart1.addPlot("default", {type: "Lines"});
  chart1.addPlot("other", {type: "Areas"});
  chart1.addAxis("x");
  chart1.addAxis("y", {vertical: true});
  chart1.addSeries("Series 1", [1, 2, 2, 3, 4, 5, 5, 7]);
  chart1.addSeries("Series 2", [1, 1, 4, 2, 1, 6, 4, 3], 
  	{plot: "other", stroke: {color:"blue"}, fill: "lightblue"});
  chart1.render();

The charting library is also very flexible in terms of combining chart types, as well as multiple axes. You can set up custom labels for a specific axis, you can set up custom markers for points on a number of different types of charts, and you can even create your own themes for a chart!


=====
Usage
=====

Updating charts and events
--------------------------

Charting was designed with periodic updating in mind. Say you have an application that remotely monitors something: the stock market, a database server, etc. With dojox.charting, you can set up a chart and then simply update the series on the charts--resulting in a fast, fluid monitoring experience. In fact, charting has been used for such things as remote CPU monitoring.

TODO: please explain more. How does this work? Show an example.

Coming with the Dojo 1.2 release, Charting will also support customized events, such as tooltip attachment and mouseover actions!

Animations
----------

TODO: Explain the animation features (new since V1.2)


========
Examples
========

Stacked area chart
------------------

Here is a very simple example of a stacked area chart.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.charting.Chart2D");
    dojo.require("dojox.charting.themes.Wetland");

    dojo.addOnLoad(function(){
      var c = new dojox.charting.Chart2D("chartOne");
      c.addPlot("default", {type: "StackedAreas", tension:3})
          .addAxis("x", {fixLower: "major", fixUpper: "major"})
	  .addAxis("y", {vertical: true, fixLower: "major", fixUpper: "major", min: 0})
          .setTheme(dojox.charting.themes.Wetland)
          .addSeries("Series A", [1, 2, 0.5, 1.5, 1, 2.8, 0.4])
          .addSeries("Series B", [2.6, 1.8, 2, 1, 1.4, 0.7, 2])
          .addSeries("Series C", [6.3, 1.8, 3, 0.5, 4.4, 2.7, 2])
          .render();
    });
    </script>

  .. cv:: html

    <div id="chartOne" style="width: 400px; height: 240px;"></div>

Pie chart
---------

Here is a pie chart, with slice information shown onmouseover and a legend:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.charting.Chart2D");
    dojo.require("dojox.charting.plot2d.Pie");
    dojo.require("dojox.charting.action2d.Highlight");
    dojo.require("dojox.charting.action2d.MoveSlice");
    dojo.require("dojox.charting.action2d.Tooltip");
    dojo.require("dojox.charting.themes.MiamiNice");
    dojo.require("dojox.charting.widget.Legend");

    dojo.addOnLoad(function(){
      var dc = dojox.charting;
      var chartTwo = new dc.Chart2D("chartTwo");
      chartTwo.setTheme(dc.themes.MiamiNice)
         .addPlot("default", {
            type: "Pie", 
            font: "normal normal 11pt Tahoma", 
            fontColor: "black", 
            labelOffset: -30,
            radius: 80
      }).addSeries("Series A", [
          {y: 4, text: "Red",   stroke: "black", tooltip: "Red is 50%"},
          {y: 2, text: "Green", stroke: "black", tooltip: "Green is 25%"},
          {y: 1, text: "Blue",  stroke: "black", tooltip: "I am feeling Blue!"},
          {y: 1, text: "Other", stroke: "black", tooltip: "Mighty <strong>strong</strong><br>With two lines!"}
      ]);
      var anim_a = new dc.action2d.MoveSlice(chartTwo, "default");
      var anim_b = new dc.action2d.Highlight(chartTwo, "default");
      var anim_c = new dc.action2d.Tooltip(chartTwo, "default");
      chartTwo.render();
      var legendTwo = new dojox.charting.widget.Legend({chart: chartTwo}, "legendTwo");
    });
    </script>

  .. cv:: html

    <div id="chartTwo" style="width: 300px; height: 300px;"></div>
    <div id="legendTwo"></div>

Animated Chart
--------------

TODO: How to use animations.

3D Chart
--------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.charting.Chart3D");
        dojo.require("dojox.charting.plot3d.Bars");

        dojo.addOnLoad(function(){
            var m = dojox.gfx3d.matrix;
            var chart3d = new dojox.charting.Chart3D("chart3d", 
                {
                    lights:   [{direction: {x: 5, y: 5, z: -5}, color: "white"}],
                    ambient:  {color:"white", intensity: 2},
                    specular: "white"
                },
                [m.cameraRotateXg(10), m.cameraRotateYg(-10), m.scale(0.8), m.cameraTranslate(-50, -50, 0)]
            );
            
            var bars3d_a = new dojox.charting.plot3d.Bars(500, 500, {gap: 10, material: "yellow"});
            bars3d_a.setData([1,2,3,2,1,2,3,4,5]);
            chart3d.addPlot(bars3d_a);
            
            var bars3d_b = new dojox.charting.plot3d.Bars(500, 500, {gap: 10, material: "red"});
            bars3d_b.setData([2,3,4,3,2,3,4,5,5]);
            chart3d.addPlot(bars3d_b);
            
            var bars3d_c = new dojox.charting.plot3d.Bars(500, 500, {gap: 10, material: "blue"});
            bars3d_c.setData([3,4,5,4,3,4,5,5,5]);
            chart3d.addPlot(bars3d_c);
            
            chart3d.generate().render();            
        });
    </script>

  .. cv:: html

    <div id="chart3d" style="width: 500px; height: 500px;"></div>

========
See also
========

* `A Beginner’s Guide to Dojo Charting, Part 1 of 2 <http://www.sitepen.com/blog/2008/06/06/a-beginners-guide-to-dojo-charting-part-1-of-2/>`_
* `A Beginner’s Guide to Dojo Charting, Part 2 of 2 <http://www.sitepen.com/blog/2008/06/16/a-beginners-guide-to-dojo-charting-part-2-of-2/>`_
* `Dojo Charting: Widgets, Tooltips, and Legend <http://www.sitepen.com/blog/2008/06/12/dojo-charting-widgets-tooltips-and-legend/>`_
* `Dojo Charting: Event Support Has Landed! <http://www.sitepen.com/blog/2008/05/27/dojo-charting-event-support-has-landed/>`_
* `Zooming, Scrolling, and Panning in Dojo Charting <http://www.sitepen.com/blog/2008/05/15/zooming-scrolling-and-panning-in-dojo-charting/>`_
* `Dojo Charting Reorganization <http://www.sitepen.com/blog/2008/05/07/dojo-charting-reorganization/>`_

=======
Credits
=======

Much of the information in the above article originally appeared in the following articles and excerpts have been used with permission from Sitepen.
* `A Beginner’s Guide to Dojo Charting, Part 1 of 2 <http://www.sitepen.com/blog/2008/06/06/a-beginners-guide-to-dojo-charting-part-1-of-2/>`_ by Doug McMaster
* `A Beginner’s Guide to Dojo Charting, Part 2 of 2 <http://www.sitepen.com/blog/2008/06/16/a-beginners-guide-to-dojo-charting-part-2-of-2/>`_ by Doug McMaster
