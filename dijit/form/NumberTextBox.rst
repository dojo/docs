.. _dijit/form/NumberTextBox:

========================
dijit/form/NumberTextBox
========================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Nikolai Onken, Marcus Reimann, Craig Riecke
:Developers: Doug Hays, Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

NumberTextBox widgets are used when user input is restricted to numeric input.


Introduction
============

By default, the widget will discover the appropriate locale and behavior as specified by Dojo.
For example, when using a NumberTextBox in the United States, an optional comma is used for the thousands separator and a period for a decimal separator when displaying numbers to the user.
For German users, a period is used for the thousands separator and a comma for the decimal separator.
Other locales may have different conventions.

When the user edits the value, or when sending data to the server,
or when retrieving the ``value`` attribute programmatically,
numbers are represented simply as JavaScript numbers, formatted with a period for decimal and no thousands separators.
This representation is unambiguous, so other applications may interact with this data without assuming any locale-specific behavior.
When specifying the ``constraints`` attribute, you have all the options available in the :ref:`Dojo constraint language <quickstart/numbersDates>`.

To further restrict/validate user input, this widget makes additional numeric ``constraints`` properties (``min`` and ``max``) available to the developer.

**Warning**: if you use programmatic creation without direct value, be sure to cast your value to ``Number`` (``value: Number(input.value)``) otherwise you'll get strange results (unformatted values and errors depending on locales).


Examples
========

Declarative example
-------------------

This example defines a ``min`` and ``max`` constraint and an initial value.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/NumberTextBox"]);

  .. html ::

    <label for="q05">Integer between -20000 to +20000:</label>
    <input id="q05" type="text"
        data-dojo-type="dijit/form/NumberTextBox"
        name= "elevation"
        required="true"
        value="3000"
        data-dojo-props="constraints:{min:-20000,max:20000,places:0},
        invalidMessage:'Please enter a numeric value.',
        rangeMessage:'Invalid elevation.'">


Programmatic example
--------------------

This example creates a simple NumberTextBox programmatically.
The fractional part can be 0 to 6 digits long.

.. code-example ::
  :djConfig: async: true

  .. js ::

    require(["dijit/form/NumberTextBox", "dojo/domReady!"], function(NumberTextBox){
        var myNumberTextBox = new NumberTextBox({
              name: "programmatic",
              constraints: {pattern: "0.######"}
        }, "programmatic");
        myNumberTextBox.startup();
    });

  .. html ::

     <label for="programmatic">Input any number with up to 6 fractional digits:</label>
     <input id="programmatic" type="text">



Formatting
----------
The ``constraints`` attribute can also contain formatting information.
The example below always makes sure that the field shows three digits after the decimal point, and has a +/- sign.
Try entering a simple value like "-3" and then tab away to see the effect.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

     require(["dojo/parser", "dijit/form/NumberTextBox"]);

  .. html ::

    <label for="zeroPadded">Fractional value:</label>
    <input id="zeroPadded" type="text"
        data-dojo-type="dijit/form/NumberTextBox"
        name= "decimal"
        value="0"
        constraints="{pattern: '+0.000;-0.000'}"
        required="true">
    <button>dummy button (tab to here)</button>

Accessibility
=============

See the Accessibility Section in :ref:`dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`
