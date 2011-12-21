.. _dojox/mobile/EdgeToEdgeDataList:

===============================
dojox.mobile.EdgeToEdgeDataList
===============================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

EdgeToEdgeDataList is an enhanced version of EdgeToEdgeList. It can generate ListItems according to the given dojo.data store.

Constructor Parameters
======================

Inherited from dojox.mobile._DataListMixin
------------------------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|store         |Object    |null     |Reference to data provider object used by this widget.                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|query         |Object    |null     |A query that can be passed to 'store' to initially filter the items.                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|queryOptions  |Object    |null     |A query options that can be passed to 'store' to initially filter the items.                               |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Inherited from dojox.mobile.EdgeToEdgeList
------------------------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |"slide"  |A type of animated transition effect. You can choose from the standard transition types, "slide", "fade",  |
|              |          |         |"flip", or from the extended transition types, "cover", "coverv", "dissolve", "reveal", "revealv",         |
|              |          |         |"scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut". If "none" is specified, transition occurs   |
|              |          |         |immediately without animation.                                                                             |
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

In this example, no ListItem is declared under EdgeToEdgeDataList. The ListItems are generated according to the sample.json. Each item in the json object is passed as the attributes of ListItem.

.. html ::

  <div data-dojo-type="dojo.data.ItemReadStore" jsId="sampleStore" url="sample.json"></div>
  <ul data-dojo-type="dojox.mobile.EdgeToEdgeDataList" store="sampleStore">
  </ul>

.. js ::

  // sample.json
  {
     "items": [
         { "label": "Wi-Fi", "icon": "images/i-icon-3.png", "rightText": "Off", "moveTo": "bar" },
         { "label": "VPN", "icon": "images/i-icon-4.png", "rightText": "VPN", "moveTo": "bar" }
     ]
  }

.. image :: EdgeToEdgeList-example1.png
