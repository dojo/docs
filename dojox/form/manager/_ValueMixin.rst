#format dojo_rst

dojox.form.manager._ValueMixin
==============================

:Status: Draft
:Version: 1.3 (trunk)
:Project owner: Eugene Lazutkin
:Available: since 1.3

.. contents::
   :depth: 3

============
Introduction
============

This class is the component of the form manager. It should be used together with `_Mixin <dojox/form/manager/_Mixin>`_.

The mixin provides commonly used methods to access values of individual form elements, as well as to perform group operations on their values.

======================
Methods and properties
======================

This section describes all public methods and properties of the dojox.form.manager._ValueMixin class.

elementValue
------------

This method is analogous to `_Mixin's inspectFormWidgets() <dojox/form/manager/_Mixin#formwidgetvalue>`_, `_Mixin's inspectAttachedPoints() <dojox/form/manager/_Mixin#formpointvalue>`_, and `_NodeMixin's formNodeValue() <dojox/form/manager/_NodeMixin#formnodevalue>`_ --- it generalizes them all providing a single point access to any types of form elements by their names.

The method can be used in two ways: with one parameter to get the value, and with two parameters to set the value:

.. code-block :: javascript

  // reading the value
  var value = fm.elementValue("lastName");
  // writing the value
  fm.elementValue("lastName", "Smith");

The first parameter is a name of `a controlled form element <dojox/form/manager#controlled-elements>`_ (a string). The optional second parameter is a value to be set. It is usually a string too.

The returned value is:

* A form element's value for the getter version.
* The form manager itself for the setter version providing easy chaining.

gatherFormValues
----------------

This method collects values of controlled elements in a dictionary. There are three ways to use this method:

1. Call it with the array of names (represented by strings):

  .. code-block :: javascript

    var names = ["firstName", "lastName"];
    var values = fm.gatherFormValues(names);

  Only supplied names will be collected.

2. Call it with a dictionary (an object). Only keys will be used, values will be ignored:

  .. code-block :: javascript

    var names = {firstName: 1, lastName: 1};
    var values = fm.gatherFormValues(names);

  Only supplied names will be collected.

  This form is especially useful when we already collected values, and want to re-read the same set of names:

  .. code-block :: javascript

    var names = {firstName: 1, lastName: 1};
    var oldValues = fm.gatherFormValues(names);
    // later in the code
    var newValues = fm.gatherFormValues(oldValues);

3. The parameter is ``null``, or ``undefined``, or missing. In this case all known values will be collected:

  .. code-block :: javascript

    var values = fm.gatherFormValues();

setFormValues
-------------

This method is complimentary to gatherFormValues_. It uses the same dictionary format returned by gatherFormValues_ to set multiple form elements at once. The method returns the form manager for easy chaining.

.. code-block :: javascript

  var values = {firstName: "Jane", lastName: "Smith"};
  fm.setFormValues(values);

=====
Usage
=====

All methods are designed to work together:

.. code-block :: javascript

  var values = fm.gatherFormValues();
  values.firstName = "Jill";
  fm.setFormValues(values);
