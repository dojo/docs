#format dojo_rst

dojox.charting.DataChart
=========================

:Status: alpha
:Version: 1.3
:Project owner: Mike Wilcox
:Author: Mike Wilcox
:Available: since 1.3

Basic Description
-----------------

DataChart is an extension to Chart2D that connects to a data store in a simple manner. Animation can be achieved by connecting to the data store and modifying the store items. The change are captured and displayed in the DataChart which connects to the store's onSet event.  Convenience methods have also been added for connecting store item labels to the chart labels.
		
The examples on this page use dojo.ItemFileWriteStore, since it is the most commonly used, and most standard store. The store connects to the *dojox/charting/tests/stock.json* file which contains a set of imaginary stock market prices. 

DataChart maintains the integrity of the current charting APIs, although some things have been added or modified in order to get the store to connect and also to get the data to scroll/animate. "displayRange" in particular is used to force the x-axis to a specific size and keep the chart from stretching or squashing to fit the data. Also, the DataChart is meant to be setup quickly. More defaults have been added so only a few simple steps are required to get up and running.

In its most basic, default form, DataChart requires no parameters, besides the node id. The store can be set in the parameters or as a separate method as shown. The setStore method is the same as used elsewhere in Dojo, like in the DataGrid. Unlike the Grid, the DataChart needs one additional argument — the store item property that will be charted. In this case, that property is "price".
		
A basic example follows:

.. code-block :: html
 :linenos:
 
 <div id="chartNode" style="width: 600px; height: 400px;"></div>
 
 
.. code-block :: javascript
 :linenos:
 
 dojo.require("dojox.charting.DataChart");
 dojo.require("dojo.data.ItemFileWriteStore");
 
  var store = new dojo.data.ItemFileWriteStore({ url:dojo.moduleUrl("dojox.charting", "tests/stock.json") });
 chart = new dojox.charting.DataChart("chartNode", chartDefault.chart);
 chart.setStore(store, {symbol='*'}, "price");


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
