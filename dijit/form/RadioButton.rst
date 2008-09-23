#format dojo_rst

dijit.form.RadioButton
======================

:Status: Draft
:Version: 1.2

RadioButton widgets capture binary user-choices unlike buttons which normally perform some action when clicked.  Normally, there are multiple RadioButton widgets assigned to a single group defined by widgets sharing the same *name* attribute.  Upon FORM submission, the 1 checked RadioButton *value* is submitted using this shared *name*. 

**Note:** To use the RadioButton widget, you currently have to call dojo.require("dijit.form.CheckBox")


Example
-------

Let's create 2 RadioButton widgets, 1 programmatically and 1 declaratively:

.. cv-compound::

  .. cv:: javascript
 
    <script type="text/javascript">
      dojo.require("dijit.form.CheckBox");

      dojo.addOnLoad(function(){
        var radioOne = new dijit.form.RadioButton({
          checked: true,
          value: "coffee",
          name: "drink",
        }, "radioOne");
      });
    </script>

  .. cv:: html

    <form id="myform">
        <input type="radio" name="drink" id="radioOne" checked value="tea"/> <label for="radioOne">Tea</label> <br />
        <input type="radio" dojoType="dijit.form.RadioButton" name="drink" id="radioTwo" /> <label for="radioTwo">Coffee</label> <br />
    </form>
    <button onclick="alert('drink = ' + dojo.byId('myform').elements[0].value); return false">Show form submit value</button>


Accessibility
-------------

Keyboard
~~~~~~~~
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
