#format dojo_rst

dijit.Tree
==========

:Authors: Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: Bill Keese
:Available: since V0.9

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

The Tree is a black-box in the sense that the developer generally won't be dealing with individual nodes of the Tree.   Rather, there are just onClick() etc. notifications, which refer to the *item* that was clicked.   Item is usually an item in the dojo.data store that the tree is connected to.

Note also that a Tree has an idea of a currently selected item, such as the currently opened folder in a mail program.

Model
-----
The real power comes in the `tree model <dijit/tree/Model>`_, which represents the hierarchical data that the tree will display.   Tree can interface to any class implementing the model API, but typically either the `TreeStoreModel <dijit/tree/TreeStoreModel>`_ or `ForestStoreModel <dijit/tree/ForestStoreModel>`_ are used, both of which themselves interface with the powerful dojo.data API.

It's important to note that the tree is merely a '''view''' onto the model.  The model is in charge of tasks like connecting to the data source (often on the server), lazy loading, and notifying the tree of changes to the data.  It's also in charge of handle drop operations, when someone drags and drops an item onto the tree.

To put it another way, you cannot "delete data from the tree" or "insert data into the tree" directly, but rather you must update the model.

Note also that each item in your Tree needs a different identifier (the value of the identifier has to be unique). It's the same concept as a primary key in a database.


Data Stores
-----------
Although not required, usually the model interfaces with a dojo.data store.

There can be many different types of stores, such as stores that work from XML vs. stores that work from JSON, stores that execute on the client vs. stores that pass through to the server, stores that load data as it's needed or stores that load all the data on initialization, etc.  All the stores, though, have the same API, so they can be connected to with either `TreeStoreModel <dijit/tree/TreeStoreModel>`_ or `ForestStoreModel <dijit/tree/ForestStoreModel>`_, depending on whether there is a single or multiple top level item in the store.

One might wonder why Tree doesn't interface directly with a dojo.data store.   There are a number of reasons:

  * The parent-child relationship of items in the store might not be expressed by a children attribute on the parent item.  For relational databases it's the other way around, where the child points to the parent.  The dijit.tree.Model code specifies how to trace parent-child relationships for a given data store.
  * The interface of dojo.data to load children is rather cumbersome... must call _loadItem() on each item in the children[] array, which means that any item in the store needs to know the list of id's of it's children at any time.  It's more efficient to not require that, and to lookup children only when they are needed (when the user clicks the expando icon to open the node).
  * Sometimes developers might use a custom model that doesn't connect to a data store at all.

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
            url: "http://archive.dojotoolkit.org/nightly/dojotoolkit/dijit/tests/_data/countries.json" 
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


A markup tree
-------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
      url="http://archive.dojotoolkit.org/nightly/dojotoolkit/dijit/tests/_data/countries.json"></div>
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

Each node in the tree has an icon.
Like other dijits, the icon is expressed as a CSS class (which should load a background-image).
You specify the class per item by overriding dijit.Tree's getIconClass().

The default implementation of getIconClass() shows two types of icons: folders and leafs.
(Actually, it has separate icons for opened and closed folders, so that's three icons...)
It tries to guess if the node is a folder or not by whether or not it has a children attribute:

.. code-block :: javascript
  :linenos:

  	getIconClass: function(/*dojo.data.Item*/ item, /*Boolean*/ opened){
		return (!item || this.model.mayHaveChildren(item)) ? (opened ? "dijitFolderOpened" : "dijitFolderClosed") : "dijitLeaf"
	},

Note that the !item check refers to the root node in the tree,
which may not have any associated item when using the old version of the Tree API,
connecting the Tree directly to a store instead of using a model.

That works fairly well, but will fail if mayHaveChildren() returns false for items with no children.
The definition of mayHaveChildren() for "empty folders" is actually somewhat vague, so it's best not to depend on it.
A better getIconClass() method for a Tree connected (through a model) to a `dojox.data.FileStore <dojox/data/FileStore>`_
would determine if the item was a folder or not based on whether or not the item had the "directory" attribute
(and it was set to true):

.. code-block :: javascript
  :linenos:

  	getIconClass: function(/*dojo.data.Item*/ item, /*Boolean*/ opened){
		return myStore.getValue(item, 'directory') ? (opened ? "dijitFolderOpened" : "dijitFolderClosed") : "dijitLeaf";
	},


If you want to have different icon types depending on the type of items in the tree (for example,
separate icons for songs, movies, and TV shows), then you really need to override the method
to return a separate class name based on the type of item:

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

    <div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
      url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/countries.json"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" 
      store="continentStore" query="{type:'continent'}"
      rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>
    
    <div dojoType="dijit.Tree" id="mytree2"
      model="continentModel" showRoot="false">
    </div>

Note that you can hide or show the root item regardless of whether that root item is fabricated or corresponds to a real item in the store.

===============
Updating a Tree
===============

People often ask:

  * how do I update a tree (adding or deleting items)?

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

Tree's support drag and drop, meaning that a user can:

  * drop an item onto the tree
  * drag an item from the tree
  * move items within the tree

In the first and last case (ie, when an item is dropped onto the tree), the drop is processed by the model, which in turn sends it to the data store (updating the underlying data).   Thus:

  * the model must implement the pasteItem() method
  * the store must implement the `dojo.data.api.Write <dojo/data/api/Write>`_ interface

In addition, to enable DnD on the Tree you must dojo.require("dijit.tree.dndSource"); and the dndController="dijit.tree.dndSource" parameter must be specified to the tree


.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileWriteStore");
      dojo.require("dijit.tree.ForestStoreModel");
      dojo.require("dijit.tree.dndSource");
      dojo.require("dijit.Tree");

      dojo.addOnLoad(function(){
        var store = new dojo.data.ItemFileWriteStore({
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
            model: treeModel,
            dndController: "dijit.tree.dndSource"
        }, "treeThree");
      });
    </script>

  .. cv:: html

    <div id="treeThree"></div>


You can also specify custom checkAcceptance() and checkItemAcceptance() to accept/reject items to the tree.   (The former function operates at the Tree level, and the latter operates per Tree node, allowing things like rejecting dropping items onto leaf nodes.)


betweenThreshold
----------------
If between threshold is set to a positive integer value like 5 (which represents 5 pixels), then when dragging within 5px of the top or bottom of a tree node, it's interpreted as trying to make the drag source the previous or next sibling of the drop target, rather than the child of the drop target.  This is useful for when a user can control the order of the children of the child nodes:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileWriteStore");
      dojo.require("dijit.tree.ForestStoreModel");
      dojo.require("dijit.tree.dndSource");
      dojo.require("dijit.Tree");
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileWriteStore" jsId="continentStore5"
      url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/countries.json"></div>
    
    <div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel5" 
      store="continentStore5" query="{type:'continent'}"
      rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>
    
    <div dojoType="dijit.Tree" id="mytree5"
      dndController="dijit.tree.dndSource" betweenThreshold="5" showRoot="false"
      model="continentModel5" openOnClick="true">
    </div>


Behind the scenes
-----------------
What happens when a user moves an item from one position in a tree to another?   It's actually quite complicated...

1. The Tree widget does not change it's display at all.  Rather, it notifies the model of the paste operation.
2. The model updates the store.
3. The store notifies the model that the data has been changed.
4. The model notifies the tree of the change (presumably the children list of nodeA is one shorter, and the children list of nodeB has a new entry)
5. The Tree updates it's display.

In this way, the Tree, Model, and data store are always in sync.

============
Context Menu
============

Tree has no built-in support for context menus, but you can use the Menu widget in conjunction with the Tree

.. cv-compound::

  .. cv:: javascript

        <script>
            dojo.require("dijit.Menu");
            dojo.require("dijit.MenuItem");
            dojo.require("dijit.tree.ForestStoreModel");
            dojo.require("dojo.data.ItemFileReadStore");
            dojo.require("dijit.Tree");
        </script>

  .. cv:: html

	<ul dojoType="dijit.Menu" id="tree_menu" style="display: none;">
		<li dojoType="dijit.MenuItem" onClick="alert('Hello world');">Item #1</li>
		<li dojoType="dijit.MenuItem">Item #2</li>
	</ul>
        
        <div dojoType="dojo.data.ItemFileReadStore" jsId="menuContinentStore"
             url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/countries.json"></div>
        
        <div dojoType="dijit.tree.ForestStoreModel" jsId="menuContinentModel" 
             store="menuContinentStore" query="{type:'continent'}"
             rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>
            
	<div dojoType="dijit.Tree" id="menuTree"
		model="menuContinentModel" showRoot="false" openOnClick="true">
                 
		<script type="dojo/connect">
			var menu = dijit.byId("tree_menu");
			// when we right-click anywhere on the tree, make sure we open the menu
			menu.bindDomNode(this.domNode);
                        
			dojo.connect(menu, "_openMyself", this, function(e){
				// get a hold of, and log out, the tree node that was the source of this open event
				var tn = dijit.getEnclosingWidget(e.target);
				console.debug(tn);
                                
				// now inspect the data store item that backs the tree node:
				console.debug(tn.item);
                               
				// contrived condition: if this tree node doesn't have any children, disable all of the menu items
				menu.getChildren().forEach(function(i){ i.attr('disabled', !tn.item.children); });
                                
				// IMPLEMENT CUSTOM MENU BEHAVIOR HERE
			});
		</script>
        </div>

=======
Styling
=======

Grid lines
----------

If you don't want to display the grid lines for a Tree then simply write CSS rules to override the theme and hide the relevant background images.  The pertinent lines from tundra are:

.. code-block:: css

  .tundra .dijitTreeNode {
    background-image : url('images/i.gif');
    ...
  }
  
  /* left vertical line (grid) for all nodes */
  .tundra .dijitTreeIsLast {
    background: url('images/i_half.gif') no-repeat;
    ...
  
  .tundra .dijitTreeExpandoLeaf {
       background-image:url(images/treeExpand_leaf.gif);
  }


Hover effect
------------

Due to implementation details, on the tundra, soria, and nihilo themes the hover effect for tree nodes is done with a near-transparent image:

.. code-block:: css

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

=============
More examples
=============

There are `more extensive examples <dijit/Tree-examples>`_ of using the tree


=============
Accessibility
=============

Keyboard
--------

===================================  ===============
Action	                             Key
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
Tree items can also be accessed by typing alphanumeric characters.  For example, typing "A" will navigate from the currently focused node to the next node that begins with the letter A (case insensitive).   Typing "Al" will navigate to the next node that starts with "Al".  Only the nodes that are visible are searched, not nodes that are hidden inside a closed node.   The nodes are searched in the order that they appear on the screen, from the focused node downwards and then looping back up to the top of the tree.

Known Issues
------------

Using JAWS 10 in Firefox 3 the properties of each tree item are spoken including the open/close state and the level information.  Using JAWS 10 with IE 8, the open/close state of each item is spoken but the level information is not spoken.   In both Firefox 3 and IE 8 the JAWS user should be in App mode or virtual pc cursor off mode for best performance (toggle the mode via the insert+z key).  
