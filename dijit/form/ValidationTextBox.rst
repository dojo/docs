#format dojo_rst

dijit.form.ValidationTextBox
============================

:Status: Draft
:Version: 1.3
:Authors: Becky Gibson, Doug Hays, Bill Keese, Craig Riecke
:Developers: Doug Hays, Bill Keese
:Available: since V1.0

.. contents::
    :depth: 2

============
Introduction
============

A ValidationTextBox is an <input>-like widget that checks to make sure the user's input is valid (according to a specified criterion).  It flags invalid input by changing the box color, showing an icon, and displaying a tooltip detailing the error.  

Note that a ValidationTextBox by itself *will not* prevent invalid entries from submission. To ensure they're not, simply surround your form with a `dijit.form.Form <dijit.form.Form>`_ widget.

ValidationTextBox (and the widgets that extend it) also provide  the ability to display a "promptMessage", a tooltip that appears whenever the field is empty.

========
Examples
========

Declarative example
-------------------

ValidationTextBox widgets usually use Regular Expression validation, as in the following example:

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

=============
Accessibility
=============

Keyboard
--------

The ValidationTextBox widget uses native HTML INPUT (type=text) controls.

Screen Readers
--------------

If an invalid value is entered into a validating Text Box the "state" of the Text box changes, i.e. its background color changes. To accomodate users who are blind, the Text Box's `ARIA state <quickstart/writingWidgets/a11y#assigning-states-as-of-1-0>`_ is changed to "invalid" so a screen reader can notify the screen reader user. In addition to the "state" change, a pop-up appears. When the pop-up appears screen readers should read the contents of the pop-up. The pop-up text comes from the "invalidMessage" parameter.

Known Issues
------------

Sometimes the popup message supplied by invalidMessage attribute may be unnecessary. For example, omitting a required field already displays an icon when the cursor leaves the field. In these cases you can omit the "invalidMessage" parameter, but keep in mind that good labels and instructions are still necessary for accessibility, i.e. if the invalid popup will not be displayed then there must be clear instructional text indicating the field is required.

As of the Dojo 1.0 release and beyond: Window-Eyes 6.1 speaks "read only" for fields that have been marked with the ARIA property invalid=true even though the field is still editable.
