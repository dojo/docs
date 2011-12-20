.. _dijit/form/MappedTextBox:

========================
dijit.form.MappedTextBox
========================

.. contents ::
    :depth: 2

Introduction
============

A dijit.form.ValidationTextBox subclass which provides a base class for widgets that have
a visible formatted display value, and a serializable
value in a hidden input field which is actually sent to the server.

Many of the form controls have a concept of "displayed value" vs. "serialized value" (a.k.a. the "real value"),
which is the value passed to the server on form submit.

For example, a NumberSpinner may be declared like

.. html ::

  <div data-dojo-type="dijit.form.NumberSpinner" data-dojo-props="value:1000">

(note the "value" keyword). But when it's displayed in America it looks like "1,000" (with the comma).
And if the user types in "1,234,567", it gets sent back to the server as "123456789".

This is handled internally by having two <input> fields in the widget:

.. image :: ../MappedTextBox.gif

The upshot of this is that Dijit handles localization issues on the client,
so the server doesn't have to worry about it
(except of course for translating the boilerplate text on the page, like the label for the above control).
