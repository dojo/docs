.. _dojo/subscribe:

==============
dojo.subscribe
==============

:since: 0.9

.. contents ::
   :depth: 2

Linked a listener to a named topic.

Introduction
============

Subscribe is a part of the Dojo Topic system used to register a function listening to a named channel. The channel is sent data via :ref:`dojo.publish <dojo/publish>`.

Usage
=====

To subscribe a function to a channel:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.subscribe("/foo/bar/baz", function(data){
      console.log("i got", data);
    });
  });
  // Dojo < 1.7
  dojo.subscribe("/foo/bar/baz", function(data){
     console.log("i got", data);
  });

To trigger that function, publish some data on the same channel:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.publish("/foo/bar/baz", [{ some:"object data" }]);
  });
  // Dojo < 1.7
  dojo.publish("/foo/bar/baz", [{ some:"object data" }]);

The channel name can be any string you choose:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.subscribe("foo-bar", function(data){ /*handle*/ });
    connect.subscribe("bar", function(data){ /*handle*/ });
    connect.subscribe("/foo/bar", function(data){ /*handle*/ });
  });
  // Dojo < 1.7
  dojo.subscribe("foo-bar", function(data){ /*handle*/ });
  dojo.subscribe("bar", function(data){ /*handle*/ });
  dojo.subscribe("/foo/bar", function(data){ /*handle*/ });

Each are unique channels.

Globbing
--------

Dojo Topics do ``not`` support `globbing`, or mixing of channel names based on wildcards. This example is ``invalid``:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.subscribe("/foo/*", function(data){ /*handle*/ });
  });
  // Dojo < 1.7
  dojo.subscribe("/foo/*", function(data){ /*handle*/ });

While this works when using :ref:`cometd <dojox/cometd>`'s dojox.cometd.subscribe function, it is not practical to do on the client side. Only fully named channels are supported.

Subscribing with scope
----------------------

Subscribe uses :ref:`dojo.hitch <dojo/hitch>` under the covers to provide more advanced functionality for controlling in which context the attached function will be called.

Consider the following object:

.. js ::
  
  var obj = {
     member:"unpublished",
     anon: function(data){
         this.member = "fixed";
     }
  }

To execute an anonymous function in the scope of `obj`:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.subscribe("/foo/bar", obj, function(data){
      // here 'this' refers to the obj instance
      this.member = "published";
    });
  });
  // Dojo < 1.7
  dojo.subscribe("/foo/bar", obj, function(data){
      // here 'this' refers to the obj instance
      this.member = "published";
  });

Alternately, you can pass a named function instead of an anonymous function with scope:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.subscribe("/foo/bar", obj, "anon");
  });
  // Dojo < 1.7
  dojo.subscribe("/foo/bar", obj, "anon");

This will execute `obj.anon()` in the scope of `obj`, passing in whatever data the accompanying :ref:`dojo.publish <dojo/publish>` call sent.
