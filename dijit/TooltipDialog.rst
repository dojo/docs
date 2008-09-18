#format dojo_rst

dijit.TooltipDialog
===================

:Status: Draft
:Version: 1.2

A variant on Dialog Box is dijit.TooltipDialog. This displays the dialog box contents in a Tooltip

Although both Dialog and TooltipDialog are modal, TooltipDialog can be closed by clicking anywhere on the screen, whereas for Dialog you must click on the [x] mark of the Dialog.


Examples
--------

The first example shows how to create a TooltipDialog and DropDownButton programmatically.

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
          dojo.addOnLoad(function(){
            var dialog = new dijit.TooltipDialog({
               content:
                 '<label for="name">Name:</label> <input dojoType="dijit.form.TextBox" id="name" name="name"><br>' +
                 '<label for="hobby">Hobby:</label> <input dojoType="dijit.form.TextBox" id="hobby" name="hobby"><br>' +
                 '<button dojoType="dijit.form.Button" type="submit">Save</button>});',
               parseWidgets: true
            };
 
            var button = new dijit.form.DropDownButton({
                label: "hello!",
                name: "programmatic2",
                dropDown: dialog,
                id: "progButton"
            });
            dojo.byId("dropdownButtonContainer").appendChild(button.domNode);
	 });
       </script>

  .. cv:: html

    <div id="dropdownButtonContainer"></div>

As usual you can create the TooltipDialog and DropDown button widget declaratively using the dojoType attribute.
When created declaratively the DropDownButton node has two children, one for the label of the button,
and the other for the drop-down widget that's displayed when you press the button.

Here's one displaying a TooltipDialog:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Dialog");
      dojo.require("dijit.form.TextBox");
    </script>

  .. cv:: html

    <div dojoType="dijit.form.DropDownButton">
      <span>Register</span>
      <div dojoType="dijit.TooltipDialog">
         <label for="name">Name:</label> <input dojoType="dijit.form.TextBox" id="name" name="name"><br>
         <label for="hobby">Hobby:</label> <input dojoType="dijit.form.TextBox" id="hobby" name="hobby"><br>
         <button dojoType="dijit.form.Button" type="submit">Save</button>
      </div>
    </div>
