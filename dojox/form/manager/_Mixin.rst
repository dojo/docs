#format dojo_rst

dojox.form.manager._Mixin
=========================

:Status: Draft
:Version: 1.3 (trunk)
:Project owner: Eugene Lazutkin
:Available: since 1.3

.. contents::
   :depth: 3

============
Introduction
============

This class is the main component of the form manager, which provides the initialization and core functionality. It can be used on its own as a mixin to other widgets, or as a part of `dojox.form.Manager <dojox/form/Manager>`_. All other form manager mixins require this class to be mixed in as well.

================================
Methods and properties of _Mixin
================================

General
-------

watch
~~~~~

Value access
------------

formWidgetValue
~~~~~~~~~~~~~~~

formPointValue
~~~~~~~~~~~~~~

Inspection
----------

inspectFormWidgets
~~~~~~~~~~~~~~~~~~

inspectAttachedPoints
~~~~~~~~~~~~~~~~~~~~~

inspect
~~~~~~~

Registration
------------

registerWidget
~~~~~~~~~~~~~~

unregisterWidget
~~~~~~~~~~~~~~~~

registerWidgetDescendants
~~~~~~~~~~~~~~~~~~~~~~~~~

unregisterWidgetDescendants
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Lifecycle
---------

startup
~~~~~~~

destroy
~~~~~~~

====================
Additional functions
====================

dojox.form.manager.actionAdapter
--------------------------------

dojox.form.manager.inspectorAdapter
-----------------------------------

dojox.form.manager._keys
------------------------

===============
Technical notes
===============

`_Mixin`_ extends `dijit._Widget <dijit/_Widget>`_ with an extra attribute: observer. It makes this attribute valid for all widgets. You can read more on observers in the `dojox.form.manager event processing documentation <dojox/form/manager#event-processing>`_.
