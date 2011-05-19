#format dojo_rst


dojox.geo.openlayers
====================

:Status: Draft
:Version: Experimental
:Project owner: Chris Mitchell
:Author: Marc Durocher
:Available: since V.1.7

.. contents::
   :depth: 2

Overview
--------

Dojo's dojox.geo.openlayers module provides a mapping component based on the OpenLayers (http://www.openlayers.org) library. This component is wrapper of the OpenLayers library with additional features such as displaying geo-referenced GFX shape and placing geo-referenced widgets on a background map. Two components are available : a div based component and a widget based component so you can either create a map in a programatic way or use markup to insert a map in a web page. 


Instantiate an OpenLayers Map component
---------------------------------------
You can either instantiate a OpenLayers Map component in a programmatic way or using a markup definition. In both cases, you will need to import the OpenLayers library. This library is available at the openlayers.org site.

Programmatic way of creating a Map component:

.. code-block :: javascript
 :linenos:
 
 <!-- Dojo -->
 <script type="text/javascript" src="path/to/dojo/dojo.js"></script>
 <!-- OpenLayers -->
 <script type="text/javascript" src="http://openlayers.org/api/OpenLayers.js"></script>
 
 <script type="text/javascript">
   require([ "dojox/geo/openlayers/Map" ], function(map){
     dojo.addOnLoad(function(){
       map = new dojox.geo.openlayers.Map("map");
       map.fitTo([ -160, 70, 160, -70 ]);
     });
   });
  </script>
  <div id="map" style="background-color: #b5d0d0; width: 100%; height: 100%;"></div>

Creating a Map using markup declaration:

.. code-block :: javascript
 :linenos:
 
 <!-- Dojo -->
 <script type="text/javascript" src="path/to/dojo/dojo.js"></script>
 <!--  OpenLayers -->
 <script type="text/javascript" src="http://openlayers.org/api/OpenLayers.js"></script>

 <script type="text/javascript">
   require(["dojox/geo/openlayers/Layer", "dojox/geo/openlayers/widget/Map", "dojo/parser" ], function(map){});
 </script>

 </head>
 <body class="tundra">
 <div id="map" dojoType="dojox.geo.openlayers.widget.Map" style="background-color: #b5d0d0; width: 100%; height: 100%;"></div>
 </body>

-- Changing the base layer type:

When creating a map, a base layer is automatically created. The default base layer type is an OpenSreetMap layer whose type is dojox.geo.openlayers.baseLayerType.OSM. It shows the background map by connecting to the OpenStreeMap server.
You can change the base layer type to access another map provider by calling setBaseLayerType or by setting the baseLayerType attribute on the widget's markup.

Available base layer types are :

  - dojox.geo.openlayers.BaseLayerType.OSM:           The Open Street Map base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.WMS:           The Web Map Server base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.GOOGLE: 	  The Google base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.VIRTUAL_EARTH: The Virtual Earth base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.BING :         Same as Virtual Earth
  - dojox.geo.openlayers.BaseLayerType.YAHOO: 	  The Yahoo Maps base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.ARCGIS:        The ESRI ARCGis base layer selector.

Note that if you attempt to access a mapping provider like Google Maps or Yahoo Maps, you will have to include the specific mapping provider API.
