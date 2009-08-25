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



Another simple example
-----------------------------------------------------------

the basic example repeated to make sure i understand the wiki

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
