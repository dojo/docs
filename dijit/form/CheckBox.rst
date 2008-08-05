#format dojo_rst

dijit.form.CheckBox
===================

CheckBoxes in dijit are very intuitive and easy to use. Markup constructs for check boxes is the same as html but dojo provides more control and styling options than a conventional check box. The following example creates a CheckBox:

Examples
--------

Lets create a checkbox programatically

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.CheckBox");
    dojo.addOnLoad(function(){
      var checkBox = new dijit.form.CheckBox({
        id: "checkBox"
      }, "checkBox");
    });
    </script>

  .. cv:: html
 
    <input type="checkbox" id="checkBox" value="true" /><label for "checkBox">I agree</label>
