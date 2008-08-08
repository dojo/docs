#format dojo_rst

dijit.form.RadioButton
======================

:Status: Draft
:Version: 1.2

dijit.form.RadioButton captures binary user-choices. Unlike command buttons, which do some action on being pressed, radio buttons are more for form data. 

Note: to use dijit.form.RadioButton you currently have to include dijit.form.CheckBox

Examples
--------

We'll enhance native radio buttons programatically

.. cv-compound::

  .. cv:: javascript
 
    <script type="text/javascript">
      dojo.require("dijit.form.CheckBox");

      dojo.addOnLoad(function(){
        var radioOne = new dijit.form.RadioButton({
          checked: true,
          id: "tea"
        }, "radioOne");
        
        var radioTwo = new dijit.form.RadioButton({
          id: "coffee"
        }, "radioTwo");
      });
    </script>
  .. cv:: html

    <input type="radio" name="group" id="radioOne" /> <label for="radioOne">Tea</label> <br />
    <input type="radio" name="group" id="radioTwo" /> <label for="radioTwo">Coffee</label> <br />
