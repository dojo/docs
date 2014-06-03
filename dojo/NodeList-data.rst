.. _dojo/NodeList-data:

==================
dojo/NodeList-data
==================

.. contents ::
   :depth: 2

:author: Peter Higgins
:since: 1.6.0

Introduction
============

``dojo/NodeList-data`` is a module that extends the :ref:`NodeList <dojo/NodeList>` by adding a simple data 
abstraction API.  This allows you to bind data items to individual nodes, allowing retrieval of the data later by
reference to the node.

The module exposes the API by extending ``NodeList`` with two methods: ``data()`` and ``removeData()``.

Usage
=====

To utilise the module, require it in.  It does not need to be provided a return variable.  It is normally used in 
conjunction with the :ref:`dojo/query <dojo/query>` module:

.. js ::

  require(["dojo/query", "dojo/NodeList-data"], function(query){
    query("#aNode").data("someKey", "someValue");
  });

data()
------

Adds or retrieves arbitrary data to ``NodeList`` nodes.  When passed two arguments the function acts as a setter, the 
first argument specifies the key of the data and the second is the value.  The function then will set that data on
each node that is a member of the ``NodeList``.  When passed only a single argument, it acts as a getter and returns a 
zero based array of the values for the specified key.

.. js ::

  require("dojo/query", "dojo/NodeList-data", function(query){
    query("#foo").data("bar", "baz");
    var values = query("#foo").data("bar");
    if(values[0] == "baz"){
      // do something
    }
  });

Notice how the return of ``data()`` when it is acting like a getter is an Array.  This is because a ``NodeList`` is 
essentially an array, even when it has only a single element.

When ``data()`` is a setter, it returns the instance of ``NodeList`` it is operating on, thereby allowing for chaining:

.. js ::

  require("dojo/query", "dojo/NodeList-data", function(query){
    query(".someClass")
      .data("bar", "baz")
      .data("qat", "qut");
  });

Also, ``data()`` can accept an Object, which will then be mixed into the data of the node:

.. js ::

  require("dojo/query", "dojo/NodeList-data", function(query){
    query("#foo").data({
      a: "bar",
      b: "baz",
      c: [0, 1, 3]
    });

    var a = query("#foo").data("a")[0];
    // a == "bar"
    var b = query("#foo").data("b")[0];
    // b == "baz"
    var c = query("#foo").data("c")[0];
    // c == [0, 1, 3]
  });

When ``data()`` is called with no arguments, it returns an array of hashes that contain all the data values:

.. js ::

  require(["dojo/query", "dojo/NodeList-data"], function(query){
    query("#foo").data("a", "bar")
      .data("b", "baz")
      .data("c", [0, 1, 3]);

    var values = query("#foo").data()[0];
    // values == { a: "bar", b: "baz", "c": [0, 1, 3] }
  });

removeData()
------------

``removeData()`` will remove data from nodes.  If pass with no arguments, it will remove all the data from the nodes in the ``NodeList`` or if provided with a key, it will remove only that attribute:

.. js ::

  require(["dojo/query", "dojo/NodeList-data"], function(query){
    query("#foo").removeData(); // add data removed
    query("#foo").removeData("bar"); // only "bar" removed
  });

Notes
=====

Memory Considerations
---------------------

There is no automatic node-deletion tracking going on. If you bind data to a node, and destroy that node directly or 
indirectly, the data will persist in the cache. In small pages, the memory consumption of this data cache is probably 
not worth considering. In large pages, or single page AJAX apps that seldom or never refresh, the memory could 
increase indefinitely, leading to what could be perceived as a *leak*. It is **highly** recommended you manually clear 
out data on nodes you no longer need. If this is not a possibility due to engineering, or loose coupling, a single 
garbage collection API is provided: ``_gcNodeData()``.  This can be accessed by ensuring you have loaded the 
``dojo/_base/kernel``:

.. js ::

  require(["dojo/_base/kernel", "dojo/NodeList-data"], function(kernel){
    kernel._gcNodeData();
  });

You can call ``_gcNodeData()`` at any time. It will remove items from the cache for nodes that no longer exist in the 
DOM. This function could be *wildly* expensive, especially on pages with a large DOM. Again, though this API is 
provided, it is **highly** recommended you manually manage your Data items if in a scenario leading to these potential 
"leaks".

See Also
========

* :ref:`dojo/store <dojo/store>` - is an opaque Data API, unrelated to direct node references. More powerful and 
  abstract than this node-data module.

* :ref:`dijit/_WidgetBase <dijit/_WidgetBase>` - If you have complex data and relationships between components and 
  nodes, perhaps you are thinking about it wrong. ``dijit/_WidgetBase`` provides another take on data-node binding by 
  providing an API to Objects exclusively, each bound to at the least a top-level DomNode. This base class powers the 
  entire Dijit UI library, and is very small.
