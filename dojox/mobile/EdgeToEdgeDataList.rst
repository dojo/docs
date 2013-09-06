.. _dojox/mobile/EdgeToEdgeDataList:

===============================
dojox/mobile/EdgeToEdgeDataList
===============================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

*Deprecated*. Since V1.8, use :ref:`dojox/mobile/EdgeToEdgeStoreList <dojox/mobile/EdgeToEdgeStoreList>` instead.

EdgeToEdgeDataList is a subclass of :ref:`dojox/mobile/EdgeToEdgeList <dojox/mobile/EdgeToEdgeList>`
which can generate ListItems according to the given dojo/data store.

.. image :: EdgeToEdgeDataList.png

Constructor Parameters
======================

Inherited from dojox/mobile/EdgeToEdgeList
------------------------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |"slide"  |The default animated transition effect for child items. If a child item does not have its own transition   |
|              |          |         |parameter specified, this value is used as its animated transition type. You can choose from the standard  |
|              |          |         |transition types, "slide", "fade", "flip", or from the extended transition types, "cover", "coverv",       |
|              |          |         |"dissolve", "reveal", "revealv", "scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut", "cube",    |
|              |          |         |and "swap". If "none" is specified, transition occurs immediately without animation.                       |
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
|syncWithViews |Boolean   |false    |If true, this widget listens to view transition events to be synchronized with view's visibility.          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|editable      |Boolean   |false    |If true, the list can be re-ordered.                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|tag           |String    |"ul"     |A name of html tag to create as domNode.                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Inherited from dojox/mobile/_DataListMixin
------------------------------------------

+--------------+----------+----------------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default               |Description                                                                                                |
+--------------+----------+----------------------+-----------------------------------------------------------------------------------------------------------+
|append        |Boolean   |false                 |If true, refresh() does not clear the existing items.                                                      |
+--------------+----------+----------------------+-----------------------------------------------------------------------------------------------------------+
|itemMap       |Object    |null                  |An optional parameter mapping field names from the store to ItemList name.                                 |
|              |          |                      |Example: itemMap:{text:'label', profile_image_url:'icon' }                                                 |
+--------------+----------+----------------------+-----------------------------------------------------------------------------------------------------------+
|itemRenderer  |Class     |dojox/mobile/ListItem |An optional property specifying the type of the ListItem instances that will be created by the mixin.      |
+--------------+----------+----------------------+-----------------------------------------------------------------------------------------------------------+

Inherited from dojox/mobile/_DataMixin
--------------------------------------

+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                        |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|store         |Object    |null     |Reference to data provider object used by this widget.                                                             |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|query         |Object    |null     |A query that can be passed to 'store' to initially filter the items. See `dojo/data <../../dojo/data/api.rst>`_    |
|              |          |         |for details.                                                                                                       |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|queryOptions  |Object    |null     |An optional parameter for the query. See `dojo/data <../../dojo/data/api.rst>`_ for details.                       |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

In this example, no ListItem is defined as children of EdgeToEdgeDataList. The ListItems are generated according to sample.json. Each item in the json object is used as attributes for ListItem.

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/EdgeToEdgeDataList",
      "dojo/data/ItemFileReadStore"
  ]);

.. html ::

  <div data-dojo-type="dojo/data/ItemFileReadStore" 
              data-dojo-id="sampleStore" data-dojo-props='url:"sample.json"'></div>
  <ul data-dojo-type="dojox/mobile/EdgeToEdgeDataList" data-dojo-props='store:sampleStore'>
  </ul>

.. js ::

  // sample.json
  {
      "items": [
          { "label": "Wi-Fi", "icon": "images/i-icon-3.png", "rightText": "Off", "moveTo": "bar" },
          { "label": "VPN", "icon": "images/i-icon-4.png", "rightText": "VPN", "moveTo": "bar" }
      ]
  }

.. image :: EdgeToEdgeDataList-example1.png

Programmatic example
--------------------

.. js ::

  require([
      "dojo/ready",
      "dojo/data/ItemFileReadStore",
      "dojox/mobile/EdgeToEdgeDataList",
      "dojox/mobile",
      "dojox/mobile/parser"
  ], function(ready, ItemFileReadStore, EdgeToEdgeDataList){
      ready(function(){
          var storeData = {
              "items": [
                  { "label": "Wi-Fi", "icon": "images/i-icon-3.png", "rightText": "Off", "moveTo": "bar" },
                  { "label": "VPN", "icon": "images/i-icon-4.png", "rightText": "VPN", "moveTo": "bar" }
              ]
          };
          var sampleStore = new ItemFileReadStore({data:storeData});
          var dataList = new EdgeToEdgeDataList({store:sampleStore}, "dataList");
          dataList.startup();
      });
  });

.. html ::

  <ul id="dataList"></ul>

.. image :: EdgeToEdgeDataList-example1.png

Filtering items
---------------

You can initially filter items by using "query" parameter. This example filters the items with label ending with "e".

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/EdgeToEdgeDataList",
      "dojo/data/ItemFileReadStore"
  ]);

.. html ::

  <div data-dojo-type="dojo/data/ItemFileReadStore" 
              data-dojo-id="sampleStore" data-dojo-props='url:"sample2.json"'></div>
  <ul data-dojo-type="dojox/mobile/EdgeToEdgeDataList" 
              data-dojo-props='store:sampleStore, query:{label:"*e"}'>
  </ul>

.. js ::

  // sample2.json
  {
      "items": [
          {label: "Apple", moveTo: "details"},
          {label: "Banana", moveTo: "details"},
          {label: "Cherry", moveTo: "details"},
          {label: "Grape", moveTo: "details"},
          {label: "Kiwi", moveTo: "details"},
          {label: "Lemon", moveTo: "details"},
          {label: "Melon", moveTo: "details"},
          {label: "Orange", moveTo: "details"},
          {label: "Peach", moveTo: "details"}
      ]
  }

.. image :: EdgeToEdgeDataList-example2.png

Using custom parameter mappings
-------------------------------

If you want to define custom parameter mappings from store object data fields to ListItem properties, you can use "itemMap" parameter.
This example maps "name" and "count" fields in the json data to "label" and "rightText" properties of ListItem respectively.

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/EdgeToEdgeDataList",
      "dojo/data/ItemFileReadStore"
  ]);

.. html ::

  <div data-dojo-type="dojo/data/ItemFileReadStore" 
              data-dojo-id="sampleStore" data-dojo-props='url:"sample3.json"'></div>
  <ul data-dojo-type="dojox/mobile/EdgeToEdgeDataList" 
              data-dojo-props='store:sampleStore, itemMap:{name:"label", count:"rightText"}'>
  </ul>

.. js ::

  // sample3.json
  {
      "items": [
          {name: "Apple", count: "10", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Banana", count: "20", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Cherry", count: "30", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Grape", count: "40", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Kiwi", count: "50", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Lemon", count: "40", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Melon", count: "30", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Orange", count: "20", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Peach", count: "10", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"}
      ]
  }

.. image :: EdgeToEdgeDataList-example3.png

Filtered list example
---------------------

See :ref:`FilteredListMixin <dojox/mobile/FilteredListMixin#declarative-example-filtered-edgetoedgedatalist>`.
