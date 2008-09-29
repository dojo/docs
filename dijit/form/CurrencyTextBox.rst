#format dojo_rst

dijit.form.CurrencyTextBox
==========================

:Status: Draft
:Version: 1.0
:Authors: Doug Hays, Bill Keese, Craig Riecke
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

CurrencyTextBox widgets inherit all the attributes and behaviors of the `NumberTextBox <dijit/form/NumberTextBox>`_ widget but are specialized for input monetary values, much like the currency type in spreadsheet programs.

=====
Usage
=====

* The ``value`` attribute is a native JavaScript floating point number.

  This means that you can easily build CurrencyTextBox widgets for a wide range of currencies without having to set a different value for each currency format.

* The optional boolean ``fractional`` property of the ``constraints`` object attribute can be set to require/refuse fractional input.


========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.CurrencyTextBox");
     </script>

  .. cv:: html

		<input type="text" name="income1" id="income1" value="54775.53"
		dojoType="dijit.form.CurrencyTextBox"
		required="true"
		constraints="{fractional:true}"
		currency="USD"
		invalidMessage="Invalid amount.  Cents are required.">
        <label for="income1">U.S. Dollars</label>
