.. _dijit/form/TextBox:

==================
dijit/form/TextBox
==================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Nikolai Onken, Marcus Reimann, Craig Riecke
:Developers: Doug Hays, Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

TextBox is a basic <input type="text">-style form control.

Introduction
============

dijit/form/TextBox has rudimentary text-scrubbing functions that trim or proper-casify text, but
it does not validate the entered text.
Like all Dijit controls, TextBox inherits the design theme, so it's better to use this than an
HTML control, even if you don't have to do any input scrubbing.
However:

* If the input is a number, use :ref:`dijit/form/NumberTextBox <dijit/form/NumberTextBox>` or :ref:`dijit/form/NumberSpinner <dijit/form/NumberSpinner>`.
  These boxes ensure only digits, decimal points and group separators (specific to the locale) are entered.
* If the input is currency, use :ref:`dijit/form/CurrencyTextBox <dijit/form/CurrencyTextBox>` instead.
* If the input is a date, use :ref:`dijit/form/DateTextBox <dijit/form/DateTextBox>` which validates date input according to the locale, and
  adds a little pop-up calendar for easy selection.
* If the input is a time, use :ref:`dijit/form/TimeTextBox <dijit/form/TimeTextBox>` which features a scrolling day-planner-like time chooser.
* If the input is a list of values, use :ref:`dijit/form/FilteringSelect <dijit/form/FilteringSelect>`. If you'd like to include free-form values too,
  use :ref:`dijit/form/ComboBox <dijit/form/ComboBox>`. These two look like <select> controls but can use Dijit TextBox attributes as well.
* If text can be validated with a regular expression, use :ref:`dijit/form/ValidationTextBox <dijit/form/ValidationTextBox>`.


Examples
========

Declarative example
-------------------

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/TextBox"]);

  .. html ::

    <label for="firstname">Auto-trimming, Proper-casing Textbox:</label>
    <input type="text" name="firstname" value="testing testing"
        data-dojo-type="dijit/form/TextBox"
        data-dojo-props="trim:true, propercase:true" id="firstname">

  
Sizing TextBoxes
----------------

Sizing a text box is done through the CSS width on the text box dom node.
Typically this is done by specifying the width in ems.
Please see the following for an example:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/TextBox"]);

  .. html ::

    <label for="dtb">A default textbox:</label> <input id="dtb" data-dojo-type="dijit/form/TextBox">
    <br>
    <label for="ltb">A large textbox:</label> <input id="ltb" style="width: 50em;" data-dojo-type="dijit/form/TextBox">
    <br>
    <label for="stb">A small textbox:</label> <input id="stb" style="width: 10em;" data-dojo-type="dijit/form/TextBox">
    <br>


To programmatically size a textbox you would do:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/parser", "dijit/registry", "dojo/dom-style", "dijit/form/TextBox", "dojo/domReady!"],
            function(parser, registry, domStyle){

        parser.parse();

        var box = registry.byId("firstname");
        domStyle.set(box.domNode, "width", "5em");
    });

  .. html ::

    <input data-dojo-type="dijit/form/TextBox" id="firstname">

Getting and Manipulating the Value
----------------------------------

Getting and manipulating the value is a trivial matter.
It is done through the set() and get() functions of the widget.
Please see the following example for more detail:

.. code-example ::
  :djConfig: parseOnLoad: false

  .. js ::

    require(["dojo/parser", "dijit/registry", "dojo/on", "dijit/form/TextBox", "dojo/domReady!"],
            function(parser, registry, on){
        parser.parse();
        var box0 = registry.byId("value0Box");
        var box1 = registry.byId("value1Box");
        box1.set("value", box0.get("value") + " modified");
        on(box0, "change", function(){
             box1.set("value", box0.get("value") + " modified");
        });
    });

  .. html ::

    <label for="value0Box">A textbox with a value:</label> <input id="value0Box" data-dojo-type="dijit/form/TextBox" value="Some value" data-dojo-props="intermediateChanges:true"></input>
    <br>
    <label for="value1Box">A textbox set with a value from the above textbox:</label> <input id="value1Box" data-dojo-type="dijit/form/TextBox"></input>
    <br>

Using the placeholder parameter
-------------------------------

Coming with Dojo 1.5 the HTML5 placeholder parameter (also known as a "hint") has been implemented for all TextBox based widgets.
Placeholder is gray example or hint text that the widget displays inside the input area of empty form fields, such as "John Doe" or "Your Name".
The text disappears when the user focuses the field.

In order to use it, submit a parameter "placeHolder" to your widget:

.. code-example::

  .. js ::

    require(["dijit/form/TextBox", "dojo/domReady!"], function(TextBox){
        var myTextBox = new dijit.form.TextBox({
            name: "firstname",
            value: "" /* no or empty value! */,
            placeHolder: "type in your name"
        }, "firstname");
    });

  .. html ::

    <input id="firstname">



Accessibility
=============

Keyboard
--------

The TextBox widget uses native HTML INPUT (type=text) controls.
