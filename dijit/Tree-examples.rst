.. _dijit/Tree-examples:

===================
dijit/Tree examples
===================


.. contents ::
  :depth: 2

Detect when tree has finished loading
=====================================

Use the onLoadDeferred to detect when the Tree has finished loading

.. js ::
  
    var tree = registry.byId('myTree');

    // Connect to tree onLoad to do work once it has initialized
    tree.onLoadDeferred.then(function(){
        console.debug("tree onLoad here!");
        dojo.disconnect(tmph);

        // do work here
    });

Expanding and selecting tree nodes programmatically
===================================================

There are a number of flags and methods for expanding/collapsing the tree and for selecting certain nodes.

If the ``autoExpand`` flag is passed to the constructor, the Tree is initially shown with all nodes expanded.

You can then call ``collapseAll()`` and ``expandAll()`` to collapse and expand the Tree, respectively.

Also, ``dijit.Tree`` has a ``paths`` attribute, which can be set with the usual
``tree.set('paths', [path1, path2])`` syntax, where each path is an array of item id's,
starting with the root node and going down to the leaf.
It serves two purposes: to expand the Tree to the specified nodes, and to select those nodes.

Combining those all together into an example:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dojo/store/Memory", "dijit/tree/ObjectStoreModel", "dijit/Tree"]);

  .. html ::

    <div data-dojo-type="dojo/store/Memory" data-dojo-id="myStore">
        <!-- Create store with inlined data.
            For larger data sets should use dojo.store.JsonRest etc. instead of dojo.store.Memory. -->
        <script type="dojo/method">
             this.setData([
                { id: 'world', name:'The earth', type:'planet', population: '6 billion'},
                { id: 'AF', name:'Africa', type:'continent', population:'900 million', area: '30,221,532 sq km',
                        timezone: '-1 UTC to +4 UTC', parent: 'world'},
                    { id: 'EG', name:'Egypt', type:'country', parent: 'AF' },
                    { id: 'KE', name:'Kenya', type:'country', parent: 'AF' },
                        { id: 'Nairobi', name:'Nairobi', type:'city', parent: 'KE' },
                        { id: 'Mombasa', name:'Mombasa', type:'city', parent: 'KE' },
                    { id: 'SD', name:'Sudan', type:'country', parent: 'AF' },
                        { id: 'Khartoum', name:'Khartoum', type:'city', parent: 'SD' },
                { id: 'AS', name:'Asia', type:'continent', parent: 'world' },
                    { id: 'CN', name:'China', type:'country', parent: 'AS' },
                    { id: 'IN', name:'India', type:'country', parent: 'AS' },
                    { id: 'RU', name:'Russia', type:'country', parent: 'AS' },
                    { id: 'MN', name:'Mongolia', type:'country', parent: 'AS' },
                { id: 'OC', name:'Oceania', type:'continent', population:'21 million', parent: 'world'},
                { id: 'EU', name:'Europe', type:'continent', parent: 'world' },
                    { id: 'DE', name:'Germany', type:'country', parent: 'EU' },
                    { id: 'FR', name:'France', type:'country', parent: 'EU' },
                    { id: 'ES', name:'Spain', type:'country', parent: 'EU' },
                    { id: 'IT', name:'Italy', type:'country', parent: 'EU' },
                { id: 'NA', name:'North America', type:'continent', parent: 'world' },
                { id: 'SA', name:'South America', type:'continent', parent: 'world' }
            ]);
        </script>
        <script type="dojo/method" data-dojo-event="getChildren" data-dojo-args="object">
             // Supply a getChildren() method to store for the data model where
             // children objects point to their parent (aka relational model)
             return this.query({parent: this.getIdentity(object)});
        </script>
    </div>

    <!-- Create the model bridging the store and the Tree -->
    <div data-dojo-type="dijit/tree/ObjectStoreModel" data-dojo-id="myModel"
      data-dojo-props="store: myStore, query: {id: 'world'}"></div>

    <!-- buttons to test Tree features -->
    <button onclick="mytree.collapseAll();">
        Collapse all
    </button>
    <button onclick="mytree.expandAll();">
        Expand all
    </button>
    <button onclick="mytree.set('paths', [ ['world', 'AF', 'KE', 'Nairobi'], ['world', 'SA'] ] );">
        Select Nairobi, South America
    </button>

    <!-- Create the tree -->
    <div data-dojo-type="dijit/Tree" data-dojo-id="mytree"
            data-dojo-props="model: myModel, autoExpand: true"></div>


One complication with using 'paths' is that you must know the full path to the node in your data you are trying to select.
(And by the way, there may be more than one path to a node, if your Tree has nodes with multiple parents.)

The solution to that problem will depend greatly on your data layout, and the query capabilities of your store.


Making nodes expand by clicking on the label
============================================

Nodes always expand/collapse by clicking on the [+] icon, but to make a node expand when clicking on the label,
simply set the ``openOnClick`` attribute to ``true``

.. code-example ::

  .. js ::

    require(["dojo/parser", "dojo/store/Memory", "dijit/tree/ObjectStoreModel", "dijit/Tree"]);

  .. html ::

    <div data-dojo-type="dojo/store/Memory" data-dojo-id="memoryStore">
        <!-- Create store with inlined data.
            For larger data sets should use dojo.store.JsonRest etc. instead of dojo.store.Memory. -->
        <script type="dojo/method">
             this.setData([
                { id: 'world', name:'The earth', type:'planet', population: '6 billion'},
                { id: 'AF', name:'Africa', type:'continent', population:'900 million', area: '30,221,532 sq km',
                        timezone: '-1 UTC to +4 UTC', parent: 'world'},
                    { id: 'EG', name:'Egypt', type:'country', parent: 'AF' },
                    { id: 'KE', name:'Kenya', type:'country', parent: 'AF' },
                        { id: 'Nairobi', name:'Nairobi', type:'city', parent: 'KE' },
                        { id: 'Mombasa', name:'Mombasa', type:'city', parent: 'KE' },
                    { id: 'SD', name:'Sudan', type:'country', parent: 'AF' },
                        { id: 'Khartoum', name:'Khartoum', type:'city', parent: 'SD' },
                { id: 'AS', name:'Asia', type:'continent', parent: 'world' },
                    { id: 'CN', name:'China', type:'country', parent: 'AS' },
                    { id: 'IN', name:'India', type:'country', parent: 'AS' },
                    { id: 'RU', name:'Russia', type:'country', parent: 'AS' },
                    { id: 'MN', name:'Mongolia', type:'country', parent: 'AS' },
                { id: 'OC', name:'Oceania', type:'continent', population:'21 million', parent: 'world'},
                { id: 'EU', name:'Europe', type:'continent', parent: 'world' },
                    { id: 'DE', name:'Germany', type:'country', parent: 'EU' },
                    { id: 'FR', name:'France', type:'country', parent: 'EU' },
                    { id: 'ES', name:'Spain', type:'country', parent: 'EU' },
                    { id: 'IT', name:'Italy', type:'country', parent: 'EU' },
                { id: 'NA', name:'North America', type:'continent', parent: 'world' },
                { id: 'SA', name:'South America', type:'continent', parent: 'world' }
            ]);
        </script>
        <script type="dojo/method" data-dojo-event="getChildren" data-dojo-args="object">
             // Supply a getChildren() method to store for the data model where
             // children objects point to their parent (aka relational model)
             return this.query({parent: object.id});
        </script>
    </div>

    <!-- Create the model bridging the store and the Tree -->
    <div data-dojo-type="dijit/tree/ObjectStoreModel" data-dojo-id="myModel"
      data-dojo-props="store: memoryStore, query: {id: 'world'}"></div>

    <!-- Create the tree -->
    <div data-dojo-type="dijit/Tree" id="mytree"
        data-dojo-props="model: myModel, openOnClick: true"></div>



Rich Text Labels
================

In this example, ``_createTreeNode()`` is overridden to allow HTML markup in the tree.
This is a hack, in the sense that the formatting may not be perfect for large (in pixels) elements.
But the tree will display and work properly regardless, and for simple markup, ex: bold, it works great.

.. code-example ::

  .. js ::

        require([
            "dojo/_base/declare", "dojo/_base/window", "dojo/store/Memory",
            "dijit/tree/ObjectStoreModel", "dijit/Tree",
            "dojo/domReady!"
        ], function(declare, win, Memory, ObjectStoreModel, Tree){

            // Create test store, adding getChildren() method needed by ObjectStoreModel
            var store = new Memory({
                data: [
                    { id: 0, label: "root"},
                       {id: 1, label: "<i>hello</i>", parent: 0},
                       {id: 2, label: "<b>world</b>", parent: 0},
                ],
                getChildren: function(object){
                    return this.query({parent: object.id});
                }
            });

            // Create the model
            var model = new ObjectStoreModel({
                store: store,
                query: {id: 0},
                labelAttr: "label"
            });

            // Custom TreeNode class (based on dijit.TreeNode) that allows rich text labels
            var MyTreeNode = declare(Tree._TreeNode, {
                _setLabelAttr: {node: "labelNode", type: "innerHTML"}
            });

            // Create the Tree.
            var tree = new Tree({
                model: model,
                _createTreeNode: function(args){
                   return new MyTreeNode(args);
                }
            });
            tree.placeAt(win.body());
            tree.startup();
        });


Tree menu with links on nodes
=============================

This example shows you how to use a tree to build a navigation menu.

.. code-example ::

  .. js ::

        require([
            "dojo/_base/window", "dojo/store/Memory",
            "dijit/tree/ObjectStoreModel", "dijit/Tree",
            "dojo/domReady!"
        ], function(win, Memory, ObjectStoreModel, Tree){

            // Create test store, adding the getChildren() method required by ObjectStoreModel
            var myStore = new Memory({
                data: [
                   { id: 1, name: 'Dijit Tree API', url: 'http://dojotoolkit.org/api/1.6/dijit.Tree', root: true },
                   { id: 2, name: 'Dijit Tree.model API', url: 'http://dojotoolkit.org/api/1.6/dijit.Tree.model', parent: 1 },
                   { id: 3, name: 'Dijit Tree.ForestStoreModel API', url: 'http://dojotoolkit.org/api/1.6/dijit.tree.ForestStoreModel', parent: 1 },
                   { id: 4, name: 'Dijit Tree.TreeStoreModel API', url: 'http://dojotoolkit.org/api/1.6/dijit.tree.TreeStoreModel', parent: 1 },
                ],
                getChildren: function(object){
                    return this.query({parent: object.id});
                }
            });

            // Create the model
            var myModel = new ObjectStoreModel({
                store: myStore,
                query: {root: true}
            });

            // Create the Tree, specifying an onClick method
            (new Tree({
                model: myModel,
                onClick: function(item){
                    // Get the URL from the item, and navigate to it
                    location.href = item.url;
                }
            })).placeAt(win.body()).startup();
       });