## page was renamed from 1.2/dojo/event
#format dojo_rst

dojo._base.event
================

:Status: Draft
:Version: 1.2
:Authors: Marcus Reimann
:Developers: James Burke, Bill Keese, Adam Peller, sjmiles
:Available: since V0.3

.. contents::
  :depth: 2

**dojo._base.event** contains functions to handle DOM events


========
Features
========

* Dojo's DOM Event Listener

  TODO: explain DOM event listener in detail

  * add

  * remove

* `dojo.fixEvent <dojo/fixEvent>`_

  Normalizes properties on the event object including event bubbling methods, keystroke normalization, and x/y positions

* `dojo.stopEvent <dojo/stopEvent>`_

  Prevents propagation and clobbers the default action of the passed event

* `dojo.keys <dojo/keys>`_

  Definitions for common key values


================
Migration issues
================

Since V0.9 most of the functionality from the dojo.event package has moved to dojo base so it is always available. Users of older releases will find more details within the `Dojo Porting Guide: 0.4x to 0.9.x <http://dojotoolkit.org/book/dojo-porting-guide-0-4-x-0-9/event-system>`__.
