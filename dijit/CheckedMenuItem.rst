.. _dijit/CheckedMenuItem:

=====================
dijit.CheckedMenuItem
=====================

.. contents ::
    :depth: 2

The CheckedMenuItem is a checkbox-like menu item for toggling on/off.
Every time the user clicks the widget, it changes state between checked and unchecked.
The default initial state of the widget is unchecked.
User can optionally change the initial state of the widget and can disable the widget as well.
A user defined event function, onChange, is used to handle check/uncheck events.

To change the default state of the menu item to “checked”,

.. js ::

    var cItem = new dijit.CheckedMenuItem({label:"ToolBar", checked:true});

The menu item can be disabled as follows:

.. js ::

   var cItem = new dijit.CheckedMenuItem({label:"Checked Menu Item", disabled:true});

This widget is helpful in cases where the user has to toggle particular column/row, on/off as and when it is required.
The examples below illustrate the usage of the widget.


Examples
========

See the :ref:`dijit.Menu <dijit/Menu>` page for an example.

Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate to menu item                          Up and down arrow keys
check/uncheck menu item                          Spacebar or enter
==========================================    =================================================

See also
========

* :ref:`dijit/RadioMenuItem <dijit/RadioMenuItem>` - for menu items where only one can be checked at a time
