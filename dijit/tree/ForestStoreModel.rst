#format dojo_rst

dijit.tree.ForestStoreModel
===========================

The ForestStoreModel connects a data store with multiple "root" items to a `dijit.Tree <dijit/Tree>`_.

An example might be a geographical database; there are multiple continents but no ''single'' top level item called "world".

Since Tree demands a single top level item, ForestStoreModel creates a fake item whose children are determined
by a query specified to the ForestStoreModel constructor.

Here's an example of a declarative initialization for a TreeStoreModel and for the data store that it connects to:

.. code-block :: html

	<div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
		url="_data/countries.json"></div>
	<div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" 
		store="continentStore" query="{type:'continent'}"
		rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>


A few things to note here:

  * The query returns multiple items
  * There's a single fake root item created with the label "The World".  The Tree will display that root item unless showRoot=false is specified.  (However, even if Tree doesn't display it, it still exists.)

Monitoring changes to items
---------------------------
Note that ForestStoreModel is inherently complex because it's difficult to tell when the children of the top level (fake) item have changed.  For example:

  * a new continent is added to the data store
  * a new country is added to the data store

ForestStoreModel has no way of knowing that the continent affects the top level node but the country doesn't.   The user needs to define the onNewItem() method, or otherwise ForestStoreModel will take the pessimistic inefficient approach.

For example:

.. code-block :: javascript


	var model = new dijit.tree.ForestStoreModel({
		store: continentStore,
		query: {type: 'continent'},
		rootLabel: "The World",
		onNewItem: function(item, parentInfo){
			if(this.store.getValue(item, 'type') == 'continent'){
				this._requeryTop();
			}
			this.inherited(arguments);
		}
	});


Moving items to/from the root node
----------------------------------
It's also complicated because users need to define what to do when an element is dropped on to the root of the tree, or dragged from the root of the tree and dropped onto a sub-node.   You may want to, for example, change the item so that the "topLevel" attribute is set/unset.   It depends on the structure of the data store what the appropriate action is.   The developer should override onAddToRoot() and onLeaveRoot().

.. code-block :: javascript

  onAddToRoot: function(/* item */ item){
        // summary
        //            Called when item added to root of tree; user must override
        //            to modify the item so that it matches the query for top level items
        // example
        //      |     store.setValue(item, "root", true);
        console.log(this, ": item ", item, " added to root");
  },
  onLeaveRoot: function(/* item */ item){
        // summary
        //            Called when item removed from root of tree; user must override
        //            to modify the item so it doesn't match the query for top level items
        // example
        //      |    store.unsetAttribute(item, "root");
        console.log(this, ": item ", item, " removed from root");
  }
