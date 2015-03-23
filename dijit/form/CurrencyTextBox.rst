.. _dijit/form/CurrencyTextBox:

==========================
dijit/form/CurrencyTextBox
==========================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Craig Riecke
:Developers: Doug Hays, Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

CurrencyTextBox widgets inherit all the attributes and behaviors of the :ref:`NumberTextBox <dijit/form/NumberTextBox>` widget, but are specialized for input monetary values, much like the currency type in spreadsheet programs.


Usage
=====

* The ``value`` attribute is a native JavaScript floating point number.

  This means that you can easily build CurrencyTextBox widgets for a wide range of currencies without having to set a different value for each currency format.

* The optional boolean ``fractional`` property of the ``constraints`` object attribute can be set to require/refuse fractional input.


Examples
========

Declarative example
-------------------

In this example using USD, both dollars and cents are required.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dijit/form/CurrencyTextBox", "dojo/parser", "dojo/domReady!"]);

  .. html ::

    <label for="income1">U.S. Dollars</label>
    <input type="text" name="income1" id="income1" value="54775.53" required="true"
        data-dojo-type="dijit/form/CurrencyTextBox"
        data-dojo-props="constraints:{fractional:true},
        currency:'USD',
        invalidMessage:'Invalid amount. Cents are required.'">



Programmatic example
--------------------

In this example using euros with German formatting, the invalid message contains a custom formatted example value.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dijit/form/CurrencyTextBox", "dojo/currency", "dojo/i18n!dojo/cldr/nls/de/currency", "dojo/i18n!dojo/cldr/nls/de/number", "dojo/domReady!"
    ], function(CurrencyTextBox, currency){
        var example = currency.format(54775.53, {locale: 'de-de', currency: "EUR"});
        var myCurrencyTextBox = new CurrencyTextBox({
            value: 54775.53,
            lang: 'de-de',
            currency: "EUR",
            invalidMessage: "Invalid amount.  Example: " + example
        }, "eurde");
        myCurrencyTextBox.startup();
    });

  .. html ::

    <label for="eurde">euros (lang: de-de):</label>
    <input id="eurde">EUR
        

Accessibility
=============

See the Accessibility Section in :ref:`dijit/form/ValidationTextBox <dijit/form/ValidationTextBox>`
