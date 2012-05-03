.. _dojox/mobile/StoreCarousel:

==========================
dojox.mobile.StoreCarousel
==========================

:Authors: Yoshiroh Kamiyama, Atsushi Ono
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

StoreCarousel is an enhanced version of :ref:`dojox.mobile.Carousel <dojox/mobile/Carousel>`. It can generate contents according to the given dojo.store store.

.. image :: StoreCarousel.png

Constructor Parameters
======================

Inherited from dojox.mobile.Carousel
------------------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|numVisible    |Number    |3        |The number of visible items.                                                                               |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|itemWidth     |Number    |0        |The number of visible items (=numVisible) is determined by (carousel_width / itemWidth). If itemWidth is   |
|              |          |         |specified, user-specified numVisible is ignored and it is automatically calculated. If resize() is called, |
|              |          |         |numVisible is recalculated and the layout changes accordingly. If itemWidth is 0 (default), numVisible is  |
|              |          |         |used as it is, and recalculation never happens.                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|title         |String    |""       |A title of the carousel to be displayed on the title bar.                                                  |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|pageIndicator |Boolean   |true     |If true, a page indicator, a series of small dots that indicate the current page, is displayed on the title|
|              |          |         |bar.                                                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|navButton     |Boolean   |false    |If true, navigation buttons are displayed on the title bar.                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|height        |String    |"300px"  |Explicitly specified height of the widget (ex. "300px"). If "inherit" is specified, the height is inherited|
|              |          |         |from its offset parent.                                                                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|selectable    |Boolean   |true     |If true, an item can be selected by clicking on it.                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Inherited from dojox.mobile._StoreMixin
---------------------------------------

+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|Parameter       |Type      |Default   |Description                                                                                             |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|store           |Object    |null      |Reference to data provider object used by this widget.                                                  |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|query           |Object    |null      |A query that can be passed to 'store' to initially filter the items. See `dojo.data <dojo/store>`_ for  |
|                |          |          |details.                                                                                                |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|queryOptions    |Object    |null      |An optional parameter for the query. See `dojo.data <dojo/store>`_ for details.                         |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|labelProperty   |String    |"label"   |A property name (a property in the dojo.store item) that specifies that item's label.                   |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|childrenProperty|String    |"children"|A property name (a property in the dojo.store item) that specifies that item's children.                |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

In this example, no CarouselItem is defined as children of StoreCarousel.
The CarouselItems are generated according to sample.json. 
Each item in the json object is used as attributes for :ref:`CarouselItem <dojox/mobile/CarouselItem>` widget.

.. html ::

  <!-- Need to load the theme files for Carousel and PageIndicator as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/StoreCarousel",
      "dojo/store/JsonRest"
  ]);

.. html ::

  <div data-dojo-type="dojo.store.JsonRest" 
          data-dojo-id="sampleStore" data-dojo-props='target:"sample.json"'></div>
  <div id="carousel1" data-dojo-type="dojox.mobile.StoreCarousel"
          data-dojo-props='store:sampleStore, height:"150px", navButton:true, numVisible:2, title:"Category"'>
  </div>

.. js ::

  // sample.json
  {
      "items": [
          { "src": "images/dish.jpg", "value": "dish", "headerText": "dish" },
          { "src": "images/glass.jpg", "value": "glass", "headerText": "glass" },
          { "src": "images/stone.jpg", "value": "stone", "headerText": "stone" },
          { "src": "images/shell.jpg", "value": "shell", "headerText": "shell" }
      ]
  }

.. image :: StoreCarousel-example1.png

Programmatic example
--------------------

.. html ::

  <!-- Need to load the theme files for Carousel and PageIndicator as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator']"></script>

.. js ::

  require([
      "dojo/ready",
      "dojo/store/JsonRest",
      "dojox/mobile/StoreCarousel",
      "dojox/mobile",
      "dojox/mobile/parser"
  ], function(ready, JsonRest, StoreCarousel){
      ready(function(){
          var sampleStore = new JsonRest({target: "sample.json"});
          var carousel = new StoreCarousel({
              store: sampleStore,
              height: "150px",
              navButton: true, 
              numVisible: 2,
              title: "Category"
          }, "carousel1");
          carousel.startup();
      });
  });

.. html ::

  <div id="carousel1"></div>

.. js ::

  // sample.json
  {
      "items": [
          { "src": "images/dish.jpg", "value": "dish", "headerText": "dish" },
          { "src": "images/glass.jpg", "value": "glass", "headerText": "glass" },
          { "src": "images/stone.jpg", "value": "stone", "headerText": "stone" },
          { "src": "images/shell.jpg", "value": "shell", "headerText": "shell" }
      ]
  }

.. image :: StoreCarousel-example1.png

Specifying the carousel item width
----------------------------------

When you specify the carousel item width by using "itemWidth" parameter, the number of visible items are automatically calculated according to the carousel width.
In this example, two items are visible in the carousel on portrait mode while three items are visible on landscape mode.

.. html ::

  <!-- Need to load the theme files for Carousel and PageIndicator as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/StoreCarousel",
      "dojo/store/Memory"
  ]);

.. html ::

  <div data-dojo-type="dojo.store.Memory" 
          data-dojo-id="sampleStore" data-dojo-props='target:"sample.json"'></div>
  <div id="carousel1" data-dojo-type="dojox.mobile.StoreCarousel"
          data-dojo-props='store:sampleStore, height:"150px", navButton:true, itemWidth:150, title:"Category"'>
  </div>

.. js ::

  // sample.json
  {
      "items": [
          { "src": "images/dish.jpg", "value": "dish", "headerText": "dish" },
          { "src": "images/glass.jpg", "value": "glass", "headerText": "glass" },
          { "src": "images/stone.jpg", "value": "stone", "headerText": "stone" },
          { "src": "images/shell.jpg", "value": "shell", "headerText": "shell" }
      ]
  }

On portrait mode:

.. image :: StoreCarousel-example2.png

On landscape mode:

.. image :: StoreCarousel-example3.png

Handling the event when a carousel item is selected
---------------------------------------------------

This example handles the event when a carousel item is selected by subscribing to "/dojox/mobile/carouselSelect" topic.

.. html ::

  <!-- Need to load the theme files for Carousel and PageIndicator as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator']"></script>

.. js ::

  require([
      "dijit/registry",
      "dojo/_base/connect",
      "dojo/ready",
      "dojo/store/JsonRest",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/StoreCarousel"
  ], function(registry, connect, ready){
      ready(function(){
          connect.subscribe("/dojox/mobile/carouselSelect", function(carousel, itemWidget, itemObject, index){
              // Each argument means:
              //   carousel - The carousel widget containing the selected item
              //   itemWidget - The selected item widget
              //   itemObject - The item object in the data store for the selected item widget 
              //   index - The index of the selected item in the carousel items
              
              var msg = "Carousel   : " + carousel.id + "<br/>"
                      + "ItemWidget : " + itemWidget.id + "<br/>"
                      + "ItemObject : " + itemObject.value + "<br/>"
                      + "Index      : " + index;
              registry.byId("msg").containerNode.innerHTML = msg;
          });
      })
  });

.. html ::

  <div data-dojo-type="dojo.store.JsonRest" 
          data-dojo-id="sampleStore" data-dojo-props='target:"sample.json"'></div>
  <div id="carousel1" data-dojo-type="dojox.mobile.StoreCarousel"
          data-dojo-props='store:sampleStore, height:"150px", navButton:true, numVisible:2, title:"Category"'>
  </div>
  <div id="msg" data-dojo-type="dojox.mobile.RoundRect" style="font-size:14px"></div>

.. js ::

  // sample.json
  {
      "items": [
          { "src": "images/dish.jpg", "value": "dish", "headerText": "dish" },
          { "src": "images/glass.jpg", "value": "glass", "headerText": "glass" },
          { "src": "images/stone.jpg", "value": "stone", "headerText": "stone" },
          { "src": "images/shell.jpg", "value": "shell", "headerText": "shell" }
      ]
  }

.. image :: StoreCarousel-example4.png

Filtering items
---------------

You can initially filter items by using "query" parameter. This example filters the items with value starting with "s".

.. html ::

  <!-- Need to load the theme files for Carousel and PageIndicator as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/StoreCarousel",
      "dojo/store/Memory"
  ], function(){
      storeData = {
          "items": [
              { "src": "images/dish.jpg", "value": "dish", "headerText": "dish" },
              { "src": "images/glass.jpg", "value": "glass", "headerText": "glass" },
              { "src": "images/stone.jpg", "value": "stone", "headerText": "stone" },
              { "src": "images/shell.jpg", "value": "shell", "headerText": "shell" }
          ]
      };
  });

.. html ::

  <div data-dojo-type="dojo.store.Memory" 
      data-dojo-id="sampleStore" data-dojo-props='data:storeData'></div>
  <div id="carousel1" data-dojo-type="dojox.mobile.StoreCarousel"
      data-dojo-props='store:sampleStore, height:"150px", navButton:true, numVisible:2, 
                       title:"Category", query:{value:/^s/}'>
  </div>

.. image :: StoreCarousel-example5.png

Using various widgets as an item of Carousel
--------------------------------------------

You can use other various widgets than :ref:`dojox.mobile.CarouselItem <dojox/mobile/CarouselItem>` as an item of StoreCarousel widget by specifying the widget class name to the "type" parameter of json object in the data store.
This example uses :ref:`dojox.mobile.ContentPane <dojox/mobile/ContentPane>` and `dijit.CalendarLite <dijit/CalendarLite>`_ widgets as well as CarouselItem widget.

.. html ::

  <!-- Need to load the theme files for dijit.Calendar, Carousel and PageIndicator -->
  <link href="dijit/themes/dijit.css" rel="stylesheet"/>
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator','dijit.Calendar']"></script>

.. js ::

  // You do not need to add "dojox/mobile/ContentPane" and "dijit/CalendarLite" since they are loaded lazily.
  require([
      "dojo/store/JsonRest",
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/StoreCarousel"
  ]);

.. html ::

  <div data-dojo-type="dojo.store.JsonRest" 
      data-dojo-id="sampleStore" data-dojo-props='target:"sample2.json"'></div>
  <div id="carousel1" data-dojo-type="dojox.mobile.StoreCarousel"
      data-dojo-props='store:sampleStore, height:"250px", navButton:true, numVisible:1, title:"Category"'>
  </div>

.. js ::

  // sample2.json
  {
      "items": [
          { "type": "dojox.mobile.ContentPane", "props": 'href:"data/fragment.html"' },
          { "type": "dijit.CalendarLite" },
          { "src": "images/shell.jpg", "value": "shell", "headerText": "shell" }
      ]
  }

.. html ::

  <!-- data/fragment.html (HTML fragment file) -->
  <div dojoType="dojox.mobile.RoundRect" shadow="true">
      <p><img src="images/tab-icon-33h.png" align="left" width="60" height="60">
      Dojo Mobile is a world class HTML5 mobile JavaScript framework 
      that enables rapid development of mobile web applications with 
      a native look and feel on modern webkit-enabled mobile devices.</p>
  </div>

.. image :: StoreCarousel-otherWidget.gif
