.. _dojox/mobile/EdgeToEdgeList:

===========================
dojox.mobile.EdgeToEdgeList
===========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

EdgeToEdgeList is an edge-to-edge layout list, which displays all items in equally sized rows. Each item must be dojox.mobile.ListItem.

.. image :: EdgeToEdgeList.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |"slide"  |The default animated transition effect for child items. If a child item does not have its own transition   |
|              |          |         |parameter specified, this value is used as its animated transition type. You can choose from the standard  |
|              |          |         |transition types, "slide", "fade", "flip", or from the extended transition types, "cover", "coverv",       |
|              |          |         |"dissolve", "reveal", "revealv", "scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut".            |
|              |          |         |If "none" is specified, transition occurs immediately without animation.                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconBase      |String    |""       |The default icon path for child items. If a child item does not have its own icon parameter specified,     |
|              |          |         |this value is used as its icon path. This parameter is especially useful when all or most of the icons are |
|              |          |         |the same, or you use CSS sprite icons, where you specify an aggregated icon image with this parameter and  |
|              |          |         |an icon position for each icon.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |""       |The default icon position for child items. This parameter is especially useful when all or most of the     |
|              |          |         |icons are the same.                                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|select        |String    |""       |Selection mode of the list. The check mark is shown for the selected list item(s). The value can be        |
|              |          |         |"single", "multiple", or "". If "single", there can be only one selected item at a time. If "multiple",    |
|              |          |         |there can be multiple selected items at a time.                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|stateful      |Boolean   |false    |If true, the last selected item remains highlighted.                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

In this example, <ul> and <li> are used just because they are typically used to create a list in html. You can use <div> instead.

.. html ::

  <ul data-dojo-type="dojox.mobile.EdgeToEdgeList">
    <li data-dojo-type="dojox.mobile.ListItem" icon="images/i-icon-3.png" rightText="Off" moveTo="bar">
      Wi-Fi
    </li>
    <li data-dojo-type="dojox.mobile.ListItem" icon="images/i-icon-4.png" rightText="VPN" moveTo="bar">
      VPN
    </li>
  </ul>

.. image :: EdgeToEdgeList-example1.png

CSS sprite example
------------------

In this example, an aggregated icon image as below is used for each list item icon. This way the number of requests to the server can be reduced and thus the performance could be improved.

.. image :: all-icons.png

(all-icons.png)

.. html ::

  <ul data-dojo-type="dojox.mobile.EdgeToEdgeList" iconBase="images/i-icon-all.png">
    <li data-dojo-type="dojox.mobile.ListItem" iconPos="0,0,29,29">
      Airplane Mode
      <div class="mblItemSwitch" data-dojo-type="dojox.mobile.Switch"></div>
    </li>
    <li data-dojo-type="dojox.mobile.ListItem" iconPos="0,29,29,29" rightText="mac" href="test_iPhone-Icon.html">
      Wi-Fi
    </li>
    <li data-dojo-type="dojox.mobile.ListItem" iconPos="0,58,29,29" rightText="AcmePhone" moveTo="general">
      Carrier
    </li>
  </ul>

.. image :: EdgeToEdgeList-example2.png

Selection mode example
----------------------

.. html ::

  <h2 data-dojo-type="dojox.mobile.EdgeToEdgeCategory">Single Select</h2>
  <ul data-dojo-type="dojox.mobile.EdgeToEdgeList" select="single">
    <li data-dojo-type="dojox.mobile.ListItem" checked="true">Cube</li>
    <li data-dojo-type="dojox.mobile.ListItem">Dissolve</li>
    <li data-dojo-type="dojox.mobile.ListItem">Ripple</li>
  </ul>

  <h2 data-dojo-type="dojox.mobile.EdgeToEdgeCategory">Multiple Select</h2>
  <ul data-dojo-type="dojox.mobile.EdgeToEdgeList" select="multiple">
    <li data-dojo-type="dojox.mobile.ListItem">Cube</li>
    <li data-dojo-type="dojox.mobile.ListItem">Dissolve</li>
    <li data-dojo-type="dojox.mobile.ListItem">Ripple</li>
  </ul>

.. image :: EdgeToEdgeList-check.png
