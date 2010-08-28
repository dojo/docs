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

============
Using data()
============

The API to *data* is very simple. Each node has some arbitrary object hash of data items. Set a data item by key by passing a string key name, and some data to set at that position.

.. js::

  dojo.query("#mynode").data("datakey", "This is the data I'm setting");

Now, the node with id="mynode" has a string data item under the key *datakey*. We can later get this data by calling *data* with only the key name:

.. js::

  var mydata = dojo.query("#mynode").data("datakey");
  if(mydata[0] == "This is the data I'm setting"){ alert("see?"); }

Notice we need to access the return of `dojo.query <dojo/query>`_ as if it were an array, despite there only being one node in the list. *data* always returns an Array when acting as a getter. If the list has more than one item, the return array will have that many items as well. 

We can set any type of data at some key name, be it a String, Array, Object, and even functions. 

.. js::

  dojo.query("#someNode").data("myarray", [1,2]);
  dojo.query("#diffNode").data("handlerFunction", function(){ ... }); 

Or an example of using an object has *as* the actual data:

.. js:: 

  dojo.query("#navNode").data("special-information", {
       huh: "the Data at `special-information` is this complex object",
       anumber: 42,
       thelist: [1,2,3]
  });

  // get it back:
  var data = dojo.query("#navNode").data("special-information")[0];
  data.anumber++;
  data.thelist.push(4);


  

============
Data Removal
============


=====================
Memory Considerations
=====================


=========
See Also:
=========

  * `dojo.data <dojo/data>`_ - dojo.data is an opaque Data API, unrelated to direct node references. More powerful and abstract than this node-data module. 
