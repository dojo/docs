#format dojo_rst

dojox.mobile.Heading
====================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz, Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama, Jared Jurkiewicz
:Available: since V1.5

.. contents::
    :depth: 2

Heading is a widget that represents a navigation bar, which usually appears at the top of an application. It usually displays the title of the current view and can contain a navigational control.
If you use it with ScrollableView, it can also be used as a fixed header bar or a fixed footer bar. In such cases, specify the fixed="top" attribute to be a fixed header bar or the fixed="bottom" attribute to be a fixed footer bar.
Heading can have one or more ToolBarButton widgets as its children.

.. image:: Heading.png

======================
Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Required |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|back          |String 	  |No       |A label for the navigational control to return to the previous View.                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|href 	       |String    |No       |A URL to open when the navigational control is pressed.                                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|moveTo        |String    |No       |An id of a View to which the current view moves when the navigational control is pressed.                  |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |No       |A type of animated transition effect. "slide", "fade", "flip", or "none". The default value is "slide".    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|label 	       |String    |No       |A title text of the heading. If the label is not specified, the innerHTML of the node is used as a label   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconBase      |String    |No       |The default icon path for child items. If a child item does not have its own icon parameter specified,     |
|              |          |         |this value is used as its icon path. This parameter is especially useful when all or most of the icons are |
|              |          |         |the same, or you use CSS sprite icons, where you specify an aggregated icon image with this parameter and  |
|              |          |         |an icon position for each icon.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

========
Examples
========

Example 1
---------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" back="Settings" moveTo="settings">General</h1>

.. image:: Heading-general.png


Example 2
---------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" label="World Clock">
    <div dojoType="dojox.mobile.ToolBarButton" style="padding: 0px 14px">Edit</div>
    <div dojoType="dojox.mobile.ToolBarButton" class="mblDomButton mblDomButtonPlus_2" style="float:right;"></div>
  </h1>

.. image:: Heading-world.png


Example 3
---------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" label="Voice Memos">
    <div dojoType="dojox.mobile.ToolBarButton" label="Speaker"></div>
    <div dojoType="dojox.mobile.ToolBarButton" label="Done" class="mblColorBlue" style="width:45px;float:right;"></div>
  </h1>

.. image:: Heading-voice.png


Example 4
---------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" label="Updates">
    <!-- dummy hidden button to center the label -->
    <div dojoType="dojox.mobile.ToolBarButton" label="Update All" style="visibility:hidden;"></div>
    <div dojoType="dojox.mobile.ToolBarButton" label="Update All" style="float:right;"></div>
  </h1>

.. image:: Heading-update.png


Example 5
---------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" label="News" back="Bookmarks" moveTo="bookmarks">
    <div dojoType="dojox.mobile.ToolBarButton" label="Done" class="mblColorBlue" style="width:45px;float:right;"></div>
  </h1>

.. image:: Heading-news.png


Example 6
---------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading">
    <div dojoType="dojox.mobile.ToolBarButton" label="Done" class="mblColorBlue"></div>
    <div dojoType="dojox.mobile.ToolBarButton" label="New Folder" style="float:right;"></div>
  </h1>

.. image:: Heading-done.png


Example 7
---------
.. code-block :: html

  <div dojoType="dojox.mobile.Heading">
    <div dojoType="dojox.mobile.ToolBarButton" toggle="true">New</div>
    <div dojoType="dojox.mobile.ToolBarButton" toggle="true">Toggle</div>
    <div dojoType="dojox.mobile.ToolBarButton" icon="images/a-icon-12.png" moveTo="view3"></div>
    <div dojoType="dojox.mobile.ToolBarButton" icon="images/tab-icons.png" iconPos="29,0,29,29" moveTo="view3"></div>
    <div dojoType="dojox.mobile.ToolBarButton" class="mblDomButton mblDomButtonPlus_2" moveTo="view3" style="float:right;"></div>
  </div>

.. image:: Heading-toggle.png


Example 8
---------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading">
    <ul dojoType="dojox.mobile.TabBar" barType="segmentedControl" style="float:left;margin-left:6px;">
      <li dojoType="dojox.mobile.TabBarButton" style="width:80px" selected="true">Catalog</li>
      <li dojoType="dojox.mobile.TabBarButton" style="width:80px">Share</li>
      <li dojoType="dojox.mobile.TabBarButton" style="width:80px">Download</li>
    </ul>
    <div dojoType="dojox.mobile.ToolBarButton" class="mblDomButton mblDomButtonSearch_2" style="float:right;"></div>
  </h1>

.. image:: Heading-catalog.png


Example 9
---------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" align="center">
    <table cellpadding="0" cellspacing="0" style="width:100%;"><tr>
    <td><div dojoType="dojox.mobile.ToolBarButton" class="mblDomButton mblDomButtonPlus_2"></div></td>
    <td align="center"><div dojoType="dojox.mobile.TabBar" barType="segmentedControl" style="margin:auto;">
      <div dojoType="dojox.mobile.TabBarButton" selected="true" style="width:80px">Search</div>
      <div dojoType="dojox.mobile.TabBarButton" style="width:80px">Directions</div>
    </div></td>
    <td align="right"><div dojoType="dojox.mobile.ToolBarButton" icon="images/tab-icon-15h.png" style="float:right;"></div></td>
    </tr></table>
  </h1>

.. image:: Heading-search.png


Example 10
----------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" back="Inbox" label="1 of 10">
    <ul dojoType="dojox.mobile.TabBar" barType="segmentedControl" style="float:right;margin-right:6px;">
      <li dojoType="dojox.mobile.TabBarButton" class="mblDomButton mblDomButtonUpArrow_2" selectOne="false"></li>
      <li dojoType="dojox.mobile.TabBarButton" class="mblDomButton mblDomButtonDownArrow_2" selectOne="false"></li>
    </ul>
  </h1>

.. image:: Heading-inbox.png


Example 11
----------
.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" back="Top" label="Inbox(32)">
    <div dojoType="dojox.mobile.ToolBarButton" class="mblDomButton mblDomButtonSearch_2" style="float:right;"></div>
    <div dojoType="dojox.mobile.ToolBarButton" class="mblDomButton mblDomButtonUpArrow_2" style="float:right;"></div>
    <div dojoType="dojox.mobile.ToolBarButton" class="mblDomButton mblDomButtonDownArrow_2" style="float:right;"></div>
  </h1>

.. image:: Heading-top.png
