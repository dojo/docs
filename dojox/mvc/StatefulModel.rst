.. _dojox/mvc/StatefulModel:

=======================
dojox.mvc.StatefulModel
=======================

:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:since: V1.7


.. contents ::
   :depth: 2

*Deprecated*. The first-class native JavaScript data model based on dojo.Stateful that wraps any data structure(s) that may be relevant for a view, a view portion, a dijit or any custom view layer component.


Constructor Parameters
======================

+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|Parameter   |Type     |Default             |Description                                                                                             |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|data        |Object   |                    |The plain JavaScript object / data structure used to initialize this model. At any point in time, it    |
|            |         |                    |holds the lasted saved model state.  Either data or store property must be provided.                    |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|store       |DataStore|                    | The data store from where to retrieve initial data for this model. An optional query may also be       |
|            |         |                    | provided along with this store. Either data or store property must be provided.                        |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+

Available Members
=================

* StatefulModel.valid

Whether this model deems the associated data to be valid.

* StatefulModel.value

The associated value (if this is a leaf node). The value of intermediate nodes in the model is not defined.

* StatefulModel.reset()

Resets this data model's values to its original state. Structural changes to the data model (such as adds or removes) are not restored.

* StatefulModel.commit()

Commits this data model:
Saves the current state such that a subsequent reset will not undo any prior changes.
Persists client-side changes to the data store, if a store has been supplied as a parameter or at instantiation.

* StatefulModel.toPlainObject()

Produces and returns a plain JavaScript object representation of the data
currently within this data model.

* StatefulModel.add(name, Stateful)

Adds the dojo.Stateful tree represented by the given dojox.mvc.StatefulModel at the given property name. In case of arrays, the property names are indices passed as Strings. An addition of such a dojo.Stateful node results in right-shifting any trailing sibling nodes.

* StatefulModel.remove(name)

Removes the dojo.Stateful tree at the given property name. In case of arrays, the property names are indices passed as Strings. A removal of such a dojo.Stateful node results in left-shifting any trailing sibling nodes.

* StatefulModel.valueOf()

Returns the value representation of the data currently within this data model

* StatefulModel.toString()

Returns the string representation of the data currently within this data model.


Usage
=====

A data model is effectively instantiated with a plain JavaScript object which specifies the initial data structure for the model.

.. js ::

    var struct = {
        order: "abc123",
        shipto: {
            address: "123 Example St, New York, NY",
            phone: "212-000-0000"
        },
        items: [
            { part: "x12345", num : 1 },
            { part: "n09876", num : 3 }
        ]
    };

    var model = dojox.mvc.newStatefulModel({ data : struct });

The simple example above shows an inline plain JavaScript object illustrating the data structure to prime the model with, however the underlying data may be made available by other means, such as from the results of a dojo.store or dojo.data query.

To deal with stores providing immediate values or Promises, a factory method for model instantiation is provided. This method will either return an immediate model or a model Promise depending on the nature of the store.

.. js ::

    var model = dojox.mvc.newStatefulModel({ store: someStore });

The created data model has the following properties:

* It enables dijits or custom components in the view to "bind" to data within the model. A bind creates a bi-directional update mechanism between the bound view and the underlying data:

* The data model is "live" data i.e. it maintains any updates driven by the view on the underlying data.

* The data model issues updates to portions of the view if the data they bind to is updated in the model. For example, if two dijits are bound to the same part of a data model, updating the value of one in the view will cause the data model to issue an update to the other containing the new value.

* The data model internally creates a tree of dojo.Stateful objects that matches the input, which is effectively a plain JavaScript object i.e. "pure data". This tree allows dijits or other view components to bind to any node within the data model. Typically, dijits with simple values bind to leaf nodes of the datamodel, whereas containers bind to internal nodes of the datamodel. For example, a datamodel created using the object below will generate the dojo.Stateful tree as shown:

.. js ::

    var model = dojox.mvc.newStatefulModel({ data : {
        prop1: "foo",
        prop2: {
            leaf1: "bar",
            leaf2: "baz"
        }
    }});

    // The created dojo.Stateful tree is illustrated below (all nodes are dojo.Stateful objects)
    //
    //                  o  (root node)
    //                 / \
    //   (prop1 node) o   o (prop2 node)
    //               / \
    // (leaf1 node) o   o (leaf2 node)
    //
    // The root node is accessed using the expression "model" (the var name above). The prop1
    // node is accessed using the expression "model.prop1", the leaf2 node is accessed using
    // the expression "model.prop2.leaf2" and so on.


* Each of the dojo.Stateful nodes in the model may store data as well as associated "meta-data", which includes things such as whether the data is \ required or readOnly etc. This meta-data differs from that maintained by, for example, an individual dijit in that this is maintained by the datamodel and may therefore be affected by datamodel-level constraints that span multiple dijits or even additional criteria such as server-side computations.

* When the model is backed by a dojo.store or dojo.data query, the client-side updates can be persisted once the client is ready to "submit" the changes (which may include both value changes or structural changes - adds/deletes). The datamodel allows control over when the underlying data is persisted i.e. this can be more incremental or batched per application needs.

There need not be a one-to-one association between a datamodel and a view or portion thereof. For example, multiple datamodels may back the dijits in a view. Indeed, this may be useful where the binding data comes from a number of data sources or queries, for example. Just as well, dijits from multiple portions of the view may be bound to a single datamodel.

Finally, requiring this class also enables all dijits to become data binding aware. The data binding is commonly specified declaratively via the "ref" property in the "data-dojo-props" attribute value.

To illustrate, the following is the "Hello World" of such data-bound widget examples.

.. js ::

        var model;
        require(["dojox/mvc", "dojo/parser", "dijit/form/TextBox", "dojo/domReady!"], function(dxmvc, parser){
            model = dojox.mvc.newStatefulModel({ data : {
                hello : "Hello World"
            }});
            parser.parse();
        });

    <input id="helloInput" data-dojo-type="dijit.form.TextBox"
        data-dojo-props="ref: 'model.hello'">


Such data binding awareness for dijits is added by extending the dijit._WidgetBase class to include data binding capabilities provided by dojox.mvc._DataBindingMixin, and this class declares a dependency on dojox.mvc._DataBindingMixin.

The presence of a data model and the data-binding capabilities outlined above support the flexible development of a number of MVC patterns on the client. As an example, CRUD operations can be supported with minimal application code.
