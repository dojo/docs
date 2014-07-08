.. _dojo/dom-geometry/normalizeEvent:

===================================
dojo/dom-geometry::normalizeEvent()
===================================

:Project owner: Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

``normalizeEvent()`` normalizes the geometry of a DOM event. It normalizes the ``pageX``, ``pageY``, ``offsetX``, ``offsetY``, ``layerX`` and ``layerX`` properties of the event.

Usage
=====

.. js ::

  require(["dojo/dom-geometry"], function(domGeom){
    domGeom.normalizeEvent(e);
    // e now has normalized geometry properties
  });

*Note*: While :ref:`dojo/_base/event::fix() <dojo/_base/event#fix>` will automatically normalize the geometry of an
event, when :ref:`dojo/on <dojo/on>` automatically normalizes DOM events, it does not do this (as it is expensive and 
not always necessary) and you will have to normalize these yourself.

See Also
========

* :ref:`dojo/dom-geometry <dojo/dom-geometry>` - The rest of the DOM Geometry API.

* :ref:`dojo/dom <dojo/dom>` - The core of the DOM API.

* :ref:`dojo/on <dojo/on>` - The Dojo event handling API.
