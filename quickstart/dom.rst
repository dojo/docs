#format dojo_rst

DOM Utilities
=============

:Status: Draft
:Version: 1.0
:Project owner: Peter Higgins
:Available: since V1.3

.. contents::
   :depth: 2

============
Introduction
============

Dojo provides a host of DOM utility functions. This guide covers combined usage of `dojo.style <dojo/style>`_, `dojo.create <dojo/create>`_, `dojo.attr <dojo/attr>`_, and a number of other base utilities for DOM convenience. 

========================
Locating and Using Nodes
========================

All of these functions work by doing work on a passed DomNode reference (an element in the page (such as a div, li, a tag)). In order to work with these nodes, we first must locate them in the Document Object Model (DOM). The most important note to get started is all DOM activity must be done after "onload" fired, or the DOM is otherwise "ready". This can be achieved by `dojo.addOnLoad <dojo/addOnLoad>`_

.. code-block :: javascript
  :linenos:

  dojo.addOnLoad(function(){
      console.log("page ready, can modify DOM anytime after this");
  }); 

Once we've ensured our code will only execute after the DOM is ready, we can move on to locating nodes to work on.

Using ID's
----------

The fastest, and most common, way of locating an element is by it's {{id}} attribute. Dojo provides `dojo.byId <dojo/byId>`_ - a shorter, safer version of {{document.getElementsById}}:

.. code-block :: javascript
  :linenos:

  dojo.addOnLoad(function(){
      var n = dojo.byId("someId");
      n.innerHTML = "Hi, World";
  }); 

Here, we locate a node with id="someId", and set it's innerHTML to new content. If a node is not found, dojo.byId returns undefined, and is falsy enough to work as a conditional:

.. code-block :: javascript
  :linenos:

  var n = dojo.byId("someId");
  if(n){ /* it exists! */ }

CSS Selectors
-------------

It is not always practical to attach id's to elements you intend to modify, which is why Dojo provides `dojo.query <dojo/query>`_ - a CSS3 query selector. It will locate nodes that match a passed CSS selector, and return a specialized Array named `dojo.NodeList <dojo/NodeList>`_. 

.. code-block :: javascript
  :linenos:

  dojo.addOnLoad(function(){
      var list = dojo.query("#someId");
  });

In this example, we are locating the same node found by dojo.byId previously, but using the CSS selector to do so. The query() call returns a found list of nodes (in this case, a single element as id's are unique in the DOM). This list is a standard JavaScript Array, decorated with a number of functions common throughout Dojo, most of which have single-node variants where applicable. This will be illustrated further in this document, but consider the following examples:

.. code-block :: javascript
  :linenos:

  dojo.addOnLoad(function(){

      // find a node byId, change the id, and set the color red
      dojo.query("#someId").attr("id","newId").style("color","red");

      // find a node byId, change the id, and set the color red
      var n = dojo.byId("someId");
      dojo.attr(n, "id", "newId");
      dojo.style(n, "color", "red");

  });

The query method is convenient and more compact, but carries the overhead of instantiating a new array and querying the Dom. Both code snippets have identical results. 

There are a number of handy CSS selectors to use for locating special DomNodes. 

.. code-block :: javascript
  :linenos:

  // by class
  dojo.query(".someClass");
  // by attributes
  dojo.query("[name^='link']");
  // by tag type
  dojo.query("div");
  // first-children
  dojo.query("ul > li");
  // odd table rows:
  dojo.query("table tr:nth-child(odd)");
  // scoped to some other node as parent
  dojo.query("a.link", "someNode"); 

Finding nodes via dojo.query is very helpful, though the same rules apply to either "lists of nodes" or single nodes, as found by dojo.byId. 

The <body> element
------------------



==================
Manipulating Nodes
==================

Node attributes
---------------

Node styles
-----------

Node placement
--------------

==============
Creating Nodes
==============

Basic Nodes
-----------

Scripts
-------

Cross-browser Considerations
----------------------------

Destroying Nodes
----------------
