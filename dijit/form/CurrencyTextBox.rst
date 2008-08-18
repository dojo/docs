#format dojo_rst

dijit.form.CurrencyTextBox
==========================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke


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

        
