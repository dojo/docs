#format dojo_rst

dojox.form.Manager
==================

:Status: Draft
:Version: 1.3 (trunk)
:Project owner: Eugene Lazutkin
:Available: since 1.3

.. contents::
   :depth: 3

============
Introduction
============

This class is the widget implementing the form manager. It includes all available mixins and "inverts" its template so developers can use template-specific directives inline.

This is a high-level widget placed directly in ``/dojox/form/`` directory. Other form manager's components (mixins) are located in ``/dojox/form/manager/`` directory.

======================
Methods and properties
======================

This widget has no public methods nor properties. Only standard lifecycle methods are defined.

Lifecycle
---------

Lifecycle methods are part of every widget. They are used to initialize and destroy a widget. If you mix `dojox.form.manager._Mixin <dojox/form/manager/_Mixin>`_ in your own widget, make sure that these methods are not overwritten. If you overwrite them, make sure to call ``this.inherited(arguments)`` at the appropriate place, so they can initialize/destroy the widget properly.

buildRendering
~~~~~~~~~~~~~~

This is the standard method of any widget. It is responsible for setting up DOM nodes during the initialization cycle. For more details, see `dijit._Widget <dijit/_Widget>`_.

startup
~~~~~~~

This is the standard method of any widget. It is responsible for starting up the widget after it was created and the DOM was parsed. For more details, see `dijit._Widget <dijit/_Widget>`_.

=====
Usage
=====

See `dojox.form.manager <dojox/form/manager/index>`_ for the usage scenarios.
