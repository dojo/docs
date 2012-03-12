.. _dojo/connect:

==============
dojo.connect()
==============

Deprecated.

Dojo versions prior to 1.7 used dojo.connect() for event handling and advice.
But it's functionality has been replaced by :ref:`dojo/on module <dojo/on>` and the :ref:`dojo/aspect module's after() method <dojo/aspect#after>`.

Events
------
As of Dojo 1.7, the preferred way of handling events is to use the new lightweight :ref:`dojo/on <dojo/on>` module.


For compatibility reasons, the dojo.connect api's will remain fully supported through remaining 1.x releases, but will likely be removed in Dojo 2.0.  Migration from connect() to on() should be straightforward as the api signature is very similar.

Old code like:

.. js ::

     var handle = dojo.connect(node, "onclick", callback);
     ...
     dojo.disconnect(handle);

should be converted to:

.. js ::

  require(["dojo/on"], function(on){
    var handle = on(node, "click", callback);
    ...
    handle.remove();
  });

Note that:
    - the "on" prefix was dropped, and "onclick" became "click"
    - the "handle" has a remove() method, rather than there being a function like dojo.disconnect()


Advice
------
The preferred way of handling after advice is to use the new lightweight :ref:`dojo/aspect's after() method <dojo/aspect#after>`.


Old code:

.. js ::

     var handle = dojo.connect(myInstance, "execute", callback);
     ...
     dojo.disconnect(handle);


is changed to

.. js ::

    require(["dojo/aspect"], function(aspect){
        aspect.after(myInstance, "execute", callback);
        ...
        handle.remove();
    });

Note that callback() should not return a value, because if it did the returned value would be reported as the value that myInstance.execute() appeared to return, which is not what dojo.connect() did.
