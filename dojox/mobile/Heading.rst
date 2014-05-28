.. _dojox/mobile/Heading:

====================
dojox/mobile/Heading
====================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

Heading is a widget that represents a navigation bar, which usually appears at the top of an application. It usually displays the title of the current view and can contain a navigational control.
If you use it with :ref:`dojox/mobile/ScrollableView <dojox/mobile/ScrollableView>`, it can also be used as a fixed header bar or a fixed footer bar. In such cases, specify the fixed="top" attribute to be a fixed header bar or the fixed="bottom" attribute to be a fixed footer bar.
Heading can have one or more ToolBarButton widgets as its children.

.. image :: Heading.png

Constructor Parameters
======================

+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default       |Description                                                                                                |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|back          |String    |""            |A label for the navigational control to return to the previous View.                                       |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|href          |String    |""            |A URL to open when the navigational control is pressed.                                                    |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|moveTo        |String    |""            |The id of the transition destination of the navigation control. If the value has a hash sign               |
|              |          |              |('#') before the id (e.g. #view1) and the dojox/mobile/bookmarkable module is loaded by the user           |
|              |          |              |application, the view transition updates the hash in the browser URL so that the user can bookmark the     |
|              |          |              |destination view. In this case, the user can also use the browser's back/forward button to navigate through|
|              |          |              |the views in the browser history. If null, transitions to a blank view. If '#', returns to the previous    |
|              |          |              |view immediately without transition.                                                                       |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |"slide"       |A type of animated transition effect. You can choose from the standard transition types, "slide", "fade",  |
|              |          |              |"flip", or from the extended transition types, "cover", "coverv", "dissolve", "reveal", "revealv",         |
|              |          |              |"scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut", "cube", and "swap". If "none" is specified, |
|              |          |              |transition occurs immediately without animation.                                                           |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|label         |String    |""            |A title text of the heading. If the label is not specified, the innerHTML of the node is used as a label.  |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|iconBase      |String    |""            |The default icon path for child items. If a child item does not have its own icon parameter specified,     |
|              |          |              |this value is used as its icon path. This parameter is especially useful when all or most of the icons are |
|              |          |              |the same, or you use CSS sprite icons, where you specify an aggregated icon image with this parameter and  |
|              |          |              |an icon position for each icon.                                                                            |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|tag           |String    |"h1"          |A name of html tag to create as domNode.                                                                   |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|busy          |Boolean   |false         |If true, a progress indicator spins on this widget.                                                        |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|progStyle     |String    |"mblProgWhite"|A css class name to add to the progress indicator.                                                         |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Example 1
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading"
       data-dojo-props='back:"Settings", moveTo:"settings"'>General</div>

.. image :: Heading-general.png

Programmatic:

.. js ::

  require([
    "dojo/dom",
    "dojo/ready",
    "dojox/mobile/Heading"
  ], function(dom, ready, Heading){
    ready(function(){
      var heading = new Heading({
                       id: "viewHeading",
                       label: "General",
                       back: "Settings",
                       moveTo: "settings"
                    });
      heading.placeAt(document.body);
      heading.startup();
    });
  });

Example 2
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading" data-dojo-props='label:"World Clock"'>
    <span data-dojo-type="dojox/mobile/ToolBarButton">Edit</span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhitePlus"'
          style="float:right;" onclick="console.log('+ was clicked')"></span>
  </div>

.. image :: Heading-world.png

Programmatic:

.. js ::

  require([
    "dojo/dom",
    "dojo/ready",
    "dojox/mobile/Heading",
    "dojox/mobile/ToolBarButton"
  ], function(dom, ready, Heading, ToolBarButton){
    ready(function(){
      var heading = new Heading({
        id: "viewHeading",
        label: "World Clock"
      });
      heading.addChild(new ToolBarButton({label:"Edit"}));
      var tb = new ToolBarButton({
        icon:"mblDomButtonWhitePlus",
        style:"float:right;"
      });
      tb.on("click", function(){ console.log('+ was clicked'); });
      heading.addChild(tb);
      heading.placeAt(document.body);
      heading.startup();
    });
  });


Example 3
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading" data-dojo-props='label:"Voice Memos"'>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='label:"Speaker"'></span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='label:"Done",defaultColor:"mblColorBlue"'
          style="float:right;"></span>
  </div>

.. image :: Heading-voice.png

Example 4
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading" data-dojo-props='label:"Updates"'>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='label:"Update All"' style="float:right;"></span>
  </div>

.. image :: Heading-update.png

Example 5
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading"
       data-dojo-props='label:"News", back:"Bookmarks", moveTo:"bookmarks"'>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='label:"Done",defaultColor:"mblColorBlue"'
          style="float:right;"></span>
  </div>

.. image :: Heading-news.png

Example 6
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading">
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='label:"Done",defaultColor="mblColorBlue"'></span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='label:"New Folder"'
          style="float:right;"></span>
  </div>

.. image :: Heading-done.png

Example 7
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading">
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='toggle:true'>New</span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='toggle:"true"'>Toggle</span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='icon:"images/tab-icon-18h.png", moveTo:"view3"'
          style="padding:0 10px"></span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='icon:"images/tab-icons.png", iconPos:"29,0,29,29", moveTo:"view3"'
          style="padding:0 10px"></span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhitePlus", moveTo:"view3"'
          style="float:right;"></span>
  </div>

.. image :: Heading-toggle.png

Example 8
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading">
    <ul data-dojo-type="dojox/mobile/TabBar" data-dojo-props='barType:"segmentedControl"'>
      <li data-dojo-type="dojox/mobile/TabBarButton" style="width:80px"
          data-dojo-props='selected:true'>Catalog</li>
      <li data-dojo-type="dojox/mobile/TabBarButton" style="width:80px">Share</li>
      <li data-dojo-type="dojox/mobile/TabBarButton" style="width:80px">Download</li>
    </ul>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteSearch"' style="float:right;"></span>
  </div>

.. image :: Heading-catalog.png

Example 9
---------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading">
    <table cellpadding="0" cellspacing="0" style="width:100%;"><tr>
    <td><span data-dojo-type="dojox/mobile/ToolBarButton"
              data-dojo-props='icon:"mblDomButtonWhitePlus"'></span></td>
    <td align="center"><div data-dojo-type="dojox/mobile/TabBar"
                            data-dojo-props='barType:"segmentedControl"' style="margin:auto;">
      <div data-dojo-type="dojox/mobile/TabBarButton"
           data-dojo-props='selected:true' style="width:80px">Search</div>
      <div data-dojo-type="dojox/mobile/TabBarButton" style="width:80px">Directions</div>
    </div></td>
    <td align="right"><span data-dojo-type="dojox/mobile/ToolBarButton"
                            data-dojo-props='icon:"images/tab-icon-15h.png"'
                            style="float:right;"></span></td>
    </tr></table>
  </div>

.. image :: Heading-search.png

Example 10
----------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading"
       data-dojo-props='back:"Inbox", label:"1 of 10"'>
    <ul data-dojo-type="dojox/mobile/TabBar"
        data-dojo-props='barType:"segmentedControl", selectOne:false'
        style="float:right;">
      <li data-dojo-type="dojox/mobile/TabBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteUpArrow"'></li>
      <li data-dojo-type="dojox/mobile/TabBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteDownArrow"'></li>
    </ul>
  </div>

.. image :: Heading-inbox.png

Example 11
----------

.. html ::

  <div data-dojo-type="dojox/mobile/Heading"
       data-dojo-props='back:"Top", label:"Inbox(32)"'>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteSearch"'
          style="float:right;"></span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteUpArrow"'
          style="float:right;"></span>
    <span data-dojo-type="dojox/mobile/ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteDownArrow"'
          style="float:right;"></span>
  </div>

.. image :: Heading-top.png
