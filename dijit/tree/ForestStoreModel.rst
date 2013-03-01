.. _dijit/tree/ForestStoreModel:

===========================
dijit/tree/ForestStoreModel
===========================

The ForestStoreModel connects a data store with multiple "root" items to a :ref:`dijit/Tree <dijit/Tree>`.

An example might be a geographical database; there are multiple continents but no ''single'' top level item called "world".

Since Tree demands a single top level item, ForestStoreModel creates a fake item whose children are determined
by a query specified to the ForestStoreModel constructor.

Here's an example of a declarative initialization for a TreeStoreModel and for the data store that it connects to:

.. html ::

    <div data-dojo-type="dojo/data/ItemFileReadStore" data-dojo-id="continentStore"
        data-dojo-props="url:'_data/countries.json'"></div>
    <div data-dojo-type="dijit/tree/ForestStoreModel" data-dojo-id="continentModel"
        data-dojo-props="store:continentStore, query:{type:'continent'},
        rootId:'continentRoot', rootLabel:'Continents', childrenAttrs:'children'"></div>


A few things to note here:

  * The query returns multiple items
  * There's a single fake root item created with the label "The World".  The Tree will display that root item unless showRoot=false is specified.  (However, even if Tree doesn't display it, it still exists.)

Monitoring changes to items
===========================
Note that ForestStoreModel is inherently complex because it's difficult to tell when the children of the top level (fake) item have changed.
For example:

  * a new continent is added to the data store
  * a new country is added to the data store

ForestStoreModel has no way of knowing that the continent affects the top level node but the country doesn't.
The user needs to define the onNewItem() method, or otherwise ForestStoreModel will take the pessimistic inefficient approach.

For example:

.. js ::

    var model = new ForestStoreModel({
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
==================================
It's also complicated because users need to define what to do when an element is dropped on to the root of the tree, or dragged from the root of the tree and dropped onto a sub-node.
You may want to, for example, change the item so that the "topLevel" attribute is set/unset.
It depends on the structure of the data store what the appropriate action is.
The developer should override onAddToRoot() and onLeaveRoot().

.. js ::

  onAddToRoot: function(/*item*/ item){
        // summary
        //            Called when item added to root of tree; user must override
        //            to modify the item so that it matches the query for top level items
        // example
        //      |     store.setValue(item, "root", true);
        console.log(this, ": item ", item, " added to root");
  },
  onLeaveRoot: function(/*item*/ item){
        // summary
        //            Called when item removed from root of tree; user must override
        //            to modify the item so it doesn't match the query for top level items
        // example
        //      |    store.unsetAttribute(item, "root");
        console.log(this, ": item ", item, " removed from root");
  }

Examples
========

A programmatic tree
-------------------

Creating a programmatic tree is very simple:

.. code-example ::

  .. js ::

    require(["dijit/Tree", "dojo/data/ItemFileReadStore", "dijit/tree/ForestStoreModel", "dojo/domReady!"],
            function(Tree, ItemFileReadStore, ForestStoreModel){
        var store = new ItemFileReadStore({
            url: "{{dataUrl}}/dijit/tests/_data/countries.json"
        });

        var treeModel = new ForestStoreModel({
            store: store,
            query: {"type": "continent"},
            rootId: "root",
            rootLabel: "Continents",
            childrenAttrs: ["children"]
        });

        var myTree = new Tree({
            model: treeModel
        }, "treeOne");
        myTree.startup();
    });

  .. html ::

    <div id="treeOne"></div>

Note that the childrenAttrs parameter to TreeStoreModel/ForestStoreModel is an array since it can list multiple attributes in the store.


A markup tree
-------------

.. code-example ::

  .. js ::

    require(["dojo/parser", "dojo/data/ItemFileReadStore", "dijit/Tree"]);

  .. html ::

    <div data-dojo-type="dojo/data/ItemFileReadStore" data-dojo-id="continentStore"
        data-dojo-props="url:'{{dataUrl}}/dijit/tests/_data/countries.json'"></div>
    <div data-dojo-type="dijit/tree/ForestStoreModel" data-dojo-id="continentModel"
        data-dojo-props="store:continentStore, query:{type:'continent'},
        rootId:'continentRoot', rootLabel:'Continents', childrenAttrs:'children'"></div>

    <div data-dojo-type="dijit/Tree" id="mytree"
        data-dojo-props="model:continentModel, openOnClick:true">
        <script type="dojo/on" data-dojo-event="click" data-dojo-args="item">
            alert("Execute of node " + continentStore.getLabel(item)
            +", population=" + continentStore.getValue(item, "population"));
        </script>
    </div>
