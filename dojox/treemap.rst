.. _dojox/treemap:

=============
dojox.treemap
=============

:since: 1.8
:authors: Christophe Jolif

.. contents ::
  :depth: 2

This page describes how to use and configure the Dojo Treemap.

Introduction
============

Treemaps display data as a set of colored, potentially nested, rectangular cells. Treemaps can be used to explore large data sets by using convenient drill-down capabilities. 
They reveal data patterns and trends easily. Treemaps rely on data clustering, using areas and color information to represent the data you want to explore.

An example of a treemap is shown below. The treemap shows business sectors at the head of the hierarchy and provides the possibility to drill down to country and then company level.

Dojo Treemap supports squarified algorithms for two-dimensional treemaps, and is characterized by the ability to:

 * Map the size, color, and label of treemap cells to properties in a data store.
 * Choose either a predefined algorithm for computing the item colors or specify a color using a customizable color function.
 * Specify the treemap levels at which labels are to appear.
 * Get an event when clicking and hovering over treemap items.
 * Navigate within a treemap with visual effects on drill down.

**Note**: The treemap is not supported on Internet Explorer 6. On IE7 and above a standard doctype must be set on the page that includes the treemap. 

.. image :: treemap.png

Creating a treemap widget
=========================

You can create a TreeMap widget either using JavaScript or using HTML markup. The following two examples create the exact same treemap.
Do not forget to include the default TreeMap CSS to get the expected default rendering.

In JavaScript:

.. js ::

  require(["dojox/treemap/TreeMap", ...], function(TreeMap, ...){
    new TreeMap({store: dataStore,
      areaAttr: "sales", colorAttr: "profit", groupAttrs: ["region"],
      colorModel: colorModel }, dom.byId("treeMap"));
  });

.. html::

  <link rel="stylesheet" href="{{baseUrl}}/dojox/treemap/themes/TreeMap.css">
  <div id="treeMap" style="width: 600px; height: 450px;"></div>

In HTML markup:

.. html ::

  <link rel="stylesheet" href="{{baseUrl}}/dojox/treemap/themes/TreeMap.css">
  <div id="treeMap" data-dojo-type="dojox/treemap/TreeMap" data-dojo-props="store: dataStore, areaAttr:'sales', 
     colorAttr:'profit', groupAttrs:['region'], colorModel: colorModel"
     style="width: 600px; height: 450px;">
  </div>

You might want to listen to store query errors, for that you can use the promise returned by the store setter:

.. js ::

  require(["dojox/treemap/TreeMap", "dojo/when", ..], function(TreeMap, when, ...){
    var treeMap = new TreeMap(...);
    when(treeMap.set("store", mystore), function onOk() {}, function onFail() {});
  });


Configuring treemap data
========================

The TreeMap can connect to any implementation of the dojo.store.api.Store interface that implements get/query and id management (getIdentity). It supports flat data and optionally creates a hierarchy from this data 
using attributes of the data to group them based on certain criteria.

Mapping using attributes 
------------------------

In this example the data are mapped from the data store using an attribute based mapping. That means the cell size and color as well as the grouping are extracted from attributes value in the data.

.. code-example ::
  :width: 620
  :height: 620

  .. js ::
  
      require(["dojo/ready", "dojo/dom", "dojox/treemap/TreeMap",
        "dojo/store/Memory", "dojox/color/MeanColorModel", "dojo/_base/Color"],
        function(ready, dom, TreeMap, Memory, MeanColorModel, Color) {
        ready(function(){
          var dataStore = new Memory({idProperty: "label", data:
	  [
            { label: "France", sales: 500, profit: 50, region: "EU" },
            { label: "Germany", sales: 450, profit: 48, region: "EU" },
            { label: "UK", sales: 700, profit: 60, region: "EU" },
            { label: "USA", sales: 2000, profit: 250, region: "America" },
            { label: "Canada", sales: 600, profit: 30, region: "America" },
            { label: "Brazil", sales: 450, profit: 30, region: "America" },
            { label: "China", sales: 500, profit: 40, region: "Asia" },
            { label: "Japan", sales: 900, profit: 100, region: "Asia" }
          ]});
          var colorModel = new MeanColorModel(new Color(Color.named.red), new Color(Color.named.green));
          new TreeMap({store: dataStore,
           areaAttr: "sales", colorAttr: "profit", groupAttrs: ["region"],
	   colorModel: colorModel }, dom.byId("treeMap"));
        });
      });

  .. html ::
  
    <div id="treeMap" style="width:600px;height:600px"></div>

For the cell colors in the value of the binding is used as an input into the specified color model. In this case this is a color model that returns a color interpolated between the red and 
green colors with a mean neutral value. One can specify his one color model like a similar one based on average neutral value instead of mean neutral. If no color model is specified at all
the color is expected to be found directly in the value of the colorAttr binding as a suitable input for the dojo/Color constructor.

Note also that the groupAttrs property is of type array instead of just a single attribute. This allows one to specify several attributes for grouping thus creating a multi-level hierarchy. As for
example:

.. js ::

  groupAttrs:['continent', 'country']

Other binding attributes are available:
 * the labelAttr that binds the cell labels to a data attribute.
 * the tooltipAttr that binds the cell tooltips to a data attribute.

Mapping using custom functions
------------------------------

In this example the data are mapped from the data store using custom functions. That means the cell size and color as well as the grouping are computed by functions specified by the application.

.. code-example ::
  :width: 620
  :height: 620

  .. js ::

      require(["dojo/ready", "dojo/dom", "dojox/treemap/TreeMap",
        "dojo/store/Memory", "dojox/color/MeanColorModel", "dojo/_base/Color"],
        function(ready, dom, TreeMap, Memory, MeanColorModel, Color) {
        ready(function(){
          var dataStore = new Memory({idProperty: "label", data:
	  [
            { label: "France", sales: 500, profit: 50, region: "EU" },
            { label: "Germany", sales: 450, profit: 48, region: "EU" },
            { label: "UK", sales: 700, profit: 60, region: "EU" },
            { label: "USA", sales: 2000, profit: 250, region: "America" },
            { label: "Canada", sales: 600, profit: 30, region: "America" },
            { label: "Brazil", sales: 450, profit: 30, region: "America" },
            { label: "China", sales: 500, profit: 40, region: "Asia" },
            { label: "Japan", sales: 900, profit: 100, region: "Asia" }
          ]});
          var colorModel = new MeanColorModel(new Color(Color.named.red), new Color(Color.named.green));
          new TreeMap({store: dataStore,
            areaAttr: "sales",
	    colorFunc: function(item){
	      // use benefit % instead of absolute profit
  	      return item.profit / item.sales;
            },
            groupAttrs: ["region"],
            colorModel: colorModel,
	    query: function(item){
	      return item.sales > 500;
	    }}, dom.byId("treeMap"));
        });
      });

  .. html ::
  
    <div id="treeMap" style="width:600px;height:600px"></div>

The example is very similar to the previous one, except that it is using a function to compute the input value for the cells color. In this case instead of using the absolute profit figure
we are computing the profit percentage. 

The example is also leveraging the query attribute that allows to reduce the scope of the query made onto the data store in order to extract a subset of the data. Here we are choosing only
data items with sales above a given threshold.

Obviously functions are also supported for binding areas, labels or tooltips.

Configuring treemap properties
==============================

In addition to the mapping properties the TreeMap widget provides other interesting properties.

 * the labelThreshold property corresponds to the maximum depth level at which labels will be displayed. If you want no labels to be displayed, choose 0, if you want only top level labels choose 1 and so on.
 * the selectionMode property corresponds to the type of selection you want to enable on the treemap, possible values are "multiple", "single" or "none".
 * the selectedItems property is the array of selected items. If you want to select only a single item you can alternatively used selectedItem property.

.. js::

  new TreeMap({store: dataStore, labelThreshold: 1, selectedItem:  dataStore.get("France") ,
    areaAttr: "sales", colorAttr: "profit", groupAttrs: ["region"],
    colorModel: colorModel }, dom.byId("treeMap"));


Styling the treemap
===================

The TreeMap widget generates HTML markup that can be styled using CSS. The treemap provides a default TreeMap.css that must be included in your application. Alternate rendering can be achieved by overriding some of the CSS rules and using the classes put by the treemap on the HTML elements.

The following example shows how to:
 * center the labels 
 * change the font size
 * use rounded corners on treemap cells (HTML5 browsers only)

.. code-example ::
  :type: inline
  :width: 620
  :height: 620

  .. js ::

      require(["dojo/ready", "dojo/dom", "dojox/treemap/TreeMap",
        "dojo/store/Memory", "dojox/color/MeanColorModel", "dojo/_base/Color"],
        function(ready, dom, TreeMap, Memory, MeanColorModel, Color) {
        ready(function(){
          var dataStore = new Memory({idProperty: "label", data:
	  [
            { label: "France", sales: 500, profit: 50, region: "EU" },
            { label: "Germany", sales: 450, profit: 48, region: "EU" },
            { label: "UK", sales: 700, profit: 60, region: "EU" },
            { label: "USA", sales: 2000, profit: 250, region: "America" },
            { label: "Canada", sales: 600, profit: 30, region: "America" },
            { label: "Brazil", sales: 450, profit: 30, region: "America" },
            { label: "China", sales: 500, profit: 40, region: "Asia" },
            { label: "Japan", sales: 900, profit: 100, region: "Asia" }
          ]});
          var colorModel = new MeanColorModel(new Color(Color.named.red), new Color(Color.named.green));
          new TreeMap({store: dataStore,
           areaAttr: "sales", colorAttr: "profit", groupAttrs: ["region"],
	   colorModel: colorModel }, dom.byId("treeMap"));
        });
      });

  .. html ::

    <div id="treeMap" style="width:600px;height:600px"></div>

  .. css ::
  
    <style type="text/css">
      @import "{{baseUrl}}/dojox/treemap/themes/TreeMap.css";

      .dojoxTreeMap {
	font-family: Geneva, Arial, Helvetica, sans-serif;
	font-size: 16px;
	text-align: center;
	background: none;
      }

      .dojoxTreeMapLeaf {
	-webkit-border-radius: 15px 15px;
	-moz-border-radius: 15px 15px;
	border-radius: 15px 15px;
	margin: 1px;
      }

      .dojoxTreeMapHeader {
	text-align: center;
	-webkit-border-radius: 15px 15px;
	-moz-border-radius: 15px 15px;
	border-radius: 15px 15px;
        background:  #0B8CD4;
      }
    </style>

Other styling can be performed like changing selection border color or adding margins between the cells.

The following CSS class are available for that purpose:

 * dojoxTreeMap: the TreeMap widget class
 * dojoxTreeMapLeaf: the TreeMap leaf cells class
 * dojoxTreeMapGroup: the TreeMap grouping div class which contains:

   * dojoxTreeMapHeader: the TreeMap grouping div header class. 
   * dojoxTreeMapHeader_*level*: the class for header of level *level*.
   * dojoxTreeMapGroupContent: the TreeMap grouping div content class.
   * dojoxTreeMapGroupContent_*level*: the class for content of level *level*.

 * dojoxTreeMapSelected: for selected TreeMap cells.

User interactions
=================

By default the TreeMap widget only provide mouse & touch selection interaction. In this default configuration the following selection actions are available:

==================== ===========
Function             Action       
==================== =========== 
Select               Click a cell in the treemap      
Extend a selection   Hold down the CTRL key an click a cell      
Reduce a selection   Hold down the CTRL key and click an already selected cell      
==================== =========== 

Other interaction must be explicitly mixed in the TreeMap in order to be available.

To get drill down ability on double click or double tap:

.. js ::

  require(["dojo/ready", "dojo/dom", "dojo/_base/declare", "dojox/treemap/TreeMap",
    "dojo/store/Memory", "dojox/color/MeanColorModel", "dojo/_base/Color", "dojox/treemap/DrillDownUp"],
    function(ready, dom, declare, TreeMap, Memory, MeanColorModel, Color, DrillDownUp) {
      ready(function(){
          var dataStore = new Memory({idProperty: "label", data:
	  [
            { label: "France", sales: 500, profit: 50, region: "EU" },
            { label: "Germany", sales: 450, profit: 48, region: "EU" },
            { label: "UK", sales: 700, profit: 60, region: "EU" },
            { label: "USA", sales: 2000, profit: 250, region: "America" },
            { label: "Canada", sales: 600, profit: 30, region: "America" },
            { label: "Brazil", sales: 450, profit: 30, region: "America" },
            { label: "China", sales: 500, profit: 40, region: "Asia" },
            { label: "Japan", sales: 900, profit: 100, region: "Asia" }
          ]});
        var colorModel = new MeanColorModel(new Color(Color.named.red), new Color(Color.named.green));
        new declare([TreeMap, DrillDownUp])({store: dataStore,
          areaAttr: "sales", colorAttr: "profit", tooltipAttr: "label", groupAttrs: ["region"],
          colorModel: colorModel }, dom.byId("treeMap"));
      });
  });


To get keyboard interaction:

.. js ::

  require(["dojo/ready", "dojo/dom", "dojo/_base/declare", "dojox/treemap/TreeMap",
    "dojo/store/Memory", "dojox/color/MeanColorModel", "dojo/_base/Color", "dojox/treemap/Keyboard"],
    function(ready, dom, declare, TreeMap, Memory, MeanColorModel, Color, Keyboard) {
      ready(function(){
          var dataStore = new Memory({idProperty: "label", data:
	  [
            { label: "France", sales: 500, profit: 50, region: "EU" },
            { label: "Germany", sales: 450, profit: 48, region: "EU" },
            { label: "UK", sales: 700, profit: 60, region: "EU" },
            { label: "USA", sales: 2000, profit: 250, region: "America" },
            { label: "Canada", sales: 600, profit: 30, region: "America" },
            { label: "Brazil", sales: 450, profit: 30, region: "America" },
            { label: "China", sales: 500, profit: 40, region: "Asia" },
            { label: "Japan", sales: 900, profit: 100, region: "Asia" }
          ]});
        var colorModel = new MeanColorModel(new Color(Color.named.red), new Color(Color.named.green));
        new declare([TreeMap, Keyboard])({store: dataStore,
          areaAttr: "sales", colorAttr: "profit", tooltipAttr: "label", groupAttrs: ["region"],
          colorModel: colorModel }, dom.byId("treeMap"));
     });
  });

Which enable the following actions:

===================== ===========
Keyboard              Action       
===================== =========== 
Right/left arrow keys Select a neighboring item that shares the same parent item.     
Up/down arrow keys    Move up or down in the hierarchy to select a parent or child item.   
Plus key (+)          Drill down the treemap
Minus key (-)         Drill up the treemap
===================== =========== 


Using alternate rendering mixins
================================

By default each cell is drawn with a fixed size label. As demonstrated in the Styling the treemap one can leverage CSS to change the default rendering like changing the font size. However some
more complex customization might not be possible with CSS, that's why the TreeMap widget conveniently propose classes that can be mixed in the TreeMap class and will provide alternate rendering.

The first rendering mixin is the GroupLabel mixin. It allows to remove cell labels and only keep group labels centered on the groups:

.. code-example::
  :type: inline
  :width: 620
  :height: 620

  .. js ::

    require(["dojo/ready", "dojo/dom", "dojo/_base/declare", "dojox/treemap/TreeMap",
      "dojo/store/Memory", "dojox/color/MeanColorModel", "dojo/_base/Color", "dojox/treemap/GroupLabel"],
      function(ready, dom, declare, TreeMap, Memory, MeanColorModel, Color, GroupLabel) {
        ready(function(){
            var dataStore = new Memory({idProperty: "label", data:
	    [
              { label: "France", sales: 500, profit: 50, region: "EU" },
              { label: "Germany", sales: 450, profit: 48, region: "EU" },
              { label: "UK", sales: 700, profit: 60, region: "EU" },
              { label: "USA", sales: 2000, profit: 250, region: "America" },
              { label: "Canada", sales: 600, profit: 30, region: "America" },
              { label: "Brazil", sales: 450, profit: 30, region: "America" },
              { label: "China", sales: 500, profit: 40, region: "Asia" },
              { label: "Japan", sales: 900, profit: 100, region: "Asia" }
            ]});
          var colorModel = new MeanColorModel(new Color(Color.named.red), new Color(Color.named.green));					
          new declare([TreeMap, GroupLabel])({store: dataStore,
            areaAttr: "sales", colorAttr: "profit", tooltipAttr: "label", groupAttrs: ["region"],
            colorModel: colorModel }, dom.byId("treeMap"));
       });
    });

  .. html ::

    <div id="treeMap" style="width:600px;height:600px"></div>

  .. css::
  
    <style type="text/css">
      @import "{{baseUrl}}/dojox/treemap/themes/TreeMap.css";
      @import "{{baseUrl}}/dojox/treemap/themes/GroupLabel.css";
    </style>

The second rendering mixin is the ScaledLabel mixin. It allows to scale the cell labels so that they fill as much as possible the cells size:

.. code-example ::
  :type: inline
  :width: 620
  :height: 620

  .. js ::

    require(["dojo/ready", "dojo/dom", "dojo/_base/declare", "dojox/treemap/TreeMap",
      "dojo/store/Memory", "dojox/color/MeanColorModel", "dojo/_base/Color", "dojox/treemap/ScaledLabel"],
      function(ready, dom, declare, TreeMap, Memory, MeanColorModel, Color, ScaledLabel) {
        ready(function(){
            var dataStore = new Memory({idProperty: "label", data:
	    [
              { label: "France", sales: 500, profit: 50, region: "EU" },
              { label: "Germany", sales: 450, profit: 48, region: "EU" },
              { label: "UK", sales: 700, profit: 60, region: "EU" },
              { label: "USA", sales: 2000, profit: 250, region: "America" },
              { label: "Canada", sales: 600, profit: 30, region: "America" },
              { label: "Brazil", sales: 450, profit: 30, region: "America" },
              { label: "China", sales: 500, profit: 40, region: "Asia" },
              { label: "Japan", sales: 900, profit: 100, region: "Asia" }
            ]});
          var colorModel = new MeanColorModel(new Color(Color.named.red), new Color(Color.named.green));					
          new declare([TreeMap, ScaledLabel])({store: dataStore,
            areaAttr: "sales", colorAttr: "profit", tooltipAttr: "label", groupAttrs: ["region"],
            colorModel: colorModel }, dom.byId("treeMap"));
       });
    });

  .. html ::

    <div id="treeMap" style="width:600px;height:600px"></div>

  .. css ::
  
    <style type="text/css">
      @import "{{baseUrl}}/dojox/treemap/themes/TreeMap.css";
    </style>


Managing treemap events
=======================

The TreeMap widget is firing the following events:

===================== ===========
Event                 Description
===================== =========== 
itemRollOver          Indicates that the user rolled the pointer over a cell in the treemap.
itemRollOut           Indicates that the user rolled the pointer over a cell in the treemap.
change                Indicates that the selection of a treemap cell has changed (i.e. it has been selected or deselected)
rendererUpdated       Indicates that a given treemap cell renderer has been updated
===================== =========== 

One can listen to this events and react to them. For example, the following code output the name of the latest selected item in the DOM:

.. js::

  require(["dojo/ready", "dojo/dom", "dojox/treemap/TreeMap",
    "dojo/store/Memory", "dojox/color/MeanColorModel", "dojo/_base/Color"],
    function(ready, dom, TreeMap, Memory, MeanColorModel, Color) {
      ready(function(){
          var dataStore = new Memory({idProperty: "label", data:
	  [
            { label: "France", sales: 500, profit: 50, region: "EU" },
            { label: "Germany", sales: 450, profit: 48, region: "EU" },
            { label: "UK", sales: 700, profit: 60, region: "EU" },
            { label: "USA", sales: 2000, profit: 250, region: "America" },
            { label: "Canada", sales: 600, profit: 30, region: "America" },
            { label: "Brazil", sales: 450, profit: 30, region: "America" },
            { label: "China", sales: 500, profit: 40, region: "Asia" },
            { label: "Japan", sales: 900, profit: 100, region: "Asia" }
          ]});
        var colorModel = new MeanColorModel(new Color(Color.named.red), new Color(Color.named.green));
        var treeMap = new TreeMap({store: dataStore,
          areaAttr: "sales", colorAttr: "profit", groupAttrs: ["region"],
          colorModel: colorModel }, dom.byId("treeMap"));
        treeMap.on("change", function(e){
          if(e.newValue){
            dom.byId("output").innerHTML = e.newValue.label;
          }
        });
     });
  });



See also
========

 * A demo is leveraging the Dojo treemap to explore Dojo Trac bug base. Check it out `here <http://archive.dojotoolkit.org/nightly/checkout/demos/tracTreemap/demo.html>`_.


