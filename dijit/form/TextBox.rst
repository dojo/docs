#format dojo_rst

dijit.form.TextBox
==================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke

TextBox is a basic <input type="text">-style form control.  It has rudimentary text-scrubbing functions that trim or proper-casify text, but
it does not validate the entered text.  Like all Dijit controls, TextBox inherits the design theme, so it's better to use this than an
HTML control, even if you don't have to do any input scrubbing.  However:

* If the input is a number, use `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_ or `dijit.form.NumberSpinner <dijit/form/NumberSpinner>`_.  
  These boxes ensure only digits, decimal points and group separators (specific to the locale) are entered.
* If the input is currency, use `dijit.form.CurrencyTextBox <dijit/form/CurrencyTextBox>`_ instead.
* If the input is a date, use `dijit.form.DateTextBox <dijit/form/DateTextBox>`_ which validates date input according to the locale, and
  adds a little pop-up calendar for easy selection.
* If the input is a time, use `dijit.form.TimeTextBox <dijit/form/TimeTextBox>`_ which features a scrolling day-planner-like time chooser.
* If the input is a list of values, use `dijit.form.FilteringSelect <dijit/form/FilteringSelect>`_.  If you'd like to include free-form values too, 
  use `dijit.form.ComboBox <dijit/form/ComboBox>`_.  These two look like <select> controls but can use Dijit TextBox attributes as well.
* If text can be validated with a regular expression, use `dijit.form.ValidatingTextBox <dijit/form/ValidatingTextBox>`_.


Examples
--------

TODO: Break up

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.TextBox");
     dojo.require("dijit.form.DateTextBox");
     dojo.require("dijit.form.CurrencyTextBox");
     dojo.require("dijit.form.NumberTextBox");
     dojo.require("dijit.form.ValidationTextBox");
     function after5(constraints){
	   var date=new Date();
	   if(date.getHours() >= 17){
		  return "\\d{5}";
	   }else{ 
		  return "\\D+";
	   }
	}
     </script>

  .. cv:: html

        <input type="text" name="firstname" value="testing testing"
		dojoType="dijit.form.TextBox"
		trim="true" id="firstname"
		propercase="true" />
        <label for="firstname">Auto-trimming, Proper-casing Textbox:</label>
	<br/>
	<input type="text" name="date1" id="date1" value="2005-12-30"
		dojoType="dijit.form.DateTextBox"
		required="true" />
        <label for="date1">Drop down Date box</label>
	<br/>
	<input type="text" name="income1" id="income1" value="54775.53"
		dojoType="dijit.form.CurrencyTextBox"
		required="true"
		constraints="{fractional:true}"
		currency="USD"
		invalidMessage="Invalid amount.  Include dollar sign, commas, and cents." />
        <label for="income1">U.S. Dollars, comma is allowed</label>
	<br/>
	<input id="q05" type="text"
		dojoType="dijit.form.NumberTextBox"
		name= "elevation"
		value="3000"
		constraints="{min:-20000,max:20000,places:0}"
		promptMessage= "Enter a value between -20000 and +20000"
		required= "true" 
		invalidMessage= "Invalid elevation." />
        <label for="q05">Integer between -20000 to +20000</label>
	<br/>
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

  
Sizing TextBoxes
----------------

TODO

Getting and Manipulating the Value
----------------------------------

TODO:

Example: Treating ENTER as a TAB
--------------------------------

TODO

Screen Readers
--------------

If an invalid value is entered into a validating Text Box the "state" of the Text box changes, i.e. its background color changes.   To accomodate users who are blind, the Text Box's <a href="/node/1577">ARIA state</a> is changed to "invalid" so a screen reader can notify the screen reader user.  In addition to the "state" change, a pop-up appears.  When the pop-up appears screen readers should read the contents of the pop-up.  The pop-up text comes from the "invalidMessage" parameter.


Known Issues
------------

Sometimes the popup message supplied by invalidMessage attribute may be
unnecessary.  For example, omitting a required field already displays an icon
when the cursor leaves the field.  In these cases
you can omit the "invalidMessage" parameter, but keep in mind that good labels and instructions
are still necessary for accessibility, i.e. if the invalid popup will not be displayed then there must be clear instructional text indicating the field is required.

UPDATED for 1.0: Window-Eyes 6.1 speaks "read only" for fields that have been marked with the ARIA property invalid=true even though the field is still editable. 
