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

.. code-example::

  .. javascript::

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

  .. html::

    <div id="chartOne" style="width: 400px; height: 240px; margin: 30px auto 0px auto;"></div>

============
Introduction
============

Dojo's Charting module provides a way to quickly and easily add great looking and functional dynamic charts and graphs to your web pages. All you need is a tiny bit of JavaScript skills and a copy of Dojo.

=====
Usage 
=====

Here is an example that is typical of a starting point for creating a Dojo Chart:

.. code-example::
  :type: inline
  :height: 250
  :width: 360
  :toolbar: versions

  .. html::

    <div id="simplechart" style="width: 250px; height: 150px; margin: 5px auto 0px auto;"></div>

  .. javascript::
 
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

Take a look at the source and you will see that it is simple to create charts.

Charting Basics
---------------

As part of configuring any Chart, you'll need to define Plots, Axes and Series data. Plots describe how data is to be visualized.  Axes describe the dimensions of data that are being visualized and includes things like specifying labels.  Series describes the Data itself that the chart will visualize.

Adding Plots
------------

The addPlot() call is used to determine what type of chart you are going to produce, and there are a variety of options to select. Here are a few examples:

TODO: Examples of Different Chart Plot Types

addPlot() accepts 2 parameters, a name and an arguments array. The name is important if you want to have more than one plot type on your chart. The arguments array contains your plot options, and these may vary depending on the type of plot you use. Note that your choice of plot type may define appropriate default options.

**type** is the main option, with a default value being a basic line chart.

.. code-block :: javascript
  :linenos:

  chart1.addPlot("default", {type: "Areas"});

Available 2D chart types include:

  * **Areas** - Area under data line(s) will be filled
  * **Bars** - Horizontal bars.
  * **ClusteredBars** - Horizontal bars with clustered data sets
  * **ClusteredColumns** - Vertical bars with clustered data sets
  * **Columns** - Vertical bars
  * **Grid** - For adding a grid layer to your chart
  * **Lines** - Basic line chart
  * **Markers** - Lines with markers
  * **MarkersOnly** - Markers, sans lines
  * **Pie** - Goes great with punch!
  * **Scatter** - Cooler name for MarkersOnly
  * **Stacked** - Data sets charted in relation to the previous data set.
  * **StackedAreas** - Stacked data sets with filled areas under chart lines
  * **StackedBars** - Stacked data sets with horizontal bars
  * **StackedColumns** - Stacked data sets with vertical bars
  * **StackedLines** - Stacked data sets using lines

With any of the lines, areas or markers types you have five specific options. First, there are three options for controlling aspects of **lines**, **areas**, and **markers**. These are often defined by the chosen plot type, but can be changed to get other behaviors. The lines option determines whether or not lines are used to connect data points. If the areas type is selected, the area below the data line will be filled. The markers option will determine if markers are placed at data points.

.. code-block :: javascript
  :linenos:

  chart1.addPlot("default", {type: "StackedAreas", lines: true, areas: true, 
  	markers: false});

There are also two graphical options, **tension** and **shadows**. Tension allows you to add some curve to the lines on you plot. By default this option is set to 0 which is off. A tension in the range from 2 to 4 should be a good range for natural looking curves. For some crazy effects try setting the tension to values < 1 or negative. Shadows allow you to add a shadow effect, and consists of an array of three parameters, dx, dy and dw, which represent the offset to the right, the offset down, and the width of the shadow line, respectively. Negative values can be specified for the dx and dy parameters to produce a shadow that is to the left or above the chart line.

.. code-block :: javascript
  :linenos:

  chart1.addPlot("default", {type: "StackedLines",tension:3, 
  	shadows: {dx: 2, dy: 2, dw: 2}});

Bar and column graph types have 1 unique option: they will accept a gap parameter that determines the spacing between your bars or columns in pixels.

.. code-block :: javascript
  :linenos:

  chart1.addPlot("default", {type: "Bars", gap: 5});

For any chart type that supports axes, you can also define custom names to your axes here. By default they are “x” and “y”, but this option becomes useful if you wish to have a chart with multiple plots and multiple axes.

.. code-block :: javascript
  :linenos:

  chart1.addPlot("default", {type: "Bars", hAxis: "cool x", 
  	vAxis: "super y"});

Pie charts have a separate list of parameters. Here are the parameters for the pie chart, from Pie.js:

.. code-block :: javascript
  :linenos:

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
  :linenos:

  chart1.addPlot("default", {type: "Grid",
          hMajorLines: true, 
          hMinorLines: false,
          vMajorLines: true,
          vMinorLines: false});

Shadows and curve can be added to the lines, and markers on data points as follows:

.. code-block :: javascript
  :linenos:

  chart1.addPlot("default", {type: "Lines", markers: true, 
  	tension:3, shadows: {dx: 2, dy: 2, dw: 2}});

The resulting chart looks like this:

TODO: Example Chart

One last feature I’d like to touch on is adding multiple plots to the same chart. Multiple plots can be of differing types and can all be configured separately. Each plot you add with addPlot() will be layered behind the previous plot. In addition, plots can have their own axes or share them with other plots on the chart. Now, if we add an areas plot to our lines example, we can create the following effect.

.. code-block :: javascript
  :linenos:

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

Specifying Axes
---------------

The addAxis() call on a chart has several options for defining axes. Similar to addPlot(), this call takes two parameters, a name and an options array. You will need to use “x” and “y” as your axes names unless you gave them custom names in your addPlot() call. Additionally, you don’t have to define the axes if you wish to create charts with one or zero axes. You can also make charts with more than two axes by adding a second plot and attaching axes to it. Using this approach, you can display up to four different axes, two vertical and two horizontal, using two to four plots. Also, a single axis can be shared by more than one plot, meaning you could have two plots that use the same horizontal axis, but have different vertical axes. Let’s look at all the addPlot() options that make this and more possible.

The first option is vertical, this determines if the axis is vertical or horizontal, it defaults to false for a horizontal axis. Make sure that your alignment matches with values set for hAxis and vAxis, which are “x” and “y” by default, on your plot or your chart will not render.

.. code-block :: javascript
  :linenos:

  chart1.addPlot("default", {type: "Lines", hAxis: "x", vAxis: "y"});
  chart1.addAxis("x"); 
  chart1.addAxis("y", {vertical: true});

Next we have the fixUpper and fixLower options, which align the ticks and have 4 available options; major, minor, micro, and none. These default to none, and when set will force the end bounds to align to the corresponding tick division. If none is chosen, the end bounds will be the highest and lowest values in your data set. Another related option is the includeZero option, which will make your lower bound be zero. If your lowest data value is negative the includeZero option has no effect.

.. code-block :: javascript
  :linenos:

  chart1.addAxis("x", {fixUpper: "major", fixLower:"minor"});
  chart1.addAxis("y", {vertical: true, fixUpper: "major", includeZero: true});

Now let’s examine the leftBottom option. This option defaults to true, and along with the vertical option determines the side of the chart the axis is placed. At the end of Part 1 we examined adding a second plot to our chart. Let’s use that sample and give the second plot its own set of axes and anchor them on the top and right using leftBottom.

.. code-block :: javascript
  :linenos:

  var chart1 = new dojox.charting.Chart2D("simplechart");
  chart1.addPlot("default", {type: "Lines"});
  chart1.addPlot("other", {type: "Areas", hAxis: "other x", vAxis: "other y"});
  chart1.addAxis("x");
  chart1.addAxis("y", {vertical: true});
  chart1.addAxis("other x", {leftBottom: false});
  chart1.addAxis("other y", {vertical: true, leftBottom: false});
  chart1.addSeries("Series 1", [1, 2, 2, 3, 4, 5, 5, 7]);
  chart1.addSeries("Series 2", [1, 1, 4, 2, 1, 6, 4, 3], 
          {plot: "other", stroke: {color:"blue"}, fill: "lightblue"}
  );
  chart1.render();

Multiple Axes
-------------

The one thing you may have noticed is that using multiple axes changes the perspective because the second data set is now charted against a different axis. You are in luck because you have full control to adjust the axis in almost every way possible. For example, you can set min and max options.

.. code-block :: javascript
  :linenos:

  min: 0
  max: 7

Enabling and disabling tick marks
---------------------------------

You can turn on and off the tick marks at the minor and micro level, and turn labels on and off for the major and minor levels

.. code-block :: javascript
  :linenos:

  majorLabels: true
  minorTicks: true
  minorLabels: true
  microTicks: false

Natural & Fixed Precision Axis
------------------------------

The natural property forces all ticks to be on natural numbers, and fixed which will fix the precision on labels and can be specifid as follows.

.. code-block :: javascript
  :linenos:

  natural: false		
  fixed: true

Axis Stepping
------------------------------

Defining the step between ticks can be specified as follows.

.. code-block :: javascript
  :linenos:

  majorTickStep: 4
  minorTickStep: 2
  microTickStep: 1

Axis Colors and Styles
----------------------

The color of the axis, the color and length of your tick marks and the font and color of your labels can be specified as follows.

.. code-block :: javascript
  :linenos:

  chart1.addAxis("other y", {vertical: true, 
	leftBottom: false, 
	max: 7,
	stroke: "green",
	font: "normal normal bold 14pt Tahoma", 
	fontColor: "red",
	majorTick: {color: "red", length: 6},
	minorTick: {stroke: "black", length: 3}
  });

TODO: Axis Properties Example

Adding a Background Grid Plot
-----------------------------

You can also add a grid at your tick marks to your entire chart by adding a Grid plot. The grid plot allows you to turn the grid on and off for major and minor ticks in both directions, and you can assign axes names if you have multiple axes. Let’s add a grid to the other axes in our above example.

.. code-block :: javascript
  :linenos:

  chart1.addPlot("Grid", {type: "Grid",
  	hAxis: "other x",
  	vAxis: "other y",
  	hMajorLines: true,	
  	hMinorLines: false,	
  	vMajorLines: true,	
  	vMinorLines: false
  });

TODO: Grid Plot Example

Using Custom Axis Labels
------------------------

Dojo Charts provide the ability to assign custom labels to any axis. Make sure to allow sufficient space in your div for the text to display properly. 
Here is an example using abbreviated month names with a Columns plot.

.. code-block :: javascript
  :linenos:

  chart1.addAxis("x", { 
  	labels: [{value: 1, text: "Jan"}, {value: 2, text: "Feb"}, 
  		{value: 3, text: "Mar"}, {value: 4, text: "Apr"}, 
  		{value: 5, text: "May"}, {value: 6, text: "Jun"},
  		{value: 7, text: "Jul"}, {value: 8, text: "Aug"},
  		{value: 9, text: "Sep"}, {value: 10, text: "Oct"},
  		{value: 11, text: "Nov"}, {value: 12, text: "Dec"}]
  	});

TODO: Month Labels Example

Connecting Charts to Data and Specifying a Data Series
------------------------------------------------------

Using addSeries(), you can define the data sets that will be displayed on our chart. addSeries() accepts three parameters, a name, a data array and an options array. There is also an updateSeries() call that takes a name and data array for when you want to refresh your data. Let’s run through the options available in the addSeries() call, then look at the data array.

There are only a few options to cover for the addSeries() call. First up is stroke, which covers the color and width of your line or the border of your bar and column type graphs.Along with stroke we have fill, and it determines the color of the fill area under the line in area type line graphs and determines the bar fill color for bar and column type graphs. If you are familiar with SVG or dojox.gfx, stroke and fill should be very familiar.

.. code-block :: javascript
  :linenos:

  chart1.addSeries("Series 1", [1, 2, 4, 5, 5, 7], {stroke: {color: "blue", width: 2}, 
  	fill: "lightblue"});

The other option is marker and it allows you to define custom markers using SVG path segments. Here are some of marker types as defined in the Dojo Charting source code. Note that each is just defined internally as an SVG path:

.. code-block :: javascript
  :linenos:

  CIRCLE:		"m-3,0 c0,-4 6,-4 6,0 m-6,0 c0,4 6,4 6,0", 
  SQUARE:		"m-3,-3 l0,6 6,0 0,-6 z", 
  DIAMOND:	"m0,-3 l3,3 -3,3 -3,-3 z", 
  CROSS:		"m0,-3 l0,6 m-3,-3 l6,0", 
  X:		"m-3,-3 l6,6 m0,-6 l-6,6", 
  TRIANGLE:	"m-3,3 l3,-6 3,6 z", 
  TRIANGLE_INVERTED:"m-3,-3 l3,6 3,-6 z"

Now take a look at these options in action using our above example:

TODO: Example Series Options

The data array, is just an array of data. All plot types can accept a one dimensional array, but there are some additional format options available based on the type of chart. With a one-dimensional array for line type graphs the X axis will be integers; 1,2,3… and the data will be the Y axis. For bar type plots the data is the length of the bar and the choice between column or bar type determines the orientation. And for pie type charts the sum of the array is your whole pie. All the plot types except pie can have multiple series.

.. code-block :: javascript
  :linenos:

  chart1.addSeries("Series A", [1, 2, 3, 4, 5]);

For any non “stacked” line plot type you can specify coordinate pairs. You need to use keys that correspond to the hAxis and vAxis parameters defined in the addPlot() call. These default to x and y.

.. code-block :: javascript
  :linenos:

  chart1.addSeries("Series A", [{x: 1, y: 5}, {x: 1.5, y: 1.7}, 
  	{x: 2, y: 9}, {x: 5, y: 3}]);
  chart1.addSeries("Series B", [{x: 3, y: 8.5}, {x: 4.2, y: 6}, {x: 5.4, y: 2}]);

Here is an example of using coordinate pairs with a scatter plot:

TODO: Example Coordinate Pairs

With any of the stacked plot types each data set added with addSeries() is placed relative to the previous set. Here is a simple example that shows this concept. Instead of the second data set being a straight line across at 1, all the points are 1 above the point from the first data set.

.. code-block :: javascript
  :linenos:

  chart1.addSeries("Series 1", [1, 2, 3, 4, 5]);
  chart1.addSeries("Series 2", [1, 1, 1, 1, 1], {stroke: {color: "red"}});

TODO: Example Stacked Data Series

For pie type charts you can specify additional information: the text label for each slice, the color of the slice and even a font color that overrides the font color definable in the addPlot() call.

.. code-block :: javascript
  :linenos:

  chart1.addSeries("Series A", [
  	{y: 4, color: "red"},
  	{y: 2, color: "green"},
  	{y: 1, color: "blue"},
  	{y: 1, text: "Other", color: "white", fontColor: "red"}
  ]);

Using dojo.data Data Sources with Charts
----------------------------------------

TODO

Changing Color Themes
---------------------
Under dojox.charting.themes, you will find a variety of predefined color themes for use with Dojo Charting.  Just make sure to require the theme you want to use, and then set the theme on your chart as follows:

.. code-block :: javascript
  :linenos:

  chart1.setTheme(dojox.charting.themes.PlotKit.blue);

Chart Events
------------

Chart events allow you to attach behavior to various chart features, such as markers in response to user actions.

The following events are supported: onclick, onmouseover, and onmouseout.

Event handlers can be attached to individual plots of a chart:

.. code-block :: javascript
  :linenos:

  chart.connectToPlot(
      plotName,    // the unique plot name you specified when creating a plot
      object,      // both object and method are the same used by dojo.connect()
      method       // you can supply a function without an object
  );

The event handler receives one argument. While it tries to unify information for different charts, its exact layout depends on the chart type:

+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| **Attribute**  | **Expected Value**                      | **Description**                                                               | **Since** |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| type           | “onclick”, “onmouseover”, “onmouseout”  |differentiate between different types of events.                               | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| element        | "marker","bar","column","circle","slice"|Indicates what kind of element has sent the event.                             | 1.0       |
|                |                                         |Can be used to define highlighting or animation strategies.                    |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| x              | number                                  |The “x” value of the point. Can be derived from the index (depends on a chart).| 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| y              | number                                  |The “y” value of the point. Can be derived from the index (depends on a chart).| 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| index          | number                                  |The index of a data point that caused the event.                               | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| run            | object                                  |The data run object that represents a data series.                             | 1.0       |
|                |                                         |Example: o.run.data[o.index]                                                   |           |
|                |                                         |returns the original data point value for the event                            |           |
|                |                                         |(o is an event handler’s argument).                                            |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| plot           | object                                  |The plot object that hosts the event’s data point.                             | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| hAxis          | object                                  |The axis object that is used as a horizontal axis by the plot.                 | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| vAxis          | object                                  |The axis object that is used as a vertical axis by the plot.                   | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| event          | object                                  |The original mouse event that started the event processing.                    | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| shape          | object                                  |The gfx shape object that represents a data point.                             | 1.0       |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| outline        | object                                  |The gfx shape object that represents an outline (a cosmetic shape).            | 1.0       |
|                |                                         |Can be null or undefined.                                                      |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| shadow         | object                                  |The gfx shape object that represents a shadow (cosmetic shape).                | 1.0       |
|                |                                         |Can be null or undefined.                                                      |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| cx             | number                                  |The “x” component of the visual center of a shape in pixels.                   | 1.0       |
|                |                                         |Supplied only for “marker”, “circle”, and “slice” elements.                    |           |
|                |                                         |Undefined for all other elements                                               |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| cy             | number                                  |The “y” component of the visual center of a shape in pixels.                   | 1.0       |
|                |                                         |Supplied only for “marker”, “circle”, and “slice” elements.                    |           |
|                |                                         |Undefined for all other elements                                               |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+
| cr             | number                                  |The radius in pixels of a “circle”, or a “slice” element.                      | 1.0       |
|                |                                         |Undefined for all other elements                                               |           |
+----------------+-----------------------------------------+-------------------------------------------------------------------------------+-----------+

Zooming, Scrolling, and Panning
-------------------------------

Dojo Charting provides methods to control arbitrary zooming to drill down to the smallest details of your chart, scrolling, and panning (moving the chart with you mouse in two dimensions). Note that the latter functionality can be taxing on the browser, but the new generation of browsers (Firefox 3, Safari 3, Opera 9.5) are up to the task.

+-----------------------------------+---------------------------------------------------------------------------------------------------------------+
| **Name**                          | **Description**                                                                                               |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------+
| setAxisWindow(name, scale, offset)|Defines a window on the named axis with a scale factor.                                                        | 
|                                   |**scale** must be >= 1.                                                                                        |
|                                   |**offset** should be >= 0.                                                                                     |
|                                   |For example if I have an array of 10 numeric values, and I want to show them ##3-8,                            |
|                                   |chart.setWindow(”x”, 3, 2) will do the trick.                                                                  |
|                                   |This call affects only plots attached to the named axis, other plots are unaffected.                           |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------+
| setWindow(sx, sy, dx, dy)         |Sets scale and offsets on all plots of the chart.                                                              | 
|                                   |**sx** specifies the magnification factor on horizontal axes. It should be >= 1.                               |
|                                   |**sy** specifies the magnification factor on vertical axes. It should be >= 1.                                 |
|                                   |**dx** specifies the offset of the horizontal axes in pixels. It should be >= 0.                               |
|                                   |**dy** specifies the offset of the vertical axes. It should be >= 0.                                           |
|                                   |All chart's axes (and, by extension, plots) will be affected)                                                  |
+-----------------------------------+---------------------------------------------------------------------------------------------------------------+

Both methods on Chart perform sanity checks, and won't allow you to scroll outside of axis’ boundaries, or zoom out too far.

Updating Charts and Events
--------------------------

Charting was designed with periodic updating in mind. Say you have an application that remotely monitors something: the stock market, a database server, etc. With dojox.charting, you can set up a chart and then simply update the series on the charts--resulting in a fast, fluid monitoring experience. In fact, charting has been used for such things as remote CPU monitoring.

TODO: please explain more. How does this work? Show an example.

Coming with the Dojo 1.2 release, Charting will also support customized events, such as tooltip attachment and mouseover actions!

==========================
Actions & Animated Effects
==========================

Actions are self-contained objects, which use events to implement certain effects when users interact with a chart. In general they are designed to attract attention and indicate which charting element is selected, or to show additional information.

While you can create your own actions, we took liberty to package some generally useful actions. The default library contains five classes: Highlight, Magnify, MoveSlice, Shake, and Tooltip. All of them take advantage of the Dojo animation support. It is the best to see them live on the demo page (it demonstrates examples of legends as well).

All actions except Tooltip support the following common keyword parameters:

+----------+----------+--------------------------+----------------------------------------------------------------------------------+
| **Name** | **Type** | **Default**              | **Description**                                                                  |
+----------+----------+--------------------------+----------------------------------------------------------------------------------+
| duration | Number   | 400 	                 |The time of effect in milliseconds.                                               |
+----------+----------+--------------------------+----------------------------------------------------------------------------------+
| easing   | Function |dojox.fx.easing.elasticOut|The easing function that specifies how controlled parameter changes over time.    |
+----------+----------+--------------------------+----------------------------------------------------------------------------------+

You can further experiment with easing functions at DojoCampus.

Highlight
---------

This action highlights (changes a color by modifying a fill) individual elements of a chart, when a user hovers over an element with the mouse. Affected elements include: markers, columns, bars, circles, and pie slices.

Highlight supports one additional parameter:

+-----------+-----------------------------------+----------------------------------+-------------------------------------------------------------------+
| **Name**  | **Type**                          | **Default**                      | **Description**                                                   |
+-----------+-----------------------------------+----------------------------------+-------------------------------------------------------------------+
| highlight | String, dojo.Color, or Function   | The default highlight function   | This parameter defines the highlight color for an individual      |
|           |                                   |                                  | element.                                                          |
+-----------+-----------------------------------+----------------------------------+-------------------------------------------------------------------+

The parameter can be any valid value for a color, e.g., “red”, “#FF0000″, “#F00″, [255, 0, 0], {r: 255, g: 0, b: 0}, and so on. In this case this color will be used to fill an element.

If the parameter is a function, it receives a charting event object (see the previous article for details), and should return a valid color.

The default highlight function uses special heuristics to select the highlight color. It makes it fully saturated, and light for dark colors, or dark for light colors. In many cases this default is more than adequate. But if you feel a need to implement a custom highlighting scheme, you can easily create your own function.

The picture below demonstrates Highlight (with a constant color) and Tooltip actions.

TODO: Highlight and Tooltip Example

Magnify
-------

This action magnifies an individual element of a chart, when users hover over them with the mouse. Affected elements include markers and circles.

Magnify supports one additional parameter:

+----------+----------+-------------+-------------------------------------------------------------------------------+
| **Name** | **Type** | **Default** | **Description**                                                               |
+----------+----------+-------------+-------------------------------------------------------------------------------+
|scale     |Number    |2 	    |The value to scale an element.                                                 |
+----------+----------+-------------+-------------------------------------------------------------------------------+

The picture below demonstrates Magnify and Tooltip actions.

TODO: Example Magnify and Tooltip

MoveSlice
---------

This action moves slices out from a pie chart, when users hover an element with the mouse.

MoveSlice supports the following parameters:

+----------+----------+-------------+-------------------------------------------------------------------------------+
| **Name** | **Type** | **Default** | **Description**                                                               |
+----------+----------+-------------+-------------------------------------------------------------------------------+
|scale     |Number    |1.5          |The value to scale an element.                                                 |
+----------+----------+-------------+-------------------------------------------------------------------------------+
|shift     |Number    |7 	    |The value in pixels to move an element from the center.                        |
+----------+----------+-------------+-------------------------------------------------------------------------------+

The picture below demonstrates MoveSlice, Highlight (with default highlighting parameter), and Tooltip actions.

TODO: MoveSlice, Highlight, and Tooltip Examples

Shake
-----

This action shakes charting elements, when users hover over an element with the mouse. Affected elements include markers, columns, bars, circles, and pie slices.

Shake supports the following parameters:

+----------+----------+-------------+-------------------------------------------------------------------------------+
| **Name** | **Type** | **Default** | **Description**                                                               |
+----------+----------+-------------+-------------------------------------------------------------------------------+
|shiftX    |Number    |3 	    |The maximal value in pixels to move an element horizontally during a shake.    |
+----------+----------+-------------+-------------------------------------------------------------------------------+
|shiftY    |Number    |3 	    |The maximal value in pixels to move an element vertically during a shake.      |
+----------+----------+-------------+-------------------------------------------------------------------------------+

Shake is a highly dynamic effect, so a picture cannot do a justice for it. Please go to the demo page and see it in action.

TODO: Shake Example

Tooltip
-------

This action shows a Tooltip, when users hover over a charting element with the mouse. Affected elements include markers, columns, bars, circles, and pie slices.

Tooltip supports the following keyword parameters:

+----------+------------+-----------------------------+-------------------------------------------------------------------------------+
| **Name** | **Type**   | **Default**                 | **Description**                                                               |
+----------+------------+-----------------------------+-------------------------------------------------------------------------------+
|text      |Function    |The default text function    |The function to produce a Tooltip text.                                        |
+----------+------------+-----------------------------+-------------------------------------------------------------------------------+

The default text function checks if a data point is an object, and uses an optional “Tooltip” member if available — this is a provision for custom Tooltips. Otherwise, it uses a numeric value. Tooltip text can be any valid HTML, so you can specify rich text multi-line Tooltips if desired.

The picture below demonstrates Tooltip, and Highlight actions.

TODO: Example Tooltip and Highlight

Using Actions
-------------

All action objects implement the following methods (no parameters are expected by these methods):

+----------------+----------------------------------------------------------------------------------------------------------------------------------+
| **Name**       | **Description**                                                                                                                  |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
| connect()      |Connect and start handling events. By default, when an action is created, it is connected.                                        | 
|                |You may need to call fullRender() on your chart object to activate the sending of messages.                                       |
|                |Typically you create an action object after you define plots, but before the first render() call; it takes care of everything.    |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|disconnect()    |Disconnect the event handler.                                                                                                     |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|destroy()       |Call this method when you want to dispose of your action. It disconnects from its event source and destroys all internal          |
|                |structures, if any, preparing to be garbage-collected.                                                                            |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+

All actions can be constructed like this:

.. code-block :: javascript
  :linenos:

  var a = new dojox.charting.action2d.Magnify(
    chart1, 
    "default", 
    {duration: 200, scale: 1.1});

The first parameter is a chart. The second parameter is the name of a plot. The third parameter is an object (property bag) with all relevant keyword parameters.

As you can see from the example above you can mixin several actions. In order to avoid unnecessary interference between actions, use your best judgment when selecting them. Try to avoid actions that modify the same visual attributes, like geometry. You can safely mix Tooltip, Highlight, and one geometric action (Magnify, MoveSlice, or Shake).

The Chart Widget
----------------

One of the easiest ways to use Dojo Charting is is to use the Chart2D widget. The example below is taken from the Dojo Chart2D widget test:

.. code-block :: html
  :linenos:

  <div dojoType="dojox.charting.widget.Chart2D" id="chart4"
      theme="dojox.charting.themes.PlotKit.green"
      style="width: 300px; height: 300px;">
    <div class="plot" name="default" type="Pie" radius="100"
        fontColor="black" labelOffset="-20"></div>
    <div class="series" name="Series C" store="tableStore" 
        valueFn="Number(x)"></div>
    <div class="action" type="Tooltip"></div>
    <div class="action" type="MoveSlice" shift="2"></div>
  </div>

Yes, it is that simple! just define a <div> with the class “action” and supply the type. If you want to specify a plot’s name, use the “plot” parameter: plot=”Plot1″. By default it will connect to the plot named “default”. If you want to change default keyword parameters, just add them to the <div>, e.g., duration=”500″.

The Chart Legend Widget
-----------------------
You can add a legend widget to your charts using dojox.charting.widget.Legend.  The legend automatically takes on the shape markers and colors of the chart to which it is attached. By default the Legend widget uses the “legend” parameter of a series. It reverts to the “name” parameter if legend is not specified.

For a pie chart, the behavior of a Legend is different: if the chart was specified with an array of numbers, it will use numbers. Otherwise it will check object properties in the following order: “legend”, “text”, and the numeric value.

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

Much of the information in the above article originally appeared first in the following articles, and excerpts have been used with permission from Sitepen.

* `A Beginner’s Guide to Dojo Charting, Part 1 of 2 <http://www.sitepen.com/blog/2008/06/06/a-beginners-guide-to-dojo-charting-part-1-of-2/>`_ by Doug McMaster
* `A Beginner’s Guide to Dojo Charting, Part 2 of 2 <http://www.sitepen.com/blog/2008/06/16/a-beginners-guide-to-dojo-charting-part-2-of-2/>`_ by Doug McMaster
* `Dojo Charting: Event Support Has Landed! <http://www.sitepen.com/blog/2008/05/27/dojo-charting-event-support-has-landed/>`_ by Eugene Latzukin
