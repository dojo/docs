#format dojo_rst

dijit.form.ToggleButton
=======================

:Authors: Doug Hays
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

ToggleButton widgets are a cross between `Button <dijit/form/Button>`_ and `Checkbox <dijit/form/CheckBox>`_ widgets. They are created like Button widgets, but like CheckBox widgets, they maintain a *checked* boolean attribute (settable/gettable) that toggles on each click action. Unlike CheckBox widgets however, ToggleButton widgets do not submit any value on FORM submit. They are used solely for client-side processing where the user can toggle between 2 states before performing some additional action. The CSS class "dijitToggleButtonChecked" is appended to the widget's outermost DOM node when the *checked* attribute is true to allow for custom styling.


========
Examples
========

Programmatic example
--------------------

Let's create a ToggleButton widget programatically, initially unchecked:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");
    dojo.addOnLoad(function(){
      new dijit.form.ToggleButton({
        showLabel: true,
        checked: false,
        onChange: function(val){this.attr('label',val)},
        label: "false" 
      }, "programmatic");
    });
    </script>

  .. cv:: html
 
    <button id="programmatic"><button>

Declarative example
-------------------

Now let's create a ToggleButton widget with HTML markup, initially checked:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html
 
    <button dojoType="dijit.form.ToggleButton" checked iconClass="dijitCheckBoxIcon">
        Toggle me
    </button>


=============
Accessibility
=============

Keyboard
--------

+----------------------------+-----------------+
| **Action**                 | **Key**         |
+----------------------------+-----------------+
| Navigate to a ToggleButton | Tab             |
+----------------------------+-----------------+
| Toggle checked state       | Spacebar        | 
+----------------------------+-----------------+

Known Issues
------------

* Running IE 8 in Windows with JAWS 10 the pressed/not pressed state of toggle buttons is not announced.  Since this works correctly in Firefox, I believe this is an IE 8 issue. 
