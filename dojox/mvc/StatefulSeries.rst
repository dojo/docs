.. _dojox/mvc/StatefulSeries:

========================
dojox/mvc/StatefulSeries
========================

.. contents ::
  :depth: 2

dojox/mvc/StatefulSeries is a chart data plugin ("series") class that watches for properties specified in :ref:`dojox/mvc/at <dojox/mvc/at>` handles in the given data. At initialization, and when the properties are updated, creates the data from data given and updates the chart.

=====
Usage
=====

In below example, the chart changes from 25%/25%/50% to 10%/10%/80%, as the data model changes:

.. code-example::
  :djConfig: async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 320
  :height: 320

  .. js ::

    require([
        "dojox/charting/Chart",
        "dojox/charting/themes/PlotKit/blue",
        "dojox/mvc/at",
        "dojo/Stateful",
        "dojox/mvc/StatefulSeries",
        "dojox/charting/plot2d/Pie",
        "dojo/domReady!"
    ], function(Chart, blue, at, Stateful, StatefulSeries){
        var model = new Stateful({
            First: 25,
            Second: 25,
            Third: 50
        });
        new Chart("chart")
         .setTheme(blue)
         .addPlot("default", {type: "Pie"})
         .addSeries("default", new StatefulSeries([
            at(model, "First"),
            at(model, "Second"),
            at(model, "Third")
        ])).render();
        setTimeout(function(){
            model.set("First", 10);
            model.set("Second", 10);
            model.set("Third", 80);
        }, 2000);
    });

  .. html ::

    <div id="chart"></div>
