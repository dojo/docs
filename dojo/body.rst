#format dojo_rst

dojo.body
=========

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

Returns the body element of the document.


============
Introduction
============

This is a shorthand ``method`` for accessing the `<body>` element within the document. Not only is it shorter, it returns the `current` body of the current context. It also allows Dojo to use the call in non-browser environments by overloading the function to return an appropriate element. 

`dojo.body` is a very simple function with one purpose:

=====
Usage
=====

The most important item to remember is dojo.body is a function, and needs to be executed to get the value:

.. code-block :: javascript

  console.log( dojo.body() );

This is an example, which is shorter, safer to write than:

.. code-block :: javascript
  
  var b = document.getElementsByTagName("body")[0];
  console.log(b);

Actually using the `<body>` element is an exercise left to the developer. There are several utility functions in Dojo to do common tasks on DomNodes, and `<body>` is just another:

.. code-block :: javascript
  
  // set the background color:
  dojo.style(dojo.body(), "backgroundColor", "green");
  // place a node with id="foo" as the last-child of body:
  dojo.place("foo", dojo.body());
  // place id="foo" as a first-child of body:
  dojo.place("foo", dojo.body(), "first");
