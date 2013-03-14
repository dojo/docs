.. _dojox/mobile/RoundRectStoreList:

===============================
dojox/mobile/RoundRectStoreList
===============================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

RoundRectStoreList is a subclass of :ref:`dojox/mobile/RoundRectList <dojox/mobile/RoundRectList>`
which can generate ListItems according to the given dojo/store store.

.. image :: RoundRectStoreList.png

Constructor Parameters
======================

Inherited from dojox/mobile/RoundRectList
-----------------------------------------

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
|              |          |         |there can be multiple selected items at a time. If "", the check mark is not shown.                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|stateful      |Boolean   |false    |If true, the last selected item remains highlighted.                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|syncWithViews |Boolean   |false    |If true, this widget listens to view transition events to be synchronized with view's visibility.          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|editable      |Boolean   |false    |If true, the list can be re-ordered.                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|tag           |String    |"ul"     |A name of html tag to create as domNode.                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Inherited from dojox/mobile/_StoreListMixin
-------------------------------------------

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

Inherited from dojox/mobile/_StoreMixin
---------------------------------------

+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|Parameter       |Type      |Default   |Description                                                                                             |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|store           |Object    |null      |Reference to data provider object used by this widget.                                                  |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|query           |Object    |null      |A query that can be passed to 'store' to initially filter the items.                                    |
|                |          |          |See `dojo/store <../../dojo/store>`_ for details.                                                       |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|queryOptions    |Object    |null      |An optional parameter for the query. See `dojo/store <../../dojo/store>`_ for details.                  |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|labelProperty   |String    |"label"   |A property name (a property in the dojo/store item) that specifies that item's label.                   |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+
|childrenProperty|String    |"children"|A property name (a property in the dojo/store item) that specifies that item's children.                |
+----------------+----------+----------+--------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

In this example, no ListItem is declared under RoundRectStoreList. The ListItems are generated according to json data in the store object. Each item in the json object is passed as the attributes of ListItem.

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/RoundRectStoreList",
      "dojo/store/Memory"
  ], function(){
      storeData = [
          { "label": "Wi-Fi", "icon": "images/i-icon-3.png", "rightText": "Off", "moveTo": "bar" },
          { "label": "VPN", "icon": "images/i-icon-4.png", "rightText": "VPN", "moveTo": "bar" }
      ];
  });

.. html ::

  <div data-dojo-type="dojo/store/Memory" data-dojo-id="sampleStore" 
              data-dojo-props='data:storeData, idProperty:"label"'></div>
  <ul data-dojo-type="dojox/mobile/RoundRectStoreList" 
              data-dojo-props='store:sampleStore'>
  </ul>

.. image :: RoundRectStoreList-example1.png

Programmatic example
--------------------

.. js ::

  require([
      "dojo/ready",
      "dojo/store/Memory",
      "dojox/mobile/RoundRectStoreList",
      "dojox/mobile",
      "dojox/mobile/parser"
  ], function(ready, Memory, RoundRectStoreList){
      ready(function(){
          var storeData = [
              { "label": "Wi-Fi", "icon": "images/i-icon-3.png", "rightText": "Off", "moveTo": "bar" },
              { "label": "VPN", "icon": "images/i-icon-4.png", "rightText": "VPN", "moveTo": "bar" }
          ];
          var sampleStore = new Memory({data:storeData, idProperty:"label"});
          var storeList = new RoundRectStoreList({store:sampleStore}, "storeList");
          storeList.startup();
      });
  });

.. html ::

  <ul id="storeList"></ul>

.. image :: RoundRectStoreList-example1.png

Filtering items
---------------

You can initially filter items by using "query" parameter. This example filters the items with label ending with "e".

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/RoundRectStoreList",
      "dojo/store/Memory"
  ], function(){
      storeData2 = [
          {label: "Apple", moveTo: "dummy"},
          {label: "Banana", moveTo: "dummy"},
          {label: "Cherry", moveTo: "dummy"},
          {label: "Grape", moveTo: "dummy"},
          {label: "Kiwi", moveTo: "dummy"},
          {label: "Lemon", moveTo: "dummy"},
          {label: "Melon", moveTo: "dummy"},
          {label: "Orange", moveTo: "dummy"},
          {label: "Peach", moveTo: "dummy"}
      ];
  });

.. html ::

  <div data-dojo-type="dojo/store/Memory" data-dojo-id="sampleStore" 
              data-dojo-props='data:storeData2, idProperty:"label"'></div>
  <ul data-dojo-type="dojox/mobile/RoundRectStoreList" 
              data-dojo-props='store:sampleStore, query:{label:/e$/}'>
  </ul>

.. image :: RoundRectStoreList-example2.png

Using custom parameter mappings
-------------------------------

If you want to define custom parameter mappings from data fields in store object to ListItem properties, you can use "itemMap" parameter.
This example maps "name" and "count" fields in the json data to "label" and "rightText" properties of ListItem respectively.

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/RoundRectStoreList",
      "dojo/store/Memory"
  ], function(){
      storeData3 = [
          {name: "Apple", count: "10", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Banana", count: "20", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Cherry", count: "30", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Grape", count: "40", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Kiwi", count: "50", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Lemon", count: "40", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Melon", count: "30", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Orange", count: "20", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"},
          {name: "Peach", count: "10", moveTo: "details", icon: "mblDomButtonDarkBlueCheck"}
      ];
  });

.. html ::

  <div data-dojo-type="dojo/store/Memory" data-dojo-id="sampleStore" 
              data-dojo-props='data:storeData3, idProperty:"name"'></div>
  <ul data-dojo-type="dojox/mobile/RoundRectStoreList" 
              data-dojo-props='store:sampleStore, itemMap:{name:"label", count:"rightText"}'>
  </ul>

.. image :: RoundRectStoreList-example3.png

Categorized data
----------------

RoundRectStoreList can handle nested data to display categorized list.
The items listed in the "children" field of each item are displayed as children of the item. The field name can be specified with the "childrenProperty" parameter. (In the example below, childrenProperty can be omitted since "children" is its default value.)

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/RoundRectStoreList",
      "dojo/store/Memory"
  ], function(){
      storeData4 = [
          { label: "Fruits", header: true,
            children: [
                { label: "Apple", icon: "images/i-icon-9.png", moveTo: "fruit" },
                { label: "Grape", icon: "images/i-icon-7.png", moveTo: "fruit" },
                { label: "Orange", icon: "images/i-icon-1.png", moveTo: "fruit" }
            ]
          },
          { label: "Vegetables", header: true,
            children: [
                { label: "Lettuce", icon: "images/i-icon-2.png", moveTo: "vegetable" },
                { label: "Potato", icon: "images/i-icon-8.png", moveTo: "vegetable" },
                { label: "Tomato", icon: "images/i-icon-9.png", moveTo: "vegetable" }
            ]
          }
      ];
  });

.. html ::

  <div data-dojo-type="dojo/store/Memory" data-dojo-id="sampleStore" 
              data-dojo-props='data:storeData4, idProperty:"label"'></div>
  <ul data-dojo-type="dojox/mobile/RoundRectStoreList" 
              data-dojo-props='store:sampleStore, childrenProperty:"children"'>
  </ul>

.. image :: RoundRectStoreList-example4.png

Filtered list example
---------------------

See :ref:`FilteredListMixin <dojox/mobile/FilteredListMixin>`.
