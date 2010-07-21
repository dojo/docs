#format dojo_rst

dojo.publish
============

:Status: Draft
:Version: 1.0
:Available: since 0.9

.. contents::
   :depth: 2

Publish an event to all subscribers of a `topic`. Publish is provided as part of Base Dojo (dojo.js), so no additional requires are needed.

============
Introduction
============

`dojo.publish` is one of three topic-related functions used to publish (broadcast?) any kind of information within the application, to be received by other functions `subscribed <dojo/subscribe>`_ to the same channel. A channel can be any string in almost any form you like. Additionally, like other Dojo `event <quickstart/events>`_ functions, a `dojo.unsubscribe <dojo/unsubscribe>`_ function is provided to disconnect subscriptions to channels.

========
Examples
========

Simple Topics
-------------

Listen to a channel named "foobar" for data:

.. code-block :: javascript
 :linenos:

  dojo.subscribe("foobar", function(message){
      console.log("I got: ", message);
  });

To publish information to that channel:

.. code-block :: javascript
 :linenos:
  
  dojo.publish("foobar", [{ 
     item:"one", another:"item", anObject:{ deeper:"data" }
  }]);

When executed, the anonymous function registered in the subscription is executed passing the object. 

Removing a Subscription
-----------------------

Subscribe returns a handle to later be used for disconnecting a subscription, much like the relationship between `dojo.connect <dojo/connect>`_ and `dojo.disconnect <dojo/disconnect>`_. Simply pass the handle as the only argument to `dojo.unsubscribe <dojo/unsubscribe>`_ to no longer receive updates:

.. code-block :: javascript
 :linenos:

  var handle = dojo.subscribe("/foo/bar", function(message){ 
      // only runs once in this case:
      dojo.unsubscribe(handle);
  });

In the above example, we're disconnecting the handle from within the subscribed function, effectively creating a "subscribe-once" pattern. After the first time something published on the ``/foo/bar`` channel, the connection is interrupted, and the function will no longer fire. 

========
See also
========

Many other components use this topic mechanism for communication. For instance, `Drag and Drop <dojo/dnd>`_ uses the channels ``/dnd/move/start`` and ``/dnd/move/end`` to publish information about drag operations, and the developer is intended to subscribe to these as needed.

Additionally, the `Cometd <dojox/cometd>`_ client implements a variation of publish/subscribe/unsubscribe for it's communication. The mechanism is identical, though with comet the subscription can exist on other clients on different hosts and domains.

Several `Dijit widgets <dijit/index>`_ use publish to alert the user (and other internal parts of their operation) about state changes. For instance, any time a new Tab is added to a `TabContainer <dijit/layout/TabContainer>`_, a message is sent out on a channel based on the id of the Tabs:

.. code-block :: javascript
 :linenos:

  var id = "myTabs";
  dojo.subscribe(id + "-addChild", function(child){
     // child is the new pane being added to the tabs with id="myTabs"
  });
