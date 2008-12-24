#format dojo_rst

Dropdowns and Popups
====================

:Status: Draft
:Version: 1.0
:Project owner: Bill Keese
:Available: since V?

.. contents::
   :depth: 2

This page lists some background on how to write popup widgets.

In most cases, there are two widgets involved with a popup:

  * The host widget, that opens and closes the popup
  * The popup widget itself

For example, respectively, dijit.form.DropDownButton and dijit.ColorPicker.

Host widget always controls
---------------------------
It's important to note that the host widget both opens '''and closes''' the popup.
Even for something like dijit.TooltipDialog, the host widget is responsible for closing it.

Here's some example code from PopupMenuItem about how it opens and closes a submenu or other widget (like a ColorPicker):

.. code-block :: javascript

		var savedFocus = dijit.getFocus(this);
		function closeAndRestoreFocus(){
			// user has clicked on a menu or popup
			dijit.focus(savedFocus);
			dijit.popup.close(self);
		}
		dijit.popup.open({
			popup: this,
			x: x,
			y: y,
			onExecute: closeAndRestoreFocus,
			onCancel: closeAndRestoreFocus,
			orient: this.isLeftToRight() ? 'L' : 'R'
		});
		this.focus();

Note that Menu is responsible for calling both dijit.popup.open() and dijit.popup.close().

Popup Widget
------------

Any normal widget can be used as a popup.   For example, dijit.Calendar is a normal widget (that can be displayed inline in the page) but is used as a popup by the DateTextBox widget.    In other words, there's no _PopupWidget base class for popup widgets.

However, there are two important methods in the popup widget that the popup widget should use to hint to the host
widget that it's ready to be closed:

.. code-block :: javascript

	onExecute: function(){
		// summary: attach point for notification about when a menu item has been executed
	},

	onCancel: function(/*Boolean*/ closeAll){
		// summary: attach point for notification about when the user cancels the current menu
	},

dijit.popup will monitor calls to these two methods and inform the host widget.


Lifecycle
---------

In summary, here is the lifecycle:

   * Host widget calls dijit.popup.open() to display the popup / drop down, defining onExecute() and onCancel() callbacks.
   * [User enters input into the popup]
   * User clicks something in the popup widget, either a "submit"/"cancel" button or maybe just a color (in the case of the ColorPicker)
   * Popup widget calls this.onExecute() or this.onCancel()
   * Dijit.popup code notices the onCancel() call and informs host widget
   * Host widget closes the popup widget and restores focus to whatever previously had focus
   * Popup widget executes.   Note that if the popup widget is something like an editor dialog, it now can access whatever previously had focus.  Part of the execution is likely calling this.onClick() so that any onClick handlers will be called.

If the user clicks a blank section of the screen in order to close the popup, then the ending steps of the lifecycle are slightly different:

   * Dijit.popup code notices the click on the blank area of the screen.
   * Dijit.popup code doesn't close the popup widget directly, but rather calls the onCancel handler setup in the dijit.popup.open() call
   * Host widget closes the popup and restores focus to whatever previously had focus



Example code
------------

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
	},
