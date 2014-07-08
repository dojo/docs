.. _dojox/mobile/LongListMixin:

==============================
dojox/mobile/LongListMixin
==============================

:since: V1.9

.. contents ::
    :depth: 2

Introduction
============

This mixin enhances scrolling performances of dojox/mobile list widgets, that is, instances of
:ref:`dojox/mobile/RoundRectList <dojox/mobile/RoundRectList>` and any of its subclasses:

* :ref:`dojox/mobile/RoundRectStoreList <dojox/mobile/RoundRectStoreList>`
* :ref:`dojox/mobile/RoundRectDataList <dojox/mobile/RoundRectDataList>`
* :ref:`dojox/mobile/EdgeToEdgeList <dojox/mobile/EdgeToEdgeList>`
* :ref:`dojox/mobile/EdgeToEdgeStoreList <dojox/mobile/EdgeToEdgeStoreList>` 
* :ref:`dojox/mobile/EdgeToEdgeDataList <dojox/mobile/EdgeToEdgeDataList>`

Lists with many items are known to cause performance problems
due the the large number of DOM nodes that must be layout by the browser.
The number of items from which performance problems arise depends highly on
the platform and device, and typically ranges from hundreds to thousands.

When mixing this class into a list widget, and when the list is contained in a 
:ref:`dojox/mobile/ScrollableView <dojox/mobile/ScrollableView>` or a 
:ref:`dojox/mobile/ScrollablePane <dojox/mobile/ScrollablePane>`,
the list items are dynamically added/removed to/from the DOM as needed as the list scrolls,
to minimize the number of DOM nodes loaded at any given time.

In most cases, all that is needed is to add the mixin, and the list will transparently
scroll faster. The mixin properties below can be used to fine-tune performances if needed.

Properties
==========

The mixin adds to the list widget the following properties:

* **pageSize**: Number (default: ``20``) - The number of list items that are loaded at a time.
* **maxPages**: Number (default: ``5``) - The number of pages above which previous pages will
  be unloaded.
* **unloadPages**: Number (default: ``1``) - The number of pages that will be unloaded when
  ``maxPages`` is reached.


Methods
=======

The mixin does no add any new methods to the list widget, but it overrides the
``addChild``, ``removeChild``, ``getChildren`` and ``resize`` methods.

**Note**: The list items must always be manipulated using the
``addChild``, ``removeChild`` and ``getChildren`` methods.
If list items are added, removed or retrieved directly using the DOM API, the list may be corrupted.

**Note**: The mixin needs to be notified when the list is resized, so it loads the correct
number of items in the DOM to fill the visible area. For this the ``resize`` method is overridden,
and must be called whenever the list size changes. This is done automatically in most cases, but
when the list is initially hidden (for example, a list contained in a
:ref:`dojox/mobile/SimpleDialog <dojox/mobile/SimpleDialog>`),
the application must call ``resize()`` explicitly on the parent
scrollable view or another ancestor after the list is made visible.

Examples
========

Declarative example: RoundRectList with LongListMixin
-----------------------------------------------------

The following example shows a 
:ref:`dojox/mobile/RoundRectList <dojox/mobile/RoundRectList>`
created in markup and using ``LongListMixin``.
The list contains 1000 items (added programmatically) but no more than 100 items will actually be added to the DOM.

.. code-example::
  :type: inline
  :djconfig: async: true, parseOnLoad: true
  :width: 600
  :height: 400
  :version: 1.9
  :theme: deviceTheme

  .. js ::

	require([
		"dojo/ready",
		"dijit/registry",
		"dojox/mobile/ListItem",
		"dojox/mobile/parser",
		"dojox/mobile",
		"dojox/mobile/compat", // For non-webkit browsers (FF, IE)
		"dojox/mobile/ScrollableView",
		"dojox/mobile/LongListMixin"
	], function(ready, registry, ListItem){
		ready(function(){
			var list = registry.byId("list");
			for(var i = 0; i < 1000; i++){
				list.addChild(new ListItem({ label: "Item "+i }));
			}
		});
	});

  .. html ::

	<div data-dojo-type="dojox/mobile/ScrollableView">
		<h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props="fixed: 'top'">Long list (declarative)</h1>
		<ul id="list" data-dojo-type="dojox/mobile/RoundRectList"
			data-dojo-mixins="dojox/mobile/LongListMixin">
		</ul>
	</div>	


Programmatic example: EdgeToEdgeStoreList with LongListMixin
------------------------------------------------------------

The following example shows a 
:ref:`dojox/mobile/EdgeToEdgeStoreList <dojox/mobile/EdgeToEdgeStoreList>`
(backed by a dojo/store) created programmatically and using ``LongListMixin``.
The store contains 1000 items but no more than 100 items will actually be added to the DOM.

.. code-example::
  :type: inline
  :djconfig: async: true, parseOnLoad: true
  :width: 600
  :height: 400
  :version: 1.9
  :theme: deviceTheme

  .. js ::

	require([
		"dojo/_base/declare",
		"dojo/ready",
		"dijit/registry",
		"dojo/store/Memory",
		"dojox/mobile/EdgeToEdgeStoreList",
		"dojox/mobile/LongListMixin",
		"dojox/mobile/SearchBox",
		"dojox/mobile/ScrollableView",
		"dojox/mobile",
		"dojox/mobile/compat", // For non-webkit browsers (FF, IE)
		"dojox/mobile/parser"
	], function(declare, ready, registry, Memory, EdgeToEdgeStoreList, LongListMixin){
		var items = [];
		for(var i = 0; i < 1000; i++){
			items.push({ label: "Item "+i });
		}
		var static_data = { 
			items: items
		};
		// store for the dojox/mobile/EdgeToEdgeStoreList
		var store = new Memory({idProperty:"label", data: static_data});
		ready(function(){
			var view = registry.byId("scrollableView");
			var listWidget =
				new declare([EdgeToEdgeStoreList, LongListMixin])(
					{store: store});
			listWidget.placeAt(view.containerNode);
			listWidget.startup();
		});
	});
	
  .. html ::
	
	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props="fixed: 'top'">Long list (programmatic)</h1>
		<div id="scrollableView" data-dojo-type="dojox/mobile/ScrollableView"></div>
	</div>

	
See Also
========

An example showing the performance benefit of using ``LongListMixin``
is provided in ``dojox/mobile/tests/test_LongListMixin.html``.
