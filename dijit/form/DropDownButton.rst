#format dojo_rst

dijit.form.DropDownButton
=========================

:Status: Draft
:Version: 1.2

The dijit.form.DropDownButton widget is for a button that displays some kind of drop down, often a menu, when you press it.

Examples
--------

The first example shows how to create a menu and drop down button programmatically.

.. cv-compound::

  .. cv:: javascript

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

As usual you can create the DropDown button widget declaratively using the dojoType attribute.
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

.
Note that DropDownButton is often used in `dijit.Toolbar </dijit/Toolbar>`_.
