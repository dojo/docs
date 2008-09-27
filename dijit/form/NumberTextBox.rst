#format dojo_rst

dijit.form.NumberTextBox
========================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

The NumberTextBox widgets are used when user input is restricted to numeric input.  By default, the widget will discover the appropriate locale and behavior as specified by Dojo.  For example, when using a NumberTextBox in the United States, an optional comma is used for the thousands separator and a period for a decimal separator when interacting with the user. For German users, a period is used for the thousands separator and a comma for the decimal separator. Other locales may have different conventions. When sending data to the server or interpreting the "value" attribute, numbers are represented simply as JavaScript formats them with a period for decimal and no thousands separators. This representation is unambiguous, so other applications may interact with this data without assuming any locale-specific behavior.  To further restrict/validate user input, this widget inherits the *min* and *max* *constraints* properties which are added by the `RangeBoundTextBox <dijit/form/RangeBoundTextBox>`_ widget base class.

========
Examples
========

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
