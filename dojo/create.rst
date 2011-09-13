#format dojo_rst

dojo.create
===========

:Available: since V1.3

.. contents::
   :depth: 2

A convenient DOM creation, manipulation and placement utility shorthand. 


============
Introduction
============

dojo.create() is designed to simplify the frequently used sequence of DOM manipulation: 

* create a node, 
* set attributes on it, 
* and place it in the DOM. 

It can be used with existing nodes too, if you want to assign new attributes and place it afterwards.

To see this utility in context, read the `DOM Quick Start <quickstart/dom>`_ first.

In dojo 1.7, dojo.create has been kept in dojo/_base/html as a compatibility of dojo version before, it is an alias of ctr.create in dojo/dom.

=====
Usage
=====

The function takes up to four arguments:

dojo.create(tag, attrs, refNode, pos);

Here is the definition of arguments:

=========  ===========  =======================================================
Parameter  Type         Description
=========  ===========  =======================================================
tag        String|Node  Can be a string or a DOM node. If it is a string, it 
                        will be treated as a node tag name, which will be used 
                        to create a new node.
                        When creating a node the owner document of ``refNode`` 
                        is used. If ``refNode`` is ``null`` or unspecified, 
                        `dojo.doc <dojo/doc>`_ is used.
attrs      Object|null  A dictionary of attributes to be set on ``node``. 
                        This parameter is passed to `dojo.attr <dojo/attr>`_ 
                        unmodified after the node is created.
                        Can be ``null`` or undefined meaning 
                        "don't set any attributes". You should always specify 
                        it explicitly (as ``null``) if you want to specify 
                        the rest of arguments.
refNode    String|null  A string (interpreted as an id of a DOM node) or 
                        a DOM node. This parameter is passed to 
                        `dojo.place <dojo/place>`_ unmodified after the node is 
                        created, and attributes are set.
                        Can be omitted meaning "don't place the node".
pos        String|null  Optional argument. Can be a number or one of the 
                        following strings: "before", "after", "replace", "only", 
                        "first", or "last". If omitted, "last" is assumed. 
                        This parameter is passed to `dojo.place <dojo/place>`_ 
                        unmodified after the node is created, and attributes 
                        are set. Please see `dojo.place <dojo/place>`_ 
                        for more details and examples.
=========  ===========  =======================================================


The function returns a DOM node it created with ``tag`` or the first argument, if it was a DOM node.

Dojo 1.7 (AMD)
--------------

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){     
      // create a div node
      var node = dojo.create("div");
  });

It's recommended to use ctr.create in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-construct"], function(ctr){  // Note, ctr or any other variable name can be used     
      // create a div node
      var node = ctr.create("div");
  });


Dojo < 1.7
----------

.. code-block :: javascript

  // create a div node
  var node = dojo.create("div");


========
Examples
========

Create a <div>:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom-construct"], function(ctr){
    var n = ctr.create("div");
  });

  // dojo < 1.7
  var n = dojo.create("div");

Create a <div> with content:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom-construct"], function(ctr){
    var n = ctr.create("div", { innerHTML: "<p>hi</p>" });
  });

  // dojo < 1.7
  var n = dojo.create("div", { innerHTML: "<p>hi</p>" });

Append a new <div> to <body> with no attributes:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom-construct", "dojo/_base/window"], function(ctr, win){
    var n = ctr.create("div", null, win.body());
  });

  // dojo < 1.7
  var n = dojo.create("div", null, dojo.body());

Place a new <div> as the first child of <body> with no attributes:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom-construct", "dojo/_base/window"], function(ctr, win){
    var n = ctr.create("div", null, win.body(), "first");
  });

  // dojo < 1.7
  var n = dojo.create("div", null, dojo.body(), "first");

Decorate and place an existing node:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom-construct", "dojo/_base/window"], function(ctr, win){
    ctr.create(node, { style: { color: "red" } }, win.body());
  });

  // dojo < 1.7
  dojo.create(node, { style: { color: "red" } }, dojo.body());

Create an <ul>, and populate it with <li>'s. Place the list as the first child of a node with id equals "someId":

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom-construct", "dojo/_base/array"], function(ctr, array){
    var ul = ctr.create("ul", null, "someId", "first");
    var items = ["one", "two", "three", "four"];
    array.forEach(items, function(data){
      ctr.create("li", { innerHTML: data }, ul);
    });
  });

  // dojo < 1.7
  var ul = dojo.create("ul", null, "someId", "first");
  var items = ["one", "two", "three", "four"];
  dojo.forEach(items, function(data){
    dojo.create("li", { innerHTML: data }, ul);
  });

Create an anchor, with an href. Place in <body>:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom-construct", "dojo/_base/window"], function(ctr, win){
    ctr.create("a", { href: "foo.html", title: "Goto FOO!", innerHTML: "link" }, win.body());
  });

  // dojo < 1.7
  dojo.create("a", { href: "foo.html", title: "Goto FOO!", innerHTML: "link" }, dojo.body());

============
Alternatives
============

Creating and/or placing with dojo.place()
-----------------------------------------

In some cases it is easier to create a node from an HTML fragment and place it, without applying any attributes, or specifying them as a part of the HTML fragment. If this is the case consider `dojo.place <dojo/place>`_:

.. code-block :: javascript
  :linenos:

  // duplicating the next line with dojo.place()
  //dojo.create("a", { href: "foo.html", title: "Goto FOO!", innerHTML: "link" }, dojo.body());
  // dojo 1.7 (AMD)
  require(["dojo/dom-construct", "dojo/_base/window"], function(ctr, win){
    ctr.place("<a href='foo.html' title='Goto FOO!'>link</a>", win.body());
  });

  // dojo < 1.7
  dojo.place("<a href='foo.html' title='Goto FOO!'>link</a>", dojo.body());


  // duplicating the next line with dojo.place()
  //var n = dojo.create("div", null, dojo.body());
  // dojo 1.7 (AMD)
  require(["dojo/dom-construct", "dojo/_base/window"], function(ctr, win){
    var n = ctr.place("<div></div>", win.body());
  });

  // dojo < 1.7
  var n = dojo.place("<div></div>", dojo.body());

Setting attributes with dojo.attr()
-----------------------------------

While you can use `dojo.create <dojo/create>`_ to set attributes on the existing node without placing it, using `dojo.attr <dojo/attr>`_ is recommended:

.. code-block :: javascript
  :linenos:

  // duplicating the next line with dojo.attr()
  //var n = dojo.create(node, { innerHTML: "<p>hi</p>" });
  // dojo 1.7 (AMD)
  require(["dojo/dom-construct"], function(ctr){
     var n = ctr.create(node, { innerHTML: "<p>hi</p>" });
  });

  // dojo < 1.7
  var n = dojo.create(node, { innerHTML: "<p>hi</p>" });

========
See also
========

* `dojo.place <dojo/place>`_
* `dojo.destroy <dojo/destroy>`_
* `dojo.empty <dojo/empty>`_
* `DOM Utilities <quickstart/dom>`_
