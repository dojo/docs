.. _dojo/_base/connect:

==================
dojo/_base/connect
==================

.. contents ::
    :depth: 2


**dojo/_base/connect** contains functions for connecting to methods, events and topics.  The functionality in this module is 
*deprecated*, but kept in the Dojo 1.X code stream for backwards compatiblity.

* If you want to connect to an event, see :ref:`dojo/on <dojo/on>` instead.

* If you want to connect to a method, use Aspect Oriented Programming with after advice and see 
  :ref:`dojo/aspect::after() <dojo/aspect#after>` instead.

* If you want to publish or subscribe to topics, see :ref:`dojo/topic <dojo/topic>` instead.

Usage
=====

As with the rest of ``dojo/_base`` modules, if you are running the Dojo loader in legacy mode (``async: false``) this 
module is automatically loaded.  Even if it is automatically loaded, you should require it in to have access to its 
features:

.. js ::

  require(["dojo/_base/connect"], function(connect){
    // connect now has the module's features
  });


See Also
========

* :ref:`dojo/on <dojo/on>` - Dojo event handling API

* :ref:`dojo/topic <dojo/topic>` - Dojo topic API

* :ref:`dojo/aspect <dojo/aspect>` - Dojo Aspect Oriented Programming Core Module
