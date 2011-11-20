.. _quickstart/topics:

Dojo Topic System
=================

Also known as Publish and Subscribe, the topic API in Dojo is very simple, though holds the same power and syntax as the event system with regard to scoping, and other magic. Publish and Subscribe are provided by Base Dojo, so no additional :ref:`dojo.require <dojo/require>` call is needed beyond loading `dojo.js`.

Topics are an easy way for ambiguous objects, widgets, or code to communicate with other widgets and objects without prior knowledge of each other.

On a very basic level, subscribe to a topic, and run an anonymous function:

.. code-block :: javascript 
 
  dojo.subscribe("/foo/bar/baz", function(message){
      console.log(message); 
  });

This code will not execute until something is published on that topic:

.. code-block :: javascript

  dojo.publish("/foo/bar/baz", {
      foo:"bar", baz:"bam"
  });

The named topics can be whatever syntax you choose, it is just a string:

.. code-block :: javascript
 
  dojo.subscribe("my-custom-topic", function(message){
      console.log(message);
  }); 
  // publish can be an Array or Object
  dojo.publish("my-custom-topic", ["a","b","c","d"]);

Topics are used in other places in the Dojo Toolkit. The :ref:`TabContainer <dijit/layout/TabContainer>` uses pub/sub to communicate between buttons and panes internally, and allows you to subscribe for notification, and :ref:`dojox.cometd <dojox/cometd>` uses topics to communicate across clients, for instance.
