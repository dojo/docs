#format dojo_rst

dijit.Tree examples
===================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

Focusing tree nodes programatically
-----------------------------------

``TODOC``

How can I prevent expanding of nodes when clicking on them?
-----------------------------------------------------------

Simply set the ``openOnClick`` attribute to ``false``

.. cv-compound::
  :type: inline

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
  :type: inline

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
