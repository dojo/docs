#format dojo_rst

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

As with all dojo._base components, this functions are included within Dojo Base. You get this functionality by just including dojo.js or dojo.xd.js in your page.


=========
Functions
=========

* `dojo.connect <dojo/connect>`_

  Connects events to methods

* `dojo.disconnect <dojo/disconnect>`_

  Disconnects methods from linked topics

* `dojo.subscribe <dojo/subscribe>`_

  Linked a listener to a named topic

* `dojo.unsubscribe <dojo/unsubscribe>`_

  Remove a topic listener

* `dojo.publish <dojo/publish>`_

  Publish an event to all subscribers of a topic

* `dojo.connectPublisher <dojo/connectPublisher>`_

  Ensure that everytime an event is called, a message is published on the topic.
