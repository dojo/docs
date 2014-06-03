.. _dojo/topic:

==========
dojo/topic
==========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
   :depth: 2

**dojo/topic** provides a centralized hub for publishing and subscribing to global messages by topic.  Topics can be 
subscribed to by using ``topic.subscribe()``, and messages can publish by using ``topic.publish()``.

Because topics are not bound to a particular object, they are useful for communication between multiple instances or 
various different types of objects.  :ref:`dojo/on <dojo/on>` is more designed to deal with handling events 
specifically related to a particular object instance or reflecting a DOM event of a particular instance.

Usage
=====

Requiring in the module is all that is needed to leverage the functionality:

.. js ::

  require(["dojo/topic"], function(topic){
      topic.subscribe("some/topic", function(){
          console.log("received:", arguments);
      });
      // ...
      topic.publish("some/topic", "one", "two");
  });

.. _dojo/topic#subscribe:

subscribe()
-----------

Subscribes to a particular topic.

``subscribe()`` returns a handle that has a ``remove()`` method that can be used to remove the listener.

.. _dojo/topic#publish:

publish()
---------

Publishes a topic, which the arguments are then sent to every listener.

Globbing
--------

Topics do **not** support *globbing*, or mixing of channel names based on wildcards. This example is **invalid**:

.. js ::

  require(["dojo/topic"], function(topic){
    topic.subscribe("/foo/*", function(data){ /*handle*/ });
  });

It is not practical to support this on the client side.

Migration
=========

``dojo/topic`` replaces the old ``dojo.publish()`` and ``dojo.subscribe()`` API.  There are some things to note about 
the migration from old API.

Passing Arguments
-----------------

Where as ``dojo.publish()`` required arguments to be specified within an array, ``dojo/topic::publish()`` does not 
have this requirement. Any number of arguments can be specified flatly after the initial argument which specifies the 
topic. For example:

.. js ::

  require(["dojo/topic"], function(topic){
    topic.publish("some/topic", "argument1", "argument2");
  })

Conversely, if you do specify an array as the second parameter, that is precisely what handlers subscribing to the 
topic will receive: a single argument which is an array.

Unsubscribe Handlers
--------------------

Whereas ``dojo.subscribe()`` returns a handle which can be later passed to ``dojo.unsubscribe()`` but is otherwise 
somewhat opaque, ``dojo/topic::subscribe()`` returns a simple object containing a ``remove()`` method, which can be 
called to unsubscribe the listener.  This is akin to the ``remove()`` method available on objects returned by 
``dojo/on`` functions:

.. js ::

  require(["dojo/topic"], function(topic){
    var handle = topic.subscribe("some/topic", function(){
      // do something
    });
    // ...
    handle.remove();
  });

Example
=======

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Demonstrates how to publish and subscribe to topics.  Once the topic has been fired one, the listener will remove 
  itself.

  .. js ::

    require(["dojo/topic", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(topic, dom, on){

      var handle = topic.subscribe("some/topic", function(e){
        dom.byId("output").innerHTML = "I received: " + e.msg;
        handle.remove();
      });

      on(dom.byId("publish"), "click", function(){
        topic.publish("some/topic", { msg: "hello world" });
      });

    });

  .. html ::

    <button type="button" id="publish">Publish "some/topic"</button>
    <div id="output">Nothing Yet...</div>

See Also
========

* :ref:`dojo/on <dojo/on>` - The DOM and synthetic event handling module.

* :ref:`dojo/Evented <dojo/Evented>` - A class that supports emitting synthetic events.

* :ref:`dojo/Stateful <dojo/Stateful>` - A class that supports the ability to "watch" property changes.
