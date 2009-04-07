## page was renamed from 1.2/dojo/fx
#format dojo_rst

dojo.fx
=======

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

Have you ever wanted to nicely fade out or fade in a block of text, slide or wipe a DOM node into position, or even chain together numerous animations to provide a nice, dynamically changing page for your users?  Well, that is exactly what the dojo.fx module is for.  This module provides several commonly used animation effects.  These FX functions all build upon the basic FX support in `dojo base <dojo/_base/fx>`_.  There are also less commonly used FX functions available in dojox under the `dojox.fx <dojox/fx>`_ package.

This page is a landing point for reference off to each function, their description, and examples.

**NOTE:** There is a great `quickstart animation guide <quickstart/Animation>`_ to get you up and running with basic FX animations

========
Features
========


Functions always avalable (Dojo 'Base')
---------------------------------------

* `dojo.animateProperty <dojo/animateProperty>`_ - The most basic animation function in dojo.  It allows you to animate the change of most CSS properties, as well as perform, pre and post operations as the animation executes.  Almost all the following animation functions are built using this function.

* `dojo.fadeIn <dojo/fadeIn>`_ - A simple function for fading a currently invisible (opacity 0), node into view.

* `dojo.fadeOut <dojo/fadeIn>`_ - A simple function for fading a currently visible(opacity 1), node to opacity 0.

Functions provided by the dojo.fx module
----------------------------------------

* `dojo.fx.easing <dojo/fx/easing>`_ -  A collection of easing functions that can be used with dojo.animateProperty and its extensions to modify an animation.

* `dojo.fx.wipeIn <dojo/fx/wipeIn>`_ -  To wipe in a node

* `dojo.fx.wipeOut <dojo/fx/wipeOut>`_ -  To wipe in a node

* `dojo.fx.slideTo <dojo/fx/slideTo>`_ -  To slide a node from current position to ABS position x*(left)*,y*(top)*.

* `dojo.fx.Toggler <dojo/fx/Toggler>`_ -  A helper class to wrap to simplify assigning two animations to a node, one for the 'show' animation and one for a 'hide' animation.  For example, fading a node in for show and out for hide.

========
See also
========

* `dojo._base.fx <dojo/_base/fx>`_

  Basic animation functions in Dojo Base

* `dojox.fx <dojox/fx>`_

  More advanced animation functions in dojox.fx

* `Animation Quickstart <quickstart/Animation>`_

  The quickstart tutorial for doing animation effects.

* `Semi-complex chaining and combining of effects <dojo/fx/chainCombineExamples>`_
