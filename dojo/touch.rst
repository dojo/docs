.. _dojo/touch:

==========
dojo.touch
==========

:Project owner: Evan Huang
:since: V.1.7

.. contents ::
   :depth: 2

Introduction
============

This module provides a set of events designed to work similarly on desktop (i.e. mouse) and touch devices:

   - press, release - "mousedown" and "mouseup" on desktop, "touchstart" and "touchend" on touch devices
   - over, out - "mouseover" and "mouseout" on desktop, and functionally equivalent events on touch devices
   - enter, leave - :ref:`dojo/mouse::enter <dojo/mouse#mouse-enter>` and :ref:`dojo/mouse::leave <dojo/mouse#mouse-leave>`
     on desktop,and functionally equivalent events on touch devices
   - move - "mousemove" on desktop, and functionally equivalent event on touch devices; note that unlike the native
     touchmove event, this synthetic event fires on the node that the finger is currently over, rather than the node
     where the drag started
   - cancel - "mouseleave" on desktop and "touchcancel" on touch devices



Usages
======


1. Used with dojo/on

.. js ::
  
      define(["dojo/on", "dojo/touch"], function(on, touch){
        on(node, touch.press, function(e){});
        on(node, touch.move, function(e){});
        on(node, touch.release, function(e){});
        ...
      }


2. Used with dojo/touch directly

.. js ::
  
      define(["dojo/touch"], function(touch){
        touch.press(node, function(e){});
        touch.move(node, function(e){});
        touch.release(node, function(e){});
        ...
      }

Relationship with dojo/gesture
==============================

:ref:`dojox/gesture <dojox/gesture>` extends dojo/touch


Known Issues
============

If a device (like blackberry phones or some high end desktop computers) has both mouse and touch,
dojo.touch will only monitor touch events; ideally it should be monitoring both.
Please see `#13048 <http://bugs.dojotoolkit.org/ticket/13048>`_.

See Also
========
`W3C Touch Events Specification <http://www.w3.org/TR/touch-events/>`_