#format dojo_rst

dijit.form.NumberTextBox
========================

:Status: Draft
:Version: 1.0
:Authors: Mark Hays, Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

NumberTextBox widgets are used when user input is restricted to numeric input.

By default, the widget will discover the appropriate locale and behavior as specified by Dojo. For example, when using a NumberTextBox in the United States, an optional comma is used for the thousands separator and a period for a decimal separator when displaying numbers to the user. For German users, a period is used for the thousands separator and a comma for the decimal separator. Other locales may have different conventions.

When the user edits the value, or when sending data to the server, or when retreiving the ``value`` attribute programmatically, numbers are represented simply as JavaScript numbers, formatted with a period for decimal and no thousands separators. This representation is unambiguous, so other applications may interact with this data without assuming any locale-specific behavior. When specifying the ``constraints`` attribute, you have all the options available in the `Dojo constraint language <quickstart/numbersDates>`_. 

To further restrict/validate user input, this widget makes additional numeric ``constraints`` properties (``min`` and ``max``) available to the developer.

========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.NumberTextBox");
     </script>

  .. cv:: html

	<input id="q05" type="text"
		dojoType="dijit.form.NumberTextBox"
		name= "elevation"
		value="3000"
		constraints="{min:-20000,max:20000,places:0}"
		promptMessage= "Enter a value between -20000 and +20000"
		required= "true" 
		invalidMessage= "Invalid elevation.">
        <label for="q05">Integer between -20000 to +20000</label>
