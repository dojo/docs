.. _dojo/fx:

=======
dojo/fx
=======

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann,
             sjmiles
:since: V1.0

.. contents ::
    :depth: 2

Have you ever wanted to nicely fade out or fade in a block of text, slide or wipe a DOM node into position, or even
chain together numerous animations to provide a nice, dynamically changing page for your users? Well, that is exactly
what the ``dojo/fx`` module and package is for. This module provides several commonly used animation effects and other
utilities to manage animations. These FX functions all build upon the basic FX support in :ref:`dojo/_base/fx <dojo/_base/fx>`. There are also less commonly used FX functions available in ``dojox`` under the :ref:`dojox/fx <dojox/fx>` package.

This page is a landing point for reference off to each function, its description, and examples.

**NOTE:** There is the `Animation Tutorial <http://dojotoolkit.org/documentation/tutorials/1.7/animation/>`_, which is a
better place to start then the Reference Guide.

Features
========

dojo/_base/fx
-------------

* :ref:`animateProperty() <dojo/_base/fx#animateproperty>` - The most basic animation function in Dojo. It allows you to
  animate the change of most CSS properties, as well as perform, pre and post operations as the animation executes.
  Almost all the following animation functions are built using this function.

* :ref:`fadeIn() <dojo/_base/fx#fadein>` - A simple function for fading a currently invisible (opacity 0), node into
  view.

* :ref:`fadeOut() <dojo/_base/fx#fadeout>` - A simple function for fading a currently visible (opacity 1), node to
  opacity 0.

dojo/fx
-------

* :ref:`wipeIn() <dojo/fx/wipeIn>` -  Wipe in a node (height 0 to max height of node).

* :ref:`wipeOut() <dojo/fx/wipeOut>` -  Wipe out a node (max height to 0).

* :ref:`slideTo() <dojo/fx/slideTo>` -  To slide a node from current position to ABS position ``x``, ``y``.

* :ref:`chain() <dojo/fx/chain>` - A helper function that can take two animation instances and combine them into a
  single animation instance where each of the input animations is run after the other in sequence.

* :ref:`combine() <dojo/fx/combine>` - A helper function that can take two animation instances and combine them into a
  single animation instance where each of the input animations are run in parallel.

dojo/fx/easing
--------------

* :ref:`dojo/fx/easing <dojo/fx/easing>` - A set of easing functions.

dojo/fx/Toggler
---------------

* :ref:`dojo/fx/Toggler <dojo/fx/Toggler>` - A helper class to wrap to simplify assigning two animations to a node, one
  for the ``show`` animation and one for ``hide`` animation. For example, fading a node in for show and out for hide.

See also
========

* :ref:`dojo/_base/fx <dojo/_base/fx>`

  Basic animation functions in Dojo Base

* :ref:`dojox/fx <dojox/fx>`

  More advanced animation functions in ``dojox/fx``

* :ref:`Semi-complex chaining and combining of effects <dojo/fx/chainCombineExamples>`
