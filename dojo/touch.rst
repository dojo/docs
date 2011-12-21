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

This module provides an unified set of touch events - "press | move | release | cancel", which can run well across a wide range of devices(including desktops).

The rationale is very simple - "press | move | release | cancel" are mapped to:

- "touchstart | touchmove | touchend | touchcancel" on touch devices(`W3C Touch Events Specification <http://www.w3.org/TR/touch-events/>`_)

- "mousedown | mousemove | mouseup | mouseleave" on desktops.

So by using dojo/touch, we don't need to worry about appropriate native events when switching running platforms.


Usages
======

dojo/touch is based on :ref:`dojo/on <dojo/on>` and provides "press | move | release | cancel" 4 event handles. Following below are detail usages:


1. Used with dojo/on

.. js ::
  
      define(["dojo/on", "dojo/touch"], function(on, touch){
        on(node, touch.press, function(e){});
        on(node, touch.move, function(e){});
        on(node, touch.release, function(e){});
        on(node, touch.cancel, function(e){});
      }


2. Used with dojo/touch directly

.. js ::
  
      define(["dojo/touch"], function(touch){
        touch.press(node, function(e){});
        touch.move(node, function(e){});
        touch.release(node, function(e){});
        touch.cancel(node, function(e){});
      }

3. Or used with the traditional dojo/connect

.. js ::
  
        dojo.connect(node, dojo.touch.press, function(e){});
        dojo.connect(node, dojo.touch.move, function(e){});
        dojo.connect(node, dojo.touch.release, function(e){});
        dojo.connect(node, dojo.touch.cancel, function(e){});



Relationship with dojo/gesture
==============================

dojo/touch is the underneath basis for :ref:`dojox/gesture <dojox/gesture>`


Known Issues
============

If a device (like blackberry phones or some high end desktop computers) has both mouse and touch, dojo.touch will only monitor touch events, ideally it should be monitoring both. Please also See `#13048 <http://bugs.dojotoolkit.org/ticket/13048>`_.
