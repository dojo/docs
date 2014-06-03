.. _dojo/number:

===========
dojo/number
===========


.. contents ::
  :depth: 2


Introduction
============

**dojo/number** contains methods for user presentation of JavaScript Number objects: formatting, parsing, and rounding.

Formatting and parsing are done in a locale-sensitive manner, using culturally appropriate patterns for representing group 
(thousands) and decimal separators, percent signs, etc.  This module forms the basis of dojo.currency, which uses similar 
methods but adds support for currency symbols and alters the pattern as appropriate.

Usage
=====

Similar to :ref:`dojo/date/locale <dojo/date/locale>`, ``dojo/number`` uses the Unicode.org Common Locale Data Repository in 
``dojo/cldr`` to look up culturally-sensitive data to interact with users.  An American user would expect the number one-
million to two decimal places to be represented as "1,000,000.00".  A German user would expect to see "1.000.000,00" and a 
French user would expect to see "1 000 000,00".  In India, there are thousands separators and hundreds place separators beyond 
that, so the appropriate formatted string would read "10,00,000.00".

format()
--------

.. js ::

  require(["dojo/number"], function(number){
    // Returns a string, in locale format, with 2 decimal places
    var num = number.format(1000000, {
      places: 2
    });
  });

The locale set in ``dojoConfig`` will determine how the number is formatted.  Custom formats may be specified to override the 
localized convention by passing in an option of ``pattern``:

.. js ::

  require(["dojo/number"], function(number){
    var num = number.format(123, {
      pattern: "00000"
    });
    // num = "00123"
  });

The pattern string is constructed according to the Unicode CLDR specifications, which uses a convention similar to Java's
NumberFormat.

parse()
-------

``parse()`` is the inverse operation of ``format()``:

.. js ::

  require(["dojo/number"], function(number){
    // Returns a number = 1000000
    var num = number.parse("1,000,000.00", {
      places: 2
    });
  });

round()
-------

``round()`` attempts to overcome some of the shortcomings of the intrinsic JavaScript rounding methods, ``Math.round()`` and 
``Number.toFixed()``, allowing arbitrary increments in rounding to any number of places, and making adjustments for browser 
quirks.  In addition ``round()`` works around a bug in Internet Explorer (through version 8) with ``Number.toFixed()``:

.. js ::

  // Outputs "0.0" in IE
  // Outputs "1.0" in other browsers
  console.log((0.9).toFixed());

regexp()
--------

Examples
========

.. code-example ::
  :djConfig: async: true

  Demonstrates the capabilities of ``format()`` and ``parse()``.

  .. js ::

    require(["dojo/number", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(number, dom, on){
      on(dom.byId("formatButton"), "click", function(){
        var val = dom.byId("format").value,
            locale = dom.byId("locale").value;
        var out = number.format(val, {
              places: 2,
              locale: locale
            });

        dom.byId("formatOut").innerHTML = out;
      });

      on(dom.byId("parseButton"), "click", function(){
        var val = dom.byId("parse").value,
            locale = dom.byId("locale").value;
        var out = number.parse(val, {
              places: 2,
              locale: locale
            });

        dom.byId("parseOut").innerHTML = out;
      });
    });

  .. html ::

    <label for="locale">Locale:</label>
    <select name="locale" id="locale">
      <option value="en-us" selected="selected">en-us</option>
      <option value="fr-fr">fr-fr</option>
      <option value="de-de">de-de</option>
    </select><br /><br />
    <input name="format" id="format" type="text" value="1000000" />
    <button type="button" id="formatButton">format()</button>
    Output: <span id="formatOut" class="out"></span><br /><br />
    <input name="parse" id="parse" type="text" value="1,000,000.00" />
    <button type="button" id="parseButton">parse()</button>
    Output: <span id="parseOut" class="out"></span>

  .. css ::

    .out{ font-weight: bold; color: blue; }

See Also
========

* :ref:`dojo/currency <dojo/currency>`

TODO: add references to CLDR, setting locale in Dojo, binary floating point issues
