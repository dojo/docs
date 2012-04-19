.. _dojox/mobile/IconContainer:

==========================
dojox.mobile.IconContainer
==========================

:Authors: Yoshiroh Kamiyama, Atsushi Ono
:Developers: Yoshiroh Kamiyama, Atsushi Ono
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

IconContainer is a container widget which can hold multiple icons. Each icon represents an application component.

.. image :: IconContainer.png


Constructor Parameters
======================

+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|Parameter         |Type      |Default         |Description                                                                                                |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|defaultIcon       |String    |""              |The default fall-back icon, which is displayed only when the specified icon has failed to load.            |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|pressedIconOpacity|Number    |0.4             |The opacity of the pressed icon image.                                                                     |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|transition        |String    |"below"         |A type of animated transition effect. You can choose from the standard transition types, "slide", "fade",  |
|                  |          |                |"flip", or from the extended transition types, "cover", "coverv", "dissolve", "reveal", "revealv",         |
|                  |          |                |"scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut", "cube", and "swap". If "none" is specified, |
|                  |          |                |transition occurs immediately without animation.  If "below" is specified, the application contents are    |
|                  |          |                |displayed below the icons.                                                                                 |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|iconBase          |String    |""              |The default icon path for child items. If a child item does not have its own icon parameter specified, this|
|                  |          |                |value is used as its icon path. This parameter is especially useful when all or most of the icons are the  |
|                  |          |                |same, or you use CSS sprite icons, where you specify an aggregated icon image with this parameter and an   |
|                  |          |                |icon position for each icon.                                                                               |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|iconPos           |String    |""              |The default icon position for child items. This parameter is especially useful when all or most of the     |
|                  |          |                |icons are the same.                                                                                        |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|back              |String    |"Home"          |A label for the navigational control.                                                                      |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|label             |String    |"My Application"|A title text of the heading.                                                                               |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|single            |Boolean   |false           |If true, only one icon content can be opened at a time.                                                    |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|editable          |Boolean   |false           |If true, the icons can be removed or re-ordered. You can enter into edit mode by pressing on a child       |
|                  |          |                |IconItem until it starts shaking.                                                                          |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|tag               |String    |"ul"            |A name of html tag to create as domNode.                                                                   |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+

Lazy loading of the contents
============================

Each icon content may consist of one or more dojo widgets. Loading of all the necessary dojo modules of all the icon contents at startup could slow down the startup time of the application. To improve the startup time performance, you can specify the lazy="true" parameter of the IconItem. In this case IconContainer loads dojo modules, which are necessary for the icon content, dynamically only when it is opened the first time.

Below is an example of lazy loading of icon contents. Before the dojo parser runs, the data-dojo-type attributes of the lazy-load nodes are rewritten so that the specified modules (in this case, dijit.ColorPalette and dijit.ProgressBar) will not be be loaded by the parser. IconContainer loads them for you when you open the icons.

In 1.7 and older, lazy loading is supported only in sync mode since it is performed synchronously using dojo.require.
There is no restriction in 1.8, and you can use lazy loading in async mode as well as in sync mode.

.. html ::

  <ul data-dojo-type="dojox.mobile.IconContainer" 
      data-dojo-props='transition:"below", iconBase:"images/icon-1.png"'>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Color Palette", lazy:true'>
      <div data-dojo-type='dijit.ColorPalette'></div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Progress Bar", lazy:true'>
      <div data-dojo-type='dijit.ProgressBar'></div>
    </li>
  </ul>

.. image :: IconContainer-lazy-17.png

Examples
========

Single / Below (transition="below" single="true")
-------------------------------------------------

In this example, icon content is shown below the icons, and only one icon content can be opened at a time.

.. html ::

  <!-- Need to load the theme file for IconContainer as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','IconContainer']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/IconContainer"
  ]);

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Single/Below)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" 
      data-dojo-props='transition:"below", single:true, iconBase:"images/icon-1.png"'>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 1"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
         App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 2"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
         App #2
      </div>
    </li>
  </ul>

.. image :: IconContainer-SingleBelow-anim.gif

Multi / Below (transition="below" single="false")
-------------------------------------------------

In this example, icon content is shown below the icons, and multiple icon contents can be opened at a time.

.. html ::

  <!-- Need to load the theme file for IconContainer as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','IconContainer']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/IconContainer"
  ]);

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Multi/Below)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" 
      data-dojo-props='transition:"below", iconBase:"images/icon-1.png"'>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 1"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
        App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 2"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
        App #2
      </div>
    </li>
  </ul>

.. image :: IconContainer-MultiBelow-anim.gif

Single / Flip (transition="flip" single="true")
-----------------------------------------------

In this example, selecting an icon causes a flip transition to show the icon content. Only one icon content can be opened at a time.

.. html ::

  <!-- Need to load the theme file for IconContainer as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','IconContainer']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/IconContainer"
  ]);

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Single/Flip)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" 
      data-dojo-props='transition:"flip", single:true, iconBase:"images/icon-1.png"'>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 1"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
        App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 2"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
        App #2
      </div>
    </li>
  </ul>

.. image :: IconContainer-SingleFlip-anim.gif

Multi / Flip (transition="flip" single="false")
-----------------------------------------------

In this example, selecting an icon causes a flip transition to show the icon content. Multiple icon contents can be opened at a time.

.. html ::

  <!-- Need to load the theme file for IconContainer as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','IconContainer']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/IconContainer"
  ]);

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Multi/Flip)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" 
      data-dojo-props='transition:"flip", iconBase:"images/icon-1.png"'>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 1"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
        App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 2"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
        App #2
      </div>
    </li>
  </ul>

.. image :: IconContainer-MultiFlip-anim.gif

Single / ZoomIn (transition="zoomIn" single="true")
---------------------------------------------------

In this example, selecting an icon causes a zoomIn transition to show the icon content. 
When you click "Home" button in header, it returns to the Home view with a zoomOut transition.

.. html ::

  <!-- Need to load stylesheets for zoomIn/zoomOut transtions -->
  <link href="dojox/mobile/themes/common/transitions.css" rel="stylesheet"/>
  <!-- Need to load the theme file for IconContainer as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','IconContainer']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/IconContainer"
  ]);

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Single/Below)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" 
      data-dojo-props='transition:"zoomIn", single:true, iconBase:"images/icon-1.png"'>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 1"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
         App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" data-dojo-props='label:"Icon 2"'>
      <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
         App #2
      </div>
    </li>
  </ul>

.. image :: IconContainer-SingleZoomIn-anim.gif

Badge on IconItem
-----------------

You can show a badge (:ref:`dojox.mobile.Badge <dojox/mobile/Badge>`) on an IconItem by using the "badge" parameter as shown in the example below.

.. html ::

  <!-- Need to load stylesheets for badge class -->
  <link href="dojox/mobile/themes/common/domButtons/DomButtonRedBadge.css" rel="stylesheet"/>
  <!-- Need to load the theme file for IconContainer as well as base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','IconContainer']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/IconContainer"
  ]);

.. html ::

  <ul data-dojo-type="dojox.mobile.IconContainer" 
      data-dojo-props='transition:"slide", single:true, iconBase:"images/icon-1.png"'>
      <li id="icon1" data-dojo-type="dojox.mobile.IconItem" 
                     data-dojo-props='badge:"55", label:"Icon 1"'></li>
      <li id="icon2" data-dojo-type="dojox.mobile.IconItem" 
                     data-dojo-props='badge:"New", label:"Icon 2"'></li>
  </ul>

.. image :: IconContainer-badge.png


You can also set/get the value of a badge by using the get/set function of the IconItem widget as shown below:

.. js ::

  require([
      "dojo/ready",
      "dijit/registry",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/IconContainer"
  ], function(ready, registry){
      ready(function(){
          // Get the value of icon1's badge 
          var icon1 = registry.byId("icon1");
          console.log(icon1.get("badge")); // "55"
          
          // Set the value of icon2's badge ("New" -> "100")
          var icon2 = registry.byId("icon2");
          icon2.set("badge", "100");
      })
  });

Editable Icon Container
-----------------------

When you set the "editable:true" property of the IconContainer widget, you can enter into edit mode by pressing on a child IconItem until it starts shaking or by calling the startEdit() function of the IconContainer widget.
During edit mode, you can delete and re-order the child IconItems. 
You end edit mode by calling the endEdit() function of the IconContainer widget.

.. html ::

  <!-- Need to load the theme files for Button and IconContainer widgets -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Button','IconContainer']"></script>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/IconContainer"
  ], function(ready, registry){
      ready(function(){
          startEdit = function(){
              registry.byId("iconContainer1").startEdit();
          };
          endEdit = function(){
              registry.byId("iconContainer1").endEdit();
          };
      })
  });

.. html ::

  <ul data-dojo-type="dojox.mobile.IconContainer" id="iconContainer1"
      data-dojo-props='editable:true, transition:"slide"'>
      <li data-dojo-type="dojox.mobile.IconItem" 
          data-dojo-props='label:"app1", moveTo:"app1", icon:"images/icon1.png"'></li>
      <li data-dojo-type="dojox.mobile.IconItem" 
          data-dojo-props='label:"app2", moveTo:"app2", icon:"images/icon2.png"'></li>
      <li data-dojo-type="dojox.mobile.IconItem" 
          data-dojo-props='label:"app3", moveTo:"app3", icon:"images/icon3.png"'></li>
      <li data-dojo-type="dojox.mobile.IconItem" 
          data-dojo-props='label:"app4", moveTo:"app4", icon:"images/icon4.png"'></li>
      <li data-dojo-type="dojox.mobile.IconItem" 
          data-dojo-props='label:"app5", moveTo:"app5", icon:"images/icon5.png"'></li>
      <li data-dojo-type="dojox.mobile.IconItem" 
          data-dojo-props='label:"app6", moveTo:"app6", icon:"images/icon6.png"'></li>
  </ul>
  <button data-dojo-type="dojox.mobile.Button" onclick="startEdit();">Start Edit</button>
  <button data-dojo-type="dojox.mobile.Button" onclick="endEdit();">End Edit</button>

.. image :: IconContainer-editable.gif


You can also handle events when edit mode starts/ends or when children IconItems are moved/deleted.
The example below handles those events by using the pub/sub feature. (See test_IconContainer-pubsub.html in the dojox/mobile/tests folder for a complete example.)

.. js ::

  require([
      "dojo/_base/connect",
      "dojo/ready",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/IconContainer"
  ], function(connect, ready){
      ready(function(){
          connect.subscribe("/dojox/mobile/startEdit", function(iconContainer){
              console.log("StartEdit");
          });
          connect.subscribe("/dojox/mobile/endEdit", function(iconContainer){
              console.log("EndEdit");
          });
          connect.subscribe("/dojox/mobile/deleteIconItem", function(iconContainer, widget){
              console.log("DeleteIconItem: " + widget.label);
          });
          connect.subscribe("/dojox/mobile/moveIconItem", function(iconContainer, widget, from, to){
              console.log("MoveIconItem: " + widget.label + " (" + from + " -> " + to + ")");
          });
      })
  });

An another example below handles those events by connecting to the callback functions of the IconContainer widget. (See test_IconContainer-connect.html in the dojox/mobile/tests folder for a complete example.)

.. js ::

  require([
      "dojo/_base/connect",
      "dojo/ready",
      "dijit/registry",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/IconContainer"
  ], function(connect, ready, registry){
      ready(function(){
          var ic = registry.byId("iconContainer1");
          connect.connect(ic, "onStartEdit", null, function(){
              console.log("StartEdit");
          });
          connect.connect(ic, "onEndEdit", null, function(){
              console.log("EndEdit");
          });
          connect.connect(ic, "onDeleteItem", null, function(widget){
              console.log("DeleteIconItem: " + widget.label);
          });
          connect.connect(ic, "onMoveItem", null, function(widget, from, to){
              console.log("MoveIconItem: " + widget.label + " (" + from + " -> " + to + ")");
          });
      })
  });
