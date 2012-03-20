.. _dojo/subscribe:

==============
dojo.subscribe
==============

Deprecated.   Dojo.subscribe() has been replaced by the :ref:`dojo/topic module <dojo/topic>`.

Code is changed from:

.. js ::

     var handle = dojo.subscribe("some/topic", context, callback);
     ...
     dojo.unsubscribe(handle);

to:

.. js ::

    require(["dojo/topic"], function(topic){
		 var handle = topic.subscribe("some/topic", callback)
		 ...
		 handle.remove();
	});

(TODO: add in context after Kris has implemented it)