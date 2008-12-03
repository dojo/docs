#format dojo_rst

dijit.TooltipDialog
===================

:Status: Draft
:Version: 1.2

A variant on Dialog Box is dijit.TooltipDialog. This displays the dialog box contents in a Tooltip

Although both Dialog and TooltipDialog are modal, TooltipDialog can be closed by clicking anywhere on the screen, whereas for Dialog you must click on the [x] mark of the Dialog.

Note: TooltipDialog can only be used, in it's current state, with the button drop down style

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
                 '<button dojoType="dijit.form.Button" type="submit">Save</button>'
            });
 
            var button = new dijit.form.DropDownButton({
                label: "hello!",
                 dropDown: dialog
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
         <label for="name2">Name:</label> <input dojoType="dijit.form.TextBox" id="name2" name="name2"><br>
         <label for="hobby2">Hobby:</label> <input dojoType="dijit.form.TextBox" id="hobby2" name="hobby2"><br>
         <button dojoType="dijit.form.Button" type="submit">Save</button>
      </div>
    </div>

It is also possible to display a dijit.TooltipDialog without a button.  This example shows how to display one when using the onmouseover event of a span element.

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
          dojo.require("dijit.form.Button");
          dojo.require("dijit.Dialog");
          dojo.require("dijit.form.TextBox");
          var dialog; // scoped globally so it can be closed
          dojo.addOnLoad(function(){
            dialog = new dijit.TooltipDialog({
               content:
                 '<label for="name">Name:</label> <input dojoType="dijit.form.TextBox" id="name" name="name"><br>' +
                 '<label for="hobby">Hobby:</label> <input dojoType="dijit.form.TextBox" id="hobby" name="hobby"><br>' +
                 '<button dojoType="dijit.form.Button" type="submit" onClick="dijit.popup.close(dialog)">Save</button>'
            });
 
            dojo.byId("target").onmouseover = function(e){
                dijit.popup.open({
                    popup: dialog,
                    around: e.target
                });
            };
	 });
       </script>

  .. cv:: html

    <span id="target">Hover over me to display a dijit.TooltipDialog</span>

Accessibility
-------------

Keyboard
~~~~~~~~

============================================================    =================================================
Action                                                          Key
============================================================    =================================================
Navigate to next focusable element in the tooltip dialog	tab
Navigate to previous focusable element in the tooltip dialog	shift-tab
Close the tooltip dialog                                        escape
============================================================    =================================================

See the detailed Keyboard Navigation Notes and Known Issues in `dijit.Dialog <dijit/Dialog#accessibility>`_
