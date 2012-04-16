.. _dojox/mobile/Carousel:

=====================
dojox.mobile.Carousel
=====================

:Authors: Yoshiroh Kamiyama, Atsushi Ono
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

The Carousel widget manages a list of images that can be displayed horizontally, and allows the user to scroll through the list and select a single item. This widget itself has no data store support, but there are two subclasses :ref:`dojox.mobile.DataCarousel <dojox/mobile/DataCarousel>` and :ref:`dojox.mobile.StoreCarousel <dojox/mobile/StoreCarousel>` available for generating the contents from data store. To feed data into Carousel through dojo.data, use DataCarousel. To feed data into Carousel through dojo.store, use StoreCarousel.

The Carousel widget loads and instantiates its item contents in a lazy manner. For example, if the number of visible items (=numVisible) is 2, the widget creates 4 items, 2 for the initial pane and 2 for the next page, at startup time. If you swipe the page to open the 2nd page, the widget creates 2 more items for the 3rd page. If the item to create is a dojo widget, its module is dynamically loaded automatically before instantiation.

.. image :: Carousel.gif

Constructor Parameters
======================

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

Examples
========

Using carousel with data store
------------------------------

In the typical usage of carousel, a data store is often used to provide the carousel item data.
You cannot use this Carousel widget itself for this purpose because it does not have support for data store.
Instead, you can use DataCarousel or StoreCarousel widget with data store.
See :ref:`dojox.mobile.DataCarousel <dojox/mobile/DataCarousel>` and :ref:`dojox.mobile.StoreCarousel <dojox/mobile/StoreCarousel>` for various examples.

If you would like to use carousel without data store, the following examples will help you.

Declarative example
-------------------

.. html ::

  <!-- Need to load the theme files for Carousel and PageIndicator as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/Carousel"
  ]);

.. html ::

  <div id="carousel1" data-dojo-type="dojox.mobile.Carousel"
              data-dojo-props='height:"150px", navButton:true, numVisible:2, title:"Category"'>
      <!-- View #1 -->
      <div data-dojo-type="dojox.mobile.SwapView">
          <div data-dojo-type="dojox.mobile.CarouselItem"
              data-dojo-props='src:"images/dish1.jpg", value:"dish", headerText:"dish"'></div>
          <div data-dojo-type="dojox.mobile.CarouselItem"
              data-dojo-props='src:"images/glass1.jpg", value:"glass", headerText:"glass"'></div>
      </div>
      <!-- View #2 -->
      <div data-dojo-type="dojox.mobile.SwapView">
          <div data-dojo-type="dojox.mobile.CarouselItem"
              data-dojo-props='src:"images/stone1.jpg", value:"stone", headerText:"stone"'></div>
          <div data-dojo-type="dojox.mobile.CarouselItem"
              data-dojo-props='src:"images/shell1.jpg", value:"shell", headerText:"shell"'></div>
      </div>
  </div>

.. image :: Carousel-desc.png

Programmatic example
--------------------

.. html ::

  <!-- Need to load the theme files for Carousel and PageIndicator as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator']"></script>

.. js ::

  require([
      "dojo/ready",
      "dojox/mobile/Carousel",
      "dojox/mobile/CarouselItem",
      "dojox/mobile/SwapView",
      "dojox/mobile",
      "dojox/mobile/parser"
  ], function(ready, Carousel, CarouselItem, SwapView){
      ready(function(){
          var view, item;
          var carousel1 = new Carousel({
              height:"150px", 
              navButton:true, 
              numVisible:2, 
              title:"Category"
          }, "carousel1");
          
          // View #1
          view = new SwapView();
          carousel1.addChild(view);
          
          item = new CarouselItem({src:"images/dish1.jpg", value:"dish", headerText:"dish"});
          item.placeAt(view.containerNode);
          
          item = new CarouselItem({src:"images/glass1.jpg", value:"glass", headerText:"glass"});
          item.placeAt(view.containerNode);
          
          // View #2
          view = new SwapView();
          carousel1.addChild(view);
          
          item = new CarouselItem({src:"images/stone1.jpg", value:"stone", headerText:"stone"});
          item.placeAt(view.containerNode);
          
          item = new CarouselItem({src:"images/shell1.jpg", value:"shell", headerText:"shell"});
          item.placeAt(view.containerNode);
          
          carousel1.startup();
      });
  });

.. html ::

  <div id="carousel1"></div>

.. image :: Carousel-desc.png

Handling the event when a carousel item is selected
---------------------------------------------------

This example handles the event when a carousel item is selected by subscribing to "/dojox/mobile/carouselSelect" topic.

.. html ::

  <!-- Need to load the theme files for Carousel and PageIndicator as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator']"></script>

.. js ::

  require([
      "dojo/ready",
      "dojo/_base/connect",
      "dijit/registry",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/Carousel"
  ], function(ready, connect, registry){
      ready(function(){
          connect.subscribe("/dojox/mobile/carouselSelect", function(carousel, itemWidget, itemObject, index){
              // Each argument means:
              //   carousel - The carousel widget containing the selected item
              //   itemWidget - The selected item widget
              //   itemObject - The item object in the data store for the selected item widget 
              //       (In case of Carousel widget, data store is not used so it is always undefined.)
              //   index - The index of the selected item in the carousel items
              
              var msg = "Carousel   : " + carousel.id + "<br/>"
                      + "ItemWidget : " + itemWidget.value + "<br/>"
                      + "ItemObject : " + itemObject + "<br/>"
                      + "Index      : " + index;
              registry.byId("msg").containerNode.innerHTML = msg;
          });
      })
  });

.. html ::

  <div id="carousel1" data-dojo-type="dojox.mobile.Carousel"
              data-dojo-props='height:"150px", navButton:true, numVisible:2, title:"Category"'>
      <!-- View #1 -->
      <div data-dojo-type="dojox.mobile.SwapView">
          <div data-dojo-type="dojox.mobile.CarouselItem"
              data-dojo-props='src:"images/dish1.jpg", value:"dish", headerText:"dish"'></div>
          <div data-dojo-type="dojox.mobile.CarouselItem"
              data-dojo-props='src:"images/glass1.jpg", value:"glass", headerText:"glass"'></div>
      </div>
      <!-- View #2 -->
      <div data-dojo-type="dojox.mobile.SwapView">
          <div data-dojo-type="dojox.mobile.CarouselItem"
              data-dojo-props='src:"images/stone1.jpg", value:"stone", headerText:"stone"'></div>
          <div data-dojo-type="dojox.mobile.CarouselItem"
              data-dojo-props='src:"images/shell1.jpg", value:"shell", headerText:"shell"'></div>
      </div>
  </div>
  <div id="msg" data-dojo-type="dojox.mobile.RoundRect"></div>

.. image :: Carousel-select.png

Using various widgets as an item of Carousel
--------------------------------------------

You can use other various widgets than :ref:`dojox.mobile.CarouselItem <dojox/mobile/CarouselItem>` as an item of Carousel widget.
This example uses :ref:`dojox.mobile.ContentPane <dojox/mobile/ContentPane>` and `dijit.CalendarLite <dijit/CalendarLite>`_ widgets.

.. html ::

  <!-- Need to load the theme files for dijit.Calendar, Carousel and PageIndicator -->
  <link href="dijit/themes/dijit.css" rel="stylesheet"/>
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Carousel','PageIndicator','dijit.Calendar']"></script>

.. js ::

  require([
      "dijit/CalendarLite",
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/Carousel",
      "dojox/mobile/ContentPane"
  ]);

.. html ::

  <div id="carousel1" data-dojo-type="dojox.mobile.Carousel"
              data-dojo-props='height:"250px", navButton:true, numVisible:1, title:"Category"'>
      <!-- View #1 : Using dojox.mobile.ContentPane -->
      <div data-dojo-type="dojox.mobile.SwapView">
          <div data-dojo-type="dojox.mobile.ContentPane" data-dojo-props='href:"data/fragment.html"'></div>
      </div>
      <!-- View #2 : Using dijit.CalendarLite -->
      <div data-dojo-type="dojox.mobile.SwapView">
          <div data-dojo-type="dijit.CalendarLite"></div>
      </div>
  </div>

.. html ::

  <!-- data/fragment.html (HTML fragment file) -->
  <div dojoType="dojox.mobile.RoundRect" shadow="true">
      <p><img src="images/tab-icon-33h.png" align="left" width="60" height="60">
      Dojo Mobile is a world class HTML5 mobile JavaScript framework 
      that enables rapid development of mobile web applications with 
      a native look and feel on modern webkit-enabled mobile devices.</p>
  </div>

.. image :: Carousel-otherWidget.gif
