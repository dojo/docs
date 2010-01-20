#format dojo_rst

dijit.form.RadioButton
======================

:Authors: Becky Gibson, Doug Hays, Nikolai Onken
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

RadioButton widgets capture binary user-choices unlike buttons which normally perform some action when clicked. 

=====
Usage
=====

Normally, there are multiple RadioButton widgets assigned to a single group defined by widgets sharing the same *name* attribute. Upon FORM submission, the 1 checked RadioButton *value* is submitted using this shared *name*. 

**Note:** To use the RadioButton widget, you currently have to call dojo.require("dijit.form.CheckBox")


========
Examples
========

Programmatic and declarative example
------------------------------------

Let's create 2 RadioButton widgets, 1 programmatically and 1 declaratively. We'll wrap both inside a FORM to illustrate what happens on submit.

.. cv-compound::

  .. cv:: javascript
 
    <script type="text/javascript">
      dojo.require("dijit.form.CheckBox");

      dojo.addOnLoad(function(){
        var radioOne = new dijit.form.RadioButton({
          checked: true,
          value: "tea",
          name: "drink",
        }, "radioOne");
      });
    </script>

  .. cv:: html

    <form id="myform">
        <input type="radio" name="drink" id="radioOne" checked value="tea"/> <label for="radioOne">Tea</label> <br />
        <input type="radio" dojoType="dijit.form.RadioButton" name="drink" id="radioTwo" value="coffee"/> <label for="radioTwo">Coffee</label> <br />
    </form>
    <button onclick="with(dojo.byId('myform'))with(elements[0])with(elements[checked?0:1])alert(name+'='+value);return false">Show form submit value</button>


=============
Accessibility
=============

Keyboard
--------

+-----------------------------+---------------------+
| **Action**                  | **Key**             |
+-----------------------------+---------------------+
| Toggle checked state        | Spacebar            |
+-----------------------------+---------------------+
| Focus previous radio button | up or left arrow    |
+-----------------------------+---------------------+
| Focus next radio button     | down or right arrow |
+-----------------------------+---------------------+

**Note:**
Using the TAB key to focus a radio group will only focus the selected RadioButton in a group.

Radio buttons are implemented using the standard input type=checkbox and type=radio elements respectively. CSS is used to overlay the unique theme over the actual input elements. Thus, the keyboard behavior of checkboxes and radio buttons mimics the behavior in the browser.
