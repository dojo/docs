.. _dojo/window:

===========
dojo/window
===========

:since: v1.5

.. contents ::
  :depth: 2

**dojo/window** contains functions related to the viewport.

Usage
=====

Requiring the module will return an object with the appropriate features:

.. js ::

  require(["dojo/window"], function(win){
    // win contains features
  });

Features
========

* :ref:`dojo/window::getBox() <dojo/window/getBox>`

  Returns the size of the viewport as a {w: 123, h: 456} Object

* :ref:`dojo/window::get() <dojo/window/get>`

  Returns the window corresponding to a document

* :ref:`dojo/window::scrollIntoView() <dojo/window/scrollIntoView>`

  Scrolls a node into view, similar to node.scrollIntoView() but working around browser quirks.

See Also
========

* :ref:`dojo/_base/window <dojo/_base/window>` - The core browser window related functions.
