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

For example, respectively, dijit.form.DropDownButton and dijit.ColorPicker.

Parent widget always controls
-----------------------------
It's important to note that the parent widget both opens and closes the popup.
Even for something like dijit.TooltipDialog, the host widget is responsible for closing it.

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
     
Popup points to a dijit.ColorPicker, dijit.Menu, etc.... it can be any widget.


Popup Widget
------------

Any normal widget can be used as a popup.   For example, dijit.Calendar is a normal widget (that can be displayed inline in the page) but is used as a popup by the DateTextBox widget.    In other words, there's no _PopupWidget base class for popup widgets.

However, there are two important methods in the popup widget that the popup widget should use to hint to the parent
widget that it's ready to be closed:

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

Lifecycle
---------

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

Stacks
------
DropDowns can open other drop downs.   This is particularly leveraged by the Menu widget.

dijit.popup() keeps track of the stack of open widgets.


Keyboard handling
-----------------
dijit.popup() automatically monitors for the ESC key as a way to cancel the current popup.   It treats it the same way as clicking on the blank area of the screen.

It also monitors for the TAB key, and if it sees it, it cancels the whole stack of popups (in the case of menus, where one popup has opened another and so forth).

Note that in neither of these cases does the dijit.popup code directly close the popup(s).  Rather, it just calls the onCancel() callback defined on the dijit.popup.open() call.   That callback then presumably calls dijit.popup.close().   This architecture was designed so that the parent widget always knows whether it's child popup is open or not, and also so that it can do any cleanup etc.
