.. _dojox/mobile/FilteredListMixin:

==============================
dojox/mobile/FilteredListMixin
==============================

:since: V1.9

.. contents ::
    :depth: 2

Introduction
============

This mixin adds filtering capabilities to all dojox/mobile list widgets: 
:ref:`dojox/mobile/RoundRectList <dojox/mobile/RoundRectList>` and any of its subclasses
(:ref:`dojox/mobile/RoundRectStoreList <dojox/mobile/RoundRectStoreList>`, 
:ref:`dojox/mobile/RoundRectDataList <dojox/mobile/RoundRectDataList>`, 
:ref:`dojox/mobile/EdgeToEdgeList <dojox/mobile/EdgeToEdgeList>`, 
:ref:`dojox/mobile/EdgeToEdgeStoreList <dojox/mobile/EdgeToEdgeStoreList>`, 
:ref:`dojox/mobile/EdgeToEdgeDataList <dojox/mobile/EdgeToEdgeDataList>`). 
When mixing this class into a list widget, the list items are dynamically filtered 
depending on the filtering string that the user enters in a dojox/mobile/SearchBox. 

This mixin supports the following use-cases:

* For user's convenience, by simply mixing this class into a list widget the mixin 
  creates a :ref:`dojox/mobile/SearchBox <dojox/mobile/SearchBox>` and a
  :ref:`dojox/mobile/ScrollableView <dojox/mobile/ScrollableView>`. 
  The list is placed inside the ScrollableView and the SearchBox, which allows
  filtering the list, is placed on top of the ScrollableView.
  
* Alternatively, the user can create (and style) the instance of dojox/mobile/SearchBox, 
  and specify its id using the property filterBoxRef of this mixin. This allows
  placing the SearchBox anywhere in the DOM, while the mixin takes care of 
  the necessary glue to ensure the list is filtered according to the filter criteria
  entered in the SearchBox.
  

The filtering works for lists backed by a store (dojo/store or dojo/data), as well 
as for lists not backed by a store. When filtering a list backed by a store 
containing hierarchical data (data items that are children of a parent data item), 
the store must support recursive search queries such that the filtering can match 
child items.

The filtering performs a matching of list items according to a regular expression
defined by the ``queryExpr`` property of the SearchBox.

* If the list is backed by a store:

  * The query matches against children's property which name is defined by 
    the ``labelProperty`` of the list widget.
  * If this property is undefined, it matches against the ``label`` property of the children.

* If the list is not backed by a store:

  * The query matches against children's ``label`` property.
  * If this property is undefined, it matches against the ``innerText`` property of 
    children's DOM node.
  * At last, if this property is undefined, it matches against the ``textContent`` 
    property of child's DOM node.

A typical screenshot of a filtered list:

.. image :: FilteredListMixin-example1.png

Properties
==========

The mixin adds to the list widget the following properties:

* **filterBoxRef**: String (default: ``null``) - The reference for the search box 
  allowing to enter the filtering criteria. Only used at construction time:

  * If unspecified, the mixin creates a dojox/mobile/SearchBox and 
    a dojox/mobile/ScrollableView. The list is placed inside the ScrollableView and the
    SearchBox, wrapped in a DIV, is placed on top of the ScrollableView.
  * If the string is the id of a widget which is an instance of dojox/mobile/SearchBox 
    or a subclass, the mixin uses this SearchBox for filtering the list.
  * If the id is specified but does not reference a dojox/mobile/SearchBox or 
    subclass, an error is thrown.

* **placeHolder**: String (default: "") - Prompt text to display inside the
  SearchBox when it would otherwise be empty (requires browser support). This 
  should only contain plain text	(no HTML markup). When the SearchBox is provided
  by the user (not created by this mixin), its placeHolder property takes precedence.
* **filterBoxVisible**: Boolean (default: true) - A flag which allows to show 
  or hide the dojox/mobile/SearchBox associated with the list.


Methods
=======

The mixin adds to the list widget the following methods:

* **getFilterBox()**: Returns the dojox/mobile/SearchBox widget used for entering 
  the filtering criteria. If an instance has been referenced at construction time using 
  the property ``filterBoxRef``, this instance is returned. Otherwise, returns the 
  instance created by the mixin. This method allows the user to get the instance of 
  SearchBox in order to customize its parameters. For an example, 
  see `Example: configuring the matching rule and the scrollable view`_.
* **getScrollableView()**: Returns the instance of dojox/mobile/ScrollableView created by, 
  this mixin, or ``null`` if none has been created. The mixin creates a ``ScrollableView`` 
  if and only if the property filterBoxRef is unspecified. For an example, 
  see `Example: configuring the matching rule and the scrollable view`_.
* **onFilter(results, query, options)**: User-defined function to handle filter actions. 
  If the function returns ``false``, the filtering is cancelled. 


Examples
========

.. _dojox/mobile/FilteredListMixin#declarative-example-filtered-roundrectlist:

Declarative example: filtered RoundRectList
-------------------------------------------

The following example shows a filtered 
:ref:`dojox/mobile/RoundRectList <dojox/mobile/RoundRectList>`
created in markup. In this example, the ``filterBoxRef`` property of the mixin is not set, 
hence the SearchBox and the ScrollableView are automatically created by the mixin.

.. code-example::
  :type: inline
  :djconfig: async: true, parseOnLoad: true
  :width: 600
  :height: 400
  :version: 1.9
  :theme: deviceTheme

  .. js ::

	require([
		"dojox/mobile/parser",
		"dojox/mobile",
		"dojox/mobile/compat", // For non-webkit browsers (FF, IE)
		"dojox/mobile/FilteredListMixin"
	]);

  .. html ::

	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props="fixed: 'top'">Fruits</h1>
		<ul id="list" data-dojo-type="dojox/mobile/RoundRectList"
			data-dojo-mixins="dojox/mobile/FilteredListMixin"
			data-dojo-props="placeHolder: 'Search'">
			<li data-dojo-type="dojox/mobile/ListItem">Apple</li>
			<li data-dojo-type="dojox/mobile/ListItem">Banana</li>
			<li data-dojo-type="dojox/mobile/ListItem">Blackberry</li>
			<li data-dojo-type="dojox/mobile/ListItem">Cherry</li>
			<li data-dojo-type="dojox/mobile/ListItem">Grapefruit</li>
			<li data-dojo-type="dojox/mobile/ListItem">Kiwi</li>
			<li data-dojo-type="dojox/mobile/ListItem">Lemon</li>
			<li data-dojo-type="dojox/mobile/ListItem">Lime</li>
			<li data-dojo-type="dojox/mobile/ListItem">Melon</li>
			<li data-dojo-type="dojox/mobile/ListItem">Orange</li>
			<li data-dojo-type="dojox/mobile/ListItem">Peach</li>
			<li data-dojo-type="dojox/mobile/ListItem">Pineapple</li>
		</ul>
	</div>

.. _dojox/mobile/FilteredListMixin#declarative-example-filtered-edgetoedgelist:

Declarative example: filtered EdgeToEdgeList
--------------------------------------------

The following example shows a filtered 
:ref:`dojox/mobile/EdgeToEdgeList <dojox/mobile/EdgeToEdgeList>`
created in markup. In this example, the ``filterBoxRef`` property of the mixin is not set, 
hence the SearchBox and the ScrollableView are automatically created by the mixin.

.. code-example::
  :type: inline
  :djconfig: async: true, parseOnLoad: true
  :width: 600
  :height: 400
  :version: 1.9
  :theme: deviceTheme

  .. js ::

	require([
		"dojox/mobile/parser",
		"dojox/mobile",
		"dojox/mobile/compat", // For non-webkit browsers (FF, IE)
		"dojox/mobile/FilteredListMixin"
	]);

  .. html ::

	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props="fixed: 'top'">Fruits</h1>
		<ul id="list" data-dojo-type="dojox/mobile/EdgeToEdgeList"
			data-dojo-mixins="dojox/mobile/FilteredListMixin"
			data-dojo-props="placeHolder: 'Search'">
			<li data-dojo-type="dojox/mobile/ListItem">Apple</li>
			<li data-dojo-type="dojox/mobile/ListItem">Banana</li>
			<li data-dojo-type="dojox/mobile/ListItem">Blackberry</li>
			<li data-dojo-type="dojox/mobile/ListItem">Cherry</li>
			<li data-dojo-type="dojox/mobile/ListItem">Grapefruit</li>
			<li data-dojo-type="dojox/mobile/ListItem">Kiwi</li>
			<li data-dojo-type="dojox/mobile/ListItem">Lemon</li>
			<li data-dojo-type="dojox/mobile/ListItem">Lime</li>
			<li data-dojo-type="dojox/mobile/ListItem">Melon</li>
			<li data-dojo-type="dojox/mobile/ListItem">Orange</li>
			<li data-dojo-type="dojox/mobile/ListItem">Peach</li>
			<li data-dojo-type="dojox/mobile/ListItem">Pineapple</li>
		</ul>
	</div>

.. _dojox/mobile/FilteredListMixin#declarative-example-filtered-edgetoedgestorelist:

Declarative example: filtered EdgeToEdgeStoreList
-------------------------------------------------

The following example shows a filtered 
:ref:`dojox/mobile/EdgeToEdgeStoreList <dojox/mobile/EdgeToEdgeStoreList>`
(backed by a dojo/store) created in markup. In this example, the SearchBox and
the ScrollableView are created by the application and are specified using 
the ``filterBoxRef`` property of the mixin. This example also applies the
``mblFilteredEdgeToEdgeListSearchBox`` style class to the SearchBox widget 
such that it is styled consistently with the list widget itself.

.. code-example::
  :type: inline
  :djconfig: async: true, parseOnLoad: true
  :width: 600
  :height: 400
  :version: 1.9
  :theme: deviceTheme

  .. js ::

	var store;
	require([
		"dojox/mobile/parser",
		"dojox/mobile",
		"dojox/mobile/compat", // For non-webkit browsers (FF, IE)
		"dojo/ready",
		"dijit/registry",
		"dojo/store/Memory",
		"dojox/mobile/ScrollableView",
		"dojox/mobile/EdgeToEdgeStoreList",
		"dojox/mobile/FilteredListMixin"
		], function(parser, mobile, compat, ready, registry, 
			Memory, ScrollableView, EdgeToEdgeStoreList, FilteredListMixin){
		var static_data = { 
			items: [ 
				{label: "Apple"},
				{label: "Banana"},
				{label: "Blackberry"},
				{label: "Cherry"},
				{label: "Grapefruit"},
				{label: "Kiwi"},
				{label: "Lemon"},
				{label: "Lime"},
				{label: "Melon"},
				{label: "Orange"},
				{label: "Peach"},
				{label: "Pineapple"}
			]
		};
		// store for the dojox/mobile/EdgeToEdgeStoreList
		store = new Memory({idProperty: "label", data: static_data});
	});

  .. html ::

	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props="fixed: 'top'">Fruits</h1>
		<input data-dojo-type="dojox/mobile/SearchBox" type="search" id="filterBox"
			class="mblFilteredEdgeToEdgeListSearchBox">
		<div data-dojo-type="dojox/mobile/ScrollableView">
			<ul data-dojo-type="dojox/mobile/EdgeToEdgeStoreList"
				data-dojo-mixins="dojox/mobile/FilteredListMixin"
				data-dojo-props="filterBoxRef: 'filterBox', placeHolder: 'Search', store: store"></ul>
		</div>
	</div>


.. _dojox/mobile/FilteredListMixin#declarative-example-filtered-edgetoedgedatalist:

Declarative example: filtered EdgeToEdgeDataList
------------------------------------------------

The following example shows a filtered 
:ref:`dojox/mobile/EdgeToEdgeDataList <dojox/mobile/EdgeToEdgeDataList>`
(backed by a dojo/data store) created in markup. In this example, the ``filterBoxRef``
property of the mixin is not set, hence the SearchBox and the ScrollableView are 
automatically created by the mixin.

.. code-example::
  :type: inline
  :djconfig: async: true, parseOnLoad: true
  :width: 600
  :height: 400
  :version: 1.9
  :theme: deviceTheme

  .. js ::

	var dataStore;
	require([
		"dojox/mobile/parser",
		"dojox/mobile",
		"dojox/mobile/compat", // For non-webkit browsers (FF, IE)
		"dojo/ready",
		"dijit/registry",
		"dojo/data/ItemFileReadStore",
		"dojox/mobile/ScrollableView",
		"dojox/mobile/EdgeToEdgeDataList",
		"dojox/mobile/FilteredListMixin"
		], function(parser, mobile, compat, ready, registry, 
			ItemFileReadStore, ScrollableView, EdgeToEdgeDataList, FilteredListMixin){
		
		var filterBox;
		var static_data = { 
			items: [ 
				{label: "Apple"},
				{label: "Banana"},
				{label: "Blackberry"},
				{label: "Cherry"},
				{label: "Grapefruit"},
				{label: "Kiwi"},
				{label: "Lemon"},
				{label: "Lime"},
				{label: "Melon"},
				{label: "Orange"},
				{label: "Peach"},
				{label: "Pineapple"}
			]
		};
		// dojo/data store for dojox/mobile/EdgeToEdgeDataList
		dataStore = new ItemFileReadStore({data: static_data});
	});

  .. html ::

	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props="fixed: 'top'">Fruits</h1>
		<ul id="list" data-dojo-type="dojox/mobile/EdgeToEdgeDataList"
			data-dojo-mixins="dojox/mobile/FilteredListMixin"
			data-dojo-props="placeHolder: 'Search', store: dataStore"></ul>
	</div>


Programmatic example: filtered EdgeToEdgeStoreList
--------------------------------------------------

The following example shows a filtered 
:ref:`dojox/mobile/EdgeToEdgeStoreList <dojox/mobile/EdgeToEdgeStoreList>`
(backed by a dojo/store) created programmatically. In this example, the SearchBox and the 
ScrollableView are created by the application and are specified using the ``filterBoxRef`` property
of the mixin. This example also applies the ``mblFilteredEdgeToEdgeListSearchBox`` style class 
to the SearchBox widget such that it is styled consistently with the list widget itself.

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
		"dojox/mobile/FilteredListMixin",
		"dojox/mobile/SearchBox",
		"dojox/mobile/ScrollableView",
		"dojox/mobile",
		"dojox/mobile/compat", // For non-webkit browsers (FF, IE)
		"dojox/mobile/parser"
	], function(declare, ready, registry, Memory, EdgeToEdgeStoreList, FilteredListMixin){
		var static_data = { 
			items: [
				{label: "Apple"},
				{label: "Banana"},
				{label: "Blackberry"},
				{label: "Cherry"},
				{label: "Grapefruit"},
				{label: "Kiwi"},
				{label: "Lemon"},
				{label: "Lime"},
				{label: "Melon"},
				{label: "Orange"},
				{label: "Peach"},
				{label: "Pineapple"}
			]
		};
		// store for the dojox/mobile/EdgeToEdgeStoreList
		var store = new Memory({idProperty:"label", data: static_data});
		ready(function(){
			var view = registry.byId("scrollableView");
			var listWidget =
				new declare([EdgeToEdgeStoreList, FilteredListMixin])(
					{filterBoxRef: 'filterBox', placeHolder: 'Search', store: store});
			listWidget.placeAt(view.containerNode);
			listWidget.startup();
		});
	});
	
  .. html ::
	
	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props="fixed: 'top'">Fruits</h1>
		<input data-dojo-type="dojox/mobile/SearchBox" type="search" id="filterBox"
			class="mblFilteredEdgeToEdgeListSearchBox">
		<div id="scrollableView" data-dojo-type="dojox/mobile/ScrollableView"></div>
	</div>

Example: configuring the matching rule and the scrollable view
--------------------------------------------------------------

The SearchBox used by FilteredListMixin performs a matching of list items using a 
regular expression as specified by its ``queryExpr`` property. The default
value of this property is "${0}*" which corresponds to a "starts with" matching. 
The following snippet shows how to get a "contains" matching. Additionally, it 
retrieves and configures the instance of ``ScrollableView`` created by the mixin.

.. js ::

	require(["dojo/ready",
		"dijit/registry", ...], function(ready, registry, ...){
		ready(function(){
			var listWidget = registry.byId("list");
			// Retrieve the instances of SearchBox and ScrollableView created by the mixin:
			var filterBox = listWidget.getFilterBox();
			var scrollableView = listWidget.getScrollableView();
			// "contains" instead of the default "starts with" matching
			filterBox.set("queryExpr", "*${0}*");
			var scrollableView = listWidget.getScrollableView();
			// Enable both horizontal and vertical scrolling
			scrollableView.set("scrollDir", "vh");
		});
	});
	
.. html ::

	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props="fixed: 'top'">Fruits</h1>
		<ul id="list" data-dojo-type="dojox/mobile/RoundRectList"
			data-dojo-mixins="dojox/mobile/FilteredListMixin"
			data-dojo-props="placeHolder: 'Search'">
			<li data-dojo-type="dojox/mobile/ListItem">Apple</li>
			<li data-dojo-type="dojox/mobile/ListItem">Banana</li>
			...
		</ul>
	</div>
	
	
See Also
========

Examples of filtered list widgets are also provided in ``dojox/mobile/tests/test_FilteredList*.html``.
