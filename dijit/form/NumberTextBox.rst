#format dojo_rst

dijit.form.NumberTextBox
========================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

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
		invalidMessage= "Invalid elevation." />
        <label for="q05">Integer between -20000 to +20000</label>
