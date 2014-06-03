.. _dojox/mobile/Accordion:

======================
dojox/mobile/Accordion
======================

:Authors: Yoshiroh Kamiyama, Atsushi Ono
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox/mobile/Accordion is a container widget that can display a group of child panes 
in a stacked format.

Typically, :ref:`dojox/mobile/Pane <dojox/mobile/Pane>`, :ref:`dojox/mobile/Container <dojox/mobile/Container>`, 
or :ref:`dojox/mobile/ContentPane <dojox/mobile/ContentPane>` are used as child widgets, but Accordion 
requires no specific child widget. Accordion supports three modes for opening child panes: 
multiselect, fixed-height, and single-select. Accordion can have rounded corners, and it can 
lazy-load the content modules.

.. image :: Accordion.gif

Parameters for Child Widgets
============================

Child widgets of an Accordion take the following parameters, which are referenced by the Accordion widget.

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|alt           |String    |""       |An alt text for the icon image.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|icon1         |String    |         |A path for the collapsed pane's title bar icon. If icon is not specified, the iconBase parameter of the    |
|              |          |         |parent widget is used.                                                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|icon2         |String    |         |A path for the open pane's title bar icon. If icon is not specified, the iconBase parameter of the parent  |
|              |          |         |widget or icon1 is used.                                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos1      |String    |         |The position of an aggregated collapsed pane's title bar icon icon. IconPos1 is comma separated values like|
|              |          |         |top,left,width,height (ex. "0,0,29,29"). If iconPos1 is not specified, the iconPos parameter of the parent |
|              |          |         |widget is used.                                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos2      |String    |         |The position of an aggregated open pane's title bar icon icon. IconPos2 is comma separated values like     |
|              |          |         |top,left,width,height (ex. "0,0,29,29"). If iconPos2 is not specified, the iconPos parameter of the parent |
|              |          |         |widget or iconPos1 is used.                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|selected      |Boolean   |false    |If true, the pane is opened at start up time.                                                              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|lazy          |Boolean   |false    |If true, the content of the pane, which includes dojo markup, is instantiated lazily. That is, only when   |
|              |          |         |the pane is opened by the user, the required modules are loaded and dojo widgets are instantiated.         |
|              |          |         |This option works only in the sync loader mode.                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconBase      |String    |""       |The default icon path for child widgets. If a child widget does not have its own icon parameter specified, |
|              |          |         |this value is used as its icon path. This parameter is especially useful when all or most of the icons are |
|              |          |         |the same, or you use CSS sprite icons, where you specify an aggregated icon image with this parameter and  |
|              |          |         |an icon position for each icon.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |""       |The default icon position for child widgets. This parameter is especially useful when all or most of the   |
|              |          |         |icons are the same.                                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|fixedHeight   |Boolean   |false    |If true, the entire accordion widget has fixed height regardless of the height of each pane.               |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|singleOpen    |Boolean   |false    |If true, only one pane is open at a time. The current open pane is collapsed, when another pane is opened. |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|animation     |Boolean   |true     |If true, animation is used when a pane is opened or collapsed. The animation works only on webkit browsers.|
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. html ::

  <!-- Need to load the theme file for Accordion widget as well as the base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Accordion']"></script>

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/Accordion",
      "dojox/mobile/ContentPane"
  ]);

.. html ::

  <div data-dojo-type="dojox/mobile/Accordion" data-dojo-props='iconBase:"images/icons16.png"'>
      <div data-dojo-type="dojox/mobile/ContentPane" 
           data-dojo-props='label:"External Content", iconPos1:"16,32,16,16", href:"data/fragment1.html"'>
      </div>
      <div data-dojo-type="dojox/mobile/ContentPane" 
           data-dojo-props='label:"RoundRectList", iconPos1:"16,48,16,16"'>
          <ul data-dojo-type="dojox/mobile/RoundRectList" data-dojo-props='iconBase:"images/tab-icon-11h.png"'>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"u1space", rightText:"Off"'>
              </li>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"u2space", rightText:"Off"'>
              </li>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"Wi-Fi", rightText:"Off"'>
              </li>
          </ul>
      </div>
  </div>

.. html ::

  <!-- data/fragment1.html (HTML fragment file) -->
  <div data-dojo-type="dojox/mobile/RoundRect" shadow="true">
      HTML fragment example
  </div>

.. image :: Accordion-example1.png

Programmatic example
--------------------

.. html ::

  <!-- Need to load the theme file for Accordion widget as well as the base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Accordion']"></script>

.. js ::

  require([
      "dojox/mobile/Accordion",
      "dojox/mobile/ContentPane",
      "dojox/mobile/RoundRectList",
      "dojox/mobile/ListItem",
      "dojox/mobile/parser",
      "dojox/mobile"
  ], function(Accordion, ContentPane, RoundRectList, ListItem){
      var accordion = new Accordion({iconBase: "images/icons16.png"}, "accordion1");
      accordion.startup();
      
      // ContentPane #1: External Content
      var pane = new ContentPane({
          label: "External Content",
          iconPos1: "16,32,16,16",
          href: "data/fragment1.html"
      });
      accordion.addChild(pane);
      
      // ContentPane #2: RoundRectList
      pane = new ContentPane({
          label: "RoundRectList",
          iconPos1: "16,48,16,16"
      });
      accordion.addChild(pane);
      
      var list = new RoundRectList({iconBase: "images/tab-icon-11h.png"});
      list.placeAt(pane.containerNode);
      list.startup();
      
      var item = new ListItem({label: "u1space", rightText: "Off"});
      list.addChild(item);
      
      item = new ListItem({label: "u2space", rightText: "Off"});
      list.addChild(item);
      
      item = new ListItem({label: "Wi-Fi", rightText: "Off"});
      list.addChild(item);
  });

.. html ::

  <div id="accordion1"></div>

.. html ::

  <!-- data/fragment1.html (HTML fragment file) -->
  <div data-dojo-type="dojox/mobile/RoundRect" shadow="true">
      HTML fragment example
  </div>

.. image :: Accordion-example1.png

Single open mode
----------------

By default, the Accordion widget allows users to open multiple panes at a time. 
But when you specify "singleOpen:true" property to the Accordion widget, it changes to the single open 
mode in which you can open only one pane at a time.

.. html ::

  <!-- Need to load the theme file for Accordion widget as well as the base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Accordion']"></script>

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/Accordion",
      "dojox/mobile/ContentPane",
      "dojox/mobile/ScrollableView"
  ]);

.. html ::

  <div data-dojo-type="dojox/mobile/Accordion" data-dojo-props='singleOpen:true'>
      <div data-dojo-type="dojox/mobile/ScrollableView" style="background-color:white"
           data-dojo-props='label:"ScrollableView", height:"100px"'>
          <div style="padding:10px;color:black;">
              A<br>B<br>C<br>D<br>E<br>F<br>G<br>H<br>I<br>J<br>K<br>L<br>M<br>N<br>
              O<br>P<br>Q<br>R<br>S<br>T<br>U<br>V<br>W<br>X<br>Y<br>Z
          </div>
      </div>
      <div data-dojo-type="dojox/mobile/ContentPane" 
           data-dojo-props='label:"External Content", href:"data/fragment1.html"'>
      </div>
      <div data-dojo-type="dojox/mobile/ContentPane" 
           data-dojo-props='label:"RoundRectList"'>
          <ul data-dojo-type="dojox/mobile/RoundRectList" data-dojo-props='iconBase:"images/tab-icon-11h.png"'>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"u1space", rightText:"Off"'>
              </li>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"u2space", rightText:"Off"'>
              </li>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"Wi-Fi", rightText:"Off"'>
              </li>
          </ul>
      </div>
  </div>

.. html ::

  <!-- data/fragment1.html (HTML fragment file) -->
  <div data-dojo-type="dojox/mobile/RoundRect" shadow="true">
      HTML fragment example
  </div>

.. image :: Accordion-example2.gif

Fixed height
------------

You can fix the height of the Accordion widget by specifying the "fixedHeight:true" property 
as described in the example below.
This example also applies the "mblAccordionRoundRect" style class to the Accordion widget to 
make it have a rounded rectangle shape.

.. html ::

  <!-- Need to load the theme file for Accordion widget as well as the base theme file -->
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Accordion']"></script>
  <!-- Stylesheets for expand/collapse icons -->
  <link href="../themes/common/domButtons/DomButtonBlackRightArrow16.css" rel="stylesheet"/>
  <link href="../themes/common/domButtons/DomButtonWhiteDownArrow16.css" rel="stylesheet"/>

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/Accordion",
      "dojox/mobile/ContentPane",
      "dojox/mobile/ScrollableView"
  ]);

.. html ::

  <div data-dojo-type="dojox/mobile/Accordion" style="height:250px;" class="mblAccordionRoundRect"
       data-dojo-props='fixedHeight:true'>
      <div data-dojo-type="dojox/mobile/ScrollableView" style="background-color:white"
           data-dojo-props='label:"ScrollableView", selected:true, height:"inherit", 
                            icon1:"mblDomButtonBlackRightArrow16", icon2:"mblDomButtonWhiteDownArrow16"'>
          <div style="padding:10px;color:black;">
              A<br>B<br>C<br>D<br>E<br>F<br>G<br>H<br>I<br>J<br>K<br>L<br>M<br>N<br>
              O<br>P<br>Q<br>R<br>S<br>T<br>U<br>V<br>W<br>X<br>Y<br>Z
          </div>
      </div>
      <div data-dojo-type="dojox/mobile/ContentPane" 
           data-dojo-props='label:"External Content", href:"data/fragment1.html",
                            icon1:"mblDomButtonBlackRightArrow16", icon2:"mblDomButtonWhiteDownArrow16"'>
      </div>
      <div data-dojo-type="dojox/mobile/ContentPane" 
           data-dojo-props='label:"RoundRectList", 
                            icon1:"mblDomButtonBlackRightArrow16", icon2:"mblDomButtonWhiteDownArrow16"'>
          <ul data-dojo-type="dojox/mobile/RoundRectList" data-dojo-props='iconBase:"images/tab-icon-11h.png"'>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"u1space", rightText:"Off"'>
              </li>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"u2space", rightText:"Off"'>
              </li>
              <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='label:"Wi-Fi", rightText:"Off"'>
              </li>
          </ul>
      </div>
  </div>

.. html ::

  <!-- data/fragment1.html (HTML fragment file) -->
  <div data-dojo-type="dojox/mobile/RoundRect" shadow="true">
      HTML fragment example
  </div>

.. image :: Accordion-example3.gif

Lazy loading
------------

If you would like to instantiate the widgets inside a child pane lazily, you can do so 
by specifying "lazy:true" property to the child widget.
In this example, the CalendarLite widget is instantiated when you open the child pane first time.

.. html ::

  <!-- Need to load the theme files for Accordion and dijit/Calendar -->
  <link href="dijit/themes/dijit.css" rel="stylesheet"/>
  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Accordion','dijit.Calendar']"></script>

.. js ::

  // No need to add "dijit/CalendarLite" since it's loaded lazily
  require([
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/Accordion",
      "dojox/mobile/ContentPane"
  ]); 

.. html ::

  <div data-dojo-type="dojox/mobile/Accordion">
      <div data-dojo-type="dojox/mobile/ContentPane" 
           data-dojo-props='label:"Calendar (Lazy)", lazy:true' height="304px">
          <div style="padding:10px">
              <!-- This widget is instantiated lazily -->
              <div data-dojo-type="dijit/CalendarLite"></div>
          </div>
      </div>
  </div>

.. image :: Accordion-example4.png
