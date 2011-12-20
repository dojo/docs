.. _dojo/disconnect:

===============
dojo.disconnect
===============

:since: 0.9

.. contents ::
   :depth: 2

Disconnects methods from linked events.

Introduction
============

Dojo's :ref:`event <quickstart/events>` system provides `dojo.disconnect` to cleanly remove event listeners created by :ref:`dojo.connect <dojo/connect>`. The more events in the page that exist, the more the browser (or otherwise) has to do.

Usage
=====

disconnect() accepts a specially-crafted parameter as it's only argument which, coincidentally, is the return value from ``dojo.connect``.

For example, to setup a function to run when a node is clicked, then remove it after the first time it is clicked:

[ Dojo 1.7 AMD ]

.. js ::
 
  require(["dojo/dom", "dojo/_base/connect"], function(){
    var node = dom.byId("someButton");
    var handle = connect.connect(node, "onclick", function(e){
        alert("you won't see me again!");
        connect.disconnect(handle);
    });
  });


[ Dojo < 1.7 ]

.. js ::
 
  var node = dojo.byId("someButton");
  var handle = dojo.connect(node, "onclick", function(e){
      alert("you won't see me again!");
      dojo.disconnect(handle);
  });

This works with any connection :ref:`dojo.connect <dojo/connect>` is able to make: DOM Connections, Dijit events, etc.

A very common pattern is to store a series of return values in an array, and use :ref:`dojo.forEach <dojo/forEach>` to iterate over them, disconnecting several connections at once:

[ Dojo 1.7 AMD ]

.. js ::
   
  require(["dojo/_base/connect", "dojo/_base/array"], function(connect, array){
    var connections = [];
    connections.push(
      connect.connect(node, "onmouseenter", function(){ /* smart mouseover code */ })
    )
    connection.push(
      connect.connect(node, "onmouseleave", function(){ /* smart mouseout code */ })
    )

    connect.connect(node, "onclick", function(){
      // disable the other mouse events:
      array.forEach(connections, connect.disconnect);
    });
  });


[ Dojo < 1.7 ]

.. js ::
   
  var connections = [];
  connections.push(
    dojo.connect(node, "onmouseenter", function(){ /* smart mouseover code */ })
  )
  connection.push(
    dojo.connect(node, "onmouseleave", function(){ /* smart mouseout code */ })
  )

  dojo.connect(node, "onclick", function(){
    // disable the other mouse events:
    dojo.forEach(connections, dojo.disconnect);
  });
   
This works because forEach passes each of the Array items as the first parameter to the passed function (in this case, `dojo.disconnect`), thus removing each of the stored connections when that node is clicked.
