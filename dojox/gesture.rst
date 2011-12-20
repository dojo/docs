.. _dojox/gesture:

=============
dojox.gesture
=============

:Project owner: Evan Huang
:since: V.1.7

.. contents ::
   :depth: 2

Introduction
============

This module provides a machinery for writing unified gesture events which can run well across a wide range of devices(most single touch gesture events can also work well on desktops).


Rationale
=========

dojox/gesture has been designed with the following rationales:

- Device neutral - The target is to be compatible with most popular devices(single touch gestures should also work well on desktops).

- Compatibility and reusability - Applicable and can be used with dijit widgets, dojo core(dnd), dojox/mobile or dojox/charting etc.

- Scalability - A modularized event processing mechanism makes it very easy to extend with more customized gestures.


The most key thing dojox/gesture does is standardizing touch and gesture events across devices. These unified gesture events are fist divided into several internal phase events with smaller granularity - "press |  move | release | cancel" which will then be mapped to appropriate native events e.g. "touchxxx" on touch devices and "mousexxx" on desktops. The native events are then monitored on the target node, and gesture events will be fired once matched during these phase events. The following picture shows more details.

.. image :: gesture2.jpg


Usages
======

Based on dojo/on and dojo/touch, all the gestures are provided as object events(taking dojox/gesture/tap for example):

1. Used with dojo/on

.. js ::

      define(["dojo/on", "dojox/gesture/tap"], function(on, tap){
        on(node, tap, function(e){});
      }
  
  
2. Used with dojox/gesture/tap directly

.. js ::

      define(["dojox/gesture/tap"], function(tap){
        tap(node, function(e){});
      }
  

3. Or used with the traditional dojo/connect

.. js ::

        dojo.connect(node, dojox.gesture.tap, function(e){});



dojox/gesture/Base
==================

The common parental class for all gesture implementations. It takes most routine works including:

1. Bind corresponding listeners for gesture events.

2. Monitor underneath events and process different phases - 'press'|'move'|'release'|'cancel'

3. Fire and bubble gesture events.


dojox/gesture/tap
=================

Provide common tap related gesture events including "tap", "tap.hold" and "tap.doubletap". It can be used in following ways:

1. Used with dojo/on

.. js ::

      define(["dojo/on", "dojox/gesture/tap"], function(on, tap){
        on(node, tap, function(e){});
        on(node, tap.hold, function(e){});
        on(node, tap.doubletap, function(e){});
      }
  
  
2. Used with dojox/gesture/tap directly

.. js ::

      define(["dojox/gesture/tap"], function(tap){
        tap(node, function(e){});
        tap.hold(node, function(e){});
        tap.doubletap(node, function(e){});
      }
  

3. Or used with the traditional dojo/connect

.. js ::

        dojo.connect(node, dojox.gesture.tap, function(e){});
        dojo.connect(node, dojox.gesture.tap.hold, function(e){});
        dojo.connect(node, dojox.gesture.tap.doubletap, function(e){});
  

There are also several configurable parameters in dojox/gesture/tap

==================  ================================================================================================
Option              Description
==================  ================================================================================================
tapRadius           Default is 10, used in "tap.doubletap" to validate whether the second tap is in the valid radius
holdThreshold       Default is 500, the minimal time(in milliseconds) to trigger a "tap.hold"
doubleTapTimeout    Default is 250, the timeout threshold(in milliseconds) for "tap.doubletap"
==================  ================================================================================================

The above parameters are supposed to be only changed seldomly with the following way:

.. js ::

        define(["dojo/on", "dojox/gesture/tap"], function(on, tap){

            // create a new one with a different holdThreshold parameter
            var myTap = new dojox.gesture.tap.Tap({holdThreshold: 300});

            // use it
            on(node, myTap, function(e){});
            on(node, myTap.hold, function(e){});
            on(node, myTap.doubletap, function(e){});
        }
  
  
  
dojox/gesture/swipe
===================

Provide swipe related gesture events including:

1. "swipe"

A series of 'swipe' will be fired during touchmove, this will mostly be used to keep sliding the target dom based on the swiped distance(dx, dy).


2. "swipe.end"

Fired when a swipe is ended so that an bounce animation could be applied to the target dom and slide to the final position.


It can be used in following ways:

1. Used with dojo/on

.. js ::

      define(["dojo/on", "dojox/gesture/swipe"], function(on, swipe){
        on(node, swipe, function(e){});
        on(node, swipe.end, function(e){});
      }
  
2. Used with dojox/gesture/swipe directly

.. js ::

      define(["dojox/gesture/swipe"], function(swipe){
        swipe(node, function(e){});
        swipe.end(node, function(e){});
      }
  

3. Or used with the traditional dojo/connect

.. js ::

        dojo.connect(node, dojox.gesture.swipe, function(e){});
        dojo.connect(node, dojox.gesture.swipe.end, function(e){});
  
  
Some swipe related information will also be provided in the fired "swipe" or "swipe.end" event:

==================  ================================================================================================
Event property      Description
==================  ================================================================================================
type                "swipe" or "swipe.end"
time                An integer indicating the delta time(in milliseconds)
dx                  Delta distance on X axis, dx < 0 means is moving left, dx > 0 means is moving right
dy                  Delta distance on Y axis, dy < 0 means is moving up, dy > 0 means is moving down
==================  ================================================================================================


Bubble the gesture event
=============================

A gesture event behaves all the same as a native Event. Besides getting useful information from the fired gesture event, we can also stop bubbling it.

The following sample shows how we can easily stop a gesture event from bubbling to parent node:

.. js ::

        function innerFunc(e){
          console.log("'tap' fired on inner div");
          dojo.stopEvent(e);
        }
        function outerFunc(e){
          // never go here since the 'tap' event is stopped at inner div
          console.log("'tap' fired on outer div");
        }
        on(inner, tap, innerFunc);
        on(outer, tap, outerFunc);
 

  

Write a new gesture
===================

It's very easy to customize a new gesture with following steps:

- Extend dojox/gesture/Base
- Overwrite phase handlers on demand - "press() | move() | release() | cancel()"
- Recognize and fire gesture events during different phases

Suppose we have a dojox/gesture/rotate which provides 3 gesture events:"rotate", "rotate.end" which can be used as:

.. js ::

        define(["dojo/on", "dojox/gesture/rotate"], function(on, rotate){
            on(node, rotate, function(e){});
            on(node, rotate.end, function(e){});
        }

Then we can define the rotate gesture like:

.. js ::

        define([..., "./Base"], function(..., Base){
          var clz = declare(Base, {
            defaultEvent: "rotate",

            subEvents: ["end"],

            press: function(data, e){
              // record the initial coords
            },
            move: function(data, e){
              // fire if matched
              this.fire(node, {type: "rotate", ...});
            },
            release: function(data, e){
              // if we're in a rotate gesture
              this.fire(node, {type: "rotate.end", ...});
            },
            cancel: function(data, e){
              // clean up
            }
          });

          // in order to have a default instance for handy use
          dojox.gesture.rotate = new clz();

          return dojox.gesture.rotate;
        });


Demo
====
The `Touch & Gesture demo <http://demos.dojotoolkit.org/demos/touch/demo.html>`_ shows how dijit/form/HorizontalSlider and dojo/dnd are now running well on iOS4+ with the new dojo/touch and dojox/gesture.

Besides a tap gesture, the demo also shows how easy it is to write a new rotate gesture with multiple touch support.
  

Supported devices in 1.7
========================

dojox/gesture is working well with:

1. Desktops
- IE8+, FF 3.6+, Chrome v10+, Safari 5+

2. Touch devices
- Android 2.2/2.3
- iOS 3/4


Future plan
============

A rich set of enhancements is being planned for the further versions:

- Enhance dojox.gesture core to support Multi-touch better
- Enrich more popular gestures e.g. rotate, flicker, pinch/spread, drag, scroll etc.
- More device support - iOS 5, Android 3, BlackBerry and devices(e.g. BB tablet) that support both touch and mouse events
