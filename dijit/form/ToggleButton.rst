#format dojo_rst

dijit.form.ToggleButton
=======================

ToggleButton widgets are a cross between Button and CheckBox widgets. They are created like Button widgets, but like CheckBox widgets, they maintain a *checked* boolean attribute (settable/gettable) that toggles on each click action.  Unlike CheckBox widgets however, ToggleButton widgets do not submit any value on FORM submit.  They are used solely for client-side processing where the user is toggle between 2 states.

Examples
--------

Programmatic example
~~~~~~~~~~~~~~~~~~~~

Let's create a ToggleButton widget programatically, initially unchecked:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");
    dojo.addOnLoad(function(){
      new dijit.form.ToggleButton({
        showLabel: true,
        checked: false,
        onChange: function(val){this.attr('label','checked: '+val)},
        label: "checked: false" 
      }, "toggle");
    });
    </script>

  .. cv:: html
 
    <button id="toggle"><button>

Declarative example
~~~~~~~~~~~~~~~~~~~

Now let's create a ToggleButton widget with HTML markup, initially checked:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html
 
    <button id=toggle dojoType="dijit.form.ToggleButton" checked iconClass="dijitCheckBoxIcon">
        Toggle me
    </button>


Accessibility
-------------

Keyboard
~~~~~~~~
+----------------------------+-----------------+
| **Action**                 | **Key**         |
+----------------------------+-----------------+
| Navigate to a ToggleButton | Tab             |
+----------------------------+-----------------+
| Toggle checked state       | Spacebar        | 
+----------------------------+-----------------+
