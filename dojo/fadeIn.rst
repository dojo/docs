#format dojo_rst

dojo.fadeIn
===========

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

This function is a helper function that wraps the `dojo.animateProperty <dojo/animateProperty>`_ function to provide an easy interface to fading a node into view on the page.  While this can be done with the *dojo.animateProperty* function, this function is simpler to use and will handle 99% of the cases a fade-in is desired.

==========
Parameters
==========

The *dojo.fadeIn* takes an object as its parameter.  This object defines what dom node to act on, how long the fade in should take (in milliseconds, and an optional easing function.  As with all dojo apis, refer to the API docs for the most up to date information on parameters.  These are listed for convenience.

+-------------------------------+--------------------------------------------------------------------------------------------+
+**Parameter**                  |**Description**                                                                             |
+-------------------------------+--------------------------------------------------------------------------------------------+
| node                          |The domNode or node id to fade in.                                                          |
|                               |                                                                                            |
|                               |**required**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| duration                      |How long, in milliseconds, should the fade take.  The default is 2000 milliseconds          |
|                               |(2 seconds).                                                                                |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| easing                        |An easing function to apply to the effect, such as exponential fade in, bouncing fade in,   |
|                               |etc.  Dojo provides a number of easing functions in module                                  |
|                               |`dojo.fx.easing <dojo/fx/easing>`_                                                          |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+


Return value
============

The *dojo.fadeIn* function returns an instance of dojo._Animation.  To execute the fadeIn, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as `dojo.fx.chain <dojo/fx/chain>`_ and `dojo.fx.combine <dojo/fx/combine>`_ to link it with other effects to perform complex animations.

Examples
========

Example 1:  Fade in a dom node
==============================


Example 2:  Fade in a dom node with a custom duration
=====================================================


Example 3:  Fade in a dom node with an easing function
======================================================
