## page was renamed from 1.2/quickstart/charting
#format dojo_rst

Dojo Charting
=============

:Status: Draft
:Version: 1.0
:Authors: Nikolai Onken, Marcus Reimann, Tom Trenka

.. contents::
    :depth: 2

Dojo comes with an amazing charting library, in the form of dojox.charting.  A large number of features are supported, with new ones being added constantly.

=====================
Supported chart types
=====================

At the time of writing, dojox.charting supports the following chart types:

* Line charts
* Bar charts
* Column charts
* Area charts
* Scatter plots
* Bubble plots
* Pie charts
* Stacked lines
* Stacked bars
* Stacked columns
* Stacked areas

...with more on the way.

The charting library is also very flexible in terms of combining chart types, as well as multiple axes. You can set up custom labels for a specific axis, you can set up custom markers for points on a number of different types of charts, and you can even create your own themes for a chart!

==========================
Updating charts and events
==========================

Charting was designed with periodic updating in mind.  Say you have an application that remotely monitors something: the stock market, a database server, etc. With dojox.charting, you can set up a chart and then simply update the series on the charts--resulting in a fast, fluid monitoring experience. In fact, charting has been used for such things as remote CPU monitoring.

Coming with the Dojo 1.2 release, Charting will also support customized events, such as tooltip attachment and mouseover actions!

==========
Animations
==========

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
