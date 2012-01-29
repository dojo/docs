.. _dijit/tree/TreeStoreModel:

=========================
dijit.tree.TreeStoreModel
=========================

The TreeStoreModel connects a data store with a single "root" item to a :ref:`dijit.Tree <dijit/Tree>`.

An example might be an employee database where the company's CEO is the root item, and all other
employees report directly or indirectly to the CEO.

Here's an example of a declarative initialization for a TreeStoreModel and for the data store that it connects to:

.. html ::

    <div data-dojo-type="dojo/data/ItemFileWriteStore" data-dojo-id="store"
        data-dojo-props="url:'../tests/_data/treeTest.json'"></div>
    <div data-dojo-type="dijit/tree/TreeStoreModel" data-dojo-id="model"
        data-dojo-props="childrenAttrs:'kids',
        store:store, query:{id:'root'}"></div>

A few things to note here:

  * The query {id:'root'}, when run against the data store, must return exactly one item
  * That item should have an attribute named "kids" with a list of children items


Here's a much more complicated where we've overridden the getChildren() method because in the
data store a child references it's parent rather than vice-versa.

.. html ::

    <div data-dojo-type="dijit/tree/TreeStoreModel" data-dojo-id="model" data-dojo-props="store:store">
        <script type="dojo/method" data-dojo-event="getChildren" data-dojo-args="item, onComplete">
            return store.fetch({query: {parent: store.getIdentity(item)}, onComplete: onComplete});
        </script>
        <script type="dojo/method" data-dojo-event="mayHaveChildren" data-dojo-args="item">
            var type = store.getValue(item, "type");
            return (type == "continent" || type == "country");
        </script>
    </div>
