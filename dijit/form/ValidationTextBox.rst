#format dojo_rst

dijit.form.ValidationTextBox
============================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Craig Riecke
:Project owners: Doug Hays, Bill Keese
:Available: since V1.0

.. contents::
    :depth: 2

============
Introduction
============

A ValidationTextBox is an <input>-like widget that checks to make sure the user's input is valid (according to a specified criterion).  It flags invalid input by changing the box color, showing an icon, and displaying a tooltip detailing the error.  

Note that a ValidationTextBox by itself *will not* prevent invalid entries from submission. To ensure they're not, simply surround your form with a `dijit.form.Form <dijit.form.Form>`_ widget.


=====
Usage
=====

The following attributes can be specified when you create a ValidationTextBox:

===============  =============  ======================================================================
Parameter        Type           Description
===============  =============  ======================================================================
required                        Whether the field is required or not. false by default.
promptMessage                   Tooltip text that appears when the text box is empty and on focus. Null by default.
invalidMessage                  Tooltip text that appears when the content of the text box is invalid. Null by default. 
constraints                     TBC.
regExp                          Regular expression pattern to be used for validation. If this is used, do not use regExpGen.
regExpGen                       TBC. If this is used, do not use regExp.
tooltipPosition                 Define where Tooltip will appear.
===============  =============  ======================================================================

Methods:

isValid()
    Method that calls validator function.
validator()
    Method that determines whether the content of the text box is valid. Called at these events: onblur, oninit, onkeypress. See also: `tips <dijit/form/ValidationTextBox-tricks>`_.
displayMessage()
    Method that displays validation errors or prompt messages. Uses dijit.Tooltip by default.


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

========
See also
========

* `Tips, tricks and edge cases for dijit.form.ValidationTextBox <dijit/form/ValidationTextBox-tricks>`_.
