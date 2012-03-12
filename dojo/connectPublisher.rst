.. _dojo/connectPublisher:

=====================
dojo.connectPublisher
=====================

Deprecated.

dojo.connectPublisher() was an automation of this common form:

.. js ::
  
  dojo.connect(myObject, "myEvent", function(){
       dojo.publish("/some/topic/name", arguments);
  });

Which became:

.. code-block :: javascript
  
  dojo.connectPublisher("/some/topic/name", myObject, "myEvent");

But going forward users should use the following for connecting to DOM events:

.. js ::
  
  require(["dojo/on", "dojo/topic"], function(on, topic){
    on(myNode, "click", function(){
      topic.publish("/some/topic/name", arg1, arg2, arg3);
    });
  });
  
Or this for after-advice on arbitrary methods of arbitrary objects:

.. js ::
  
  require(["dojo/aspect", "dojo/topic"], function(aspect, topic){
    aspect.after(myObj, "myFunc", function(){
      topic.publish("/some/topic/name", arg1, arg2, arg3);
    });
  });
  
