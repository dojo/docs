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

How can I make all items in a tree to appear and work like items and not items and folders?
-------------------------------------------------------------------------------------------

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
      rootId="continentRoot" rootLabel="Continents" openOnClick="false" childrenAttrs="children"></div>

    <div dojoType="dijit.Tree" id="mytree"
      model="continentModel" openOnClick="true">
      <script type="dojo/method" event="onClick" args="item">
        alert("Execute of node " + continentStore.getLabel(item)
            +", population=" + continentStore.getValue(item, "population"));
      </script>
    </div>
