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
    
 new dojox.geo.charting.Map(container, shapeFile);
//	container:
//		map container html node/id
//	shapeFile:
//		map shape data url, handled as json style

shapeFile data format: 
{
//LayerExtent: Map boundary.
  "layerExtent":[0, 0, 8036, 5263],
//FeatureNames: Map unit name.
  "featureNames":["RI", "VT", "HI", "ME", "VA", "MI", "DE", "ID", "IA", "MD", "MA", "AR", "IL", "UT", "IN", "MN", "AZ", "MO", "MT", "MS", "NH", "NJ", "NM", "AK", "TX", "AL", "NC", "ND", "NE", "NY", "GA", "NV", "TN", "CA", "OK", "OH", "WY", "FL", "SD", "SC", "CT", "WV", "DC", "WI", "KY", "KS", "OR", "LA", "WA", "CO", "PA"],
//Features: Map unit shape info.  
"features":{
    "RI":{
	//shape: unit polygon point: [polygon_1, polygon_2, ...]; (polygon_1: [point1.x, point1.y, point2.x, point2.y, ...]; polygon_2:...)
      "shape":[[7641, 1436, 7651, 1437, 7661, 1467, 7661, 1467, 7653, 1478, 7641, 1436], [7541, 1398, 7559, 1392, 7598, 1380, 7615, 1420, 7635, 1430, 7635, 1431, 7627, 1445, 7626, 1427, 7615, 1429, 7607, 1410, 7618, 1435, 7606, 1444, 7617, 1460, 7618, 1506, 7612, 1496, 7568, 1527, 7568, 1526, 7541, 1398], [7633, 1474, 7639, 1442, 7645, 1476, 7631, 1485, 7633, 1474]],
	//center: shape's rect boundary center point.      
	"center":[7585, 1442],
	//bbox: shape's rect boundary.     
      "bbox":[7541, 1380, 120, 147]
    },
}
