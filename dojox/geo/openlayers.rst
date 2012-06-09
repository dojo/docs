.. _dojox/geo/openlayers:


dojox.geo.openlayers
====================

:Project owner: Chris Mitchell
:Author: Marc Durocher
:since: V.1.7

.. contents ::
   :depth: 3

Overview
--------

Dojo's dojox.geo.openlayers module provides a mapping component based on the OpenLayers (http://www.openlayers.org) library. This component is mainly a wrapper of the OpenLayers library with additional features such as displaying geo-referenced GFX shape and placing geo-referenced widgets on a background map. Two components are available : a div based component and a widget based component so you can either create a map in a programmatic way or use markup to insert a map in a web page.

This Map component is intended to display a background map with graphical GFX or widget overlay. The background map can come from various online map providers such as OpenStreetMap, Google Maps of ESRI Maps. Note that you may have to include specific map provider javascript library in order to have access to the corresponding mapping service.

In any cases, you will have to include the OpenLayers library in order to use the dojox.geo.openlayers module.

Instantiate an OpenLayers Map component
---------------------------------------

You can either instantiate a OpenLayers Map component in a programmatic way or using a markup definition. In both cases, you will need to import the OpenLayers library. This library is available at the openlayers.org site and you can include it in your page with the following script tag :

.. html ::

    <script type="text/javascript" src="http://openlayers.org/api/OpenLayers.js"></script>

Here are some examples of how to create a basic OpenLayers Map component :

Programmatic way of creating a Map component:

.. js ::

       require(["dojo/ready", "dojox/geo/openlayers/Map" ], function(ready, Map){
         ready(function(){
           map = new Map("map");
           map.fitTo([ -160, 70, 160, -70 ]);
         });
       });

.. html ::

      <div id="map" style="background-color: #b5d0d0; width: 100%; height: 100%;"></div>

Creating a Map using markup declaration:

.. js ::

       require(["dojox/geo/openlayers/Layer", "dojox/geo/openlayers/widget/Map", "dojo/parser" ], function(map){});

.. html ::

      <div id="map" data-dojo-type="dojox.geo.openlayers.widget.Map" style="background-color: #b5d0d0; width: 100%; height: 100%;"></div>

Changing the base layer type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When creating a map, a background base layer is automatically created. The default base layer type is an OpenSreetMap layer whose type is dojox.geo.openlayers.baseLayerType.OSM. It shows the background map by connecting to the OpenStreeMap server.
You can change the base layer type to access another map provider by calling setBaseLayerType or by setting the baseLayerType attribute on the widget's markup.

Available base layer types are :

  - dojox.geo.openlayers.BaseLayerType.OSM:           The Open Street Map base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.WMS:           The Web Map Server base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.GOOGLE:        The Google base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.VIRTUAL_EARTH: The Virtual Earth base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.BING :         Same as Virtual Earth
  - dojox.geo.openlayers.BaseLayerType.YAHOO:         The Yahoo Maps base layer type selector.
  - dojox.geo.openlayers.BaseLayerType.ARCGIS:        The ESRI ARCGis base layer selector.

Note that if you attempt to access a mapping provider like Google Maps or Yahoo Maps, you will have to include the specific mapping provider API in your application.

Here are the JavaScript API needed to access specific map provider :

 - Google API:

   .. html ::

        <script src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>

 - Microsoft Virtual Hearth:

   .. html ::

         <script src='http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.3'></script>

 - Yahoo Maps:

   .. html ::

         <script src="http://api.maps.yahoo.com/ajaxymap?v=3.0&appid=euzuro-openlayers"></script>

Some examples of how to set/change the base layer type:

.. js ::

        var map;

        require(["dojo/ready", "dojo/dom", "dojox/geo/openlayers/Map", "dijit/form/RadioButton"],
                function(ready, dom, Map, RadioButton){
          ready(function(){
              map = new Map("map", {
                baseLayerType : dojox.geo.openlayers.BaseLayerType.ARCGIS
              });
              map.fitTo([ -160, 70, 160, -70 ]);
          });
        });

        function layerType(id){
          var i = dom.byId(id);
          var v = i.value;
          map.setBaseLayerType(v);
        }

.. html ::

      <input type="radio" data-dojo-type="dijit.form.RadioButton" id="osm" name="layertype" value="OSM" onClick="layerType('osm')" />
      <input type="radio" checked data-dojo-type="dijit.form.RadioButton" id="arcgis" name="layertype" value="ArcGIS" onClick="layerType('arcgis')" />

      <div id="map" style="background-color: #b5d0d0; width: 100%; height: 100%;"></div>

Specifying the displayed part of the map
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can define the initial location and extent of map that is displayed by using the fitTo method of the map. This method can take several type of arguments such as extent to be displayed or the initial location.
You can also define the initial location as markup attribute if you use the markup widget version of the map component.
Initial location ca be in the form of :

.. js ::

    { bounds : [ulx, uly, lrx, lry] }

The map is fit on the specified bounds expressed as decimal degrees latitude and longitude. The bounds are defined with their upper left and lower right corners coordinates.

.. js ::

    { position : [longitude, latitude], extent : degrees }

The map is fit on the specified position showing the extent <extent> around the specified center position.

Programmatic version:

.. js ::
  
  require(["dojo/ready", "dojox/geo/openlayers/Map"], function(ready, Map){

    ready(function(){
      var map = new Map("map");
      // This is New York location
      var ny = {
        latitude : 40.71427,
        longitude : -74.00597
      };
      // fit to New York with 0.1 degrees extent
      map.fitTo({
        position : [ ny.longitude, ny.latitude ],
        extent : 0.1
      });
    });
  });

.. html ::

    <div id="map" style="background-color: #b5d0d0; width: 100%; height: 100%;"></div>

Markup version:

.. js ::
   
    require(["dojo/parser", "dojox/geo/openlayers/widget/Map" ], function(){});

.. html ::

    <div id="map" data-dojo-type="dojox.geo.openlayers.widget.Map"
                  initialLocation="{position : [ -74.00597, 40.71427 ], extent : 0.1 }"
                  style="background-color: #b5d0d0; width: 100%; height: 100%;">
    </div>


Positioning shapes on the map
-----------------------------

The OpenLayers mapping component allows to position GFX shapes on the map at specified locations. The location of the shape is specified as longitude and latitude coordinates. To place such a shape on the map, you will need to insert a dedicated dojox.geo.openlayer.GfxLayer layer in the map and add dojox.geo.openlayers.GeometryFeature s to it. The GeometryFeature class defines the position and the type of shape to display.

The following code shows how to display a point at the New York location. A circle is displayed as it is the default GFX shape to be displayed for a Point geometry.

.. js ::
   
    require(["dojo/ready", "dojox/geo/openlayers/Map", "dojox/geo/openlayers/GfxLayer",
              "dojox/geo/openlayers/GeometryFeature", "dojox/geo/openlayers/Point" ],
         function(ready, Map, GfxLayer, GeometryFeature, Point){
  
      ready(function(){
        // create a map widget.
        var map = new Map("map");
       // This is New York
        var ny = {
          latitude : 40.71427,
          longitude : -74.00597
        };
        // create a GfxLayer
        var layer = new GfxLayer();
        // create a Point geometry at New York location
        var p = new Point({x:ny.longitude, y:ny.latitude});
        // create a GeometryFeature
        var f = new GeometryFeature(p);
        // set the shape properties, fill and stroke
        f.setFill([ 0, 128, 128 ]);
        f.setStroke([ 0, 0, 0 ]);
        f.setShapeProperties({
          r : 20
        });
        // add the feature to the layer
        layer.addFeature(f);
        // add layer to the map
        map.addLayer(layer);
        // fit to New York with 0.1 degrees extent
        map.fitTo({
        position : [ ny.longitude, ny.latitude ],
                     extent : 0.1
        });
      });
    });

You can also place polylines on the map. In this case, you will need to create a dojox.geo.openlayers.LineString geometry so that the points defining the polyline are geo-referenced. The following example shows how to create a polyline joining some major towns of the world.

.. js ::
   
    require(["dojo/ready", "dojox/geo/openlayers/Map", "dojox/geo/openlayers/GfxLayer",
             "dojox/geo/openlayers/GeometryFeature", "dojox/geo/openlayers/LineString"],
             function(ready, Map, GfxLayer, GeometryFeature, LineString){

       var towns = [ {
          name : 'Sydney',
          x : 151.20732,
          y : -33.86785
       }, {
          name : 'Shanghai',
          x : 121.45806,
          y : 31.22222
       }, {
          name : 'Moscow',
          x : 37.61556,
          y : 55.75222
       }, {
          name : 'London',
          x : -0.12574,
          y : 51.50853
       }, {
          name : 'Toronto',
          x : -79.4163,
          y : 43.70011
       }, {
          name : 'Buenos Aires',
          x : -58.37723,
          y : -34.61315
       }, {
          name : 'Kinshasa',
          x : 15.32146,
          y : -4.32459
       }, {
          name : 'Cairo',
          x : 31.24967,
          y : 30.06263
       } ];

       ready(function(){
            // create a map widget and place it on the page.
            var map = new Map("map");
            // create a GfxLayer
            var layer = new GfxLayer();
            // towns objects already have a x and y field.
            var pts = new LineString(towns);
            // create a GeometryFeature
            var f = new GeometryFeature(pts);
            // set the shape stroke property
            f.setStroke([ 0, 0, 0 ]);
            // add the feature to the layer
            layer.addFeature(f);
            // add layer to the map
            map.addLayer(layer);
       });
    });

You can also place combination of geometries using a dojox.geo.openlayers.Collection geometry which can hold any combination of existing geometries. Here is an example that shows how to use this collection geometry:

.. js ::
  
   require(["dojo/_base/array", "dojo/ready",
                "dojox/geo/openlayers/Map", "dojox/geo/openlayers/GfxLayer",
             "dojox/geo/openlayers/GeometryFeature", "dojox/geo/openlayers/Collection",
             "dojox/geo/openlayers/Linestring", "dojox/geo/openlayers/Point"],
         function(array, ready, Map, GfxLayer, GeometryFeature, Collection, LineString, Point){
     var towns = [ {
       name : 'Sydney',
       x : 151.20732,
       y : -33.86785
     }, {
     name : 'Shanghai',
       x : 121.45806,
       y : 31.22222
     }, {
     name : 'Moscow',
       x : 37.61556,
       y : 55.75222
     }, {
     name : 'London',
       x : -0.12574,
       y : 51.50853
     }, {
     name : 'Toronto',
       x : -79.4163,
       y : 43.70011
     }, {
     name : 'Buenos Aires',
       x : -58.37723,
       y : -34.61315
     }, {
     name : 'Kinshasa',
       x : 15.32146,
       y : -4.32459
     }, {
     name : 'Cairo',
       x : 31.24967,
       y : 30.06263
     } ];

     ready(function(){
       // create a map widget and place it on the page.
       var map = new Map("map");
      // create a GfxLayer
      var layer = new GfxLayer();
      // The array of geometries
      var a = [];
      // towns objects already have a x and y field.
      var pts = new LineString(towns);
      a.push(pts);
      // make a point for each line.
      array.forEach(towns, function(t){
        var p = new Point(t);
        a.push(p);
     });
     var col = new Collection(a);
     // create a GeometryFeature
     var f = new GeometryFeature(col);
     // set the shape properties, fill and stroke
     f.setStroke([ 0, 0, 0 ]);
     f.setShapeProperties({
       r : 10
     });
     // add the feature to the layer
     layer.addFeature(f);
     // add layer to the map
     map.addLayer(layer);
     // fit to New York with 0.1 degrees extent
   });
 });

You also might want to display a specific shape on the map. For that, you can redefine the `createShape` function of the GeometryFeature and create the shape you want. This methods takes the dojox.gfx.Surface as parameter that can be used to create the shape.

Example that shows a star at Paris location:

.. js ::
  
  require(["dojo/ready", "dojox/geo/openlayers/Map", "dojox/geo/openlayers/GfxLayer",
      "dojox/geo/openlayers/Point", "dojox/geo/openlayers/GeometryFeature"],
      function(ready, Map, GfxLayer, Point, GeometryFeature){

    ready(function(){

      // create a map widget and place it on the page.
      var map = new Map("map");

      // This Paris

      var paris = {
        latitude : 48.866667,
        longitude : 2.333333
      };
      // create a GfxLayer
      var layer = new GfxLayer();
      // create a OpenLayers Point geometry at New York location
      var p = new Point({
        x : paris.longitude,
        y : paris.latitude
      });
      // create a GeometryFeature
      var f = new GeometryFeature(p);
      // create a star graphic
      f.createShape = myCreateShape;
      f.setStroke([ 0, 0, 0 ]);
      f.setFill([ 0, 128, 128 ]);
      // add the feature to the layer
      layer.addFeature(f);
      // add layer to the map
      map.addLayer(layer);
      // fit to Paris with 0.1 degrees extent
      map.fitTo({
        position : [ paris.longitude, paris.latitude ],
        extent : 0.1
      });
    });

    function myCreateShape(s){
      var r1 = 20;
      var r2 = 50;
      var branches = 10;
      var start = 2;
      console.log("create star " + r1);
      var star = makeStarShape(r1, r2, branches, start);
      var path = s.createPath();
      path.setShape({
        path : star
      });
      return path;
    }

    function makeStarShape(r1, r2, b, start){
      var precision = 2;
      var TPI = Math.PI * 2;
      var di = TPI / b;
      if(!start)
        start = Math.PI;
      var s = null;
      var end = start + TPI;
      for( var i = start; i < end; i += di){
        var c1 = Math.cos(i);
        var s1 = Math.sin(i);
        var i2 = i + di / 2;
        var c2 = Math.cos(i2);
        var s2 = Math.sin(i2);
        if(s == null){
          s = "M" + (s1 * r1).toFixed(precision) + "," + (c1 * r1).toFixed(precision) + " ";
        }else{
          s += "L" + (s1 * r1).toFixed(precision) + "," + (c1 * r1).toFixed(precision) + " ";
        }
        s += "L" + (s2 * r2).toFixed(precision) + "," + (c2 * r2).toFixed(precision) + " ";
      }
      s += "z";
      return s;
    }
  });


The styling of the GFX shapes is done through the setFill and setStroke methods of the GeometryFeature class. These fill and stroke parameters are simply passed to the shape at display time and depend on the kind of shape displayed.

The shape can also be configured a with the setShapeProperties method. These properties are passed to the GFX shape object via the setShape method of the GFX shape so the two following code segments are equivalent.

.. js ::
  
 var f = new dojox.geo.openlayers.GeometryFeature(p);
 // create a graphic as a group
 f.createShape = function(s){
   return s.createPath();
 };
 var star = makeStarShape(20, 50, 10, 2);
 f.setShapeProperties({
  path : star
 });

.. js ::
  
 var f = new dojox.geo.openlayers.GeometryFeature(p);
 // create a graphic as a group
 f.createShape = function(s){
   var path = s.createPath();
   var star = makeStarShape(20, 50, 10, 2);
   path.setShape({
     path : star
   });
   return path;
 };

Positioning widgets on the map
------------------------------

The OpenLayers Map component allows to position dijit widgets on the map. To do that, the widget must be described with a dojox.geo.openlayers.WidgetFeature class. The descriptor of the widget includes the creation method of the widget and the coordinates at which the widget should be positioned. Once created with the widget descriptor, the WidgetFeature has to be added in a layer to be displayed.

The descriptor passed to the Widget feature is an object containing the following fields:

 - createWidget: Function for widget creation. Must return a `dijit._Widget`.
 - data-dojo-type: The class of a widget to create;
 - dijitId: The digitId of an existing widget.
 - widget: An already created widget.
 - width: The width of the widget.
 - height: The height of the widget.
 - longitude: The longitude, in decimal degrees where to place the widget.
 - latitude: The latitude, in decimal degrees where to place the widget.

Here is an example that shows a pie chart at New York location:

.. js ::
  
  require([ "dojo/ready", "dojo/dom-construct", "dojo/_base/window",
      "dojox/geo/openlayers/Map", "dojox/geo/openlayers/Layer",
      "dojox/geo/openlayers/WidgetFeature", "dojox/charting/widget/Chart",
      "dojox/charting/widget/Chart2D", "dojox/charting/plot2d/Pie",
      "dojox/charting/themes/PlotKit/blue" ],
              function(ready, win, domConstruct, Map, Layer, WidgetFeature, Chart, Chart2D, Pie, blue){
    ready(function(){

      // create a map widget and place it on the page.
      var map = new Map("map");
      
      // This is New York
      var ny = {
        latitude : 40.71427,
        longitude : -74.00597
      };

      var div = domConstruct.create("div", {}, win.body());
      var chart = new Chart({
        margins : {
          l : 0,
          r : 0,
          t : 0,
          b : 0
        }
      }, div);
      var c = chart.chart;
      c.addPlot("default", {
        type : "Pie",
        radius : 50,
        labelOffset : 100,
        fontColor : "black",
        fontSize : 20
      });

      var ser = [ 2, 8, 12, 3 ];
      c.addSeries("Series", ser);
      c.setTheme(blue);
      c.render();
      c.theme.plotarea.fill = undefined;

      var descr = {
        longitude : ny.longitude,
        latitude : ny.latitude,
        widget : chart,
        width : 120,
        height : 120
      };
      feature = new WidgetFeature(descr);

      layer = new Layer();
      layer.addFeature(feature);
      map.addLayer(layer);
      // fit to New York with 0.1 degrees extent
      map.fitTo({
        position : [ ny.longitude, ny.latitude ],
        extent : 0.1
      });
    });
  });
