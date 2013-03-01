.. _dijit/form/ComboButton:

======================
dijit.form.ComboButton
======================

:Authors: Becky Gibson, Bill Keese
:Developers: ?-
:since: V?

.. contents ::
    :depth: 2

The dijit.form.ComboButton widget has a regular button on the left, and on the right has an arrow to show a drop down (often a menu).

Examples
========

Programmatic example
--------------------

This example shows how to create a menu and combo button programmatically.

.. code-example ::

  .. js ::

    require(["dijit/Menu", "dijit/MenuItem", "dijit/form/ComboButton", "dojo/domReady!"],
            function(Menu, MenuItem, ComboButton){
        var menu = new Menu({ style: "display: none;"});
        var menuItem1 = new MenuItem({
            label: "Yahoo",
            onClick: function(){ alert('hi'); }
        });
        menu.addChild(menuItem1);

        var menuItem2 = new MenuItem({
            label: "Google",
            onClick: function(){ alert('ho'); }
        });
        menu.addChild(menuItem2);

        var button = new ComboButton({
            label: "get all mail",
            dropDown: menu
        });
        button.placeAt(dojo.body());
    });


Declarative example
-------------------

As usual, you can create the ComboButton widget declaratively using the data-dojo-type attribute.
When created declaratively the DropDownButton node has two children, one for the label of the button,
and the other for the drop-down widget that's displayed when you press the button.

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/ComboButton", "dijit/DropDownMenu", "dijit/MenuItem"]);

  .. html ::

    <div data-dojo-type="dijit/form/ComboButton">
        <span>get all mail</span>
        <div data-dojo-type="dijit/DropDownMenu">
            <div data-dojo-type="dijit/MenuItem" data-dojo-props="onClick:function(){console.log('hi!')}">Yahoo</div>
            <div data-dojo-type="dijit/MenuItem" data-dojo-props="onClick:function(){console.log('ho!')}">Google</div>
        </div>
    </div>


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

In Firefox 2 with Dojo releases 1.0 through 1.0.2 the focus on a combo button is not visible.
This is not an issue in Firefox 3 and has been fixed for Firefox 2 in Dojo Releases 1.1 and beyond.


Known Issues
------------

High Contrast Mode
~~~~~~~~~~~~~~~~~~

All buttons should include a label parameter with text for the button even if the showLabel parameter is set to false.
The label parameter is used to identify the button in high contrast mode when the icon for the button will no longer be displayed and is also used to identify the button to a screen reader.

Screen Reader
~~~~~~~~~~~~~

In order to identify the button description to the screen reader, all buttons should include a label parameter even if the showLabel parameter is set to false.

All Combo Buttons should include a optionsTitle parameter to identify the function of the drop down button.
The optionsTitle parameter is used by the screen reader to speak the information about the drop down portion of the button.
Note that the Window-Eyes screen reader will speak "question" and then the optionsTitle text when the drop down portion of the Combo button receives focus.
The "question" is spoken because Window-Eyes does not recognize the html entity character that is used to provide the visual drop down arrow in the button.

Even though the combo buttons are marked with the ARIA haspopup property, the screen readers do not indicate this to the user in Firefox 2.
In Firefox 3 the dropdown and combo buttons will be announced as "menu button".
