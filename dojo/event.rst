## page was renamed from 1.2/dojo/event
#format dojo_rst

dojo.event
==========

:Status: Contributed, Draft
:Version: 1.2
:Developers: ?-
:Available: since V0.3

.. contents::
  :depth: 2

Dojo's Event System is an abstraction of JavaScript's Event System.

========
Features
========

* TODO: explain DOM event listener in detail
* dojo.fixEvent

  normalizes properties on the event object including event bubbling methods, keystroke normalization, and x/y positions

* dojo.stopEvent

  prevents propagation and clobbers the default action of the passed event

* dojo.keys

  definitions for common key values

================
Migration issues
================

Since V0.9 most of the functionality from the dojo.event package has moved to dojo base so it is always available. Users of older releases will find more details within the `Dojo Porting Guide: 0.4x to 0.9.x <http://dojotoolkit.org/book/dojo-porting-guide-0-4-x-0-9/event-system>`__.
