#format dojo_rst

Dropdowns and Popups
====================

:Status: Draft
:Version: 1.0
:Project owner: Bill Keese
:Available: since V?

.. contents::
   :depth: 2

This page explains how to drop down / popup widgets using dijit.

In most cases, there are two widgets involved with a popup:

* The parent widget, that opens and closes the popup
* The popup widget itself

For example, respectively, `dijit.form.DropDownButton <dijit/form/DropDownButton>`_ and `dijit.ColorPalette <dijit/ColorPalette>`_.


=============================
Parent widget always controls
=============================

It's important to note that the parent widget both opens and closes the popup.
Even for something like `dijit.TooltipDialog <dijit/TooltipDialog>`_, the host `DropDownButton widget <dijit/form/DropDownButton>`_ is responsible for closing it.
This architecture was chosen so that the parent widget always knows whether it's child popup is open or not, and also so that it can do any cleanup etc.

Here's some example code from DropDownButton about how it opens and closes it's drop down:

.. code-block :: javascript

    dijit.popup.open({
        parent: this,
        popup: dropDown,
        around: this.domNode,
        orient: {'BR':'TR', 'BL':'TL', 'TR':'BR', 'TL':'BL'},
        onExecute: function(){
            dijit.popup.close(dropDown);
        },
        onCancel: function(){
            dijit.popup.close(dropDown);
        },
        onClose: function(){
            ...
        }
    });
     
Popup points to a `dijit.ColorPalette <dijit/ColorPalette>`_, `dijit.Menu <dijit/Menu>`_, etc.... it can be any widget.

The parent code should also call dijit.popup.prepare() to hide the popup widget and to get it ready for dijit.popup.open() calls:

.. code-block :: javascript

  dijit.popup.prepare(dropDown);


============
Popup Widget
============

Any normal widget can be used as a popup. For example, `dijit.Calendar <dijit/Calendar>`_ is a normal widget (that can be displayed inline in the page) but is used as a popup by the `DateTextBox <dijit/form/DateTextBox>`_ widget. In other words, there's no _PopupWidget base class for popup widgets.

However, there are two important methods in the popup widget that the popup widget should use to hint to the parent widget that it's ready to be closed:

.. code-block :: javascript

    onExecute: function(){
        // summary: attach point for notification about when a menu item has been executed
    },

    onCancel: function(/*Boolean*/ closeAll){
        // summary: attach point for notification about when the user cancels the current menu
    },

dijit.popup will monitor calls to these two methods and inform the parent widget.

Here's some example code from a popup widget showing what it does when it's been clicked:

.. code-block :: javascript

    onItemClick: function(/*Widget*/ item, /*Event*/ evt){
        ...
        // before calling user defined handler, close hierarchy of menus
        // and restore focus to place it was when menu was opened
        this.onExecute();

        // user defined handler for click
        item.onClick(evt);
        ...
    }


=========
Lifecycle
=========

In summary, here is the lifecycle:

* Parent widget calls dijit.popup.open() to display the popup / drop down, defining onExecute() and onCancel() callbacks.
* [User enters input into the popup]
* User clicks something in the popup widget, either a "submit"/"cancel" button or maybe just a color (in the case of the ColorPicker)
* Popup widget calls this.onExecute() or this.onCancel()
* Dijit.popup code notices the popupWidget.onExecute() / popupWidget.onCancel() has been called and informs host widget, by calling the onExecute() callback defined in the dijit.popup.open() call 
* Parent widget calls dijit.popup.close(), closing the popup widget
* Dijit.popup.close() calls onClose() callback defined in dijit.popup.open() code.
* Parent widget probably restores focus to whatever had focus before.
* Popup widget executes.   Note that if the popup widget is something like an editor dialog, it now can access whatever previously had focus.  Part of the execution is likely calling this.onClick() so that any onClick handler will be called.

If the user clicks a blank section of the screen in order to close the popup, then the ending steps of the lifecycle are slightly different:

* Dijit.popup code notices the click on the blank area of the screen.
* Dijit.popup code doesn't close the popup widget directly, but rather calls the onCancel callback specified in the dijit.popup.open() call
* Host widget closes the popup and restores focus to whatever previously had focus


======
Stacks
======

DropDowns can open other drop downs. This is particularly leveraged by the Menu widget.

dijit.popup() keeps track of the stack of open widgets.

Note that when clicking on the blank area of the screen, the stack of active popups should all close. This isn't handled by the dijit.popup package directly. Rather, the top parent widget should connect to _onBlur(), which will be called (only) when focus is removed from the top parent widget *and* it's descendant submenus. In this case, the top parent widget should call dijit.popup.close() on the top popup, which will close the stack of open popups.


=================
Keyboard handling
=================

dijit.popup() automatically monitors for the ESC key as a way to cancel the current popup, and return to the parent node (which may itself be a popup).  It calls the onCancel() callback in this case.

It also monitors for the TAB key, and if it sees it, it cancels the whole stack of popups (in the case of menus, where one popup has opened another and so forth).

Note that in neither of these cases does the dijit.popup code directly close the popup(s). Rather, it just calls the onCancel() callback defined on the dijit.popup.open() call. That callback then presumably calls dijit.popup.close().


==========================
Popup DOM node positioning
==========================

dijit.popup.prepare() should be called on any nodes that will be used as popups. It's main function, besides hiding the node, is to attach it as a direct child of <body>. The reason we do this is so that the node doesn't get cut off if it's inside a <div> with a short height. (For example, a button inside a TabContainer... the popup might want to overflow past the bottom of the TabContainer.)

Note that this design decision makes TAB key handling particularly difficult, and it's not handled perfectly: if a user hits the TAB key while on a submenu from a MenuBar, or any drop down from a DropDownButton, they probably expect the focus to go to the next element after the MenuBar/DropDownButton. However, since the drop down has actually been repositioned as the last element in &lt;body&gt;, just letting the browser handle the tab key won't do what the user expects.

As a compromise, the TAB key (while on a popup) will re-focus on the DropDownButton/MenuBarItem that spawned the top popup. This is handled by the code that calls dijit.popup.open(), in the return handler for onCancel(). See `DropDownButton <dijit/form/DropDownButton>`_ for an example. (Note though that the _onBlur() handler mentioned above, for handling clicking on a blank area of the screen, should not refocus to the parent widget, as that would interefere if the user had clicked on, for example, a random <input> on the page and wants the focus to go there.)
