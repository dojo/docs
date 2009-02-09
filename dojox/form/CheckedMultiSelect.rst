#format dojo_rst

dojox.form.CheckedMultiSelect
=============================

:Status: Draft
:Version: 1.2
:Project owner: Nathan Toone
:Available: since V1.2

.. contents::
   :depth: 2

A multi-select widget (similar to html select with multiple=true) that uses check boxes.

============
Introduction
============

This widget provides a more user-friendly mechanism for multi-selects (HTML select tags with multiple=true).


=====
Usage
=====

The CheckedMultiSelect is designed to replace existing HTML select elements with minimal effort.  You can also create them programmatically.


========
Examples
========

A simple CheckedMultiSelect
---------------------------

This example shows a simple CheckedMultiSelect widget - converted from a select tag.

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.form.CheckedMultiSelect");
    </script>

  .. cv :: html

    <select multiple="true" name="multiselect" dojoType="dojox.form.CheckedMultiSelect">
          <option value="TN">Tennessee</option>
          <option value="VA" selected="selected">Virginia</option>
          <option value="WA" selected="selected">Washington</option>
          <option value="FL">Florida</option>
          <option value="CA">California</option>
     </select>

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/form/resources/CheckedMultiSelect.css";
    </style>

A radio-based CheckedMultiSelect
--------------------------------

By not specifying "multiple=true" in your widget, you will create a widget using radio buttons instead of check boxes.

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.form.CheckedMultiSelect");
    </script>

  .. cv :: html

    <select jsId="ss1" name="ss1" dojoType="dojox.form.CheckedMultiSelect">
          <option value="TN">Tennessee</option>
          <option value="VA" selected="selected">Virginia</option>
          <option value="WA">Washington</option>
          <option value="FL">Florida</option>
          <option value="CA">California</option>
    </select>

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/form/resources/CheckedMultiSelect.css";
    </style>
