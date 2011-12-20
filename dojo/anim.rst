.. _dojo/anim:

=========
dojo.anim
=========

:Project owner: ?--
:since: V1.4

.. contents ::
   :depth: 2

A simpler interface to `dojo.animateProperty()`.


Introduction
============

dojo.anim returns an instance of `dojo.Animation` but begins the animation immediately, unlike nearly every other Dojo animation API.

`dojo.anim` is a simpler (but somewhat less powerful) version of `dojo.animateProperty`. It uses defaults for many basic properties and allows for positional parameters to be used in place of the packed "property bag" which is used for other Dojo animation methods.

The `dojo.Animation` object returned from `dojo.anim` will be already playing when it is returned from this function, so calling play() on it again is (usually) a no-op.


Usage
=====

Dojo 1.7 (AMD)
--------------

.. js ::
 
   require(['dojo/_base/fx'], function(fx){
     fx.anim(node, properties, duration, easing, onEnd, delay);
   });

Dojo < 1.7
----------

.. js ::
 
   dojo.anim(node, properties, duration, easing, onEnd, delay);



Examples
========

TODO: example

.. api-inline :: dojo.anim

See also
========

* TODO: links to other related articles
