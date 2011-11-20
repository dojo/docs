.. _dojo/_base/connect:

dojo._base.connect
==================

:Status: Draft
:Version: 1.0
:Authors: Marcus Reimann
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2


**dojo._base.connect** contains functions for connecting methods to events and to subscribe and publish events.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including dojo.js or dojo.xd.js in your page.


========
Features
========

* :ref:`dojo.connect <dojo/connect>`

  Connects events to methods

* :ref:`dojo.disconnect <dojo/disconnect>`

  Disconnects methods from linked topics

* :ref:`dojo.subscribe <dojo/subscribe>`

  Linked a listener to a named topic

* :ref:`dojo.unsubscribe <dojo/unsubscribe>`

  Remove a topic listener

* :ref:`dojo.publish <dojo/publish>`

  Publish an event to all subscribers of a topic

* :ref:`dojo.connectPublisher <dojo/connectPublisher>`

  Ensure that everytime an event is called, a message is published on the topic.
