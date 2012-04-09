.. _dijit/DropDownMenu:

==================
dijit/DropDownMenu
==================

:Authors: Bill Keese
:jsDoc: http://dojotoolkit.org/api/dijit.DropDownMenu

.. contents ::
    :depth: 2


Introduction
============

The DropDownMenu widget is a vertical menu (contrast with the horizontal
:ref:`dijit.MenuBar <dijit/MenuBar>`) that is used for:

  * drop down menu from :ref:`dijit/form/ComboButton <dijit/form/ComboButton>`,
    :ref:`dijit/form/DropDownButton <dijit/form/DropDownButton>`, and :ref:`dijit/MenuBar <dijit/MenuBar>` widgets,
    typically appearing below the parent widget
  * child menu spawned from another DropDownMenu (a.k.a, a nested menu), appearing to the left or right of the
    parent DropDownMenu
  * independent and always visible menu, typically a left-hand-side navigation menu

Items In a DropDownMenu
=======================
:ref:`dijit/MenuItem <dijit/MenuItem>` widgets are the actual items in the menu.

:ref:`dijit/CheckedMenuItem <dijit/CheckedMenuItem>` widgets are like :ref:`dijit/MenuItem <dijit/MenuItem>`
widgets, but can be clicked to change between a checked and unchecked state.

The :ref:`dijit/PopupMenuItem <dijit/PopupMenuItem>` is like a :ref:`dijit/MenuItem <dijit/MenuItem>`,
but when clicked displays a submenu or other widget to the right or left.
A :ref:`dijit/PopupMenuItem <dijit/PopupMenuItem>` always has two child nodes:
a tag with the displayed label (usually in a SPAN tag), and a widget to be popped up,
typically another dijit/DropDownMenu widget.

:ref:`dijit/MenuSeparator <dijit/MenuSeparator>` widgets render as horizontal lines between other
DropDownMenu items.

Examples
========

Drop Down Menu
--------------
See the :ref:`dijit/form/DropDownButton <dijit/form/DropDownButton>`,
:ref:`dijit/form/ComboButton <dijit/form/ComboButton>`, and :ref:`dijit/MenuBar <dijit/MenuBar>` pages
for examples of drop down menus.

Navigation Menu
---------------
The DropDownMenu widget can also be used for left-hand-side (style) navigation menus,
which are functionally equivalent to MenuBar's, but appear vertically (just like a popup menu).
In this case may want to modify the CSS so that the entire left hand column is one color,
rather than just the Menu itself.

Usage to display a Menu statically is the same as context menus,
except that you don't specify style="display: none" or contextMenuForWindow or any connect ids.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/DropDownMenu", "dijit/MenuItem", "dijit/MenuSeparator", "dijit/PopupMenuItem"]);

  .. html ::

    <div data-dojo-type="dijit/DropDownMenu" id="navMenu">
        <div data-dojo-type="dijit/MenuItem" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut',
            onClick:function(){alert('cut!')}">Cut</div>
        <div data-dojo-type="dijit/MenuItem" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCopy',
            onClick:function(){alert('copy!')}">Copy</div>
        <div data-dojo-type="dijit/MenuItem" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconPaste',
            onClick:function(){alert('paste!')}">Paste</div>
        <div data-dojo-type="dijit/MenuSeparator"></div>
        <div data-dojo-type="dijit/PopupMenuItem">
            <span>Action</span>
            <div data-dojo-type="dijit/DropDownMenu" id="submenu2">
                <div data-dojo-type="dijit/MenuItem" data-dojo-props="onClick:function(){alert('nested #1!')}">Nested #1</div>
                <div data-dojo-type="dijit/MenuItem" onclick="alert('nested #2!')">Nested #2</div>
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
Navigate menu items                           Up and down arrow keys
Activate a menu item                          Spacebar or enter
Open a submenu                                Spacebar, enter, or right arrow
Close a context menu or submenu               Esc or left arrow
Close a context menu and all open submenus    Tab
==========================================    =================================================



Implementation Notes
====================

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
