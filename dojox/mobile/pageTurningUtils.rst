.. _dojox/mobile/pageTurningUtils:

=============================
dojox.mobile.pageTurningUtils
=============================

:Authors: Atsushi Ono
:Developers: Richard Redpath, Atsushi Ono
:since: V1.8

.. contents ::
  :depth: 2

The dojox.mobile.pageTurningUtils is an **EXPERIMENTAL** module. It works only on webkit-based browsers. It does not work on other desktop browsers such as Firefox or IE.

Introduction
============

pageTurningUtils is an utility class which provides page turning effects just like turning a real book.
It enables you to create a kind of ebook reader application with more realistic page turning animations.

Currently, this class provides the following three types of page turning effects. We may add bottom-left turning in the future.

Top-right turning with dog ear
------------------------------

The top right corner of the current page is dog-eared, and you can turn the page from the dog-eared corner with page turning animations.
This page turning effect can be used, for example, for English books.

.. image :: pageTurningUtils-top.gif


Bottom-right turning without dog ear
------------------------------------

The current page is not dog-eared. You can turn the page from the bottom right corner with page turning animations.
This page turning effect can be used, for example, for English books, too.

.. image :: pageTurningUtils-bottom.gif


Top-left turning with dog ear
-----------------------------

The top left corner of the current page is dog-eared, and you can turn the page from the dog-eared corner with page turning animations.
This page turning effect can be used, for example, for some Asian books.

.. image :: pageTurningUtils-left.gif


Usage
=====

pageTurnigUtils class expects that your book application has the DOM structure as shown below.
The top level container node represents a whole catalog, and it has multiple pages as child nodes.
And each page node should have two child nodes; the first node represents the content shown in the front side of the page, and the second node represents the one shown in the back side of the page.
Please make the front-side/back-side node empty if it is an empty page (like "back1" node in the example below).

.. html ::

  <div id="catalog">
      <div id="page1">
          <div id="front1"><img src="images/pic1.jpg"></div>
          <div id="back1"></div>
      </div>
      <div id="page2">
          <div id="front2"><img src="images/pic2.jpg"></div>
          <div id="back2"><img src="images/pic3.jpg"></div>
      </div>
      <div id="page3">
          <div id="front3"><img src="images/pic4.jpg"></div>
          <div id="back3"></div>
      </div>
  </div>

When the DOM structure is ready, you can instantiate the pageTurnigUtils class to initialize the catalog node.
Note that this class is not a widget, and that it is not intended to be used declaratively in html markup. You need to instantiate it programmatically.
The typical usage is as below:

.. html ::

  <!-- Need to load the stylesheet for the pageTurningUtils class -->
  <link href="dojox/mobile/themes/common/PageTurning.css" rel="stylesheet">

.. js ::

  require([
      "dojo/dom",
      "dojo/ready",
      "dojox/mobile/pageTurningUtils"
  ], function(dom, ready, pageTurningUtils){
      utils = new pageTurningUtils();
      
      ready(function(){
          // Set property values to pageTurningUtils object
          utils.init(288, 385, "top", 2, 1.0, 2.0, false);
          
          // Initialize catalog node
          utils.initCatalog(dom.byId("catalog"));
      });
      
      prev = function(){
          utils.turnToPrev();
      };
      
      next = function(){
          utils.turnToNext();
      };
  });

First, you need to call pageTurningUtils.init() function to set several property values. 
You can specify the following arguments:

  pageTurningUtils.init(w, h, turnfrom, page, dogear, duration, alwaysDogeared)

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Argument      |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|w             |Number    |0        |The width of each page by pixels. You cannot specify it by percentage.                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|h             |Number    |0        |The height of each page by pixels. You cannot specify it by percentage.                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|turnfrom      |String?   |"top"    |Specifies from which side/corner the page turning starts. You can choose from "top", "bottom" or "left".   |
|              |          |         |Defaults to "top". If "top", each page is turned from top-right corner of the page. If "bottom", each page |
|              |          |         |is turned from bottom-right corner of the page. And if "left", each page is turned from top-left corner of |
|              |          |         |the page. The page is shown as dog-eared except the case of "bottom".                                      |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|page          |Number?   |1        |The number of pages shown in the screen at a time. This parameter should be either of 1 or 2. Defaults to  |
|              |          |         |1. If 1, the only one side of two facing pages are shown. If 2, the two facing pages are shown at a time.  |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|dogear        |Float?    |1.0      |The ratio of actual dogear width to the maximum dogear width which is 11 percent of the page width         |
|              |          |         |(= 0.11 * w). This parameter should be a float number between 0 and 1. Defaults to 1. The actual dogear    |
|              |          |         |width is calculated by the following formula: 0.11 * w * dogear. This parameter is ignored if "bottom" is  |
|              |          |         |specified to turnfrom parameter.                                                                           |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|duration      |Float?    |2.0      |The duration of page turning animations by seconds (ex. 1.5, 3, etc). Defaults to 2.0.                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|alwaysDogeared|Boolean   |false    |Specifies whether all pages are always dog-eared or not. If true, all pages are always dog-eared. If false,|
|              |          |         |only the current page is dog-eared while the others are not. This parameter is ignored if "bottom" is      |
|              |          |         |specified to turnfrom parameter.                                                                           |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+


And all you need to do is to call pageTurningUtils.initCalatalog(catalogNode) function to initialize the catalog node.
After initialization, you can turn page forward by calling pageTurningUtils.turnToNext() function, and turn page backward by calling pageTurningUtils.turnToPrev() function.


Examples
========

Various page contents
---------------------

The page contents can be not only images but also other elements such as iframe and div contents. 
You can also use widgets as page contents such as dojox.mobile.View, dojox.mobile.ScrollableView, dojox.mobile.ContentPane, etc.
See test_pageTurningUtils-pageType.html in the dojox/mobile/tests folder for a complete example.

.. js ::

  require([
      "dojo/dom",
      "dojo/ready",
      "dojox/mobile/pageTurningUtils",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/ScrollableView",
      "dojox/mobile/ContentPane",
      "dojox/mobile/SpinWheel"
  ], function(dom, ready, pageTurningUtils){
      utils = new pageTurningUtils();
      
      ready(function(){
          // Set property values to pageTurningUtils object
          utils.init(320, 400, "top", 1, 1.0, 1.5);
          
          // Initialize catalog node
          utils.initCatalog(dom.byId("catalog"));
      });
      
      prev = function(){
          utils.turnToPrev();
      };
      
      next = function(){
          utils.turnToNext();
      };
  });

.. html ::

  <div>
      <button onclick="prev()" style="width:50px">Prev</button>
      <button onclick="next()" style="width:50px">Next</button>
  </div>
  <div id="catalog">
      <div id="page1"> <!-- image -->
          <div id="front1">
              <img src="images/pic2.jpg" width="100%" height="100%"/>
          </div>
          <div id="back1"></div>
      </div>
      <div id="page2"> <!-- iframe -->
          <div id="front2" class="myPane">
              <iframe src="data/fragment1.html" width="100%" height="100%"></iframe>
          </div>
          <div id="back2"></div>
      </div>
      <div id="page3"> <!-- div contents -->
          <div id="front3" class="myPane">
              <div style="padding:10px;">
                  <div style="font-size: 24px">Unbeatable JavaScript Tools</div>
                  <div style="border-top: 1px dashed gray;margin: 20px"></div>
                  <img alt="" src="images/dojo-logo1.png" style="float:left;margin-right:5px">
                  <p>Dojo saves you time, delivers powerful performance, and scales with your development process...</p>
              </div>
          </div>
          <div id="back3"></div>
      </div>
      <div id="page4"> <!-- dojox.mobile.View widget -->
          <div id="front4" data-dojo-type="dojox.mobile.View" style="height:100%;background-color:#c5ccd3;">
              <h1 data-dojo-type="dojox.mobile.Heading">View</h1>
              <div dojoType="dojox.mobile.RoundRect" shadow="true">
                  <p><img src="images/dojo-logo1.png" align="left" width="60" height="60">
                  Dojo saves you time and scales with your development process, using web standards as its platform...</p>
              </div>
          </div>
          <div id="back4"></div>
      </div>
      <div id="page5"> <!-- dojox.mobile.ScrollableView widget -->
          <div id="front5" data-dojo-type="dojox.mobile.ScrollableView" style="height:100%;background-color:#c5ccd3;">
              <h1 data-dojo-type="dojox.mobile.Heading">ScrollableView</h1>
              <ul data-dojo-type="dojox.mobile.EdgeToEdgeList">
                  <li data-dojo-type="dojox.mobile.ListItem" data-dojo-props='icon:"images/i-icon-1.png"'>
                      Item 1
                  </li>
                  <li data-dojo-type="dojox.mobile.ListItem" data-dojo-props='icon:"images/i-icon-2.png"'>
                      Item 2
                  </li>
              </ul>
          </div>
          <div id="back5"></div>
      </div>
      <div id="page6"> <!-- dojox.mobile.ContentPane widget -->
          <div id="front6" data-dojo-type="dojox.mobile.ContentPane" data-dojo-props='href:"data/view5.html"'></div>
          <div id="back6"></div>
      </div>
  </div>



.. image :: pageTurningUtils-pageType.gif


Handling the event when a page is turned
----------------------------------------

You can handle the event when a page is turned by connecting to "onPageTruned" callback function of pageTurningUtils object as shown in the example below.
See test_pageTurningUtils-callback.html in the dojox/mobile/tests folder for a complete example.

.. js ::

  require([
      "dojo/_base/connect",
      "dojo/dom",
      "dojo/ready",
      "dojox/mobile/pageTurningUtils"
  ], function(connect, dom, ready, pageTurningUtils){
      utils = new pageTurningUtils();
      
      ready(function(){
          // Set property values to pageTurningUtils object
          utils.init(288, 385, "top", 1, 1.0, 1.5);
          
          // Initialize catalog node
          utils.initCatalog(dom.byId("catalog"));
          
          // Connect to onPageTurned callback function
          connect.connect(utils, "onPageTurned", null, function(pageNode){
              console.log("onPageTurned: " + pageNode.id);
          });
      });
  });


Changing the property values
----------------------------

If you want to change the property values of pageTurningUtils object (ex. changing the number of pages shown in a screen when the orientation changes), you can do so by calling both init() and initCatalog() functions again.
See test_pageTurningUtils.html in the dojox/mobile/tests folder for a complete example.

.. js ::

  require([
      "dojo/dom",
      "dojo/ready",
      "dojox/mobile/pageTurningUtils"
  ], function(dom, ready, pageTurningUtils){
      utils = new pageTurningUtils();
      
      ready(function(){
          // Set property values to pageTurningUtils object
          utils.init(288, 385, "top", 1, 1.0, 1.5);
          
          // Initialize catalog node
          utils.initCatalog(dom.byId("catalog"));
      });
      
      // Call this function when you would like to change property
      changeProperty = function(){
          // Change page property value from 1 to 2
          utils.init(288, 385, "top", 2); 
          
          // Initialize catalog node again
          utils.initCatalog(dom.byId("catalog"));
      };
  });


Adding/Removing pages
---------------------

The following example shows how you can add/remove pages. 
When you add a page, you need to call initPage(pageNode) function first to initialize the new page, and then call resetCatalog() function.
When you remove a page, you need to call only resetCatalog() function.
See test_pageTurningUtils-add-remove.html in the dojox/mobile/tests folder for a complete example.

.. js ::

  require([
      "dojo/dom",
      "dojo/dom-construct",
      "dojo/ready",
      "dojox/mobile/pageTurningUtils"
  ], function(dom, domConstruct, ready, pageTurningUtils){
      utils = new pageTurningUtils();
      
      ready(function(){
          // Set property values to pageTurningUtils object
          utils.init(288, 385, "top", 1, 1.0, 1.5);
          
          // Initialize catalog node
          utils.initCatalog(dom.byId("catalog"));
      });
      
      // Call this function when you would like to a new page
      addPage = function(){
          // Add a new page node to the catalog node
          var page = domConstruct.create("div", null);
          page.innerHTML = '<div class="myPane"><h1>New Page</h1></div>'
                         + '<div></div>';
          domConstruct.place(page, dom.byId("catalog"));
          
          // Initialize a new page
          utils.initPage(page);
          
          // Reset catalog
          utils.resetCatalog();
      };
      
      // Call this function when you would like to remove the last page
      remove = function(){
          // Remove the last page
          var pages = utils.getPages();
          domConstruct.destroy(pages[pages.length - 1]);
          
          // Reset catalog
          utils.resetCatalog();
      };
  });

