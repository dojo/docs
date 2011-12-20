.. _dijit/Tree-examples:

===================
dijit.Tree examples
===================


.. contents ::
  :depth: 2

Detect when tree has finished loading
-------------------------------------

Use the onLoadDeferred to detect when the Tree has finished loading

.. js ::
  
    var tree = dijit.byId('myTree');

    // Connect to tree onLoad to do work once it has initialized
    tree.onLoadDeferred.then(function(){
        console.debug("tree onLoad here!");
        dojo.disconnect(tmph);

        // do work here
    });

Expanding and Focusing tree nodes programmatically
--------------------------------------------------

``dijit.Tree`` in dojo 1.4 has a new 'path' attribute, which can be set with the usual ``tree.set('path', thePath);`` syntax.  It serves two purposes: to expand the tree up to the node in question, and to highlight that node.


.. code-example ::

  .. js ::

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dijit.Tree");
        dojo.require("dijit.form.Button");

        selectNode = function(){
            mytree.set('path', [ 'continentRoot', 'NA', 'MX', 'Mexico City' ] );
        }
    </script>

  .. html ::

    <div data-dojo-type="dojo.data.ItemFileReadStore" data-dojo-id="continentStore"
      data-dojo-props="url:'{{ dataUrl }}dijit/tests/_data/countries.json'"></div>
    <div data-dojo-type="dijit.tree.ForestStoreModel" data-dojo-id="continentModel"
      data-dojo-props="store:continentStore, query:{type:'continent'},
      rootId:'continentRoot', rootLabel:'Continents', childrenAttrs:'children'"></div>
    <div data-dojo-type="dijit.Tree" data-dojo-id="mytree"
      data-dojo-props="openOnClick:true, model:continentModel, showRoot:false, persist:false"></div>
    <div data-dojo-type="dijit.form.Button" data-dojo-props="onClick:selectNode}">Highlight the node!</div>

One problem with using 'path' is that you must know the full path to the node in your data you are trying to select.

The following example contains workaround code for this problem, as well as an example call to tree.set('path').
If you already know the full path to the tree node you want to highlight, you can simply call tree.set('path').

.. code-example ::

  .. js ::

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dijit.Tree");
        dojo.require("dijit.form.Button");

        function recursiveHunt(lookfor, model, buildme, item){
            console.log(">> recursiveHunt, item ", item, " looking for ", lookfor);
            var id = model.getIdentity(item);
            buildme.push(id);
            if(id == lookfor){
                // Return the buildme array, indicating a match was found
                console.log("++ FOUND item ", item, " buildme now = ", buildme);
                return buildme;
            }
            for(var idx in item.children){
                // start a new branch of buildme, starting with what we have so far
                var buildmebranch = buildme.slice(0);
                console.log("Branching into ", model.store.getValue(item.children[idx], 'name'), ", buildmebranch=", buildmebranch);
                var r = recursiveHunt(lookfor, model, buildmebranch, item.children[idx]);
                // If a match was found in that recurse, return it.
                //  This unwinds the recursion on completion.
                if(r){ return r; }
            }
            // Return undefined, indicating no match was found
            return undefined;
        }

        function selectTreeNodeById(tree, lookfor){
            console.log("See model root=", tree.model.root);
            var buildme = [];
            var result = recursiveHunt(lookfor, tree.model, buildme, tree.model.root);
            console.log("*** FINISHED: result ", result, " buildme ", buildme);
            console.dir(result);
            if(result && result.length > 0){
                tree.set('path', result);
            }
        }

        selectNode = function(){

            selectTreeNodeById(mytree2, 'Mexico City');

        }
    </script>

  .. html ::

    <div data-dojo-type="dojo.data.ItemFileReadStore" data-dojo-id="continentStore"
      data-dojo-props="url:'{{dataUrl}}dijit/tests/_data/countries.json'"></div>
    <div data-dojo-type="dijit.tree.ForestStoreModel" data-dojo-id="continentModel"
      data-dojo-props="store:continentStore,query:{type:'continent'},
      rootId:'continentRoot', rootLabel:'Continents', childrenAttrs:'children'"></div>
    <div data-dojo-type="dijit.Tree" data-dojo-id="mytree2"
      data-dojo-props="openOnClick:true, model:continentModel, showRoot:false, persist:false"></div>
    <div data-dojo-type="dijit.form.Button" onClick="selectNode();">Highlight the node!</div>

How can I prevent expanding of nodes when clicking on them?
-----------------------------------------------------------

Simply set the ``openOnClick`` attribute to ``false``

.. code-example ::

  .. js ::

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");
    </script>

  .. html ::

    <div data-dojo-type="dojo.data.ItemFileReadStore" data-dojo-id="continentStore"
      data-dojo-props="url:'{{dataUrl}}dijit/tests/_data/countries.json'"></div>
    <div data-dojo-type="dijit.tree.ForestStoreModel" data-dojo-id="continentModel"
      data-dojo-props="store:continentStore, query:{type:'continent'},
      rootId:'continentRoot', rootLabel:'Continents', childrenAttrs:'children'"></div>

    <div data-dojo-type="dijit.Tree" id="mytree"
      data-dojo-props="model:continentModel, openOnClick:false">
      <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="item">
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

.. code-example ::

  .. js ::

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

        function prepare(){
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

        dojo.ready(prepare);
    </script>

  .. html ::

    <div id="treeOne"></div>

Example how to build a tree menu with links on nodes
-----------------------------------------------------------

This example shows you how to use a tree to build a navigation menu.

.. code-example ::

  .. js ::

        <script type="text/javascript">
       dojo.require("dojo.data.ItemFileWriteStore");
       dojo.require( "dijit.Tree" );

       function initTree(){
          var treeStore = new dojo.data.ItemFileWriteStore({ data:
             {
                identifier: 'id',
                label: 'name',
                items: [
                   { id: 1, name: 'Dijit Tree API', url: 'http://dojotoolkit.org/api/1.6/dijit.Tree', root: true,
                      children:[{_reference: 2}, {_reference: 3}, {_reference: 4}] },
                   { id: 2, name: 'Dijit Tree.model API', url: 'http://dojotoolkit.org/api/1.6/dijit.Tree.model' },
                   { id: 3, name: 'Dijit Tree.ForestStoreModel API', url: 'http://dojotoolkit.org/api/1.6/dijit.tree.ForestStoreModel' },
                   { id: 4, name: 'Dijit Tree.TreeStoreModel API', url: 'http://dojotoolkit.org/api/1.6/dijit.tree.TreeStoreModel' },
                ]
             }
          });
        
          var treeModel = new dijit.tree.ForestStoreModel({
             store: treeStore,
             query: { 'root': true }
          });

          var navTree = new dijit.Tree({model: treeModel, showRoot: false }, "navTree")

          navTree.onClick = function(item){
              /* load the url from datastore */
              location.href = item.url;
          };
       }
     
       dojo.ready(initTree);
    </script>

  .. html ::

    <div id="navTree"></div>
