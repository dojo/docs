.. _dojox/form/manager/_ValueMixin:

==============================
dojox.form.manager._ValueMixin
==============================

:Project owner: Eugene Lazutkin
:since: 1.3

.. contents ::
   :depth: 3

Introduction
============

This class is the component of the form manager. It should be used together with :ref:`_Mixin <dojox/form/manager/_Mixin>`.

The mixin provides commonly used methods to access values of individual form elements, as well as to perform group operations on their values.

Methods and properties
======================

This section describes all public methods and properties of the dojox.form.manager._ValueMixin class.

elementValue
------------

This method is analogous to :ref:`_Mixin's inspectFormWidgets() <dojox/form/manager/_Mixin>`, :ref:`_Mixin's inspectAttachedPoints() <dojox/form/manager/_Mixin>`, and :ref:`_NodeMixin's formNodeValue() <dojox/form/manager/_NodeMixin>` --- it generalizes them all providing a single point access to any types of form elements by their names.

The method can be used in two ways: with one parameter to get the value, and with two parameters to set the value:

.. js ::

  // reading the value
  var value = fm.elementValue("lastName");
  // writing the value
  fm.elementValue("lastName", "Smith");

The first parameter is a name of :ref:`a controlled form element <dojox/form/manager/index>` (a string). The optional second parameter is a value to be set. It is usually a string too.

The returned value is:

* A form element's value for the getter version.
* The form manager itself for the setter version providing easy chaining.

gatherFormValues
----------------

This method collects values of controlled elements in a dictionary. There are three ways to use this method:

1. Call it with the array of names (represented by strings):

  .. js ::

    var names = ["firstName", "lastName"];
    var values = fm.gatherFormValues(names);

  Only supplied names will be collected.

2. Call it with a dictionary (an object). Only keys will be used, values will be ignored:

  .. js ::

    var names = {firstName: 1, lastName: 1};
    var values = fm.gatherFormValues(names);

  Only supplied names will be collected.

  This form is especially useful when we already collected values, and want to re-read the same set of names:

  .. js ::

    var names = {firstName: 1, lastName: 1};
    var oldValues = fm.gatherFormValues(names);
    // later in the code
    var newValues = fm.gatherFormValues(oldValues);

3. The parameter is ``null``, or ``undefined``, or missing. In this case all known values will be collected:

  .. js ::

    var values = fm.gatherFormValues();

setFormValues
-------------

This method is complimentary to gatherFormValues_. It uses the same dictionary format returned by gatherFormValues_ to set multiple form elements at once. The method returns the form manager for easy chaining.

.. js ::

  var values = {firstName: "Jane", lastName: "Smith"};
  fm.setFormValues(values);

Usage
=====

All methods are designed to work together:

.. js ::

  var values = fm.gatherFormValues();
  values.firstName = "Jill";
  fm.setFormValues(values);
