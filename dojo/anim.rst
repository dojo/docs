#format dojo_rst

dojo.anim
=========

:Project owner: ?--
:Available: since V1.4

.. contents::
   :depth: 2

A simpler interface to `dojo.animateProperty()`.


============
Introduction
============

dojo.anim returns an instance of `dojo.Animation` but begins the animation immediately, unlike nearly every other Dojo animation API.

`dojo.anim` is a simpler (but somewhat less powerful) version of `dojo.animateProperty`. It uses defaults for many basic properties and allows for positional parameters to be used in place of the packed "property bag" which is used for other Dojo animation methods.

The `dojo.Animation` object returned from `dojo.anim` will be already playing when it is returned from this function, so calling play() on it again is (usually) a no-op.


=====
Usage
=====

Here is the definition of arguments:

===========  ==============  ======================================================================
Parameter    Type            Description
===========  ==============  ======================================================================
node         DOMNode|String  Can be a DOM node or the id of a node (as string) to animate CSS properties on.

properties   Object

duration     Integer         The number of milliseconds over which the animation should run. Defaults to the global animation default duration (350ms).

easing       Function        An easing function over which to calculate acceleration and deceleration of the animation through its duration. A default easing algorithm is provided, but you may plug in any you wish. A large selection of easing algorithms are available in `dojo.fx.easing`.

onEnd        Function        A function to be called when the animation finishes running.

delay        Integer         The number of milliseconds to delay beginning the animation by. The default is 0.
===========  ==============  ======================================================================


========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
