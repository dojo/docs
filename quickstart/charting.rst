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
