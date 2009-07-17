#format dojo_rst

dojo.NodeList-traverse
========================

:Status: Draft
:Version: 1.0
:Project owner: James Burke
:Available: since 1.4

.. contents::
   :depth: 2

Method extensions to `dojo.NodeList <dojo/NodeList>`_/`dojo.query <dojo/query>`_ for traversing the DOM. These methods are intended to match the API naming and behavior as the similarly named methods in jQuery.

============
Introduction
============

Doing a dojo.require("dojo.NodeList-traverse") will add some addition methods to `dojo.NodeList <dojo/NodeList>`_ (the return object from a `dojo.query <dojo/query>`_ call) that allow easier traversal of the DOM as it relates to the nodes in the dojo.NodeList.


=====
Usage
=====

Here is a simple example showing how dojo.NodeList-traverse adds a "children" method to dojo.NodeList that can be called via the normal method chaining done with a dojo.query result:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //Grabs all child nodes of all divs
  //and returns a dojo.NodeList object
  //to allow further chaining operations
  dojo.query("div").children();


=========================================
Methods added by dojo.NodeList-traverse
=========================================

children
---------

closest
---------

parent
---------

parents
---------

siblings
---------

next
---------

prev
---------

first
---------
This method is provided due to a difference in the Acme query engine used by default in Dojo. The Acme engine does not support ":first" queries, since it is not part of the CSS3 spec. This method can be used to give the same effect. For instance, instead of doing dojo.query("div:first"), you can do dojo.query("div").first().


last
---------
This method is provided due to a difference in the Acme query engine used by default in Dojo. The Acme engine does not support ":last" queries, since it is not part of the CSS3 spec. This method can be used to give the same effect. For instance, instead of doing dojo.query("div:last"), you can do dojo.query("div").last().


even
---------
This method is provided due to a difference in the Acme query engine used by default in Dojo. The Acme engine does not support ":even" queries, since it is not part of the CSS3 spec. This method can be used to give the same effect. For instance, instead of doing dojo.query("div:even"), you can do dojo.query("div").even().


odd
---------
This method is provided due to a difference in the Acme query engine used by default in Dojo. The Acme engine does not support ":odd" queries, since it is not part of the CSS3 spec. This method can be used to give the same effect. For instance, instead of doing dojo.query("div:odd"), you can do dojo.query("div").odd().

