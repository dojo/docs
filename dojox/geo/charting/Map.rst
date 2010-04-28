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

'Series' function This function is used to parse the above data and define which series and which properties are to be used for the chart. 
