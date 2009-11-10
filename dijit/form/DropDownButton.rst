#format dojo_rst

dijit.form.DropDownButton
=========================

:Status: Draft
:Version: 1.0
:Authors: Becky Gibson, Doug Hays, Bill Keese
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

The dijit.form.DropDownButton widget is for a button that displays some kind of drop down, often a menu, when you press it.


========
Examples
========

Programmatic example
--------------------

The first example shows how to create a menu and drop down button programmatically.

.. cv-compound::

  .. cv:: javascript

        <script type="text/javascript">
          dojo.require("dijit.form.Button");
          dojo.require("dijit.Menu");
        </script>
	<script type="text/javascript">
          dojo.addOnLoad(function(){
            var menu = new dijit.Menu({ style: "display: none;"});
            var menuItem1 = new dijit.MenuItem({
                label: "Save",
                iconClass:"dijitEditorIcon dijitEditorIconSave",
                onClick: function(){ alert('save'); }
            });
            menu.addChild(menuItem1);

            var menuItem2 = new dijit.MenuItem({
                label: "Cut",
                iconClass:"dijitEditorIcon dijitEditorIconCut",
                onClick: function(){ alert('cut'); }
            });
            menu.addChild(menuItem2);

            var button = new dijit.form.DropDownButton({
                label: "hello!",
                name: "programmatic2",
                dropDown: menu,
                id: "progButton"
            });
            dojo.byId("dropdownButtonContainer").appendChild(button.domNode);
	 });
       </script>

  .. cv:: html

    <div id="dropdownButtonContainer"></div>

Declarative example
-------------------

As usual you can create the DropDown button widget declaratively using the dojoType attribute.
When created declaratively the DropDownButton node has two children, one for the label of the button,
and the other for the drop-down widget that's displayed when you press the button.

Here's one displaying a `TooltipDialog <dijit/TooltipDialog>`_:

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

Note that DropDownButton is often used in `dijit.Toolbar </dijit/Toolbar>`_.


=============
Accessibility
=============

Keyboard
--------

=========================================================    =================================================
Action                                                       Key
=========================================================    =================================================
Navigate to a button                                         tab - all buttons are in the tab order
Activate the button to display the drop down menu            enter or space key
Close an open drop down                                      escape key - focus returns to button
With drop down open, navigate to the next element on page    tab will close drop down and set focus back to the button, tab again to navigate
                                                             to next element
=========================================================    =================================================

Known Issues
------------

High Contrast Mode
~~~~~~~~~~~~~~~~~~

All buttons should include a label parameter with text for the button even if the showLabel parameter is set to false. The label parameter is used to identify the button in high contrast mode when the icon for the button will no longer be displayed and is also used to identify the button to a screen reader.

Screen Reader
~~~~~~~~~~~~~

In order to identify the button description to the screen reader, all buttons should include a label parameter even if the showLabel parameter is set to false.

Even though the dropdown buttons are marked with the ARIA haspopup property, the screen readers do not indicate this to the user in Firefox 2. In Firefox 3 the dropdown and combo buttons are announced as "menu button".
