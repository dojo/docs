#format dojo_rst

dijit.form.ValidationTextBox
============================

:Status: Draft
:Version: 1.0
:Authors: Doug Hays, Bill Keese, Craig Riecke
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

A ValidationTextBox by itself '''will not''' prevent invalid entries from submission. To ensure they're not, simply surround your form with a dijit.form.Form widget.

========
Examples
========

Declarative example
-------------------

ValidationTextBox widgets usually use Regular Expression validation, as in the following examples:

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
		invalidMessage="Invalid Non-Space Text.">
        <label for="phone">Phone number, no spaces</label>

Using regular expressions
-------------------------

The regular expression syntax comes directly from JavaScript. The start and ending qualifiers of the regular expression, ^ and $, are implicit - you do not need to include them. This code demonstrates a ValidationTextBox that only accepts a 5 digit zip code.

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.ValidationTextBox");
     </script>

  .. cv:: html

	<input type="text" name="zip" value="00000"
		dojoType="dijit.form.ValidationTextBox"
		regExp="\d{5}"
		required="true"
		invalidMessage="Invalid zip code.">
        <label for="zip">Also 5-Digit U.S. Zipcode only</label>

Generate regular expressions
----------------------------

ValidationTextBox also supports functions that generate regular expressions. Having a generating function enables you to write much more dynamic Web applications. ValidationTextBox passes its constraints object to the generating function. The following code demonstrates a dynamic ValidationTextBox that only accepts a 5 digit zip code after 5:00PM, and only accepts a county name before then.

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
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

	<input type="text" name="zip" value="00000" id="zip2"
		dojoType="dijit.form.ValidationTextBox"
		regExpGen="after5"
		required="true"
		invalidMessage="Zip codes after 5, county name before then.">
        <label for="zip2">Also 5-Digit U.S. Zipcode only</label>
