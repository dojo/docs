#format dojo_rst

dojo/topic
==========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: 1.7.0

dojo/topic provides a centralized hub for publishing and subscribing to global messages by topic (using the same hub as dojo.connect). One can subscribe to these messages by using ``topic.subscribe``, and one can publish by using ``topic.publish``. For example:

Example using AMD style:
------------------------

.. code-block :: javascript

  require(["dojo/topic"], function(topic){
    topic.subscribe("some/topic", function(){
      console.log("received:", arguments);
    });
    // ...
    topic.publish("some/topic", "one", "two");
  });

Example using dojo.require:
---------------------------

.. code-block :: javascript

  dojo.require("dojo.topic");
  dojo.ready(function(){
    dojo.topic.subscribe("some/topic", function(){
      console.log("received:", arguments);
    });
    // ...
    dojo.topic.publish("some/topic", "one", "two");
  });
