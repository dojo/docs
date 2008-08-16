#format dojo_rst

dijit.form.CheckBox
===================

CheckBoxes in dijit are very intuitive and easy to use. Markup constructs for check boxes is the same as html but dojo provides more control and styling options than a conventional check box. The following example creates a CheckBox:

Examples
--------

Lets create a checkbox programatically, initially unchecked:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.CheckBox");
    dojo.addOnLoad(function(){
      var checkBox = new dijit.form.CheckBox({
        id: "checkBox",
        checked: false,
        onChange: function(b){ alert('new value is ' + b); }
      }, "checkBox");
    });
    </script>

  .. cv:: html
 
    <input id="checkBox"> <label for="checkBox">I agree</label>
