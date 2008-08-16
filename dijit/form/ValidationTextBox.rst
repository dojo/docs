#format dojo_rst

dijit.form.ValidatingTextBox
============================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke

A ValidatingTextBox by itself '''will not''' prevent invalid entries from submission.  To ensure they're not, simply surround your form with a dijit.form.Form widget

The ``value`` attribute is a floating point number.  
This means that you can easily build CurrencyTextBoxes for a wide range of currencies without having to set a different value for each currency format.  
``fractional`` is still set to true, but it is set inside the constraints object instead of on the widget.

ValidationTextBoxes usually use Regular Expression validation, as in the following example:

The regular expression syntax comes directly from JavaScript.  
The start and ending qualifiers of the regular expression, ^ and $, are implicit - you do not need 
to include them.  This code demonstrates a ValidationTextBox that only accepts a 5 digit zip code.

ValidationTextBox also supports functions that generate regular expressions.  Having a generating function enables you to write much more dynamic Web applications.  ValidationTextBox passes its constraints object to the generating function.  The following code demonstrates a dynamic ValidationTextBox that only accepts a 5 digit zip code after 5:00PM, and only accepts a county name before then.
