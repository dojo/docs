#format dojo_rst

dojox.widget.DataPresentation
=============================

:Status: Draft
:Version: Experimental
:Project owner: Dean Williams
:Available: since V.1.4

DataPresentation provides ...

.. contents::
   :depth: 2

============
Introduction
============

DataPresentation:  a widget that connects to a data store in a simple manner,
		      and also provides some additional convenience mechanisms
		      for connecting to common data sources without needing to
		      explicitly construct a Dojo data store. The widget can then
		      present the data in several forms: as a graphical chart,
		      as a tabular grid, or as display panels presenting meta-data
		      (title, creation information, etc) from the data. The
		      widget can also create and manage several of these forms
		      in one simple construction.
		
		      Note: this is a first experimental draft and any/all details
		      are subject to substantial change in later drafts.
		
			example:
		
			 	var pres = new dojox.data.DataPresentation("myChartNode", {
			 		type: "chart",
			 		url: "/data/mydata",
		          gridNode: "myGridNode"
			 	});
		
			properties:
		
		  store: Object
		      Dojo data store used to supply data to be presented. This may
		      be supplied on construction or created implicitly based on
		      other construction parameters ('data', 'url').
		
		  query: String
		      Query to apply to the Dojo data store used to supply data to
		      be presented.
		
		  queryOptions: String
		      Query options to apply to the Dojo data store used to supply
		      data to be presented.
		
		  data: Object
		      Data to be presented. If supplied on construction this property
		      will override any value supplied for the 'store' property.
		
		  url: String
		      URL to fetch data from in JSON format. If supplied on
		      construction this property will override any values supplied
		      for the 'store' and/or 'data' properties.
		
		  refreshInterval: Number
		      the time interval in milliseconds after which the data supplied
		      via the 'data' property or fetched from a URL via the 'url'
		      property should be regularly refreshed. This property is
		      ignored if neither the 'data' nor 'url' property has been
		      supplied. If the refresh interval is zero, no regular refresh is done.
		
		  refreshIntervalPending:
		      the JavaScript set interval currently in progress, if any
		
		  series: Array
		      an array of objects describing the data series to be included
		      in the data presentation. Each object may contain the 
		      following fields:
					datapoints: the name of the field from the source data which
						contains an array of the data points for this data series.
						If not supplied, the source data is assumed to be an array
						of data points to be used.
					field: the name of the field within each data point which
						contains the data for this data series. If not supplied,
						each data point is assumed to be the value for the series.
              	name: a name for the series, used in the legend and grid headings
		          namefield: the name of the field from the source data which
		              contains the name the series, used in the legend and grid
		              headings. If both name and namefield are supplied, name takes
		              precedence. If neither are supplied, a default name is used.
					chart: true if the series should be included in a chart presentation (default: true)
		          charttype: the type of presentation of the series in the chart, which can be
						"range", "line", "bar" (default: "bar")
		          axis: the dependant axis to which the series will be attached in the chart,
		              which can be "primary" or "secondary"
        			grid: true if the series should be included in a data grid presentation (default: true)
        			gridformatter: an optional formatter to use for this series in the data grid
		
	          a call-back function may alternatively be supplied. The function takes
		      a single parameter, which will be the data (from the 'data' field or
		      loaded from the value in the 'url' field), and should return the array
		      of objects describing the data series to be included in the data
		      presentation. This enables the series structures to be built dynamically
		      after data load, and rebuilt if necessary on data refresh. The call-back
		      function will be called each time new data is set, loaded or refreshed.
		      A call-back function cannot be used if the data is supplied directly
		      from a Dojo data store.
		
		  type: String
		      the type of presentation to be applied at the DOM attach point.
		      This can be 'chart', 'legend', 'grid', 'title', 'footer'. The
		      default type is 'chart'.
		type: "chart",
		
		  chartType: String
		      the type of chart to display. This can be 'clusteredbars',
		      'areas', 'stackedcolumns', 'stackedbars', 'stackedareas',
		      'lines', 'hybrid'. The default type is 'bar'.
		chartType: "clusteredBars",
		
		  reverse: Boolean
		      true if the chart independant axis should be reversed.
		reverse: false,
		
		  labelMod: Integer
		      the frequency of label annotations to be included on the
		      independent axis. 1=every label. The default is 1.
		labelMod: 1,
		
		  legendVertical: Boolean
		      true if the legend should be rendered vertically. The default
		      is false (legend rendered horizontally).
		legendVertical: false,
		
		  theme: String|Theme
		      a theme to use for the chart, or the name of a theme.
		
		  chartNode: String|DomNode
		      an optional DOM node or the id of a DOM node to receive a
		      chart presentation of the data. Supply only when a chart is
		      required and the type is not 'chart'; when the type is
		      'chart' this property will be set to the widget attach point.
		
		  legendNode: String|DomNode
		      an optional DOM node or the id of a DOM node to receive a
		      chart legend for the data. Supply only when a legend is
		      required and the type is not 'legend'; when the type is
		      'legend' this property will be set to the widget attach point.
		
		  gridNode: String|DomNode
		      an optional DOM node or the id of a DOM node to receive a
		      grid presentation of the data. Supply only when a grid is
		      required and the type is not 'grid'; when the type is
		      'grid' this property will be set to the widget attach point.
		
		  titleNode: String|DomNode
		      an optional DOM node or the id of a DOM node to receive a
		      title for the data. Supply only when a title is
		      required and the type is not 'title'; when the type is
		      'title' this property will be set to the widget attach point.
		
		  footerNode: String|DomNode
		      an optional DOM node or the id of a DOM node to receive a
		      footer presentation of the data. Supply only when a footer is
		      required and the type is not 'footer'; when the type is
		      'footer' this property will be set to the widget attach point.
		
		  chartWidget: Object
		      the chart widget, if any
		
		  legendWidget: Object
		      the legend widget, if any
		
		  gridWidget: Object
		      the grid widget, if any



* feature 1
* feature 2
* feature 3

=====
Usage
=====

The following steps show a typical usage of DataPresentation:

.. code-block :: javascript
  :linenos:

  <style type="text/css">
      @import "../../../../dijit/themes/tundra/tundra.css";
      @import "../../enhanced/resources/tundraEnhancedGrid.css";
      ...
  </style>


2. Declare required feature plugins 

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      dojo.require("dojox.grid.EnhancedGrid");                          // Required for all Enhanced features
      dojo.require("dojox.grid.enhanced.plugins.DnD");                  // Row/Column drag-drop feature
      dojo.require("dojox.grid.enhanced.plugins.Menu");                 // Declarative pop-up menu feature
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");        // Nested sorting feature
      dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");    // Indirect selection
                                                                        // (checkbox/radio button selection) feature
      ...
  </script>

3. Use features:

.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
      plugins="{nestedSorting: true, dnd: true, indirectSelection: true,  // Each required feature must be turned on
      menus:{
      headerMenu:'headerMenu',  //References menus defined declaratively below
      rowMenu:'rowMenu',
      cellMenu:'cellMenu',
      selectedRegionMenu:'selectedRegionMenu'}}"
      ...>
  </div>

TODO:  Add a live EDG demo here

=========
Feature 1
=========

This feature enhances the ...

Usage
-----

Using the nested sorting feature is pretty simple as shown below:

* Declare nested sorting feature plugin

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
      ...
  </script>

* Use nested sorting feature

    ... with HTML markup
    
.. code-block :: javascript
  :linenos:

  <div id="grid" store="store1" dojoType="dojox.grid.EnhancedGrid" plugins="{nestedSorting: true}" ... >
  </div>

    ... with JavaScript  <<< '''This isn't code. Not sure how to fix'''
    
.. code-block :: javascript
  :linenos:

  <script>
      var grid = new dojox.grid.EnhancedGrid({id: "grid", store: "store1", plugins: {nestedSorting: true}, ...}, dojo.byId("gridDiv"));
  </script>
    
When nested sorting is enabled, you can also use comparatorMap for custom sorting; see `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_ on DojoCampus.org for more details.
