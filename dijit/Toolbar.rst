#format dojo_rst

dijit.Menu
==========

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors: Bill Keese

The Menu widget models a context menu, otherwise known as a right-click or popup menu, and they also appear in ComboButton and DropDownButton widgets.

MenuItem widgets are the actual items in the menu. The PopupMenuItem is like a MenuItem, but displays a submenu or other widget to the right . A PopupMenuItem always has two child nodes: a tag with the displayed label (usually in a SPAN tag), and a widget to be popped up, typically a dijit.Menu widget.

A programatically created menu
------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Menu");

      var pMenu;
      dojo.addOnLoad(function(){
            pMenu = new dijit.Menu({
                targetNodeIds:["prog_menu"]
            });
            pMenu.addChild(new dijit.MenuItem({
                label:"Simple menu item"
            }));
            pMenu.addChild(new dijit.MenuItem({
                label:"Disabled menu item",
                disabled: true
            }));
            pMenu.addChild(new dijit.MenuItem({
                label:"Menu Item With an icon",
                iconClass:"dijitEditorIcon dijitEditorIconCut",
                onClick: function(){alert('i was clicked')}
            }));
            pMenu.addChild(new dijit.CheckedMenuItem({
                label: "checkable menu item"
            }));
            pMenu.addChild(new dijit.MenuSeparator());

            var pSubMenu = new dijit.Menu({
                parentMenu: pMenu
            });
            pSubMenu.addChild(new dijit.MenuItem({
                label:"Submenu item"
            }));
            pSubMenu.addChild(new dijit.MenuItem({
                label:"Submenu item"
            }));
            pMenu.addChild(new dijit.PopupMenuItem({
                label:"Submenu",
                popup:pSubMenu
            }));

            pMenu.startup();
        });
    </script>

  .. cv:: html

    <span id="prog_menu">Right click me to get a menu</span>



Creation from markup is even easier.
This example creates a context menu for the whole window.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Menu");
      dojo.require("dijit.ColorPalette");
    </script>

  .. cv:: html

	<div dojoType="dijit.Menu" id="submenu1" contextMenuForWindow="true" style="display: none;">
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCut"
			onClick="alert('not actually cutting anything, just a test!')">Cut</div>
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCopy"
			onClick="alert('not actually copying anything, just a test!')">Copy</div>
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconPaste"
			onClick="alert('not actually pasting anything, just a test!')">Paste</div>
		<div dojoType="dijit.MenuSeparator"></div>
		<div dojoType="dijit.PopupMenuItem">
			<span>Enabled Submenu</span>
			<div dojoType="dijit.Menu" id="submenu2">
				<div dojoType="dijit.MenuItem" onClick="alert('Submenu 1!')">Submenu Item One</div>
				<div dojoType="dijit.MenuItem" onClick="alert('Submenu 2!')">Submenu Item Two</div>
			</div>
		</div>
		<div dojoType="dijit.PopupMenuItem">
			<span>Popup of something other than a menu</span>
			<div dojoType="dijit.ColorPalette"></div>
		</div>
	</div>

        <span> Click anywhere on the page to see this menu.</span>
