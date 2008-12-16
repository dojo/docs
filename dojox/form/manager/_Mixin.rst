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

======================
Methods and properties
======================

This section describes all public methods and properties of `dojox.form.manager._Mixin`_ class.

General
-------

Only one property falls under this category: watch_.

watch
~~~~~

This is a Boolean property, which is used to control `observers <dojox/form/manager#event-processing>`_. When this property is ``true`` change events are processed and passed to relevant observers as usual. When it is ``false``, change events are ignored.

This property is useful when you want to modify/update controlled elements, but you don't want to cause observers to run.

Example:

.. code-block :: javascript

  // stop change event processing
  fm.watch = false;
  // update some fields without alerting observers
  fm.setFormValues({
    lastName:  "Smith",
    firstName: "Jane"
  });
  // start change event processing
  fm.watch = true;

Value access
------------

Methods in this category provides primitives for low-level access to values of individual form elements. For high-level access to values use `_ValueMixin <dojox/form/manager/_ValueMixin>`_.

formWidgetValue
~~~~~~~~~~~~~~~

This method allows to get/set values of controlled form widgets. It can be used two ways: with one parameter to get the value, and with two parameters to set the value:

.. code-block :: javascript

  // reading the value
  var value = fm.formWidgetValue("lastName");
  // writing the value
  fm.formWidgetValue("lastName", "Smith");

The first parameter is a name of `a controlled form element <dojox/form/manager#controlled-elements>`_ (a string). The optional second parameter is a value to be set. It is usually a string too.

The returned value is:
* A form element's value for the getter version.
* The form manager itself for the setter version providing easy chaining.

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
