.. _dojo/fx:

=======
dojo.fx
=======

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:since: V1.0

.. contents ::
    :depth: 2

Have you ever wanted to nicely fade out or fade in a block of text, slide or wipe a DOM node into position, or even chain together numerous animations to provide a nice, dynamically changing page for your users?  Well, that is exactly what the dojo/fx module is for.  This module provides several commonly used animation effects.  These FX functions all build upon the basic FX support in :ref:`dojo base <dojo/_base/fx>`.  There are also less commonly used FX functions available in dojox under the :ref:`dojox.fx <dojox/fx>` package.

This page is a landing point for reference off to each function, their description, and examples.

**NOTE:** There is a great :ref:`quickstart animation guide <quickstart/Animation>` to get you up and running with basic FX animations

Features
========


Functions in dojo/_base/fx module
----------------------------------------

* :ref:`animateProperty() <dojo/_base/fx#animateproperty>` - The most basic animation function in dojo.  It allows you to animate the change of most CSS properties, as well as perform, pre and post operations as the animation executes.  Almost all the following animation functions are built using this function.

* :ref:`dojo.fadeIn <dojo/fadeIn>` - A simple function for fading a currently invisible (opacity 0), node into view.

* :ref:`dojo.fadeOut <dojo/fadeOut>` - A simple function for fading a currently visible(opacity 1), node to opacity 0.

Functions provided by the dojo/fx module
----------------------------------------

* :ref:`dojo.fx.wipeIn <dojo/fx/wipeIn>` -  Wipe in a node (Height 0 to max height of node).

* :ref:`dojo.fx.wipeOut <dojo/fx/wipeOut>` -  Wipe out a node (Max height to 0).

* :ref:`dojo.fx.slideTo <dojo/fx/slideTo>` -  To slide a node from current position to ABS position x,y.

* :ref:`dojo.fx.Toggler <dojo/fx/Toggler>` -  A helper class to wrap to simplify assigning two animations to a node, one for the 'show' animation and one for a 'hide' animation.  For example, fading a node in for show and out for hide.

* :ref:`dojo.fx.chain <dojo/fx/chain>` -  A helper function that can take two animation instances and combine them into a single animation instance where each of the input animations is run after the other in sequence.

* :ref:`dojo.fx.combine <dojo/fx/combine>` -  A helper function that can take two animation instances and combine them into a single animation instance where each of the input animations are run in parallel.

Additionally, there is a collection of easing functions living in the  :ref:`dojo.fx.easing <dojo/fx/easing>` module.

See also
========

* :ref:`dojo/_base/fx <dojo/_base/fx>`

  Basic animation functions in Dojo Base

* :ref:`dojox.fx <dojox/fx>`

  More advanced animation functions in dojox.fx

* :ref:`Animation Quickstart <quickstart/Animation>`

  The quickstart tutorial for doing animation effects.

* :ref:`Semi-complex chaining and combining of effects <dojo/fx/chainCombineExamples>`
