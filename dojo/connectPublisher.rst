#format dojo_rst

dojo.connectPublisher
=====================

:Status: Draft
:Version: 1.0
:Project owner: Alex Russell
:Available: since V0.9

.. contents::
   :depth: 2

Ensure that everytime an event is called, a message is published on the topic. 


============
Introduction
============

dojo.connectPublisher is an automation of this common form:

.. code-block :: javascript
  
  dojo.connect(foo, "bar", function(){
       dojo.publish("/some/topic/name", arguments);
  });

Which becomes:

.. code-block :: javascript
  
  dojo.connectPublisher("/some/topic/name", foo, "bar");


=====
Usage
=====

.. code-block :: javascript
  
  var foo = dojo.connectPublisher(topic, obj, event);


Returns a handle which can be passed to `dojo.disconnect() <dojo/disconnect>`_ to disable subsequent automatic publication on the topic.

=========  ===========  =============================================================================
Parameter  Type         Description
=========  ===========  =============================================================================
topic      String       The name of the topic to publish.
obj        Object|null  The source object for the event function. Defaults to dojo.global if null.
event      String       The name of the event function in obj. I.e. identifies a property obj[event].
=========  ===========  =============================================================================


========
Examples
========

Programmatic example
--------------------

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.connectPublisher("/ajax/start", dojo, "xhrGet");
 </script>


========
See also
========

* `Event QuickStart <quickstart/events>`_
* `dojo.connect <dojo/connect>`_
* `dojo.publish <dojo/publish>`_
* `dojo.disconnect <dojo/disconnect>`_
