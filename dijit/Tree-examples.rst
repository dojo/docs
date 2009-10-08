#format dojo_rst

dijit.Tree examples
===================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

Expanding and Focusing tree nodes programatically
-------------------------------------------------

Taking as an example a dijit.Tree linked to a ForestStoreModel linked to a ItemFileReadStore:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.tree.ForestStoreModel");
      dojo.require("dijit.Tree");
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="catStore"
        dojoAttachPoint="catStore" onComplete="_storeOnComplete" dojoAttachEvent="onComplete: _storeOnComplete"
        url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/countries.json">
    </div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="catModel" jsId="catModel" store="catStore"
        query="{type:'continent'}" rootId="continentRoot" rootLabel="Continents"
        childrenAttrs="children">
    </div>
    <span>In Category:</span>
    <div dojoType="dijit.Tree" id="mytree" jsId="catTree" model="catModel"
        openOnClick="true" showRoot="false" persist="false">
    </div>

Lets presume the tree does not persist its expanded state between reloads (see 'persist="false"' in the example above).  It will load unexpanded, with only the root TreeNode in the tree.  When that root node is expanded, its immediate child TreeNodes will be created.  However, until then, there is only the root node.

In order to select a TreeNode deep in the hierarchy, we must:
- know the identify of the item in the store for the item we want to expand.
- build an array of DataItem objects from the store for each item in the data hierarchy
- expand each TreeNode in the tree for that hierarchy, to force creation of all the TreeNodes we need
- finally, tell the Tree to select the TreeNode we are interested in.

Here is the solution I came up with:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.tree.ForestStoreModel");
      dojo.require("dijit.Tree");

	function recursiveExpandNodes(tree, thisTreeNode, items, itemLevel) {

		// Remember, there may be more than one TreeNode for each DataItem.
		// This approach only matches multiple TreeNodes if they are in the
		//  same group of siblings, not elsewhere in the tree.
		thisTreeNode.getChildren().forEach(function(eachTreeNode) {
			console.log("Want to expand item ", items[itemLevel], ", this child ", eachTreeNode);
			if (eachTreeNode.item == items[itemLevel]) {
				console.log("*** EXPAND tree node ", eachTreeNode, "!!");
				tree._expandNode(eachTreeNode);
				if (itemLevel < (items.length-1)) {
					recursiveExpandNodes(tree, eachTreeNode, items, itemLevel + 1);
				}
			}
		});
		
	}

	// This function uses 'idLevel' to work its way down 'idArray'.
	// For each simple id, it queries the tree's model's store, and caches the
	//  DataItem in 'items'.
	// Finally, 'items' is used in tree.attr('path').
	function recursiveFetch(dataItems, tree, idArray, idLevel) {
		if (idLevel == idArray.length) {
			console.log("Final recurse, use built array ", dataItems);

			// If we use 'path' now, tree nodes are not guaranteed to exist
			//  because the tree lazy loads them.  Have to programatically
			//  expand tree nodes.
			var root = tree.rootNode;
			recursiveExpandNodes(tree, root, dataItems, 0);

			console.log("Calling attr('path') for items: ", dataItems);
			// NB setPathAttr will empty the dataItems array as a side-effect,
			//  so grab lastItem here.
			var lastItem = dataItems[dataItems.length-1];

			tree.attr('path', dataItems);

			console.log("Setting selected item to ", lastItem);
			tree.attr('selectedItem', lastItem);
		} else {
			tree.model.store.fetch({
				query: { 'id': idArray[idLevel] },
				queryOptions: { 'deep': true },
				onComplete: dojo.hitch(this, function(dataItem) {
					console.log("buildRendering fetch onComplete: ", dataItem, " at level " + idLevel + " of " + idArray.length);
					dataItems.push(dataItem[0]);

					idLevel ++;
					if (idLevel <= idArray.length) {
						console.log("Recursing for level " + idLevel + ", id " + idArray[idLevel]);
						this.recursiveFetch(dataItems, tree, idArray, idLevel);
					}

				}),
				onError: function(data) {
					console.log("ERROR fetching category: ", data);
				}
			});
		}

	}

	function selectTheNode() {

		var dataItems = new Array();

		// The intention is to select the last item in the array, however, to do
		//  so I seem to need to query the store for each item leading up to
		//  that last item, and build an array of DataItems from the store for
		//  each one, in order to pass the array of DataItems to tree.attr('path').
		recursiveFetch(dataItems, catTree,
				['NA', 'MX', 'Mexico City'], 0);
	}
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="catStore"
        dojoAttachPoint="catStore" onComplete="_storeOnComplete" dojoAttachEvent="onComplete: _storeOnComplete"
        url="http://neekfenwick.homeip.net:8080/DojoTest/treeitemselect.json">
    </div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="catModel" jsId="catModel" store="catStore"
        query="{type: 'continent'}" rootId="continentRoot" rootLabel="Continents"
        childrenAttrs="children">
    </div>
    <span>In Category:</span>
    <div dojoType="dijit.Tree" id="mytree" jsId="catTree" model="catModel"
        openOnClick="true" showRoot="false" persist="false">
    </div>
    <input type='button' onClick='selectTheNode();'>Select the node!</input>

How can I prevent expanding of nodes when clicking on them?
-----------------------------------------------------------

Simply set the ``openOnClick`` attribute to ``false``

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
      model="continentModel" openOnClick="false">
      <script type="dojo/method" event="onClick" args="item">
        alert("Execute of node " + continentStore.getLabel(item)
            +", population=" + continentStore.getValue(item, "population"));
      </script>
    </div>



Example using Local Data and Markup
-----------------------------------------------------------

Most of the examples have used the same url:json source of the data for the store.
This example uses local data from a javascript object as the raw data.
In addition, _createTreeNode is overridden to allow HTML markup in the tree.
This is a hack, in the sense that the formatting may not be perfect for large (in pixels) elements.
But the tree will display and work properly regardless, and for simple markup, eg bold, it works great.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require( "dijit.Tree" );

        var rawdata = [ {
            label: 'Something <b>important</b>',
            id: '1',
            children:  [ { label: 'Life', id: '1.1' }, { label: 'Liberty', id: '1.2' } ]
        }, {
            label: 'Some links (note: the link is <b>not</b> clickable)',
            id: '2',
            children: [
                { id: '2.1', label: '<a href="http://dojotoolkit.org">Dojo Toolkit</a>' },
                { id: '2.2', label: '<img src="http://dojofoundation.org/media/img/dojo.logo.png" alt="greatest ever" height="32px" />' },
                { id: '2.3', label: '<a href="http://blog.nqzero.com">my blog</a>' }
            ]
        } ];

        function prepare() {
            var store = new dojo.data.ItemFileReadStore({
                data: { identifier: 'id', label : 'label', items: rawdata }
            });
            var treeModel = new dijit.tree.ForestStoreModel({ store: store });
            var treeControl = new dijit.Tree({
                model: treeModel,
                showRoot: false,
                _createTreeNode: function(/*Object*/ args){
                    var tnode = new dijit._TreeNode(args);
                    tnode.labelNode.innerHTML = args.label;
                    return tnode;
                }
            }, "treeOne" );
        }

        dojo.addOnLoad(prepare);
    </script>

  .. cv:: html

    <div id="treeOne"></div>
