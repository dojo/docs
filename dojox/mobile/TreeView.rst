.. _dojox/mobile/TreeView:

====================================
dojox.mobile.TreeView (EXPERIMENTAL)
====================================

:Authors: Yoshiroh Kamiyama
:Developers: Michael Rheinheimer, Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

The dojox.mobile.TreeView is an **EXPERIMENTAL** widget.

Introduction
============

The dojox.mobile.TreeView widget is a scrollable view with tree-style navigation. You may use it when implementing the Master-Detail pattern.

.. image :: TreeView-anim.gif

Examples
========

Declarative example
-------------------

.. js ::

  require([
    "dojox/data/FileStore",
    "dijit/tree/ForestStoreModel",
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/TreeView"
  ], function(FileStore, ForestStoreModel){
    var store = new FileStore({
      url: "../../data/demos/stores/filestore_dojotree.php",
      id: "theStore",
      label: "name",
      pathAsQueryParam: true
    });
    treeModel = new ForestStoreModel({
      store: store,
      rootLabel: "Files",
      childrenAttrs: ["children"],
      newItemIdAttr: "path"
    });
  });

.. html ::

  <div data-dojo-type="dojox.mobile.TreeView"
       data-dojo-props='model: treeModel'></div>

.. image :: TreeView-example1-anim.gif
