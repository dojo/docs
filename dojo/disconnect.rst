#format dojo_rst

dojo.disconnect
===============

:Status: Draft
:Version: 1.0
:Available: 0.9

.. contents::
   :depth: 2

Disconnects methods from linked events.

============
Introduction
============

Dojo's `event <quickstart/events>`_ system provides `dojo.disconnect` to cleanly remove event listeners created by `dojo.connect <dojo/connect>`_. The more events in the page that exist, the more the browser (or otherwise) has to do. 

=====
Usage
=====

disconnect() accepts a specially-crafted parameter as it's only argument which, coincidentally, is the return value from ``dojo.connect``. 

For example, to setup a function to fun when a node is clicked, then remove it after the first time it is clicked:

.. code-block :: javascript
 :linenos:

  var node = dojo.byId("someButton");
  var handle = dojo.connect(node, "onclick", function(e){
      alert("you won't see me again!");
      dojo.disconnect(handle);
  });

This works with any connection `dojo.connect <dojo/connect>`_ is able to make: DOM Connections, Dijit events, etc. 

A very common pattern is to store a series of return values in an array, and use `dojo.forEach <dojo/forEach>`_ to iterate over them, disconnecting several connections at once:

.. code-block :: javascript
 :linenos:
  
  var connections = [];
  connections.push(
    dojo.connect(node,"onmouseenter",function(){ /* smart mouseover code */ })
  )
  connection.push(
    dojo.connect(node, "onmouseleave",function(){ /* smart mouseout code */ })
  )

  dojo.connect(node,"onclick", function(){
    // disable the other mouse events:
    dojo.forEach(connections, dojo.disconnect);
  }); 
   
This works because forEach passes each of the Array items as the first parameter to the passed function (in this case, `dojo.disconnect`), thus removing each of the stored connections when that node is clicked.
