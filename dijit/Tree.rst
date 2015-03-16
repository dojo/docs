.. _dijit/Tree:

==========
dijit.Tree
==========

:Authors: Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: Bill Keese
:since: V0.9

.. contents ::
    :depth: 2

The trees we see in User Interfaces help sort out long, hierarchical lists.
A file system is the classic example, with Windows using it in Explorer.
The Dijit tree widget is like that.

Dojo makes simple trees easy, and complicated trees possible.
In particular, you can:

* Connect your tree to any dojo.store, with or without a single root item, and with various ways to express parent/child relationships
* Nest items to an arbitrary depth ... each branch is independently expandable
* Apply different icons to different leaf or branch items
* Setup a global handler for when a user clicks or double clicks a particular nodes.
* Tree will automatically reflect changes made to the underlying data store (when connected to the data store through
  the :ref:`ObjectStoreModel <dijit/tree/ObjectStoreModel>`, or legacy
  :ref:`TreeStoreModel <dijit/tree/TreeStoreModel>` or :ref:`ForestStoreModel <dijit/tree/ForestStoreModel>`)
* Allow nodes to be dragged and dropped through the familiar Dojo DnD API.
* Drag and drop onto the tree, which updates the data store indirectly


Components Involved In a Tree
=============================

To understand how to use a Tree, you need to be aware of three components that feed each other:

Tree
----
The Tree widget itself is merely a view of the data.
It's in charge of displaying the data and handling user events only.

The Tree is a black-box in the sense that the developer generally won't be dealing with individual nodes of the Tree.
Rather, there are just onClick() etc.
notifications, which refer to the *item* that was clicked.
Item is usually an item in a dojo.store that the tree is connected to.

Note also that a Tree has an idea of a currently selected item, such as the currently opened folder in a mail program.

Model
-----
The real power comes in the :ref:`tree model <dijit/tree/Model>`,
which represents the hierarchical data that the tree will display.
Tree can interface to any class implementing the model API,
but typically interfaces through the :ref:`ObjectStoreModel <dijit/tree/ObjectStoreModel>`,
which itself interfaces with the powerful :ref:`dojo.store <dojo/store>` API.

It's important to note that the tree is merely a **view** onto the model.
The model is in charge of tasks like connecting to the data source (often on the server), lazy loading, and notifying the tree of changes to the data.
It's also in charge of handling drop operations, when someone drags and drops an item onto the tree.

To put it another way, you cannot "delete data from the tree" or "insert data into the tree" directly, but rather you must update the model.

Note also that each item in your Tree needs a different identifier (the value of the identifier has to be unique).
It's the same concept as a primary key in a database.


Data Stores
-----------
Although not required, usually the model interfaces with a :ref:`dojo.store <dojo/store>`.

There can be many different types of stores, such as stores that work from XML vs.
stores that work from JSON, stores that execute on the client vs.
stores that pass through to the server, stores that load data as it's needed or stores that load all the data on initialization, etc.
All the stores, though, have the same API, so they can be connected to with the
:ref:`ObjectStoreModel <dijit/tree/ObjectStoreModel>`.

Relationship
------------
From the simplest point of view, the information flows like this:

Data Store --> Model --> Tree

That gets more complicated when we think about drag & drop, but we'll address that later.

A Simple Tree Example
=====================

We can display a Tree on a page by creating a data store, a model, and the Tree widget itself.

A programmatic tree
-------------------

Creating a programmatic tree is very simple:

.. code-example ::
  :djConfig: async: true

  .. js ::

        require([
            "dojo/_base/window", "dojo/store/Memory",
            "dijit/tree/ObjectStoreModel", "dijit/Tree",
            "dojo/domReady!"
        ], function(win, Memory, ObjectStoreModel, Tree){

            // Create test store, adding the getChildren() method required by ObjectStoreModel
            var myStore = new Memory({
                data: [
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
                ],
                getChildren: function(object){
                    return this.query({parent: object.id});
                }
            });

            // Create the model
            var myModel = new ObjectStoreModel({
                store: myStore,
                query: {id: 'world'}
            });

            // Create the Tree.
            var tree = new Tree({
                model: myModel
            });
            tree.placeAt(win.body());
            tree.startup();
        });


A markup tree
-------------

Here's an example of creating a Tree in markup.
It's not wrapping the store in Observable(), so that store updates won't be reflected into the tree.
(Wrapping the store in Observable is not easy to do through markup.
If you need the functionality, we suggest creating the store in JavaScript, or create your own custom store.
In any case, the dijit.tree.Model and dijit.Tree themselves can still be created in markup.)

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

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
             return this.query({parent: object.id});
        </script>
    </div>

    <!-- Create the model bridging the store and the Tree -->
    <div data-dojo-type="dijit/tree/ObjectStoreModel" data-dojo-id="myModel"
      data-dojo-props="store: myStore, query: {id: 'world'}"></div>

    <!-- Create the tree -->
    <div data-dojo-type="dijit/Tree" id="myTree" data-dojo-props="model: myModel"></div>


Icons
=====

Each node in the tree has an icon.
Like other dijits, the icon is expressed as a CSS class (which should load a background-image).
You specify the class per item by overriding dijit.Tree's getIconClass().

The default implementation of getIconClass() shows two types of icons: folders and leafs.
(Actually, it has separate icons for opened and closed folders, so that's three icons...)
It tries to guess if the node is a folder or not by whether or not it has a children attribute:

.. js ::
  
    getIconClass: function(/*dojo.store.Item*/ item, /*Boolean*/ opened){
        return (!item || this.model.mayHaveChildren(item)) ? (opened ? "dijitFolderOpened" : "dijitFolderClosed") : "dijitLeaf"
    },

Note that the !item check refers to the root node in the tree,
which may not have any associated item when using the old version of the Tree API,
connecting the Tree directly to a store instead of using a model.

That works fairly well, but will fail if mayHaveChildren() returns false for items with no children.
The definition of mayHaveChildren() for "empty folders" is actually somewhat vague, so it's best not to depend on it.
A better getIconClass() method for a Tree connected (through a model) to a :ref:`dojox.data.FileStore <dojox/data/FileStore>`
would determine if the item was a folder or not based on whether or not the item had the "directory" attribute
(and it was set to true):

.. js ::
  
    getIconClass: function(/*dojo.store.Item*/ item, /*Boolean*/ opened){
        return myStore.getValue(item, 'directory') ? (opened ? "dijitFolderOpened" : "dijitFolderClosed") : "dijitLeaf";
    },


If you want to have different icon types depending on the type of items in the tree (for example,
separate icons for songs, movies, and TV shows), then you really need to override the method
to return a separate class name based on the type of item:

.. html ::
  
  <script type="dojo/method" data-dojo-event="getIconClass" data-dojo-args="item, opened">
      if(item == this.model.root){
          return (opened ? "customFolderOpenedIcon" : "customFolderClosedIcon");
      }else{
          return myStore.getValue(item, "type") + "Icon";
      }
  </script>



Hiding a Tree's root node
=========================

There's always a single root item for a Tree, returned by the model's getRoot() method.
It might be a real item from the store (such as a tree of employees, with the CEO as the root),
or it if there's no single root item in the store (like if the store lists continents but the top item,
"the world", is implied, the model is responsible for fabricating such a root item (from the perspective of the tree).

Correspondingly, all trees have a root node, corresponding to the root "item" from the model.

Sometimes you don't want that "the world" top level node to be displayed,
especially if the Tree is inside a TitlePane/AccordionPane/etc. with the label "The World".
In that case you should set showRoot=false.
The item still exists in the model but it's hidden on the screen:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dojo/store/Memory", "dijit/tree/ObjectStoreModel", "dijit/Tree"]);

  .. html ::

    <!-- Create store with inlined data.
        For larger data sets should use dojo.store.JsonRest etc. instead of dojo.store.Memory. -->
    <div data-dojo-type="dojo/store/Memory" data-dojo-id="myStore">
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
      data-dojo-props="store: myStore, query: {id: 'world'}"></div>

    <!-- Create the tree -->
    <div data-dojo-type="dijit/Tree" id="myTree"
            data-dojo-props="model: myModel, showRoot: false"></div>


Note that you can hide or show the root item regardless of whether that root item is fabricated
(see :ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`)
or corresponds to a real item in the store.

Updating a Tree
===============

People often ask:

How do I update a tree (adding or deleting items)?
--------------------------------------------------

You can't update the tree directly, but rather you need to update the model.
Usually the model is connected to a data store and in that case you need to update the data store.
Thus, you need to use a data store that allows updates (through its official API),
like :ref:`dojo.store.Memory <dojo/store/Memory>`.

When using :ref:`dijit.tree.ObjectStoreModel <dijit/tree/ObjectStoreModel>`, the store needs to be wrapped
in a `dojo.store.Observable <dojo/store/Observable>`, as below:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

        require([
            "dojo/store/Memory", "dojo/store/Observable",
            "dijit/tree/ObjectStoreModel", "dijit/Tree", "dojo/parser"
        ], function(Memory, Observable, ObjectStoreModel, Tree, parser){
            // Create test store, adding a getChildren() method needed by the model
            myStore = new Memory({
                data: [
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
                ],
                getChildren: function(object){
                    // Add a getChildren() method to store for the data model where
                    // children objects point to their parent (aka relational model)
                    return this.query({parent: object.id});
                }
            });

            // Wrap the store in Observable so that updates to the store are reflected to the Tree
            myStore = new Observable(myStore);

            myModel = new ObjectStoreModel({
                store: myStore,
                query: { id: "world" }
            });

            parser.parse();
        });

  .. html ::

    <!-- Create the tree -->
    <div data-dojo-type="dijit/Tree" id="myTree" data-dojo-props="model: myModel"></div>

    <!-- Buttons to show data store update -->
    <button onclick="myStore.add({id: 'US', name:'United States', type:'country', parent: 'NA'});">
        Add U.S. as child of North America
    </button>
    <button onclick="myStore.remove('EU');">
        Remove Europe
    </button>


How do I refresh a Tree from the store?
---------------------------------------

This isn't supported.
The store needs to notify the tree of any changes to the data.
Currently this is really only supported (out of the box) by a :ref:`dojo.store <dojo/store>`
wrapped in a `dojo.store.Observable <dojo/store/Observable>`, or by
:ref:`dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`.

Setting up a client-server dojo.store source where the server notifies the client whenever the data has changed
is quite complicated, and beyond the scope of dojo, which is a client-only solution.

Lazy Loading a Tree
===================
People often ask how to lazy-load a tree, but this question is really unrelated to the Tree itself.
If you use a data store that is lazy loading, such as :ref:`dojo.store.JsonRest <dojo/store/JsonRest>`
then the data will be loaded lazily.


Drag and Drop
=============

Tree's support drag and drop, meaning that a user can:

  * drop an item onto the tree
  * drag an item from the tree
  * move items within the tree

In the first and last case (ie, when an item is dropped onto the tree), the drop is processed by the model,
which in turn sends it to the data store (updating the underlying data).
Thus:

  * the model must implement the pasteItem() method
  * the store must support put(child, {parent: parent}, and Observable.

In addition, to enable DnD on the Tree you must require ``dijit/tree/dndSource``
and set the Tree's dndController to ``dijit.tree.dndSource``.

.. code-example ::
  :djConfig: async: true

  .. js ::

    require([
        "dojo/aspect", "dojo/_base/window", "dojo/store/Memory", "dojo/store/Observable",
        "dijit/Tree", "dijit/tree/ObjectStoreModel", "dijit/tree/dndSource",
        "dojo/domReady!"
    ], function(aspect, win, Memory, Observable, Tree, ObjectStoreModel, dndSource){

            // Create test store, adding the getChildren() method required by ObjectStoreModel,
            // and making put(child, {parent: parent}) work
            var memoryStore = new Memory({
                data: [
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
                        { id: 'AU', name:'Australia', type:'country', population:'21 million', parent: 'OC'},
                    { id: 'EU', name:'Europe', type:'continent', parent: 'world' },
                        { id: 'DE', name:'Germany', type:'country', parent: 'EU' },
                        { id: 'FR', name:'France', type:'country', parent: 'EU' },
                        { id: 'ES', name:'Spain', type:'country', parent: 'EU' },
                        { id: 'IT', name:'Italy', type:'country', parent: 'EU' },
                    { id: 'NA', name:'North America', type:'continent', parent: 'world' },
                        { id: 'MX', name:'Mexico', type:'country',  population:'108 million', area:'1,972,550 sq km',
                                parent: 'NA' },
                            { id: 'Mexico City', name:'Mexico City', type:'city', population:'19 million', timezone:'-6 UTC', parent: 'MX'},
                            { id: 'Guadalajara', name:'Guadalajara', type:'city', population:'4 million', timezone:'-6 UTC', parent: 'MX' },
                        { id: 'CA', name:'Canada', type:'country',  population:'33 million', area:'9,984,670 sq km', parent: 'NA' },
                            { id: 'Ottawa', name:'Ottawa', type:'city', population:'0.9 million', timezone:'-5 UTC', parent: 'CA'},
                            { id: 'Toronto', name:'Toronto', type:'city', population:'2.5 million', timezone:'-5 UTC', parent: 'CA' },
                        { id: 'US', name:'United States of America', type:'country', parent: 'NA' },
                    { id: 'SA', name:'South America', type:'continent', parent: 'world' },
                        { id: 'BR', name:'Brazil', type:'country', population:'186 million', parent: 'SA' },
                        { id: 'AR', name:'Argentina', type:'country', population:'40 million', parent: 'SA' }
                ],
                getChildren: function(object){
                    return this.query({parent: object.id});
                }
            });
            aspect.around(memoryStore, "put", function(originalPut){
                // To support DnD, the store must support put(child, {parent: parent}).
                // Since memory store doesn't, we hack it.
                // Since our store is relational, that just amounts to setting child.parent
                // to the parent's id.
                return function(obj, options){
                    if(options && options.parent){
                        obj.parent = options.parent.id;
                    }
                    return originalPut.call(memoryStore, obj, options);
                }
            });

            // Wrap the store in Observable so that updates to the store are reflected to the Tree
            var observableStore = new Observable(memoryStore);

            // Create the model
            var myModel = new ObjectStoreModel({
                store: observableStore,
                query: {id: 'world'}
            });

            // Create Tree
            (new Tree({
                model: myModel,
                dndController: dndSource
            })).placeAt(win.body()).startup();
        });

You can also specify custom checkAcceptance() and checkItemAcceptance() to accept/reject items to the tree.
(The former function operates at the Tree level, and the latter operates per Tree node,
allowing things like rejecting dropping items onto leaf nodes.)

Further Examples
----------------

If you are interested in further examples, please make sure you have glanced at the unit tests.
You can find a good example in
`test_Tree_Dnd.html <http://download.dojotoolkit.org/release-1.7.1/dojo-release-1.7.1/dijit/tests/tree/test_Tree_DnD.html>`_.

betweenThreshold
----------------
If between threshold is set to a positive integer value like 5 (which represents 5 pixels),
then dragging within 5px of the top or bottom of a tree node,
is interpreted as trying to make the drag source the previous or next sibling of the drop target
rather than the child of the drop target.
This is useful for when a user can control the order of the children of the child nodes:

Note that if the Tree data is from a dojo/store, the store's `put()` method must support both the `parent` option
and the `before` option.  Since dojo/store/Memory supports neither of these options, here's
an example based on the old dojo/data code:

.. code-example ::
  :djConfig: async: true

.. code-example ::

  .. js ::

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileWriteStore");
      dojo.require("dijit.tree.ForestStoreModel");
      dojo.require("dijit.tree.dndSource");
      dojo.require("dijit.Tree");
    </script>

  .. html ::

    <div data-dojo-type="dojo.data.ItemFileWriteStore" data-dojo-id="continentStore5"
      data-dojo-props="url:'{{dataUrl}}/dijit/tests/_data/countries.json'"></div>

    <div data-dojo-type="dijit.tree.ForestStoreModel" data-dojo-id="continentModel5"
      data-dojo-props="store:continentStore5, query:{type:'continent'},
      rootId:'continentRoot', rootLabel:'Continents', childrenAttrs:'children'"></div>

    <div data-dojo-type="dijit.Tree" id="mytree5"
      data-dojo-props="dndController:'dijit.tree.dndSource', betweenThreshold:5, showRoot:false,
      model:continentModel5, openOnClick:true">
    </div>

Behind the Scenes
-----------------
What happens when a user moves an item from one position in a tree to another?
It's actually quite complicated...

1. The Tree widget does not change its display at all.  Rather, it notifies the model of the paste operation.
2. The model updates the store.
3. The store notifies the model that the data has been changed.
4. The model notifies the tree of the change (presumably the children list of nodeA is one shorter, and the children list of nodeB has a new entry)
5. The Tree updates its display.

In this way, the Tree, Model, and data store are always in sync.

Context Menu
============

Tree has no built-in support for context menus, but you can use the Menu widget in conjunction with the Tree:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dojo/store/Memory", "dojo/query!css2",
    	"dijit/Menu", "dijit/MenuItem", "dijit/tree/ObjectStoreModel", "dijit/Tree"]);

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
             return this.query({parent: object.id});
        </script>
    </div>

    <!-- Create the model bridging the store and the Tree -->
    <div data-dojo-type="dijit/tree/ObjectStoreModel" data-dojo-id="myModel"
      data-dojo-props="store: myStore, query: {id: 'world'}"></div>

    <!-- Create the tree -->
    <div data-dojo-type="dijit/Tree" id="menuTree"
             data-dojo-props="model: myModel, showRoot: false, openOnClick: true">
    </div>

	<ul id="menuTree_menu" data-dojo-type="dijit/Menu"
			data-dojo-props='style:"display: none;", targetNodeIds: ["menuTree"], selector: ".dijitTreeNode"'>
		<li data-dojo-type="dijit/MenuItem">
			<script type="dojo/connect" data-dojo-event="onClick">
				// get a hold of the dijit.TreeNode that was the source of this open event
				var tn = dijit.byNode(this.getParent().currentTarget);

				// now print the data store item that backs the tree node
				console.debug("menu click for item: ", tn.item.name);
			</script>
			Click Me
		</li>
	</ul>

Note that it's including dojo/query in order to use Menu.selector.

Styling
=======

Grid lines
----------

If you don't want to display the grid lines for a Tree then simply write CSS rules
to override the theme and hide the relevant background images.
The pertinent lines from tundra are:

.. css ::

  .tundra .dijitTreeNode {
    background-image : url('images/i.gif');
    ...
  }
  
  /* left vertical line (grid) for all nodes */
  .tundra .dijitTreeIsLast {
    background: url('images/i_half.gif') no-repeat;
    ...
  }
  
  .tundra .dijitTreeExpandoLeaf {
       background-image:url(images/treeExpand_leaf.gif);
  }


Hover effect
------------

Due to implementation details, on the tundra, soria, and nihilo themes the hover effect for tree nodes is done with a near-transparent image:

.. css ::

  .tundra .dijitTreeNodeHover {
      /*background-color: #f6f9fa !important;*/
      /* using a transparent png so that we can still see grid lines, which are (unfortunately) behind the dijitRowNode that we are hovering over */
      background-image: url(images/treeHover.png);
      background-repeat: repeat;
      background-color: none !important;
  }

So in order to change the hover effect you would need to create a new image (with for example 95% transparency), and write a CSS rule to override the one above.

You can also remove the hover effect altogether by just writing a CSS rule that sets background-image to none, overriding the above rule.

On the claro theme, the hover effect is done via a background-color (combined with a white gradient background image), so changing the hover effect just involves changing that background color.

Miscellaneous
=============

Persistence
-----------
By default, a Tree will remember which branches were opened/closed.
To use this feature you must specify an id for the Tree.
To disable the feature, set the "persist" parameter to false.

More examples
=============

There are :ref:`more extensive examples <dijit/Tree-examples>` of using the tree.


Accessibility
=============

Keyboard
--------

===================================  ===============
Action                               Key
===================================  ===============
Navigate into tree*                  Tab
Navigate to the next sibling         Down arrow
Navigate to the previous sibling     Up arrow
Open a subtree                       Right arrow
Close a subtree                      Left arrow
Navigate to open subtree             Right arrow
Navigate to parent                   Left arrow
Activate a tree item                 Enter
Navigate to first tree node          Home
Navigate to last visible tree node   End
===================================  ===============

* Note: The most recently focused tree item will be in the Tab order.


Keyboard searching
------------------
Tree items can also be accessed by typing alphanumeric characters.
For example, typing "A" will navigate from the currently focused node to the next node that begins with the letter A (case insensitive).
Typing "Al" will navigate to the next node that starts with "Al".
Only the nodes that are visible are searched, not nodes that are hidden inside a closed node.
The nodes are searched in the order that they appear on the screen, from the focused node downwards and then looping back up to the top of the tree.

Known Issues
------------

Using JAWS 10 in Firefox 3 the properties of each tree item are spoken including the open/close state and the level information.
Using JAWS 10 with IE 8, the open/close state of each item is spoken but the level information is not spoken.
In both Firefox 3 and IE 8 the JAWS user should be in App mode or virtual pc cursor off mode for best performance (toggle the mode via the insert+z key).
