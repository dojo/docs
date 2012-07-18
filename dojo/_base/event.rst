.. _dojo/_base/event:

================
dojo/_base/event
================

.. contents ::
  :depth: 2

**dojo/_base/event** contains the legacy API for managing DOM events and is *deprecated*.  For handling DOM events, 
you should use :ref:`dojo/on <dojo/on>` instead.

Usage
=====

As with the rest of ``dojo/_base`` modules, if you are running the Dojo loader in legacy mode (``async: false``) this 
module is automatically loaded.  Even if it is automatically loaded, you should require it in to have access to its 
features:

.. js ::

  require(["dojo/_base/event"], function(event){
    // event now contains the modules features
  });

Features
========

stop()
------

.. api-doc :: dojo/_base/event
  :methods: stop
  :summary:
  :description:
  :sig:
  :no-headers:

fix()
-----

.. api-doc :: dojo/_base/event
  :methods: fix
  :summary:
  :description:
  :sig:
  :no-headers:

*Note*: ``fix()`` also invokes :ref:`dojo/dom-geometry::normalizeEvent() <dojo/dom-geometry/normalizeEvent>` in 
addition to normal event fixing that is performaned by :ref:`dojo/on <dojo/on>`.  This is because it is expensive and 
can be handled directly if needed.

See also
========

* :ref:`dojo/on <dojo/on>` - Dojo's event API.
