#format dojo_rst

dijit.Tree
==========

:Status: Draft
:Version: 1.0
:Authors: Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

The trees we see in User Interfaces help sort out long, hierarchical lists. A file system is the classic example, with Windows using it in Explorer. The Dijit tree widget is like that.

Dojo makes easy trees easy, and hard trees possible. In particular, you can:

* Connect your tree to any dojo.data store implementing the Identity API,  with or without a single root item, and with various ways to express parent/child relationships
* Nest items to an arbitrary depth ... each branch is independently expandable
* Apply different icons to different leaf or branch items
* Setup a global handler for when a user clicks or double clicks a particular nodes.
* Tree will automatically reflect changes made to the underlying data store (when connected to the data store through the `TreeStoreModel <dijit/tree/TreeStoreModel>`_ or `ForestStoreModel <dijit/tree/ForestStoreModel>`_)
* Allow nodes to be dragged and dropped through the familiar Dojo DnD API.
* Drag and drop onto the tree, which updates the data store indirectly


=============================
Components Involved In A Tree
=============================

To understand how to use a Tree, you need to be aware of three components that feed each other:

Tree
----
The Tree widget itself is merely a view of the data.   It's in charge of displaying the data and handling user events only.

Model
-----
The real power comes in the `tree model <dijit/tree/Model>`_, which represents the hierarchical data that the tree will display.   Tree can interface to any class implementing the model API, but typically either the `TreeStoreModel <dijit/tree/TreeStoreModel>`_ or `ForestStoreModel <dijit/tree/ForestStoreModel>`_ are used, both of which themselves interface with the powerful dojo.data API.

It's important to note that the tree is merely a '''view''' onto the model.  The model is in charge of tasks like connecting to the data source (often on the server), lazy loading, and notifying the tree of changes to the data.  It's also in charge of handle drop operations, when someone drags and drops an item onto the tree.

To put it another way, you cannot "delete data from the tree" or "insert data into the tree" directly, but rather you must update the model.

Note also that each item in your Tree needs a different identifier (the value of the identifier has to be unique). It's the same concept as a primary key in a database.


Data Stores
-----------
Although not required, usually the model interfaces with a dojo.data store.  In this case, every node in the Tree will represent an '''item''' in the data store.  The idea of items is pervasive in the Tree.  For example, when any tree node is clicked, the event handler called with the item as it's primary argument:

.. code-block:: javascript

	onClick: function(/* dojo.data */ item, /*TreeNode*/ node){
		// summary: user overridable function for executing a tree item
	},

From the Tree's perspective, the item is a black box that can be accessed through getLabel(), getChildren() etc. methods on the model.

There can be many different types of stores, such as stores that work from XML vs. stores that work from JSON, stores that execute on the client vs. stores that pass through to the server, stores that load data as it's needed or stores that load all the data on initialization, etc.  All the stores, though, have the same API, so they can be connected to with either `TreeStoreModel <dijit/tree/TreeStoreModel>`_ or `ForestStoreModel <dijit/tree/ForestStoreModel>`_, depending on whether there is a single or multiple top level item in the store.


Relationship
------------
From the simplest point of view, the information flows like this:

Data Store --> Model --> Tree

That gets more complicated when we think about drag & drop, but we'll address that later.

=====================
A Simple Tree Example
=====================

We can display a Tree on a page by creating a data store, a model, and the Tree widget itself.

A programmatic tree
-------------------

Creating a programmatic tree is very simple: 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");

      dojo.addOnLoad(function(){
        var store = new dojo.data.ItemFileReadStore({
            url: "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/countries.json" 
        });
        
        var treeModel = new dijit.tree.ForestStoreModel({
            store: store,
            query: {"type": "continent"},
            rootId: "root",
            rootLabel: "Continents",
            childrenAttrs: ["children"]
        });
        
        new dijit.Tree({
            model: treeModel    
        }, "treeOne");
      });
    </script>

  .. cv:: html

    <div id="treeOne"></div>

Note that the childrenAttrs parameter to TreeStoreModel/ForestStoreModel is an array since it can list multiple attributes in the store.


A simple tree
-------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
      url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/countries.json"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" 
      store="continentStore" query="{type:'continent'}"
      rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>

    <div dojoType="dijit.Tree" id="mytree"
      model="continentModel" openOnClick="true">
      <script type="dojo/method" event="onClick" args="item">
        alert("Execute of node " + continentStore.getLabel(item)
            +", population=" + continentStore.getValue(item, "population"));
      </script>
    </div>


=====
Icons
=====

Like other dijits, the icon is expressed as a CSS class (which should load a background-image). You specify the class per item by overriding getIconClass():

.. code-block :: javascript
  :linenos:


  <script type="dojo/method" event="getIconClass" args="item, opened">
      if(item == this.model.root) {
          return (opened ? "customFolderOpenedIcon" : "customFolderClosedIcon");
      } else {
          return myStore.getValue(item, "type") + "Icon";
      }
  </script>



=========================
Hiding a Tree's root node
=========================

There's always a single root item for a Tree, returned by the model's getRoot() method.  It might be a real item from the store (such as a tree of employees, with the CEO as the root), or it if there's no single root item in the store (like if the store lists continents but the top item, "the world", is implied, the model is responsible for fabricating such a root item (from the perspective of the tree).

Correspondingly, all trees have a root node, corresponding to the root "item" from the model.

Sometimes you don't want that "the world" top level node to show up, especially if the Tree is inside a TitlePane/AccordionPane/etc. with the label "The World". In that case you should set showRoot=false. The item still exists in the model but it's hidden on the screen:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");
    </script>

  .. cv:: html

    <div dojoType="dijit.Tree" id="mytree2"
      model="continentModel" showRoot="false">
    </div>

Note that you can hide or show the root item regardless of whether that root item is fabricated or corresponds to a real item in the store.

===============
Updating a Tree
===============

People often ask:

  * how do I update a tree (adding or deleting items?

You can't update the tree directly, but rather you need to update the model.   Usually the model is connected to a data store and in that case you need to update the data store.  Thus, you need to use a data store that allows updates (through it's official API), like `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_.

  * how do I refresh a Tree from the store?

This isn't supported.   The store needs to notify the tree of any changes to the data.  Currently this is really only supported (out of the box) by `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_, as setting up a client-server dojo.data source where the server notifies the client whenever the data has changed is quite complicated, and beyond the scope of dojo, which is a client-only solution.

===================
Lazy Loading A Tree
===================
People often ask how to lazy-load a tree, but this question is really unrelated to the Tree itself.  If you use a data store that is lazy loading, such as `dojox.data.QueryReadStore <dojox/data/QueryReadStore>`_ or `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_, then the data will be loaded lazily.


=============
Drag And Drop
=============

TODO

=============
More examples
=============

There are `more extensive examples <dijit/Tree-examples>`_ of using the tree


=============
Accessibility
=============

Keyboard
--------

================================    ===============
Action	                            Key
================================    ===============
Navigate to first tree item*        Tab
Navigate to the next sibling        Down arrow
Navigate to the previous sibling    Up arrow
Open a subtree                      Right arrow
Close a subtree                     Left arrow
Navigate to open subtree            Right arrow
Navigate to parent                  Left arrow
Activate a tree item                Enter
================================    ===============

* Note: The last tree item focused will be in the Tab order.
