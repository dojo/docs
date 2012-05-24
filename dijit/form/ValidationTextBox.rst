.. _dijit/form/ValidationTextBox:

============================
dijit/form/ValidationTextBox
============================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Craig Riecke
:Project owners: Doug Hays, Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

Introduction
============

A ValidationTextBox is an <input>-like widget that checks to make sure the user's input is valid (according to a specified criterion).
It flags invalid input by changing the box color, showing an icon, and displaying a tooltip detailing the error.

Note that a ValidationTextBox by itself *will not* prevent invalid entries from submission.
To ensure they're not, simply surround your form with a :ref:`dijit/form/Form <dijit/form/Form>` widget.


Usage
=====

The following attributes can be specified when you create a ValidationTextBox:

================  =============  ======================================================================
Parameter         Type           Description
================  =============  ======================================================================
required          boolean        Whether the field is required or not. false by default.
promptMessage     String         Tooltip text that appears when the text box is empty and on focus. Null by default.
invalidMessage    String         Tooltip text that appears when the content of the text box is invalid.
missingMessage    String         Tooltip text that appears when the content of the text box is empty and the field is required.
constraints       Object         Holds constraints (like min and max values) for use in subclasses of ValidationTextBox.
regExp            RegExp         Regular expression pattern to be used for validation. If this is used, do not use regExpGen.
regExpGen         function       Function that should return a string representing the body of a regular expression; see the String.replace() format. If this is used, do not use regExp.
tooltipPosition   String         Define where Tooltip will appear.
================  =============  ======================================================================
 
Methods:

isValid()
    Method that calls validator function.
validator()
    Method that determines whether the content of the text box is valid. Called at these events: onblur, oninit, onkeypress. See also: :ref:`tips <dijit/form/ValidationTextBox-tricks>`.
displayMessage()
    Method that displays validation errors or prompt messages. Uses dijit/Tooltip by default.


Examples
========

Declarative example
-------------------

ValidationTextBox widgets usually use Regular Expression validation, as in the following example:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/ValidationTextBox"]);

  .. html ::

    <label for="phone">Phone number, no spaces:</label>
    <input type="text" name="phone" id="phone" value="someTestString" required="true"
        data-dojo-type="dijit/form/ValidationTextBox"
        data-dojo-props="regExp:'[\\w]+', invalidMessage:'Invalid Non-Space Text.'" />

Using regular expressions
-------------------------

The regular expression syntax comes directly from JavaScript.
The start and ending qualifiers of the regular expression, ^ and $, are implicit - you do not need to include them.
This code demonstrates a ValidationTextBox that only accepts a 5 digit zip code.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/ValidationTextBox"]);

  .. html ::

    <label for="zip">Also 5-Digit U.S. Zipcode only:</label>
    <input type="text" name="zip" value="00000" required="true"
        data-dojo-type="dijit/form/ValidationTextBox"
        data-dojo-props="regExp:'\\d{5}', invalidMessage:'Invalid zip code.'" />

Generate regular expressions
----------------------------

ValidationTextBox also supports functions that generate regular expressions.
Having a generating function enables you to write much more dynamic Web applications.
ValidationTextBox passes its constraints object to the generating function.
The following code demonstrates a dynamic ValidationTextBox that only accepts a 5 digit zip code after 5:00PM, and only accepts a county name before then.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/ValidationTextBox"]);

    var after5 = function(constraints){
        var date = new Date();
        if(date.getHours() >= 17){
            return "\\d{5}";
        }else{
            return "\\D+";
        }
    }

  .. html ::

    <label for="zip2">Also 5-Digit U.S. Zipcode only:</label>
    <input type="text" name="zip" value="00000" id="zip2" required="true"
        data-dojo-type="dijit/form/ValidationTextBox"
        data-dojo-props="regExpGen:after5, invalidMessage:'Zip codes after 5, county name before then.'" />


Accessibility
=============

Keyboard
--------

The ValidationTextBox widget uses native HTML INPUT (type=text) controls.

Screen Readers
--------------

If an invalid value is entered into a validating Text Box the "state" of the Text box changes, i.e.
its background color changes.
To accommodate users who are blind, the Text Box's :ref:`ARIA state <quickstart/writingWidgets/a11y>`
is changed to "invalid" so a screen reader can notify the screen reader user.
In addition to the "state" change, a pop-up appears.
When the pop-up appears screen readers should read the contents of the pop-up.
The pop-up text comes from the "invalidMessage" parameter.

Known Issues
------------

Sometimes the popup message supplied by invalidMessage attribute may be unnecessary.
For example, omitting a required field already displays an icon when the cursor leaves the field.
In these cases you can omit the "invalidMessage" parameter,
but keep in mind that good labels and instructions are still necessary for accessibility,
i.e. if the invalid popup will not be displayed then there must be clear instructional text indicating the field is required.

As of the Dojo 1.0 release and beyond: Window-Eyes 6.1 speaks "read only" for fields that have been marked with the ARIA property invalid=true even though the field is still editable.

See also
========

* :ref:`Tips, tricks and edge cases for dijit/form/ValidationTextBox <dijit/form/ValidationTextBox-tricks>`.
