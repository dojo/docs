#format dojo_rst


dojox.widget.DataPresentation
=============================

:Status: Draft
:Version: Experimental
:Project owner: Dean Williams
:Author: Dave Clark
:Available: since V.1.4

.. contents::
   :depth: 2

Overview
--------

DataPresentation is a widget that connects to a data store in a simple manner, and also provides some additional convenience mechanisms for connecting to common data sources without needing to explicitly construct a Dojo data store. 

The widget can then present the data in several forms: as a graphical chart, as a tabular grid, or as display panels presenting meta-data (title, creation information, etc) from the data. 

The widget can also create and manage several of these forms in one simple construction. 
		

Example 1.
~~~~~~~~~~

.. code-block :: html
 :linenos:
 
 <div id="myChartNode" style="width: 600px; height: 400px;"></div>
 <div id="myGridNode"  style="width: 600px; height: 400px;"></div>
 
 
.. code-block :: javascript
 :linenos:
 
 dojo.require("dojox.widget.DataPresentation");

 var pres = new dojox.widget.DataPresentation("myChartNode", {
		type: "chart",
		url: "/data/mydata",   // see example below
		gridNode: "myGridNode"
	});
 


fig 1.

.. image:: datapres_example_1.png


Properties
----------

store: Object
~~~~~~~~~~~~~
 Dojo data store used to supply data to be presented. This may be supplied on construction or created implicitly based on other construction parameters.

query: String
~~~~~~~~~~~~~
 Query to apply to the Dojo data store used to supply data to be presented.
		
queryOptions: String
~~~~~~~~~~~~~~~~~~~~
 Query options to apply to the Dojo data store used to supply data to be presented.
		
data: Object
~~~~~~~~~~~~
 Data to be presented. If supplied on construction this property will override any value supplied for the 'store' property.
		
url: String
~~~~~~~~~~~
 URL to fetch data from in JSON format. If supplied on construction this property will override any values supplied for the 'store' and/or 'data' properties.
		
refreshInterval: Number
~~~~~~~~~~~~~~~~~~~~~~~
 The time interval in milliseconds after which the data supplied via the 'data' property or fetched from a URL via the 'url' property should be regularly refreshed. This property is ignored if neither the 'data' nor 'url' property has been supplied. If the refresh interval is zero, no regular refresh is done.
		
refreshIntervalPending:
~~~~~~~~~~~~~~~~~~~~~~~
 The JavaScript set interval currently in progress, if any

series: Array
~~~~~~~~~~~~~
 An array of objects describing the data series to be included in the data presentation. Each object may contain the following fields:

  datapoints: the name of the field from the source data which contains an array of the data points for this data series. If not supplied, the source data is assumed to be an array of data points to be used.

  field: the name of the field within each data point which contains the data for this data series. If not supplied, each data point is assumed to be the value for the series.

  name: a name for the series, used in the legend and grid headings

  namefield: the name of the field from the source data which contains the name the series, used in the legend and grid headings. If both name and namefield are supplied, name takes precedence. If neither are supplied, a default name is used.

  chart: true if the series should be included in a chart presentation (default: true)

  charttype: the type of presentation of the series in the chart, which can be "range", "line", "bar" (default: "bar")

  axis: the dependant axis to which the series will be attached in the chart, which can be "primary" or "secondary" 

  grid: true if the series should be included in a data grid presentation (default: true)

  gridformatter: an optional formatter to use for this series in the data grid
		
 a call-back function may alternatively be supplied. The function takes a single parameter, which will be the data (from the 'data' field or      loaded from the value in the 'url' field), and should return the array of objects describing the data series to be included in the data 	      presentation. This enables the series structures to be built dynamically after data load, and rebuilt if necessary on data refresh. The call-back       function will be called each time new data is set, loaded or refreshed. A call-back function cannot be used if the data is supplied directly 	      from a Dojo data store.



		
type: String
~~~~~~~~~~~~
 The type of presentation to be applied at the DOM attach point. This can be 'chart', 'legend', 'grid', 'title', 'footer'. 
 The default type is 'chart'.
		
chartType: String
~~~~~~~~~~~~~~~~~
 The type of chart to display. This can be 'clusteredbars', 'areas', 'stackedcolumns', 'stackedbars', 'stackedareas', 'lines', 'hybrid'. 
 The default type is 'bar'.

reverse: Boolean
~~~~~~~~~~~~~~~~
 true if the chart independent axis should be reversed.

labelMod: Integer
~~~~~~~~~~~~~~~~~
 The frequency of label annotations to be included on the independent axis. 1=every label. 
 The default is 1.
		
legendVertical: Boolean
~~~~~~~~~~~~~~~~~~~~~~~
 true if the legend should be rendered vertically. 
 The default is false (legend rendered horizontally).

theme: String|Theme
~~~~~~~~~~~~~~~~~~~
 A theme to use for the chart, or the name of a theme.
		
chartNode: String|DomNode
~~~~~~~~~~~~~~~~~~~~~~~~~
 An optional DOM node or the id of a DOM node to receive a chart presentation of the data. Supply only when a chart is required and the type is not 'chart'; when the type is 'chart' this property will be set to the widget attach point.
		
legendNode: String|DomNode
~~~~~~~~~~~~~~~~~~~~~~~~~~
 An optional DOM node or the id of a DOM node to receive a chart legend for the data. Supply only when a legend is required and the type is not legend'; when the type is 'legend' this property will be set to the widget attach point.
		
gridNode: String|DomNode
~~~~~~~~~~~~~~~~~~~~~~~~
 An optional DOM node or the id of a DOM node to receive a grid presentation of the data. Supply only when a grid is required and the type is not 'grid'; when the type is 'grid' this property will be set to the widget attach point.
		
titleNode: String|DomNode
~~~~~~~~~~~~~~~~~~~~~~~~~
 An optional DOM node or the id of a DOM node to receive a title for the data. Supply only when a title is 		      required and the type is not 'title'; when the type is 'title' this property will be set to the widget attach point.
		
footerNode: String|DomNode
~~~~~~~~~~~~~~~~~~~~~~~~~~
 An optional DOM node or the id of a DOM node to receive a footer presentation of the data. Supply only when a footer is required and the type is not 'footer'; when the type is 'footer' this property will be set to the widget attach point.
		
chartWidget: Object
~~~~~~~~~~~~~~~~~~~
 The chart widget, if any
		
legendWidget: Object
~~~~~~~~~~~~~~~~~~~~
 The legend widget, if any
		
gridWidget: Object
~~~~~~~~~~~~~~~~~~
 The grid widget, if any


Sample Data
-----------

Typical input chart data
 
.. code-block :: javascript
 :linenos:
 

 {
 "title"  : "Softdrink Sales (2008)",
 "footer" : "North America only",
 "range"  : [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],

 "series" : 
 [                            
 { "legend" : "Pepsi-cola",  "values" : [ "84", "98", "24", "56", "78", "84", "84", "98", "24", "56", "78", "94" ] },
 { "legend" : "Sprite",      "values" : [ "75", "65", "85", "75", "82", "43", "59", "34", "76", "65", "34", "67" ] },
 { "legend" : "Coca-Cola",   "values" : [ "64", "47", "68", "73", "43", "34", "42", "69", "86", "77", "65", "41" ] },
 { "legend" : "Ginger Ale",  "values" : [ "54", "43", "76", "92", "32", "54", "78", "65", "43", "43", "45", "65" ] },
 { "legend" : "Creme Soda",  "values" : [ "44", "58", "44", "36", "48", "54", "34", "38", "24", "56", "48", "34" ] },
 { "legend" : "7-Up",        "values" : [ "45", "25", "45", "31", "42", "33", "49", "34", "46", "25", "44", "37" ] },
 { "legend" : "Fanta",       "values" : [ "34", "17", "38", "13", "33", "14", "22", "39", "26", "17", "35", "21" ] },
 { "legend" : "Diet Coke",   "values" : [ "14", "23", "16", "32", "12", "24", "18", "25", "13", "33", "15", "25" ] }
 ]
 }

 
Demos
-----

DataPresentation Demo: http://dleadt.torolab.ibm.com/dl/charts/testd.html

fig 2.

.. image:: datapres6.png
