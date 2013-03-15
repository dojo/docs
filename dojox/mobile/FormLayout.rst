.. _dojox/mobile/FormLayout:

=======================
dojox.mobile.FormLayout
=======================

:since: V1.9

.. contents ::
    :depth: 2

Introduction
============

FormLayout is a widget which layouts form controls. Each control is associated with a label. Two layouts are supported using the columns property: single and two columns. A third option is to set the columns property to "auto". In this case the layout is determined by the width of the screen: A single column if the screen width is lower than 500px, two columns otherwise.

Each element of a form is made of a <label> and a <fieldset> that contains one or more form widgets.
Form controls are: "dojox/mobile/Button", "dojox/mobile/CheckBox", "dojox/mobile/ComboBox", "dojox/mobile/RadioButton", "dojox/mobile/Slider", "dojox/mobile/TextBox", "dojox/mobile/SearchBox", "dojox/mobile/ExpandingTextArea", "dojox/mobile/ToggleButton".

.. image :: FormLayout1.png

.. image :: FormLayout2.png

.. image :: FormLayout3.png

Examples
========

Example 1
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading"
       data-dojo-props='back:"Settings", moveTo:"settings"'>General</div>

.. image :: Heading-general.png

Example 2
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading" data-dojo-props='label:"World Clock"'>
    <span data-dojo-type="dojox.mobile.ToolBarButton">Edit</span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhitePlus"'
          style="float:right;" onclick="console.log('+ was clicked')"></span>
  </div>

.. image :: Heading-world.png

Example 3
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading" data-dojo-props='label:"Voice Memos"'>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='label:"Speaker"'></span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='label:"Done",defaultColor:"mblColorBlue"'
          style="float:right;"></span>
  </div>

.. image :: Heading-voice.png

Example 4
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading" data-dojo-props='label:"Updates"'>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='label:"Update All"' style="float:right;"></span>
  </div>

.. image :: Heading-update.png

Example 5
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading"
       data-dojo-props='label:"News", back:"Bookmarks", moveTo:"bookmarks"'>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='label:"Done",defaultColor:"mblColorBlue"'
          style="float:right;"></span>
  </div>

.. image :: Heading-news.png

Example 6
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading">
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='label:"Done",defaultColor="mblColorBlue"'></span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='label:"New Folder"'
          style="float:right;"></span>
  </div>

.. image :: Heading-done.png

Example 7
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading">
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='toggle:true'>New</span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='toggle:"true"'>Toggle</span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='icon:"images/tab-icon-18h.png", moveTo:"view3"'
          style="padding:0 10px"></span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='icon:"images/tab-icons.png", iconPos:"29,0,29,29", moveTo:"view3"'
          style="padding:0 10px"></span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhitePlus", moveTo:"view3"'
          style="float:right;"></span>
  </div>

.. image :: Heading-toggle.png

Example 8
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading">
    <ul data-dojo-type="dojox.mobile.TabBar" data-dojo-props='barType:"segmentedControl"'>
      <li data-dojo-type="dojox.mobile.TabBarButton" style="width:80px"
          data-dojo-props='selected:true'>Catalog</li>
      <li data-dojo-type="dojox.mobile.TabBarButton" style="width:80px">Share</li>
      <li data-dojo-type="dojox.mobile.TabBarButton" style="width:80px">Download</li>
    </ul>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteSearch"' style="float:right;"></span>
  </div>

.. image :: Heading-catalog.png

Example 9
---------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading">
    <table cellpadding="0" cellspacing="0" style="width:100%;"><tr>
    <td><span data-dojo-type="dojox.mobile.ToolBarButton"
              data-dojo-props='icon:"mblDomButtonWhitePlus"'></span></td>
    <td align="center"><div data-dojo-type="dojox.mobile.TabBar"
                            data-dojo-props='barType:"segmentedControl"' style="margin:auto;">
      <div data-dojo-type="dojox.mobile.TabBarButton"
           data-dojo-props='selected:true' style="width:80px">Search</div>
      <div data-dojo-type="dojox.mobile.TabBarButton" style="width:80px">Directions</div>
    </div></td>
    <td align="right"><span data-dojo-type="dojox.mobile.ToolBarButton"
                            data-dojo-props='icon:"images/tab-icon-15h.png"'
                            style="float:right;"></span></td>
    </tr></table>
  </div>

.. image :: Heading-search.png

Example 10
----------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading"
       data-dojo-props='back:"Inbox", label:"1 of 10"'>
    <ul data-dojo-type="dojox.mobile.TabBar"
        data-dojo-props='barType:"segmentedControl", selectOne:false'
        style="float:right;">
      <li data-dojo-type="dojox.mobile.TabBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteUpArrow"'></li>
      <li data-dojo-type="dojox.mobile.TabBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteDownArrow"'></li>
    </ul>
  </div>

.. image :: Heading-inbox.png

Example 11
----------

.. html ::

  <div data-dojo-type="dojox.mobile.Heading"
       data-dojo-props='back:"Top", label:"Inbox(32)"'>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteSearch"'
          style="float:right;"></span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteUpArrow"'
          style="float:right;"></span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='icon:"mblDomButtonWhiteDownArrow"'
          style="float:right;"></span>
  </div>

.. image :: Heading-top.png
