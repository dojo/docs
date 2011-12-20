.. _dijit/Menu:

==========
dijit.Menu
==========

:Authors: Bill Keese
:jsDoc: http://dojotoolkit.org/api/dijit.Menu

.. contents ::
    :depth: 2

Introduction
============

The Menu widget is used for context menus, otherwise known as a right-click or popup menus.

Previously Menu was also used for drop-down menus, but that functionality has been split off to the
:ref:`dijit.DropDownMenu <dijit/form/DropDownMenu>` widget.

Since Menu extends :ref:`dijit.DropDownMenu <dijit/form/DropDownMenu>`, consult that page for general
documentation about the children of Menu, etc.

Examples
========

Programmatic example
--------------------

.. code-example ::

  .. js ::

      dojo.require("dijit.Menu");

      var pMenu;
      dojo.ready(function(){
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

  .. html ::

    <span id="prog_menu">Right click me to get a menu</span>


Declarative markup
------------------

Creation from markup is even easier.
This example creates a context menu for the whole window.

.. code-example ::

  .. js ::

      dojo.require("dijit.Menu");
      dojo.require("dijit.ColorPalette");

  .. html ::

    <div data-dojo-type="dijit.Menu" id="windowContextMenu" data-dojo-props="contextMenuForWindow:true" style="display: none;">
        <div data-dojo-type="dijit.MenuItem" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut',
            onClick:function(){alert('not actually cutting anything, just a test!')}">Cut</div>
        <div data-dojo-type="dijit.MenuItem" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCopy',
            onClick:function(){alert('not actually copying anything, just a test!')}">Copy</div>
        <div data-dojo-type="dijit.MenuItem" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconPaste',
            onClick:function(){alert('not actually pasting anything, just a test!')}">Paste</div>
        <div data-dojo-type="dijit.MenuSeparator"></div>
        <div data-dojo-type="dijit.PopupMenuItem">
            <span>Enabled Submenu</span>
            <div data-dojo-type="dijit.Menu" id="submenu1">
                <div data-dojo-type="dijit.MenuItem" data-dojo-props="onClick:function(){alert('Submenu 1!')}">Submenu Item One</div>
                <div data-dojo-type="dijit.MenuItem" data-dojo-props="onClick:function(){alert('Submenu 2!')}">Submenu Item Two</div>
            </div>
        </div>
        <div data-dojo-type="dijit.PopupMenuItem">
            <span>Popup of something other than a menu</span>
            <div data-dojo-type="dijit.ColorPalette"></div>
        </div>
    </div>

    <span>Right click anywhere on this page to see a menu</span>

Note that popup menus should be hidden via specifying style="display: none".
Hiding the menu indirectly via a class won't work (in that the menu will remain invisible even when it's supposed to be displayed).

Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Open a context menu                           On Windows: shift-f10 or the Windows context menu key.

                                              On Firefox on the Macintosh: ctrl-space.

                                              On Safari 4 or Chrome on Mac: VO+shift+m (VO is usually control+option).
                                              But to use this keyboard sequence (on Safari or Chrome) the voice-over option on safari or chrome(in System Preferences / Universal Access) must be turned on.

Navigate menu items                           Up and down arrow keys
Activate a menu item                          Spacebar or enter
Open a submenu                                Spacebar, enter, or right arrow
Close a context menu or submenu               Esc or left arrow
Close a context menu and all open submenus    Tab
==========================================    =================================================


Implementation Notes
====================

Focus
-----
Context menus are focused as soon as they are opened, and focus follows the mouse (or the keyboard arrow keys)


CSS Classes
-----------
There are separate CSS classes for indicating that a MenuItem is mouse hovered (dijitMenuItemHover),
and to indicate which MenuItem is selected/active (dijitMenuItemSelected).
In tundra/nihilo/soria they look exactly the same, although that could be customized by a user,
including removing the hover effect altogether.

"Selected/active" is in the sense of the selected tab, and is controlled by the mouse or keyboard.  Implementation-wise, it means that either the MenuItem has focus, or focus is on a submenu of that MenuItem.

The Menu/MenuBar domNode has a dijitMenuPassive/dijitMenuActive class so that CSS rules for hover can be customized
based on whether or not the menu has focus.
Once the menu gets focus the dijitMenuHover effect is disabled in favor of the dijitMenuSelected effect,
so that the dijitMenuHover effect won't linger on "File" if user moved the mouse over "File" but then used the keyboard
arrows to move to the "Edit" MenuBarItem.
(This is a setting in tundra/nihilo/soria and can be changed if desired.)
