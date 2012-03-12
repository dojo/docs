.. _dojo/topic:

==========
dojo/topic
==========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

dojo/topic provides a centralized hub for publishing and subscribing to global messages by topic.
One can subscribe to these messages by using ``topic.subscribe``, and one can publish by using ``topic.publish``.

Usage
=====

.. js ::

  require(["dojo/topic"], function(topic){
      topic.subscribe("some/topic", function(){
          console.log("received:", arguments);
      });
      // ...
      topic.publish("some/topic", "one", "two");
  });

Globbing
--------

Topics do ``not`` support `globbing`, or mixing of channel names based on wildcards. This example is ``invalid``:

.. js ::

  require(["dojo/topic"], function(topic){
    topic.subscribe("/foo/*", function(data){ /*handle*/ });
  });

While this works when using :ref:`cometd <dojox/cometd>`'s dojox.cometd.subscribe function, it is not practical to do on the client side. Only fully named channels are supported.

Differences from old APIs
=========================

Passing arguments via publish
-----------------------------

Whereas ``dojo.publish`` required arguments to be specified within an array, ``topic.publish`` does not have this requirement; any number of arguments can be specified flatly after the initial argument which specifies the topic.  For example:

.. js ::

  topic.publish("some/topic", "argument1", "argument2");

Conversely, if you do specify an array as the second parameter, that is precisely what handlers subscribing to the topic will receive: a single argument which is an array.

Unsubscribing handlers
----------------------

Whereas ``dojo.subscribe`` returns a handle which can be later passed to ``dojo.unsubscribe`` but is otherwise somewhat opaque, ``topic.subscribe`` returns a simple object containing a ``remove`` method, which can be called to unsubscribe the listener.  This is akin to the ``remove`` method available on objects returned by ``dojo/on`` functions.
