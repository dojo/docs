.. _dojox/geo/charting/Map:


dojox.geo.charting.Map
======================

:Project owner: Dean Williams
:Author: Qi Ruan
:since: V.1.5

.. contents ::
   :depth: 2

Overview
--------

A dojo widget to render map information "shapefile" data.

.. js ::
     
 dojo.require("dojox.geo.charting.Map");

 dojo.ready(function(){
    var USStates = new dojox.geo.charting.Map("USStates", "../resources/data/USStates.json");
    USStates.setMarkerData("../resources/markers/USStates.json");
 });
 

.. html ::
  
 <h1>Simple Maps, support zoom in and zoom out.</h1>
 <div class="mapContainer" style="display:block;" id="USStates"></div>




fig 1. Map (Click on map)

.. code-example ::
  :type: inline
  :height: 430
  :version: 1.4

  .. html ::

    <iframe width='100%'  height='320px' src="http://www-01.ibm.com/software/ucd/dojo/dojox/geo/charting/tests/test_maps.html"></iframe>


fig 2. Map with associated DataChart (Click on map)

.. code-example ::
  :type: inline
  :height: 430
  :version: 1.4

  .. html ::

    <iframe width='100%'  height='320px' src="http://www-01.ibm.com/software/ucd/dojo/dojox/geo/charting/tests/test_mapWithCharting.html"></iframe>


fig 3. Map with Legend (Click on map)

.. code-example ::
  :type: inline
  :height: 430
  :version: 1.4

  .. html ::

    <iframe width='100%'  height='320px' src="http://www-01.ibm.com/software/ucd/dojo/dojox/geo/charting/tests/test_mapWithLegend.html"></iframe>
  
