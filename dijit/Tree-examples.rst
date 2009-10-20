#format dojo_rst

dijit.Tree examples
===================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

Initialise the Tree after onLoad Event has Fired
------------------------------------------------

``New in 1.4`` The onLoad event is being introduced in Dojo release 1.4.

.. code-block :: javascript
  :linenos:

    var tree = dijit.byId('myTree');

    // Connect to tree onLoad to do work once it has initialised
    var tmph = dojo.connect(tree, 'onLoad', function() {
        console.debug("tree onLoad here!");
        dojo.disconnect(tmph);

        // do work here
    });

Expanding and Focusing tree nodes programatically
-------------------------------------------------

``New in 1.4``

``dijit.Tree`` in dojo 1.4 has a new 'path' attribute, which can be set with the usual ``tree.attr('path', thePath);`` syntax.  It serves two purposes: to expand the tree up to the node in question, and to highlight that node.


.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dijit.Tree");
        dojo.require("dijit.form.Button");

        function selectNode() {

            mytree.attr('path', [ 'NA', 'MX', 'Mexico City' ] );

        }
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
      url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/countries.json"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" 
      store="continentStore" query="{type:'continent'}"
      rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>
    <div dojoType="dijit.Tree" jsId="mytree" openOnClick="true"
        model="continentModel" showRoot="false" preserve="false"></div>
    <div dojoType="dijit.form.Button" onClick="selectNode();">Highlight the node!</div>

One problem with using 'path' is that you must know the full path to the node in your data your are trying to select.

The following example contains workaround code for this problem, as well as an example call to tree.attr('path').  If you already know the full path to the tree node you want to highlight, you can simply call tree.attr('path').

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dijit.Tree");
        dojo.require("dijit.form.Button");

        function recursiveHunt(lookfor, buildme, item) {
            console.log(">> recursiveHunt, item ", item, " looking for ", lookfor);
            buildme.push(item.id[0]);
            if (item.id[0] == lookfor) {
                // Return the buildme array, indicating a match was found
                console.log("++ FOUND item ", item, " buildme now = ", buildme);
                return buildme;
            }
            for (var idx in item.children) {
                // start a new branch of buildme, starting with what we have so far
                var buildmebranch = buildme.slice(0);
                console.log("Branching into ", item.children[idx].name[0], ", buildmebranch=", buildmebranch);
                var r = recursiveHunt(lookfor, buildmebranch, item.children[idx]);
                // If a match was found in that recurse, return it.
                //  This unwinds the recursion on completion.
                if (r) { return r; }
            }
            // Return undefined, indicating no match was found
            return undefined;
        }

        function selectTreeNodeById(tree, lookfor) {
            console.log("See model root=", tree.model.root);
            var buildme = new Array();
            var result = recursiveHunt(lookfor, buildme, tree.model.root);
            console.log("*** FINISHED: result ", result, " buildme ", buildme);
            console.dir(result);
            if (result && result.length > 0) {
                tree.attr('path', result);
            }
        }

        function selectNode() {

            selectTreeNodeById(mytree2, 'Mexico City');

        }
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
      url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/countries.json"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" 
      store="continentStore" query="{type:'continent'}"
      rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>
    <div dojoType="dijit.Tree" jsId="mytree2" openOnClick="true"
        model="continentModel" showRoot="false" preserve="false"></div>
    <div dojoType="dijit.form.Button" onClick="selectNode();">Highlight the node!</div>

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
