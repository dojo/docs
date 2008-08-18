#format dojo_rst

dijit.form.ValidationTextBox
============================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke


.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.ValidationTextBox");
     </script>

  .. cv:: html

	<input type="text" name="phone" id="phone" value="someTestString"
		dojoType="dijit.form.ValidationTextBox"
		regExp="[\w]+"
		required="true"
		invalidMessage="Invalid Non-Space Text." />
        <label for="phone">Phone number, no spaces</label>
	<br/>
	<input type="text" name="zip" value="00000"
		dojoType="dijit.form.ValidationTextBox"
		regExp="\d{5}"
		required="true"
		invalidMessage="Invalid zip code." />
        <label for="zip">Also 5-Digit U.S. Zipcode only</label>
	<br/>
	<input type="text" name="zip" value="00000" id="zip2"
		dojoType="dijit.form.ValidationTextBox"
		regExpGen="after5"
		required="true"
		invalidMessage="Zip codes after 5, county name before then." />
        <label for="zip2">Also 5-Digit U.S. Zipcode only</label>
	<br/>
