## page was renamed from dijit/TreeModel
#format dojo_rst

dijit.tree.Model
================

A `dijit.Tree <dijit/Tree>`_ presents a view onto some hierarchical data.  The "TreeModel" represents the actual data.

Usually, the data ultimately comes from a data store, but the Tree
interfaces with a "dijit.tree.Model", an Object matching a certain API of methods the tree needs.
This allows Tree to access data in various formats, such as with a data store where items
reference their parents (ie, the relational model) rather than parents having a list of
their children.

There are two model implementations included with Tree:

  * `dijit.tree.TreeStoreModel <dijit/tree/TreeStoreModel>`_: interface to a data store with a single item that represents the root of the tree.  For example, a data store of employees where the root is the CEO of the company.
  * `dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_: interface to a data store with multiple top level items.  For example, a data store of places (countries, states, cities).  If the data store doesn't have a single root item ("world" in this example) then ForestStoreModel is the interface for it.

Here's the API to implement your own model.

.. code-block :: javascript

  destroy: function(){
          // summary: destroys this object, releasing connections to the store
  },
  
  // =======================================================================
  // Methods for traversing hierarchy
  getRoot: function(onItem){
          // summary:
          //            Calls onItem with the root item for the tree, possibly a fabricated item.
          //            Throws exception on error.
  },
  
  mayHaveChildren: function(/*dojo.data.Item*/ item){
          // summary
          //            Tells if an item has or may have children.  Implementing logic here
          //            avoids showing +/- expando icon for nodes that we know don't have children.
          //            (For efficiency reasons we may not want to check if an element actually
          //            has children until user clicks the expando node)
  },
  
  getChildren: function(/*dojo.data.Item*/ parentItem, /*function(items)*/ onComplete){
          // summary
          //           Calls onComplete() with array of child items of given parent item, all loaded.
          //            Throws exception on error.
  },
  
  // =======================================================================
  // Inspecting items
  getIdentity: function(/* item */ item){
          // summary: returns identity for an item
  },
  
  getLabel: function(/*dojo.data.Item*/ item){
          // summary: get the label for an item
  },
  
  // =======================================================================
  // Write interface
  newItem: function(/* Object? */ args, /*Item?*/ parent){
          // summary
          //            Creates a new item.   See dojo.data.api.Write for details on args.
  },
  
  pasteItem: function(/*Item*/ childItem, /*Item*/ oldParentItem, /*Item*/ newParentItem, /*Boolean*/ bCopy){
          // summary
          //            Move or copy an item from one parent item to another.
          //            Used in drag & drop.
          //            If oldParentItem is specified and bCopy is false, childItem is removed from oldParentItem.
          //            If newParentItem is specified, childItem is attached to newParentItem.
  },
  
  // =======================================================================
  // Callbacks
  onChange: function(/*dojo.data.Item*/ item){
          // summary
          //            Callback whenever an item has changed, so that Tree
          //            can update the label, icon, etc.   Note that changes
          //            to an item's children or parent(s) will trigger an
          //            onChildrenChange() so you can ignore those changes here.
  },
  
  onChildrenChange: function(/*dojo.data.Item*/ parent, /*dojo.data.Item[]*/ newChildrenList){
          // summary
          //            Callback to do notifications about new, updated, or deleted items.
  }
