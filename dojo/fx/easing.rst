## page was renamed from 1.2/dojo/fx
#format dojo_rst

dojo.fx.easing
==============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

Have you ever wanted a fade out, fade in, wipe in, and so forth to apply the effect in a non-linear way?  For example, wouldn't it be cool to have a fade in accelerate the rate at which the node appears the further along in the animation duration it is?  This is handled through the 'easing' property of the arguments passed to the animation creation functions.  

Instead of having to write the easing function yourself, dojo provides a collection of easing functions to use as this parameter to get a variety of effects.

================
Easing Functions
================

+---------------------------------------+------------------------------------------------------------------------------------------------------+
|**Function**                           |**Description**                                                                                       |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.linear                 | The most basic easing function (and the default for animations), apply the effect linearly over time.|
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quadIn                 | A function to increase the rate of the effect by a power of 2 over time.                             |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quadOut                | A function to decrease the rate of the effect by a power of 2 over time.                             |
+---------------------------------------+------------------------------------------------------------------------------------------------------+


========
See Also
========

* `dojox.fadeIn <dojox/fadeIn>`_ - Examples show using the expoOut easing.

* `dojox.fadeOut <dojox/fadeOut>`_ - Examples show using the expoOut easing.
