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

Basic Description
-----------------

DataPresentation is a widget that connects to a data store in a simple manner, and also provides some additional convenience mechanisms for connecting to common data sources without needing to explicitly construct a Dojo data store. 

The widget can then present the data in several forms: as a graphical chart, as a tabular grid, or as display panels presenting meta-data (title, creation information, etc) from the data. 

The widget can also create and manage several of these forms in one simple construction. 
		

A basic example follows:

.. code-block :: html
 :linenos:
 
 <div id="myChartNode" style="width: 600px; height: 400px;"></div>
 <div id="myGridNode"  style="width: 600px; height: 400px;"></div>
 
 
.. code-block :: javascript
 :linenos:
 
 dojo.require("dojox.widget.DataPresentation");

 var pres = new dojox.widget.DataPresentation("myChartNode", {
		type: "chart",
		url: "/data/mydata",
		gridNode: "myGridNode"
	});
 
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






Different Chart Types
---------------------

Different chart styles is a simple matter of passing a type:

.. code-block :: javascript
 :linenos:

 dojo.addOnLoad(function(){
    chart = new dojox.charting.DataChart("chartDiv", {
        type: dojox.charting.plot2d.Columns, // <-- chart type
            scroll:false,
            xaxis:{labelFunc:"seriesLabels"}
    });
    chart.setStore(store, {symbol:"*"}, "price");
 });


DataChart Mapping
-----------------

This is a (trimmed down) version of the JSON file used, as it is important to the next concepts:
 
.. code-block :: javascript
 :linenos:
 
 { "identifier": "symbol", "idAttribute":"symbol", "label": "symbol","items": [
    { "symbol":"ANDT", "historicPrice":[0.01,3.52,3.66,3.11,3.90,3.11,3.11], "price":3.52},
    { "symbol":"ATEU", "historicPrice":[6.72,6.76,6.61,6.41,6.31,6.99,7.20], "price":6.76},
    { "symbol":"BGCN", "historicPrice":[4.11,3.98,4.05,4.20,4.16,4.22,3.80], "price":3.98},
    { "symbol":"BAYC", "historicPrice":[9.79,9.60,9.50,2.23,9.45,9.76,9.99], "price":9.60},
    { "symbol":"CRCR", "historicPrice":[8.44,8.44,8.54,8.60,9.65,8.42,8.44], "price":8.44},
    { "symbol":"DTOA", "historicPrice":[2.11,2.47,3.11,3.06,3.01,3.01,3.00], "price":2.47}
 ]}


The property used for the first chart example is historicPrice and is an array. Because the default chart is a line-type, and plots each item separately, more than one bit of data is necessary to span across the x-axis. In this case, there are seven slots in the array, which is why there is an x-axis span of seven. If the price property was charted, there would be seven points all along the y-axis, and the chart x-axis would only have a length of one.

However, the need of the chart may not be a series of individual item properties, it may be single item properties compared to the others. To compare the price of each item on a line chart using the comparative property:
 
.. code-block :: javascript
 :linenos:
 
 dojo.addOnLoad(function(){
    chart = new dojox.charting.DataChart("chartDiv", {
        comparative:true
    });
    chart.setStore(store, {symbol:"*"}, "price");  //  <-- single value property
 });

The DataChart supports information updating, which allows it to animate. To update the information, change the item property in the store. The DataChart is connected to the onSet event in the store and reflects the change. The test in the DojoX trunk demonstrates this with spinner widgets that modify the store item property (see link at bottom of page).

The scroll parameter works in conjunction with two other parameters:

    * stretchToFit: This is how native charts work. If given five bits of data, the x-axis will be five segments long.
    * displayRange: If set, stretchToFit is overridden and the x-axis will not stretch, it will always be that long. This is often used with scroll.
    * scroll: If true and there is more data than fits on the x-axis, it will scroll to the left.

Note that the y-axis is always fixed, having it stretch to fit or scroll is not currently supported.

The combination of these parameters can be confusing, especially when it comes to different chart types. See the Property Demo link at the bottom of the page that you can use to test the different parameters and dynamically build new charts.


Chart Legends
-------------

DojoX Charting comes with dojox.charting.widget.Legend to make it easy to add legends to your charts. Currently however, it isn’t designed to handle "live" data — it’s expecting that the chart knows the data as it’s created. Therefore it needs to connect it when the chart has data:
 

.. code-block :: html
 :linenos:
 
 <div id="chartDiv" style="width: 400px; height: 250px;"></div>
 <div id="legend"></div>

.. code-block :: javascript
 :linenos:
 
 dojo.addOnLoad(function(){
    chart = new dojox.charting.DataChart("chartDiv", {});
    chart.setStore(store, {symbol:"*"}, "historicPrice");
 
    var c = dojo.connect(chart, "onData", function(){
        dojo.disconnect(c);
        new dojox.charting.widget.Legend({chart:chart}, "legend"); 
    });
 });

Chart Labels
------------

DataChart has a convenient method for applying the store item labels. The chart.xaxis object can be edited, which is exposed so that besides the property to be added here, the other standard chart axis properties can edited as well.

*labelFunc* is actually a method that to tap into to write custom labels. DataChart also accepts a specific string which tells it to use its seriesLabels method. Simply put, it connects the item labels to the chart labels.

.. code-block :: javascript
 :linenos:

 dojo.addOnLoad(function(){
    chart = new dojox.charting.DataChart("chartDiv", {
        comparative:true,
        xaxis:{labelFunc:"seriesLabels"},
    });
    chart.setStore(store, {symbol:"*"}, "price");
 });
 

Demos
-----

DojoX Test: http://user.sitepen.com/~mwilcox/dojotoolkit/dojox/charting/tests/test_DataChart.html

DataChart Property Demo: https://user.sitepen.com/~mwilcox/Chart/DataChart.html
