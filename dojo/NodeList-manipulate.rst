#format dojo_rst

dojo.NodeList-manipulate
========================

:Status: Draft
:Version: 1.0
:Project owner: James Burke
:Available: since Dojo 1.4

.. contents::
   :depth: 2

Method extensions to `dojo.NodeList <dojo/NodeList>`_/`dojo.query <dojo/query>`_ that manipulate HTML. These methods are intended to match the API naming and behavior as the similarly names methods in jQuery.


============
Introduction
============

Doing a dojo.require("dojo.NodeList-manipulate") will add some addition methods to `dojo.NodeList <dojo/NodeList>`_ (the return object from a `dojo.query <dojo/query>`_ call) that allow easier manipulation of HTML as it relates to the nodes in the dojo.NodeList.


=====
Usage
=====

Here is a simple example showing how dojo.NodeList-manipulate adds an "after" method to dojo.NodeList that can be called via the normal method chaining done with a dojo.query result:

.. code-block :: javascript
 :linenos:

 dojo.require("dojo.NodeList-manipulate");
 
 //Add a span that says Hello World after each div in the DOM
 //by using the "after" method added by dojo.NodeList-manipulate
 dojo.query("div").after("<span>Hello World');


=========================================
Methods added by dojo.NodeList-manipulate
=========================================

innerHTML
--------------------
Allows setting the innerHTML of each node in the NodeList,
if there is a value passed in, otherwise, reads the innerHTML value of the **first node** in the dojo.NodeList.

This method is simpler than the dojo.NodeList.html() method provided by
`dojo.NodeList-html`. This method just does proper innerHTML insertion of HTML fragments,
and it allows for the innerHTML to be read for the first node in the node list.

Since dojo.NodeList-html already took the "html" name, this method is called
"innerHTML". However, if dojo.NodeList-html has not been loaded yet, this
module will define an "html" method that can be used instead.

Be careful if you are working in an environment where it is possible that dojo.NodeList-html could
have been loaded, since its definition of "html" will take precedence.

The nodes represented by the value argument will be cloned if more than one
node is in this NodeList. The nodes in this NodeList are returned in the "set"
usage of this method, not the HTML that was inserted.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"></div>
  <div id="bar"></div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  //inserts <p>Hello World</p> into both divs:
  dojo.query("div").innerHTML("<p>Hello World</p>");

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars</p></div>
  <div id="bar"><p>Hello World</p></div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  //This code returns "<p>Hello Mars</p>":
  var message = dojo.query("div").innerHTML();


html
--------------------


text
--------------------


val
--------------------


append
--------------------


appendTo
--------------------


prepend
--------------------


prependTo
--------------------


after
--------------------


insertAfter
--------------------


before
--------------------


insertBefore
--------------------


remove
--------------------


wrap
--------------------


wrapAll
--------------------


wrapInner
--------------------


replaceWith
--------------------


replaceAll
--------------------


clone
--------------------



========
See also
========

* `dojo.NodeList <dojo/NodeList>`_
* `dojo.NodeList-traverse <dojo/NodeList-traverse>`_
