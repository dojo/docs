#format dojo_rst

dojo.subscribe
==============

:Status: Draft
:Version: 1.0
:Available: since 0.9

.. contents::
   :depth: 2

Linked a listener to a named topic.

============
Introduction
============

Subscribe is a part of the the Dojo Topic system used to register a function listening to a named channel. The channel is sent data via `dojo.publish <dojo/publish>`_.

=====
Usage
=====

To subscribe a function to a channel:

.. code-block :: javascript
 :linenos:

  dojo.subscribe("/foo/bar/baz", function(data){
     console.log("i got", data);
  });

To trigger that function, publish some data on the same channel:

.. code-block :: javascript
 :linenos:

  dojo.publish("/foo/bar/baz", [{ some:"object data" }]);

The channel name can be any string you choose:

.. code-block :: javascript
 :linenos:

  dojo.subscribe("foo-bar", function(data){ /* handle */ });
  dojo.subscribe("bar", function(data){ /* handle */ });
  dojo.subscribe("/foo/bar", function(data){ /* handle */ });

Each are unique channels.

Globbing
--------

Dojo Topics do ``not`` support `globbing`, or mixing of channel names based on wildcards. This example is ``invalid``:

.. code-block :: javascript
 :linenos:

  dojo.subscribe("/foo/*", function(data){ /* handle */ });

While this works when using `cometd <dojox/cometd>`_'s dojox.cometd.subscribe function, it is not practical to do on the client side. Only fully named channels are supported. 

Subscribing with scope
----------------------

Subscribe uses `dojo.hitch <dojo/hitch>`_ under the covers to provide more advanced functionality for controlling in which context the attached function will be called. 

Consider the following object:

.. code-block :: javascript
 :linenos:
 
  var obj = {
     member:"unpublished",
     anon: function(data){
         this.member = "fixed";
     }
  }

To execute an anonymous function in the scope of `obj`:

.. code-block :: javascript
 :linenos: 

  dojo.subscribe("/foo/bar", obj, function(data){ 
      // here 'this' refers to the obj instance
      this.member = "published";
  });

Alternately, you can pass a named function instead of an anonymous function with scope:

.. code-block :: javascript
 :linenos:

  dojo.subscribe("/foo/bar", obj, "anon");

This will execute `obj.anon()` in the scope of `obj`, passing in whatever data the accompanying `dojo.publish <dojo/publish>`_ call sent.
