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

  * the host widget, that opens and closes the popup
  * the popup itself

For example, respectively, dijit.form.DropDownButton and dijit.ColorPicker.

It's important to note that the host widget both opens <i>and closes</i> the popup.
Even for something like dijit.TooltipDialog, the host widget is responsible for closing it.

However, there are two important methods in the popup widget that the popup widget can use to hint to the host
widget that it's ready to be closed:

  * onExecute()
  * onCancel()

The host widget will monitor calls to these two methods and close the popup widget on either one.

Lifecycle
---------

   * host widget calls dijit.popup.open() to display the popup / drop down
   * user enters input into the popup
   * user clicks something in the popup, either a "submit"/"cancel" button or maybe just a color (in the case of the ColorPicker
   * popup calls this.onExecute()   (or this.onCancel())
   * host widget closes the popup and restores focus to whatever previously had focus
   * popup executes.   Note that if the popup is something like an editor button, it now can access whatever previously had focus
