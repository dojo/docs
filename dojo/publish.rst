.. _dojo/publish:

============
dojo.publish
============

Deprecated.   Dojo.publish() has been replaced by the :ref:`dojo/topic <dojo/topic>` module's publish() method.

Publishing code is changed from:

.. js ::

    dojo.publish("some/topic", [1, 2, 3]);

to:

.. js ::

    require(["dojo/topic"], function(topic){
    	topic.publish("some/topic", 1, 2, 3);
    });

Note that array brackets are no longer needed.
