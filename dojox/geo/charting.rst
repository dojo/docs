#format dojo_rst


dojox.geo.charting
==================

:Status: Draft
:Version: Experimental
:Project owner: Dean Williams
:Author: Qi Ruan, Erwan Aullas
:Available: since V.1.5

.. contents::
   :depth: 2

Overview
--------

The dojox.geo.charting module contains classes to display geographical map together with charting data.
Map elements are colorized according to their value (fetched from a dojo DataStore) and a color scheme
(the 'series') that defines colors for value ranges.

The map data to supply to the component must be either a Json object containing data in shapefile format, or a file containing a Json dump of such object.

The charting data to supply must be available as a dataStore object implementing dojo.data.api.Read and dojo.data.api.Identity APIs

The data series (i.e. the color scheme for different value ranges)  is also a Json object of Json file described below.

Two Dijits components are provided, one acting a a widget wrapper for the Map component, the other as a legend explaining map colors.

Several interactor classes can be installed on the Map component, to allow navigation - mainly zoom,pan and select - on different hardware configurations :


  - mouse interactor for usual desktop use
  - keyboard interactor for accessibility purposes 
  - touch interactor (for touch devices)


Instantiate Map component
-------------------------

First, instantiate the Map component, and associate it with the DOM Node container 'USStates' declared further in the HTML markup.

.. code-block :: javascript
 :linenos:
    
 require(["dojox/geo/charting/Map",function(){
	dojo.ready(function(){
		//create new map
		var map = new dojox.geo.charting.Map("USStates", "../resources/data/USStates.json");
		//add outside map marker file
		map.setMarkerData("../resources/markers/USStates.json");
	});
 });

 
The setMarkerData function is used to supply a Json file containing tooltips for map elements. For instance :
{"AK":"Alaska","AZ":"Arizona","AR":"Arkansas" 
Each map element is referenced in the marker json object by its unique id (defined in the json map data, and also used in the dataStore that contains charting values).

Declare the markup container node for the Map component :

.. code-block :: html
 :linenos:
 
 <h1>Simple Maps,support zoom in and zoom out.</h1>
 <div class="mapContainer" style="display:block;" id="USStates"></div>

Here is a basic demo:

.. code-example::
  :type: inline
  :height: 340
  :width: 520
  :toolbar: versions

  .. html::

    <div class="mapContainer" style="display:block;" id="USStates"></div>

  .. javascript::

    <script type="text/javascript">
      dojo.require("dojox.geo.charting.Map");
      dojo.addOnLoad(function(){

		var dataOk = function(data) {console.log("received data");};
		var fileUrl = dojo.moduleUrl('dojox.geo.charting', 'resources/data/USStates.json');
		var file2Url = dojo.moduleUrl('dojox.geo.charting', '_Feature.xd.js');
			
		console.log(""+fileUrl);
		console.log(""+file2Url);

		dojo.xhrGet({
			url: file2Url ,
			
			handleAs: "javascript",
			load: "dataOk"
		});

		//create new map
		var map = new dojox.geo.charting.Map("USStates",  dojo.moduleUrl('dojox.geo.charting', 'resources/data/USStates.json'));
		//add outside map marker file
		map.setMarkerData(dojo.moduleUrl('dojox.geo.charting', 'resources/markers/USStates.json'));
		// install mouse navigation
		map.fitToMapContents();
	});
   </script>

Data binding
------------

The purpose of this Map component is to represent figures on a map. Hence the need for connecting the component with a dataStore object.

Here, we extend the previous code sample to illustrate how to connect to data :

.. code-block :: javascript
 :linenos:

 require(["dojox/geo/charting/Map","dojo.data.ItemFileWriteStore",function(){
	dojo.ready(function(){
		//create new map
		var map = new dojox.geo.charting.Map("USStates", "../resources/data/USStates.json");
		//add outside map marker file
		map.setMarkerData("../resources/markers/USStates.json");
				
		//instantiate a dataStore
		var dataStore = new dojo.data.ItemFileWriteStore({
			url: "datastore/dataStore.json"
		});
								
		// set it on the map
		map.setDataStore(dataStore, "product A");

		// associate with series (i.e. color scheme)
		map.addSeries("../resources/data/series.json");
	});
 });
    

The above call to setDataStore on the map implicitely calls setDataBindingAttribute with "product A" value (passed in parameter). This tells the Map component
what property value of dataStore items should be used to set the value on map elements (aka Feature instances).

Here we look for the "product A" property of dataStore items (one item per US State in this example) to fetch the sales figures for product A, and colorize the map according to those values.

The coloring is done via the addSeries call, that reads a color sheme from a Json file or object.

Here is an example of a series object :

.. code-block :: javascript
 :linenos:

 {
	"series": [{
		name: "Low sales state(0~$3.0M)",
		min: "0.0",
		max: "3.0",
		color: "#FFCE52"
	},
	{
		name: "Normal sales state($3.0M~$6.0M)",
		min: "3.0",
		max: "6.0",
		color: "#63A584"
	},
	{
		name: "High sales state($6.0M~$10.0M)",
		min: "6.0",
		max: "9.0",
		color: "#CE6342"
	}]
 }


Interacting with the Map
------------------------

Here, we instantiate the appropriate interactors and connect them to the Map component. For example (extending previous code samples)  :

.. code-block :: javascript
 :linenos:

 require(["dojox/geo/charting/Map",
	  "dojox.geo.charting.MouseInteractionSupport",
	  "dojox.geo.charting.KeyboardInteractionSupport",function(){
	dojo.ready(function(){
		//create new map
		var map = new dojox.geo.charting.Map("USStates", "../resources/data/USStates.json");
		//add outside map marker file
		map.setMarkerData("../resources/markers/USStates.json");
				
		// install mouse navigation
		var mouseInteraction =
			new dojox.geo.charting.MouseInteractionSupport(map,{enablePan:true,enableZoom:true});
		mouseInteraction.connect();
		// install keyboard navigation
		var keyboardInteraction = new dojox.geo.charting.KeyboardInteractionSupport(map, {enableZoom: true});
        	keyboardInteraction.connect();
	});
 });

The interactors can be configured via the object passed as second parameter. Please refer to API documentation for further details.

Using Dijits
------------

Two Dijits are provided in this module : dojox.geo.charting.widget.Map and dojox.geo.charting.widget.Legend

the Map widget wraps an above Map component to ease its integration along other Dijits.
It can be fully configured in the markup declaration

.. code-block :: html
 :linenos:
 
 <div id="mapWidget" dojoType="dojox.geo.charting.widget.Map" 
	shapeData="resources/data/US_States_intermediate.json"
	dataStore="csvStore" series="resources/data/series.json"  markerData="resources/data/markers.json" showTooltips="false"
	animateOnResize="false" colorAnimationDuration="300"
	adjustMapCenterOnResize="true" adjustMapScaleOnResize="true" dataBindingAttribute="2009"
	dataBindingValueFunction="getPopulationForYear"  enableMouseSupport="true"
	enableMousePan="true" enableMouseZoom="true"
	onFeatureClick="onFeatureClick" enableFeatureZoom="false" enableTouchSupport="true"
	style="height: 100%; width: 100%;">
 </div>

Legend, as its name supposes, displays a legend describing map color scheme.

.. code-block :: html
 :linenos:
 
 <div id="mapLegend" dojoType="dojox.geo.charting.widget.Legend" map="dijit.byId('mapWidget').getInnerMap()"
	swatchSize="10" horizontal="false">
 </div> 

The map attribute connects this Legend Dijit to the above Map Dijit inner map.
