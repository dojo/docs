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

================  ==============================  ======================================================================
Parameter         Type                            Description
================  ==============================  ======================================================================
required          boolean                         Whether the field is required or not. false by default.
promptMessage     String                          Tooltip text that appears when the text box is empty and on focus. Null by default.
invalidMessage    String                          Tooltip text that appears when the content of the text box is invalid.
missingMessage    String                          Tooltip text that appears when the content of the text box is empty and the field is required.
constraints       Object                          Holds constraints (like min and max values) for use in subclasses of ValidationTextBox.
pattern           String | function               Regular expression pattern to be used for validation or a function that should return a string representing the body of a regular expression. '^' and '$' are automatically added to the regular expression.
tooltipPosition   String                          Define where Tooltip will appear.
================  ==============================  ======================================================================
 
Methods:

isValid()
    Method that calls validator function.
validator()
    Method that determines whether the content of the text box is valid. Called at these events: onblur, oninit, onkeypress.
displayMessage()
    Method that displays validation errors or prompt messages. Uses dijit/Tooltip by default.


Examples
========

Using regular expressions
-------------------------

When using the 'pattern' property, regular expressions are used to validate input.
The start and ending qualifiers of the regular expression, ^ and $, are implicit - you do not need to include them.

Declarative example
-------------------

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/ValidationTextBox"]);

  .. html ::

    <label for="zipCode">Zip code:</label>
    <input type="text" name="zipCode" id="zipCodeTextBox" value="" required="true"
        data-dojo-type="dijit/form/ValidationTextBox"
        data-dojo-props="pattern:'\\d{5}', invalidMessage:'Not a valid zipcode.'">


Programmatic example
--------------------

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dijit/form/ValidationTextBox", "dojo/domReady!"], function(ValidationTextBox) {
      var ipAddrTextBox = new ValidationTextBox({
        pattern: "(\\d{1,3}\\.){3}\\d{1,3}",
        required: true,
        invalidMessage: "Not a valid IP address"
      }, "ipAddress");
    });

  .. html ::

    <label for="ipAddress">IP Address:</label>
    <input type="text" name="ipAddress" id="ipAddress" value="">


Generate regular expressions
----------------------------

The pattern property also accepts a function that generates the body of a regular expression. In the example below the function will return a pattern validating IPv4 or IPv6 addresses depending on the value of a drop-down.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require([
      "dijit/form/ValidationTextBox",
      "dijit/form/Select",
      "dojo/domReady!"
    ], function(ValidationTextBox, Select) {
      var addressTypeSelect = new Select({}, "ipType");
      var ipAddrTextBox = new ValidationTextBox({
        required: true,
        pattern: function () {
          if (addressTypeSelect.get("value") === "v4") {
            return "(\\d{1,3}\\.){3}\\d{1,3}";
          } else {
            return "([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}"
          }
        },
        invalidMessage: "Not a valid IP address."
      }, "ipAddress");
      addressTypeSelect.on("change", function() {
        ipAddrTextBox.validate();
      });
    });



  .. html ::

    <label for="ipAddress">IP Address:</label>
    <select id="ipType" name="ipType">
      <option value="v4" selected>IPv4</option>
      <option value="v6">IPv6</option>
    </select>
    <input type="text" name="ipAddress" value="" id="ipAddress">

Using a validator function
--------------------------
Input can also be validated by providing a custom validator function. The example below is a less naive IP address validator than the example above.
Because the validator function is called on every key press, it should not contain resource or time intensive logic.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dijit/form/ValidationTextBox", "dojo/domReady!"], function(ValidationTextBox) {
      var ipAddressTextBox = new ValidationTextBox({
        validator: function(value) {
          var isValid = true;
          if (/^(\d{1,3}\.){3}\d{1,3}$/.test(value)) {
            value.split(".").forEach(function(octet) {
              if (parseInt(octet) > 255) {
                isValid = false;
              }
            });
          } else {
            isValid = false;
          }
          return isValid;
        },
        required: true,
        invalidMessage: "Not a valid IP address."
      }, "ipAddress");
    });

  .. html ::

    <label for="ipAddress">IP Address:</label>
    <input type="text" name="ipAddress" id="ipAddress" value="">


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
