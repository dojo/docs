#format dojo_rst

dijit.Tree
==========

:Status: Draft
:Version: 1.2
:Authors: ?--

.. contents::
    :depth: 2

The trees we see in User Interfaces help sort out long, hierarchical lists. A file system is the classic example, with Windows using it in Explorer and Macintoshes with its folder windows. The Dijit tree widget is like that. The Tree widget itself is simple, but the real power comes in the data you pass - this represents the heirarchical structure of the tree. This data is fed by an implementation of the `tree model <dijit/tree/Model>`_, typically either the `TreeStoreModel <dijit/tree/TreeStoreModel>`_ or `ForestStoreModel <dijit/tree/ForestStoreModel>`_, both of which themselves interface with the powerful dojo.data API.

Dojo makes easy trees easy, and hard trees possible. In particular, you can:

* Connect your tree to any dojo.data store implementing the Identity API,  with or without a single root item and with various ways to express parent/child relationships
* Nest trees to an arbitrary depth ... each branch is independently expandable
* Apply different icons to different leaf or branch classes
* Attach code to events. Events fire when users expand, contract or click particular nodes.
* Manipulate the Dojo.data store directly, which manipulates the tree indirectly
* Allow nodes to be dragged and dropped through the familiar Dojo DnD API.
* Drag and drop onto the tree, which updates the data store indirectly


=====
Usage
=====

Unique Identifiers
------------------

Each item in your Tree needs a different identifier (the value of the identifier has to be unique). It's the same concept as a primary key in a database.

Icons
-----

Like other dijits, the icon is expressed as a CSS class (which should load a background-image). You specify the class per item by overriding getIconClass():

  .. code-block ::  html

    <script type="dojo/method" event="getIconClass" args="item, opened">
        if(item == this.model.root) return (opened ? "customFolderOpenedIcon" : "customFolderClosedIcon");
        else return myStore.getValue(item, "type") + "Icon";
    </script>

========
Examples
========

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

Tree without root node
----------------------

Sometimes you don't want that "Continents" top level node to show up, especially if it's inside a TitlePane/AccordionPane/etc. with the label "Continents". In that case you should set showRoot=false. The item still exists in the model but it's hidden on the screen:

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

Drag And Drop
-------------

TODO

More examples
-------------

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
