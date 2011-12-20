.. _dojo/body:

=========
dojo.body
=========

:since: V?

.. contents ::
   :depth: 2

Returns the body element of the document.


Introduction
============

This is a shorthand ``method`` for accessing the `<body>` element within the document. Not only is it shorter, it returns the `current` body of the current context. It also allows Dojo to use the call in non-browser environments by overloading the function to return an appropriate element.

`dojo.body` is a very simple function with one purpose:

Usage
=====

The most important item to remember is dojo.body is a function, and needs to be executed to get the value:

[ Dojo 1.7 AMD ]

.. js ::

  require(["dojo/_base/window"], function(win){
    console.log( win.body() );
  });


[ Dojo < 1.7 ]

.. js ::

  console.log( dojo.body() );

This is an example, which is shorter, safer to write than:

.. js ::
  
  var b = document.getElementsByTagName("body")[0];
  console.log(b);

Actually using the `<body>` element is an exercise left to the developer. There are several utility functions in Dojo to do common tasks on DomNodes, and `<body>` is just another:

[ Dojo 1.7 AMD ]

.. js ::
  
  require(["dojo/_base/window", "dojo/dom-style", "dojo/dom-construct"], function(win, style, ctr){
    // set the background color:
    style.set(win.body(), "backgroundColor", "green");
    // place a node with id="foo" as the last-child of body:
    ctr.place("foo", win.body());
    // place id="foo" as a first-child of body:
    ctr.place("foo", win.body(), "first");
  });


[ Dojo < 1.7 ]

.. js ::
  
  // set the background color:
  dojo.style(dojo.body(), "backgroundColor", "green");
  // place a node with id="foo" as the last-child of body:
  dojo.place("foo", dojo.body());
  // place id="foo" as a first-child of body:
  dojo.place("foo", dojo.body(), "first");
