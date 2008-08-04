## page was renamed from 1.2/dijit/Tree
## page was renamed from dijit/Tree
#format dojo_rst

dijit.Tree
==========

:Status: Draft
:Version: 1.2

The trees we see in User Interfaces help sort out long, heirarchical lists. A file system is the classic example, with Windows using it in Explorer and Macintoshes with its folder windows. The Dijit tree widget is like that. The Tree widget itself is simple, but the real power comes in the data you pass - this represents the heirarchical structure of the tree. This data is fed by the powerful dojo.data API.

Dojo makes easy trees easy, and hard trees possible. In particular, you can:

* Build rooted or rootless trees (forests)
* Nest trees to an arbitrary depth ... each branch is independently expandible
* Apply different icons to different leaf or branch classes
* Connect your tree to any dojo.data store implementing the Identity API.
* Attach code to events. Events fire when users expand, contract or click particular nodes.
* Programmatically build trees. Add, remove or disable nodes programatically.
* Manipulate the Dojo.data store directly, which manipulates the tree indirectly
* Allow nodes to be dragged and dropped through the familiar Dojo DnD API.


Examples
--------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");
      dojo.require("dijit.Menu");
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
      url="http://docs.dojocampus.org/moin_static163/js/dojo/1.1.1/dijit/tests/_data/countries.json"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" 
      store="continentStore" query="{type:'continent'}"
      rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>

    <h3>Tree with hardcoded root node (not corresponding to any item in the store)</h3>
    <p>Clicking a folder node will open/close it (openOnclick==true), and clicking a leaf node will popup an alert.</p>
    <div dojoType="dijit.Tree" id="mytree"
      model="continentModel" openOnClick="true">
      <script type="dojo/method" event="onClick" args="item">
        alert("Execute of node " + continentStore.getLabel(item)
            +", population=" + continentStore.getValue(item, "population"));
      </script>
      <script type="dojo/method" event="onOpen" args="item">
        alert("Open of node " + continentStore.getLabel(item));
      </script>
      <script type="dojo/method" event="onClose" args="item">
        alert("Close of node " + continentStore.getLabel(item));
      </script>
    </div>
