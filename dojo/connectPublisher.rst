#format dojo_rst

dojo.connectPublisher
=====================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Ensure that everytime an event is called, a message is published on the topic. 


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

Returns a handle which can be passed to dojo.disconnect() to disable subsequent automatic publication on the topic.

topic:
The name of the topic to publish.

obj: 
The source object for the event function. Defaults to dojo.global if null.

event:
The name of the event function in obj. I.e. identifies a property obj[event].


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

* TODO: links to other related articles
