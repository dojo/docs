#format dojo_rst

dojo/on
=======

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: 1.7.0

dojo/topic provides a centralized hub for publishing and subscribing to global messages by topic (using the same hub as dojo.connect). One can subscribe to these messages by using ``topic.subscribe``, and one can publish by using ``topic.publish``. For example:

.. code-block :: javascript

  topic.subscribe("some/topic", listener); // listener will be called when a message is published for this topic
  ...
  topic.publish("some/topic", "hi there", "additional arguments"); // publish a message
