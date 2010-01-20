#format dojo_rst

dijit.TooltipDialog
===================

:Authors: Bill Keese, Nikolai Onken, Marcus Reimann
:Available: since V0.9

.. contents::
    :depth: 2

A variant on Dialog Box is dijit.TooltipDialog.


============
Introduction
============

The dijit.TooltipDialog displays a tooltip that contains form elements (like a dialog).

Although both Dialog and TooltipDialog are modal, TooltipDialog can be closed by clicking anywhere on the screen, whereas for Dialog you must click on the [x] mark of the Dialog.

A TooltipDialog can only be opened as a drop down from another widget, usually `dijit.form.DropDownButton`.


========
Examples
========

Programmatic example
--------------------

The first example shows how to create a TooltipDialog and DropDownButton programmatically.

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
          dojo.require("dijit.form.DropDownButton");
          dojo.require("dijit.TooltipDialog");
          dojo.require("dijit.form.TextBox");
          dojo.require("dijit.form.Button");

          dojo.addOnLoad(function(){
            var dialog = new dijit.TooltipDialog({
               content:
                 '<label for="name">Name:</label> <input dojoType="dijit.form.TextBox" id="name" name="name"><br>' +
                 '<label for="hobby">Hobby:</label> <input dojoType="dijit.form.TextBox" id="hobby" name="hobby"><br>' +
                 '<button dojoType="dijit.form.Button" type="submit">Save</button>'
            });
 
            var button = new dijit.form.DropDownButton({
                label: "show tooltip dialog",
                dropDown: dialog
            });
            dojo.byId("dropdownButtonContainer").appendChild(button.domNode);
	 });
       </script>

  .. cv:: html

    <div id="dropdownButtonContainer"></div>


Declarative markup
------------------

As usual you can create the TooltipDialog and DropDown button widget declaratively using the dojoType attribute.
When created declaratively the DropDownButton node has two children, one for the label of the button,
and the other for the drop-down widget that's displayed when you press the button.

Here's one displaying a TooltipDialog:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.DropDownButton");
      dojo.require("dijit.TooltipDialog");
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.Button");
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


=============
Accessibility
=============

Keyboard
--------

============================================================    =================================================
Action                                                          Key
============================================================    =================================================
Navigate to next focusable element in the tooltip dialog	tab
Navigate to previous focusable element in the tooltip dialog	shift-tab
Close the tooltip dialog                                        escape
============================================================    =================================================

See the detailed Keyboard Navigation Notes and Known Issues in `dijit.Dialog <dijit/Dialog#accessibility>`_
