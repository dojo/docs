#format dojo_rst

dijit.form.CurrencyTextBox
==========================

:Status: Draft
:Version: 1.3
:Authors: Becky Gibson, Doug Hays, Bill Keese, Craig Riecke
:Developers: Doug Hays, Bill Keese
:Available: since V1.0

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

In this example using USD, both dollars and cents are required.

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
		dojo.require("dijit.form.CurrencyTextBox");
	</script>

  .. cv:: html

        <label for="income1">U.S. Dollars</label>
	<input type="text" name="income1" id="income1" value="54775.53"
		dojoType="dijit.form.CurrencyTextBox"
		required="true"
		constraints="{fractional:true}"
		currency="USD"
		invalidMessage="Invalid amount.  Cents are required.">



Programmatic example
--------------------

In this example using euros with German formatting, the invalid message contains a custom formatted example value.

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
		dojo.require("dijit.form.CurrencyTextBox");
		dojo.require("dojo.currency");
		dojo.requireLocalization("dojo.cldr", "currency", 'de-de');
		function createWidget(){
			var example = dojo.currency.format(54775.53, {locale: 'de-de', currency: "EUR"});
			var props = {
				value: 54775.53,
				lang: 'de-de',
				currency: "EUR",
				invalidMessage: "Invalid amount.  Example: " + example
			};
			new dijit.form.CurrencyTextBox(props, "eurde");
		}
		dojo.addOnLoad(createWidget);
	</script>

  .. cv:: html

	<label for="eurde">euros (lang: de-de):</label>
	<input id="eurde">EUR
        

=============
Accessibility
=============

See the Accessibility Section in `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_
