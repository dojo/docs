#format dojo_rst


dojox.geo.charting.Map
======================

:Status: Draft
:Version: Experimental
:Project owner: Dean Williams
:Author: Qi Ruan
:Available: since V.1.5

.. contents::
   :depth: 2

Overview
--------

A dojo widget to render map information map "shapefile" data. 

.. code-block :: javascript
 :linenos:
    
 dojo.require("dojox.geo.charting.Map");

 dojo.addOnLoad(function(){
	var USStates = new dojox.geo.charting.Map("USStates", "../resources/data/USStates.json");
	USStates.setMarkerData("../resources/markers/USStates.json");
 });
 

.. code-block :: html
 :linenos:
 
 <h1>Simple Maps,support zoom in and zoom out.</h1>
 <div class="mapContainer" style="display:block;" id="USStates"></div>







fig 1.

.. cv-compound::
  :type: inline
  :height: 430
  :version: 1.4

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojox.widget.DataPresentation");
      dojo.require("dojox.charting.themes.Distinctive");

      var jsondata0 = {
	"title"  : "Softdrink Sales (2007)",
	"footer" : "North America only",
	"range"  : [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],
	"series" : [                            
		{ "legend" : "Cola", 		"values" : [  35, 37,  44, 41, 43,  57,  62,  69,  74,  86, 101, 124 ] },
		{ "legend" : "Lemonade", 	"values" : [ 122, 99, 111, 98, 82,  77,  76,  67,  72,  75,  66,  67 ] },
		{ "legend" : "Dandelion",	"values" : [  99, 98,  98, 99, 97, 102, 100,  99, 102,  97,  95,  98 ] },
		{ "legend" : "Ginger ale", 	"values" : [  54, 59,  76, 84, 98, 110, 126, 121, 115, 109, 104,  99 ] },
		{ "legend" : "Creme soda", 	"values" : [  44, 58,  44, 36, 48,  54,  34,  38,  24,  56,  48,  34 ] },
		{ "legend" : "Orangeade", 	"values" : [  45, 25,  45, 31, 42,  33,  49,  34,  46,  25,  44,  37 ] },
		{ "legend" : "Diet lemonade", 	"values" : [  34, 17,  38, 13, 33,  14,  22,  39,  26,  17,  35,  21 ] },
		{ "legend" : "Shandy", 		"values" : [  14, 23,  16, 32, 12,  24,  18,  25,  13,  33,  15,  25 ] }
		]
	};

      var makeseries = function(data) {
	return[ { datapoints: "range", name: "Month", type: "range", chart: false },
       		{ datapoints: "series[0].values", namefield: "series[0].legend" },
       		{ datapoints: "series[1].values", name: "Lemonade (fizzy)"      },
		{ datapoints: "series[2].values", namefield: "series[2].legend" },
       		{ datapoints: "series[3].values", namefield: "series[3].legend" }
      		];
	}


      var dp;

      dojo.addOnLoad(function() {

      dp = new dojox.widget.DataPresentation("chartdiv", {
		type: "chart",
		chartType: "ClusteredColumns",
		data: jsondata0,
		series: makeseries(jsondata0),
        	legendNode: "legenddiv",
                animate: true,
        	theme: "dojox.charting.themes.Distinctive"
		});
	});
    </script>

  .. cv:: html

    <div id="legenddiv"></div>
    <div id="chartdiv" style="width: 650px; height: 300px;"></div>  

  .. cv:: css

    <style type="text/css">

    </style>

   
