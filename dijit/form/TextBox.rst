#format dojo_rst

dijit.form.TextBox
==================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Nikolai Onken, Marcus Reimann, Craig Riecke
:Developers: Doug Hays, Bill Keese
:Available: since V1.0

.. contents::
    :depth: 2

TextBox is a basic <input type="text">-style form control. It has rudimentary text-scrubbing functions that trim or proper-casify text, but
it does not validate the entered text. Like all Dijit controls, TextBox inherits the design theme, so it's better to use this than an
HTML control, even if you don't have to do any input scrubbing. However:

* If the input is a number, use `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_ or `dijit.form.NumberSpinner <dijit/form/NumberSpinner>`_.
  These boxes ensure only digits, decimal points and group separators (specific to the locale) are entered.
* If the input is currency, use `dijit.form.CurrencyTextBox <dijit/form/CurrencyTextBox>`_ instead.
* If the input is a date, use `dijit.form.DateTextBox <dijit/form/DateTextBox>`_ which validates date input according to the locale, and
  adds a little pop-up calendar for easy selection.
* If the input is a time, use `dijit.form.TimeTextBox <dijit/form/TimeTextBox>`_ which features a scrolling day-planner-like time chooser.
* If the input is a list of values, use `dijit.form.FilteringSelect <dijit/form/FilteringSelect>`_. If you'd like to include free-form values too, 
  use `dijit.form.ComboBox <dijit/form/ComboBox>`_. These two look like <select> controls but can use Dijit TextBox attributes as well.
* If text can be validated with a regular expression, use `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_.


========
Examples
========

Declarative example
-------------------

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

Sizing a text box is done through the CSS width on the text box dom node.  Typically this is done by specifying the width in ems.  Please see the following for an example:

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dijit.form.TextBox");

      function init() {
        var box = dijit.byId("progBox");
        dojo.style(box.domNode, "width", "5em");
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html

    <b>A default textbox:</b> <div dojoType="dijit.form.TextBox"></div>
    <br>
    <b>A large textbox:</b> <div style="width: 50em;" dojoType="dijit.form.TextBox"></div>
    <br>
    <b>A small textbox:</b> <div style="width: 10em;" dojoType="dijit.form.TextBox"></div>
    <br>

    <b>A programmatically sized textbox:</b> <div id="progBox" dojoType="dijit.form.TextBox"></div>
    <br>


  .. cv:: css

    <style type="text/css">
    </style>



Getting and Manipulating the Value
----------------------------------

Getting and manipulating the value is a trivial matter.  It is done through the attr() function of the widget.  Please see the following example for more detail:

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dijit.form.TextBox");

      function init() {
        var box0 = dijit.byId("value0Box");
        var box1 = dijit.byId("value1Box");
        box1.attr("value", box0.attr("value") + " modified");
        dojo.connect(box0, "onChange", function(){
           box1.attr("value", box0.attr("value") + " modified");
        });
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html

    <b>A textbox with a value:</b> <input id="value0Box" dojoType="dijit.form.TextBox" value="Some value" intermediateChanges="true"></input>
    <br>
    <b>A textbox set with a value from the above textbox:</b> <input id="value1Box" dojoType="dijit.form.TextBox"></input>
    <br>

  .. cv:: css

    <style type="text/css">
    </style>



=============
Accessibility
=============

Keyboard
--------

The TextBox widget uses native HTML INPUT (type=text) controls.
