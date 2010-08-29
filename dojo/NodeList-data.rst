#format dojo_rst

dojo.NodeList-data
==================

.. contents::
   :depth: 2

:author: Peter Higgins
:since: 1.6.0

========
Overview
========

Provides a simple Data abstraction API to `dojo.NodeList <dojo/NodeList>`_, which is the result of calling `dojo.query <dojo/query>`_. This allows you to bind data items to individual nodes, knowing you will be able to retrieve the data later if you get a reference to that node. 

The public APIs for the module are exposed on `dojo.NodeList <dojo/NodeList>`_ as *data* and *removeData*. The *data* method acts as a setter getter, and *removeData* does as it's name suggests: remove all or some data from this node reference.

The include the **data** APIs in your environment issue an appropriate `dojo.require <dojo/require>`_ call:

.. javascript ::

  dojo.require("dojo.NodeList-data");

============
Using data()
============

The API to *data* is very simple. Each node has some arbitrary object hash of data items. Set a data item by key by passing a string key name, and some data to set at that position.

.. javascript::

  dojo.query("#mynode").data("datakey", "This is the data I'm setting");

Now, the node with id="mynode" has a string data item under the key *datakey*. We can later get this data by calling *data* with only the key name:

.. javascript::

  var mydata = dojo.query("#mynode").data("datakey");
  if(mydata[0] == "This is the data I'm setting"){ alert("see?"); }

Notice we need to access the return of `dojo.query <dojo/query>`_ as if it were an array, despite there only being one node in the list. *data* always returns an Array when acting as a getter. If the list has more than one item, the return array will have that many items as well. 

We can set any type of data at some key name, be it a String, Array, Object, and even functions. 

.. javascript::

  dojo.query("#someNode").data("myarray", [1,2]);
  dojo.query("#diffNode").data("handlerFunction", function(){ ... }); 

Or an example of using an object has *as* the actual data:

.. javascript::

  dojo.query("#navNode").data("special-information", {
       huh: "the Data at `special-information` is this complex object",
       anumber: 42,
       thelist: [1,2,3]
  });

  // get it back:
  var data = dojo.query("#navNode").data("special-information")[0];
  data.anumber++;
  data.thelist.push(4);

Like other Dojo APIs, *data* accepts an object argument, which would be mixed into the node's data set. For example:

.. javascript::

  // like calling .data("a", 'b").data("c", "d").data("e", [1,2,3]
  dojo.query("#foo").data({
     a:"b", c:"d", e:[1,2,3]
  });

  dojo.query("#foo").data("a")[0]; // "b"
  dojo.query("#foo").data("e")[0]; // [1,2,3]

This is useful when needing to set multiple independent data keys. Note how this differs from calling:

.. javascript::

   dojo.query("#foo").data("stuff", {
       a:"b", c:"d", e:[1,2,3]
   }); 

Here were stashing this object at the key *stuff*, as compared to the previous example where each of the object keys we used as data keys.

Various Return Types
--------------------

There are several different types of returns that can come from *NodeList.data*. First, when acting as a setter, *data* returns the NodeList, so you can continue chaining.

.. javascript::

  dojo.query("#bar").data("foo", 10).onclick(function(){ alert(dojo.query(this).data("foo")[0] == 10) });

When acting as a getter, NodeList.data *always* returns an Array. The array is populated with either the data at the requested key, or the entire data set if called with no arguments.

.. javascript::

  dojo.query("#bar").data("a", "b").data("c", "d").data({ e:[1,2,3] };
  // calling with no arguments return _entire_ data set bound to node. 
  var data = dojo.query("#bar").data()[0];
  console.log(data.a, data.c, data.e); // logs "b" "d" [1,2,3]

Private APIs
------------

Though nonstandard, NodeList-data provides several "private" APIs. These functions are used with the NodeList "adapters", and mixed in from the single-node variant. If you are more comfortable with using direct node access, feel free to use these APIs. There name may change, but their function signature cannot, as the power the public *data* and *removeData* exported to `NodeList <dojo/NodeList>`_

:dojo._nodeData(node, key, value): Can be called by passing a String or DomNode reference in the first position. All other arguments are shifted over.
:dojo._removeNodeData(node, key): Can be called by passing a String or DomNode reference in the first position. 

Here is a comparison:

.. javascript::

   // setters:
   dojo.query("#bar").data("baz", 10);
   dojo._nodeData("bar", "baz", 10);

   // getter, _nodeData does _not_ return an Array:
   var data = dojo.query("#bar").data("baz")[0];
   var dat2 = dojo._nodeData("bar", "baz"); 

   if(data == dat2){ alert("see?") }


============
Data Removal
============

The *removeData* API works nearly the same as *data*. Calling *removeData* with no arguments will erase all data bound to the node, and passing a string key name will erase the data under the key of the same name in the cache. 

.. javascript::

   dojo.query("#bar").removeData(); // erases all information
   dojo.query("#baz").removeData("e"); // removed [1,2,3] for instance

There is, however, no way to remove a list of keys. An example of how to do so would look like:

.. javascript::

  var remover = dojo.partial(dojo._removeNodeData, "nodeId");
  dojo.forEach(["key", "otherkey", "somekey"], remover);

=====================
Memory Considerations
=====================

There is no automatic node-deletion tracking going on. If you bind data to a node, and destroy that node directly or indirectly, the data will persist in the cache. In small pages, the memory consumption of this data cache is probably not worth considering. In large pages, or single-page-ajax apps that seldom or never refresh, the memory could increase indefinitely, leading to what could be perceived as a *leak*. It is **highly** recommended you manually clear out data on nodes you no longer need. If this is not a possibility due to engineering, or loose coupling, a single garbage collection API is provided: ``dojo._gcNodeData()``

You can call ``_gcNodeData`` at any time. It will remove items from the cache for nodes that no longer exist in the DOM. This function could be **wildly** expensive, especially on pages with a large DOM. Again, though this API is provided, it is **highly** recommended you manually manage your Data items if in a scenario leading to these potential "leaks". 

=========
See Also
=========

  * `dojo.data <dojo/data>`_ - dojo.data is an opaque Data API, unrelated to direct node references. More powerful and abstract than this node-data module. 
  * `dijit._Widget <dijit/_Widget>`_ - If you have complex data and relationships between components and nodes, perhaps you are thinking about it wrong. dijit._Widget provides another take on data-node binding by providing an API to Objects exclusively, each bound to at the least a top-level DomNode. This base class powers the entire Dijit UI library, and is very small. 
