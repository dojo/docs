.. _dojo/clone:

===============
dojo.clone
===============

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

Part of Base Dojo (dojo.js) - Clones `anything` objects and/or nodes, returning a new `anything`.

Usage
=====

Simply pass _something_ to dojo.clone, and a new version of that _something_ will be made.

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/lang"], function(lang){
    // clone an object
    var obj = { a:"b", c:"d" };
    var thing = lang.clone(obj);

    // clone an array
    var newarray = lang.clone(["a", "b", "c"]);
  });
  // Dojo < 1.7
  // clone an object
  var obj = { a:"b", c:"d" };
  var thing = dojo.clone(obj);

  // clone an array
  var newarray = dojo.clone(["a", "b", "c"]);
  
Often times, you want to clone a DOM Node. The easiest way to locate a DOM Node is :ref:`byId <dojo/byId>`, though consideration to change the id after cloning is required (id's are unique, and should be used as such)

.. js ::
  
  // Dojo 1.7 (AMD)
  require(["dojo/_base/lang", "dojo/dom", "dojo/dom-attr"], function(lang, dom, attr){
    var node = dom.byId("someNode");
    var newnode = lang.clone(node);
    attr.set(newnode, "id", "someNewId");
  });
  // Dojo < 1.7
  var node = dojo.byId("someNode");
  var newnode = dojo.clone(node);
  dojo.attr(newnode, "id", "someNewId");

If you have a pointer to some node already, or want to avoid id's all together, :ref:`dojo.query <dojo/query>` may be useful:

.. js ::
  
  // Dojo 1.7 (AMD)
  require(["dojo/_base/lang", "dojo/query", "dojo/dom-construct", "dojo/_base/window"], function(lang, query, ctr, win){
    // get a reference to some node
    var n = query(".someNode")[0];

    // create 10 clones of this node and append to body
    var i = 10;
    while(i--){
      ctr.place(lang.clone(n), win.body());
    }
  });
  // Dojo < 1.7
  // get a reference to some node
  var n = dojo.query(".someNode")[0];

  // create 10 clones of this node and append to body
  var i = 10;
  while(i--){
      dojo.place(dojo.clone(n), dojo.body());
  }

dojo.clone is always "deep". Cyclic (e.g., circular or DAG) cases are explicitly not supported due to speed and space concerns.

    * If you want a shallow copy of an object y = dojo.mixin({}, x);
    * If you want a shallow copy of an array: y = dojo.map(x, "return value;");
    * The rest will be covered by the deep copy: y = dojo.clone(x);

TODOC: clone + events?
