#format dojo_rst

dijit.form.CheckBox
===================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Nikolai Onken
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

**dijit.form.CheckBox** is nearly the same as an HTML checkbox, but with fancy styling.

=====
Usage
=====

CheckBox widgets in dijit are very intuitive and easy to use. Markup constructs for check boxes resemble the same as HTML but dojo provides more control and styling options than a conventional check box.

Conceptually, native HTML checkboxes have 2 separate values; the first being the boolean checked state, and the second being the text value that is submitted with the containing FORM element if the checked state is true. To resolve this dichotomy, the *value* of a CheckBox widget is false when unchecked, but the text value when checked. Setting the *value* to true will check the box (but leave the submittable text string unchanged) while false will uncheck it. Setting the *value* to a text string will check the box and set the value to be submitted to the indicated text string.


========
Examples
========

Programmatic example
--------------------

Let's create a checkbox programatically, initially unchecked:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.CheckBox");
    dojo.addOnLoad(function(){
      var checkBox = new dijit.form.CheckBox({
        name: "checkBox",
        value: "agreed",
        checked: false,
        onChange: function(b){ alert('onChange called with parameter = ' + b + ', and widget value = ' + checkBox.attr('value') ); }
      }, "checkBox");
    });
    </script>

  .. cv:: html
 
    <input id="checkBox"> <label for="checkBox">I agree</label>

Declarative example
-------------------

Let's create a checkbox with HTML markup, initially checked:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.CheckBox");
    </script>

  .. cv:: html
 
    <input id="mycheck" name="mycheck" dojoType="dijit.form.CheckBox" value="agreed" checked onChange="alert('onChange called with parameter = ' + arguments[0] + ', and widget value = ' + dijit.byId('mycheck').attr('value'))"> <label for="mycheck">I agree</label>


=============
Accessibility
=============

Keyboard
--------

+----------------------------+-----------------+
| **Action**                 | **Key**         |
+----------------------------+-----------------+
| Navigate to a checkbox     | Tab             |
+----------------------------+-----------------+
| Toggle checked state       | Spacebar        | 
+----------------------------+-----------------+

Checkboxes and Radio buttons are implemented using the standard input type=checkbox and type=radio elements respectively. CSS is used to overlay the unique theme over the actual input elements. Thus, the keyboard behavior of checkboxes and radio buttons mimics the behavior in the browser.
