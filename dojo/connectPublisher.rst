.. _dojo/connectPublisher:

=====================
dojo.connectPublisher
=====================

:Project owner: Alex Russell
:Available: since V0.9

.. contents::
   :depth: 2

Ensure that every time an event is called, a message is published on the topic.


Introduction
============

dojo.connectPublisher is an automation of this common form:

[ Dojo 1.7 AMD ]

.. js ::
  
  require(["dojo/_base/connect"], function(connect){
    connect.connect(myObject, "myEvent", function(){
      connect.publish("/some/topic/name", arguments);
    });
  });
  

Which becomes:

.. js ::
  
  require("dojo/_base/connect", function(connect){
    connect.connectPublisher("/some/topic/name", myObject, "myEvent");
  });


[ Dojo < 1.7 ]

.. js ::
  
  dojo.connect(myObject, "myEvent", function(){
       dojo.publish("/some/topic/name", arguments);
  });

Which becomes:

.. js ::
  
  dojo.connectPublisher("/some/topic/name", myObject, "myEvent");


Example
=======

.. js ::
 
 <script type="text/javascript">
   // Dojo 1.7 (AMD)
   require(["dojo/_base/connect"], function(connect){
      connect.connectPublisher("/ajax/start", dojo, "xhrGet");
   });
   // Dojo < 1.7
   dojo.connectPublisher("/ajax/start", dojo, "xhrGet");
 </script>

.. api-inline :: dojo.connectPublisher

See also
========

* :ref:`Event QuickStart <quickstart/events>`
* :ref:`dojo.connect <dojo/connect>`
* :ref:`dojo.publish <dojo/publish>`
* :ref:`dojo.disconnect <dojo/disconnect>`
