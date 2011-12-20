.. _dojo/publish:

============
dojo.publish
============

:since: 0.9

.. contents ::
   :depth: 2

Publish an event to all subscribers of a `topic`. Publish is provided as part of Base Dojo (dojo.js), so no additional requires are needed.

Introduction
============

`dojo.publish` is one of three topic-related functions used to publish (broadcast?) any kind of information within the application, to be received by other functions :ref:`subscribed <dojo/subscribe>` to the same channel. A channel can be any string in almost any form you like. Additionally, like other Dojo :ref:`event <quickstart/events>` functions, a :ref:`dojo.unsubscribe <dojo/unsubscribe>` function is provided to disconnect subscriptions to channels.

Examples
========

Simple Topics
-------------

Listen to a channel named "foobar" for data:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.subscribe("foobar", function(message){
      console.log("I got: ", message);
    });
  });
  // Dojo < 1.7
  dojo.subscribe("foobar", function(message){
      console.log("I got: ", message);
  });

To publish information to that channel:

.. js ::
   
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.publish("foobar", [{
      item:"one", another:"item", anObject:{ deeper:"data" }
    }]);
  });
  // Dojo < 1.7
  dojo.publish("foobar", [{
     item:"one", another:"item", anObject:{ deeper:"data" }
  }]);

When executed, the anonymous function registered in the subscription is executed passing the object.

Removing a Subscription
-----------------------

Subscribe returns a handle to later be used for disconnecting a subscription, much like the relationship between :ref:`dojo.connect <dojo/connect>` and :ref:`dojo.disconnect <dojo/disconnect>`. Simply pass the handle as the only argument to :ref:`dojo.unsubscribe <dojo/unsubscribe>` to no longer receive updates:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    var handle = connect.subscribe("/foo/bar", function(message){
      // only runs once in this case:
      connect.unsubscribe(handle);
    });
  });
  // Dojo < 1.7
  var handle = dojo.subscribe("/foo/bar", function(message){
      // only runs once in this case:
      dojo.unsubscribe(handle);
  });

In the above example, we're disconnecting the handle from within the subscribed function, effectively creating a "subscribe-once" pattern. After the first time something published on the ``/foo/bar`` channel, the connection is interrupted, and the function will no longer fire.

See also
========

Many other components use this topic mechanism for communication. For instance, :ref:`Drag and Drop <dojo/dnd>` uses the channels ``/dnd/move/start`` and ``/dnd/move/end`` to publish information about drag operations, and the developer is intended to subscribe to these as needed.

Additionally, the :ref:`Cometd <dojox/cometd>` client implements a variation of publish/subscribe/unsubscribe for it's communication. The mechanism is identical, though with comet the subscription can exist on other clients on different hosts and domains.

Several :ref:`Dijit widgets <dijit/index>` use publish to alert the user (and other internal parts of their operation) about state changes. For instance, any time a new Tab is added to a :ref:`TabContainer <dijit/layout/TabContainer>`, a message is sent out on a channel based on the id of the Tabs:

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    var id = "myTabs";
    connect.subscribe(id + "-addChild", function(child){
      // child is the new pane being added to the tabs with id="myTabs"
    });
  });
  // Dojo < 1.7
  var id = "myTabs";
  dojo.subscribe(id + "-addChild", function(child){
     // child is the new pane being added to the tabs with id="myTabs"
  });
