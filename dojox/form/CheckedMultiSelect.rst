.. _dojox/form/CheckedMultiSelect:

=============================
dojox.form.CheckedMultiSelect
=============================

:Project owner: Nathan Toone
:since: V1.2

.. contents ::
   :depth: 2

A multi-select widget (similar to html select with multiple=true) that uses check boxes.

Introduction
============

This widget provides a more user-friendly mechanism for multi-selects (HTML select tags with multiple=true).


Usage
=====

The CheckedMultiSelect is designed to replace existing HTML select elements with minimal effort.  You can also create them programmatically.


Examples
========

A simple CheckedMultiSelect
---------------------------

This example shows a simple CheckedMultiSelect widget - converted from a select tag.

.. code-example ::

  .. js ::

      require(["dojox/form/CheckedMultiSelect"]);

  .. html ::

    <select multiple="true" name="multiselect" data-dojo-type="dojox.form.CheckedMultiSelect">
          <option value="TN">Tennessee</option>
          <option value="VA" selected="selected">Virginia</option>
          <option value="WA" selected="selected">Washington</option>
          <option value="FL">Florida</option>
          <option value="CA">California</option>
     </select>

  .. css ::

      @import "{{baseUrl}}dojox/form/resources/CheckedMultiSelect.css";

A radio-based CheckedMultiSelect
--------------------------------

By not specifying "multiple=true" in your widget, you will create a widget using radio buttons instead of check boxes.

.. code-example ::

  .. js ::

      require(["dojox/form/CheckedMultiSelect"]);

  .. html ::

    <select data-dojo-id="ss1" name="ss1" data-dojo-type="dojox.form.CheckedMultiSelect">
          <option value="TN">Tennessee</option>
          <option value="VA" selected="selected">Virginia</option>
          <option value="WA">Washington</option>
          <option value="FL">Florida</option>
          <option value="CA">California</option>
    </select>

  .. css ::

      @import "{{baseUrl}}dojox/form/resources/CheckedMultiSelect.css";
