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

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.TextBox");
     </script>

  .. cv:: html

        <input type="text" name="firstname" value="testing testing"
		dojoType="dijit.form.TextBox"
		trim="true" id="firstname"
		propercase="true">
        <label for="firstname">Auto-trimming, Proper-casing Textbox:</label>

  
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
