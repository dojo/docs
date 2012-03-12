.. _dojo/unsubscribe:

================
dojo.unsubscribe
================

Deprecated.   Dojo.unsubscribe() has been replaced by the :ref:`dojo/topic module <dojo/topic>`.

Code is changed from:

.. js ::

     var handle = dojo.unsubscribe("some/topic", callback);
     ...
     dojo.ununsubscribe(handle);

to:

.. js ::

    require(["dojo/topic"], function(topic){
		 var handle = topic.unsubscribe("some/topic", listener)
		 ...
		 handle.remove();
	});
