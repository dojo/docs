## page was renamed from 1.2/quickstart/charting
#format dojo_rst

Dojo Charting
=============

Dojo comes with an amzing charting library.

Examples
--------

Here is a very simple example from plain markup

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.charting.Chart2D");
    dojo.require("dojox.charting.themes.Wetland");

    dojo.addOnLoad(function(){
      var chart3 = new dojox.charting.Chart2D("chartOne");
      chart3.addPlot("default", {type: "Areas", tension:2.5})
          .setTheme(dojox.charting.themes.Wetland);
          .addSeries("Series A", [1, 2, 0.5, 1.5, 1, 2.8, 0.4]);
          .addSeries("Series B", [2.6, 1.8, 2, 1, 1.4, 0.7, 2]);
          .addSeries("Series C", [6.3, 1.8, 3, 0.5, 4.4, 2.7, 2]);
          .render();
    });
    </script>

  .. cv:: html

    <div id="chartOne" style="width: 400px; height: 240px;"></div>
