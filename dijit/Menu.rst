#format dojo_rst

dijit.Menu
==========

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors: Bill Keese
:jsDoc: http://api.dojotoolkit.org/jsdoc/1.3/dijit.Menu

The Menu widget is used for three types of menus:

  * context menu, typically otherwise known as a right-click or popup menu
  * drop down menu from `dijit.form.ComboButton <dijit/form/ComboButton>`_, `dijit.form.DropDownButton <dijit/form/DropDownButton>`_, and `dijit.MenuBar <dijit/MenuBar>`_ widgets.
  * statically positioned menu on the screen, typically a left-hand-side navigation menu

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

            var pSubMenu = new dijit.Menu();
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

	<div dojoType="dijit.Menu" id="windowContextMenu" contextMenuForWindow="true" style="display: none;">
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCut"
			onClick="alert('not actually cutting anything, just a test!')">Cut</div>
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCopy"
			onClick="alert('not actually copying anything, just a test!')">Copy</div>
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconPaste"
			onClick="alert('not actually pasting anything, just a test!')">Paste</div>
		<div dojoType="dijit.MenuSeparator"></div>
		<div dojoType="dijit.PopupMenuItem">
			<span>Enabled Submenu</span>
			<div dojoType="dijit.Menu" id="submenu1">
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

Note that popup menus should be hidden via specifying style="display: none".  Hiding the menu indirectly via a class won't work (in that the menu will remain invisible even when it's supposed to be displayed).


Navigation Menus
================
The Menu widget can also be used for left-hand-side (style) navigation menus, which are functionally equivalent to MenuBar's, but appear vertically (just like a popup menu).   In this case may want to modify the CSS so that the entire left hand column is one color, rather than just the Menu itself.

Usage to display a Menu statically is the same as context menus, except that you don't specify style="display: none" or contextMenuForWindow or any connect ids.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Menu");
    </script>

  .. cv:: html

	<div dojoType="dijit.Menu" id="navMenu">
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCut"
			onClick="alert('drama!')">Drama</div>
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCopy"
			onClick="alert('comedy!')">Comedy</div>
		<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconPaste"
			onClick="alert('romance!')">Romance</div>
		<div dojoType="dijit.MenuSeparator"></div>
		<div dojoType="dijit.PopupMenuItem">
			<span>Action</span>
			<div dojoType="dijit.Menu" id="submenu2">
				<div dojoType="dijit.MenuItem" onClick="alert('diehard!')">Diehard</div>
				<div dojoType="dijit.MenuItem" onClick="alert('indiana!')">Indiana Jones</div>
			</div>
		</div>
	</div>

Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Open a context menu                           On Windows: shift-f10 or the Windows context menu key
                                              On Firefox on the Macintosh: ctrl-space
Navigate menu items                           Up and down arrow keys
Activate a menu item                          Spacebar or enter
Open a submenu                                Spacebar, enter, or right arrow
Close a context menu or submenu               Esc or left arrow
Close a context menu and all open submenus    Tab
==========================================    =================================================


Known Issues
------------

When reading a menu item on Firefox 2, JAWS 8 may say "submenu" for an item that does not have a submenu. This will be fixed in Firefox 3.


Implementation Notes
====================

Focus
-----
Context menus are focused as soon as they are opened, and focus follows the mouse (or the keyboard arrow keys)

For a static Menu/MenuBar, focus is deferred until user clicks it, or tabs into it.   Once user clicks on a Menu/MenuBar, it focuses on it, and then (as with a context menu) any mouse movement or keyboard movement (via arrow keys) will change focus.

CSS Classes
-----------
There are separate CSS classes for indicating that a MenuItem is mouse hovered (dijitMenuItemHover), and to indicate which MenuItem is selected/active (dijitMenuItemSelected).   In tundra/nihilo/soria they look exactly the same, although that could be customized by a user, including removing the hover effect altogether.

"Selected/active" is in the sense of the selected tab, and is controlled by the mouse or keyboard.  Implementation-wise, it means that either the MenuItem has focus, or focus is on a submenu of that MenuItem.

The Menu/MenuBar domNode has a dijitMenuPassive/dijitMenuActive class so that CSS rules for hover can be customized based on whether or not the menu has focus.   Once the menu gets focus the dijitMenuHover effect is disabled in favor of the dijitMenuSelected effect, so that the dijitMenuHover effect won't linger on "File" if user moved the mouse over "File" but then used the keyboard arrows to move to the "Edit" MenuBarItem.  (This is a setting in tundra/nihilo/soria and can be changed if desired.)
