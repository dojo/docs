#format dojo_rst

dijit.form.CurrencyTextBox
==========================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke

As expected this is used to input monetary values, much like the currency type in spreadsheet programs.

The ``value`` attribute is a floating point number.  
This means that you can easily build CurrencyTextBoxes for a wide range of currencies without having to set a different value for each currency format.  
``fractional`` is still set to true, but it is set inside the constraints object instead of on the widget.


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
		invalidMessage="Invalid amount.  Include dollar sign, commas, and cents." />
        <label for="income1">U.S. Dollars, comma is allowed</label>

        
