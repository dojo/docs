.. _dojo/touch:

==========
dojo/touch
==========

:Project owner: Evan Huang
:since: v1.7

.. contents ::
   :depth: 2

**dojo/touch** is a module that provides a set of events designed to work similarly on a desktop browser (e.g. with mouse) and touch devices, so that the developer only needs to handle code for one set of events and abstract themselves from the specifics of mouse and touch events.

Usage
=====

Requiring in the module makes the events available for handling:

.. js ::

  require(["dojo/touch"], function(touch){
    // touch is available
  });

There are two main ways of using ``dojo/touch``.  The first is using it coupled with :ref:`dojo/on <dojo/on>`.  For example:

.. js ::

  require(["dojo/touch", "dojo/on"], function(touch){
    on(node, touch.press, function(e){
      // handle event
    });
  });

Also, the touch event listeners can be registered directly with the module:

.. js ::

  require(["dojo/touch"], function(touch){
    touch.press(node, function(e){
      // handle event
    });
  });

Events
------

The following table provides information on the events supported by the module:

================ ================================================== ============ ======================================
dojo/touch Event Browser                                            Touch Device Notes
================ ================================================== ============ ======================================
press            mousedown                                          touchstart
release          mouseup                                            touchend
over             mouseover                                          *synthetic*
out              mouseout                                           *synthetic*
enter            :ref:`dojo/mouse::enter <dojo/mouse#enter>`        *synthetic*
leave            :ref:`dojo/mouse::leave <dojo/mouse#leave>`        *synthetic*
move             mousemove                                          *synthetic*  This synthetic events fires on the 
                                                                                 node that the finger is currently 
                                                                                 over, rather than the node where the 
                                                                                 drag started.
cancel           mouseleave                                         touchcancel
================ ================================================== ============ ======================================

dojox/gesture
=============

:ref:`dojox/gesture <dojox/gesture>` extends ``dojo/touch``.

Known Issues
============

If a device has both mouse and touch (like Blackberry phones or some high end desktop computers), ``dojo/touch`` will 
only monitor touch events; ideally it should be monitoring both.

Please see `#13048 <http://bugs.dojotoolkit.org/ticket/13048>`_.  This will not be addressed until Dojo 2.0.

See Also
========

* `W3C Touch Events Specification <http://www.w3.org/TR/touch-events/>`_

* :ref:`dojo/mouse <dojo/mouse>` - Moused based events

* :ref:`dojox/gesture <dojox/gesture>` - Gesture based events
