## page was renamed from 1.2/quickstart/charting
#format dojo_rst

Dojo Charting
=============

Dojo comes with an amazing charting library, in the form of dojox.charting.  A large number of features are supported, with new ones being added constantly.  At the time of writing, dojox.charting supports the following chart types:

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

Updating charts and events
--------------------------

Charting was designed with periodic updating in mind.  Say you have an application that remotely monitors something: the stock market, a database server, etc.  With dojox.charting, you can set up a chart and then simply update the series on the charts--resulting in a fast, fluid monitoring experience.  In fact, charting has been used for such things as remote CPU monitoring.

Coming with the Dojo 1.2 release, Charting will also support customized events, such as tooltip attachment and mouseover actions!

Examples
--------

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
          {y: 4, text: "Red",   color: "red",   stroke: "black", tooltip: "Red is 50%"},
          {y: 2, text: "Green", color: "green", stroke: "black", tooltip: "Green is 25%"},
          {y: 1, text: "Blue",  color: "blue",  stroke: "black", tooltip: "I am feeling Blue!"},
          {y: 1, text: "Other", color: "white", stroke: "black", tooltip: "Mighty <strong>strong</strong><br>With two lines!"}
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
